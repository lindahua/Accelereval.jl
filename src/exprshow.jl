# Functions to dump delayed expressions

import Base.show

function println_indent(io::IO, indent::Int, x)
	if indent > 0
		print(io, repeat("    ", indent))
	end
	println(io, x)
end

_typehead(x::DelayedArray) = "DelayedArray"
_typehead(x::DelayedUnaryExpr) = "DelayedUnaryExpr"
_typehead(x::DelayedBinaryExpr) = "DelayedBinaryExpr"
_typehead(x::DelayedTernaryExpr) = "DelayedTernaryExpr"

exprhead(x::DelayedExpr) = "$(_typehead(x)) (size = $(result_size(x)))"

show_expr(io::IO, indent::Int, x::DelayedExpr) = println(exprhead(x))

show_expr(io::IO, indent::Int, x::Number) = println("Number ($x)")
		
function show_expr(io::IO, indent::Int, x::DelayedMap)
	println(exprhead(x))
	for (i, a) in enumerate(arguments(x))
		println_indent(io, indent, "Argument [$i]: ")
		show_epxr(io, indent+1, x)
	end
end

show(io::IO, x::DelayedExpr) = show_expr(io, x)

