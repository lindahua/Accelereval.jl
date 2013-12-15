# Functions to dump delayed expressions

import Base.show

function print_indent(io::IO, indent::Int, x)
	if indent > 0
		print(io, repeat("    ", indent))
	end
	print(io, x)
end

function println_indent(io::IO, indent::Int, x)
	if indent > 0
		print(io, repeat("    ", indent))
	end
	println(io, x)
end

_typehead(x::DelayedArray) = "DelayedArray"
_typehead{F}(x::DelayedUnaryMap{F}) = "DelayedUnaryMap (fun = $F)"
_typehead{F}(x::DelayedBinaryMap{F}) = "DelayedBinaryMap (fun = $F)"
_typehead{F}(x::DelayedTernaryMap{F}) = "DelayedTernaryMap (fun = $F)"

exprhead(x::DelayedExpr) = "$(_typehead(x)) (size = $(result_size(x)))"

show_expr(io::IO, indent::Int, x::DelayedExpr) = println(exprhead(x))

show_expr(io::IO, indent::Int, x::Number) = println("Number ($x)")
		
function show_expr(io::IO, indent::Int, x::DelayedMap)
	println(exprhead(x))
	for (i, a) in enumerate(arguments(x))
		print_indent(io, indent+1, "Argument [$i]: ")
		show_expr(io, indent+1, a)
	end
end

show_expr(io::IO, x::DelayedExpr) = show_expr(io, 0, x)
show(io::IO, x::DelayedExpr) = show_expr(io, x)

