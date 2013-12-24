# Tools for compilation


compile_log(s::String) = println(s)
compile_error(msg::String) = error("[Accelereval]: $msg")

tyannot_error(s::Symbol, msg::String) = compile_error("Annotation of $s: $msg")

#################################################
#
#   Parse variable declaration
#
#################################################

RECOGNIZED_NUMTYPES = Set(
	Bool, Int8, Int16, Int32, Int64, Uint8, Uint16, Uint32, Uint64, 
	Float32, Float64)

function _check_numtype(s::Symbol, T::Type)
	if T in RECOGNIZED_NUMTYPES 
		return T
	else 
		tyannot_error(s, "$T is not a recognized numeric type.")
	end
end

function parse_vartype(s::Symbol, T::Type)
	# parse a variable type expression to get eltype and ndims

	if T <: Number
		return (_check_numtype(s, T), 0)
	elseif T <: AbstractArray
		return (_check_numtype(s, eltype(T)), ndims(T))
	else
		tyannot_error(s, "type must be either number or array.")
	end
end

function parse_vardecl(t::Expr)
	# parse variable declaration like a::Array{T,2} to a variable 

	isa(t, Symbol) && compile_error("function parameter $t lacks type annotation.")
	((t.head == :(::) && length(t.args) == 2)) || compile_error("invalid parameter declaration: $(t).")
	s::Symbol = t.args[1]
	T = eval(t.args[2])
	isa(T, DataType) || tyannot_error(s, "$T is not a valid data type.")
	(et, nd) = parse_vartype(s, T)
	return variable(s, et, nd)
end