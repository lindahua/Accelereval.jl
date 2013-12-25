# Tools for expression parsing


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


#################################################
#
#   Parse function header
#
#################################################

function parse_funhead(f::Expr)
	# parse a function head expression like f(x::A, y::B) 
	# it returns (fname, vars), where fname is a symbol
	# representing the function name, and vars is a sequence
	# of parsed variables (instances of Variable)

	@assert f.head == :(call)

	fname::Symbol = f.args[1]
	vars = Variable[parse_vardecl(t) for t in f.args[2:end]]

	return (fname, vars)
end



#################################################
#
#   Parse right-hand-side expressions
#
#################################################

function lookup_variable(vmap::VariableMap, s::Symbol)
	v = get(vmap, s, nothing)
	if v == nothing
		compile_error("variable $s is not initialized when it is used.")
	end
	return v::Variable
end


parse_rhs(vmap::VariableMap, ex::Symbol) = lookup_variable(vmap, ex)

function parse_rhs(vmap::VariableMap, ex::Expr)
	if ex.head == :call
		parse_call(vmap, ex)
	else
		compile_error("Unsupported expression: $(ex).")
	end
end


function parse_call(vmap::VariableMap, ex::Expr)
	@assert ex.head == :call

	fsym = ex.args[1]
	isa(fsym, Symbol) || compile_error("Only simple function name is supported. (ref: $(fsym))")

	delayed_call = Expr(:call, fsym, [parse_rhs(vmap, a) for a in ex.args[2:]]...)
	eval(delayed_call)
end

