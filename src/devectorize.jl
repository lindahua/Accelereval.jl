# Devectorized evaluation of delayed expressions

global devec_eval!
function devec_eval!(r::AbstractArray, ex::DelayedExpr) 
	global devec_eval!
	global _devec_eval!

	T = typeof(ex)
	println("compiling for expression type $T ...")
	preamble, kernel = devectorize_code(:x, ex)

	@eval function _devec_eval!(r::AbstractArray, x::$(T))		
		size(r) == result_size(x) || error("Argument dimension mismatch.")
		$(preamble)
		for i = 1 : length(r)
			@inbounds r[i] = $(kernel(:i))
		end
	end
	@eval devec_eval!(r::Array, x::$(T)) = _devec_eval!(r, x)

	_devec_eval!(r, ex)
end


function devectorize_code(s::Symbol, x::DelayedArray)
	a = gensym("a")
	pre = assign_expr(a, :($s.arr))  # a = s.arr
	ker = i -> Expr(:ref, a, i)     # a[i]
	return (pre, ker)
end

function devectorize_code(s::Symbol, x::DelayedMap)
	f = funsym(s)
	args = arguments(x)
	na = length(args)

	argpres = Any[]
	preasgns = Expr[]
	argkers = Function[]

	sizehint(preasgns, na)
	sizehint(argpres, na)
	sizehint(argkers, na)

	for i = 1 : na
		a = gensym("a$i")
		af = symbol("a$i")
		apre, aker = devectorize_code(a, args[i])
		push!(preasgns, assign_expr(a, :($s.$af)))  # a = s.a$i
		push!(argpres, apre)   
		push!(argkers, aker)
	end

	pre = flatten_exprblock(preasgns..., argpres...)
	ker = i -> Expr(:call, funsym(x), [k(i) for k in argkers]...)
	return (pre, ker)
end

