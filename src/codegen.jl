# code generation utilities

assign_expr(lhs::Symbol, rhs::Expr) = Expr(:(=), lhs, rhs)

add_flatten_expr!(s::Vector{Expr}, ex::Nothing) = nothing

function add_flatten_expr!(s::Vector{Expr}, ex::Expr)
	if ex.head == :block
		for x in ex.args
			add_flatten_expr!(s, x)
		end
	else
		push!(s, ex)
	end
end


function flatten_exprblock(exprs...)
	s = Expr[]
	for x in exprs
		add_flatten_expr!(s, x)
	end
	return isempty(s) ? nothing : Expr(:block, s...)
end

