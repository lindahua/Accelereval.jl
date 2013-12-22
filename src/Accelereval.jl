module Accelereval

	import Base: show, symbol
	import Base: +, -, *, /, \, ^, %, .+, .-, .*, ./, .\, .^
	import Base: max, min
	import Base: abs, abs2, sqrt, cbrt

	export 

	# functions
	SFunc, funsym,

	# exprtypes
	AbstractNumExpr, Constant, constant,
	Variable, ScalarVar, VectorVar, MatrixVar, 
	variable, scalarvar, vectorvar, matrixvar,
	MapExpr, mapexpr

	# include sources

	include("functions.jl")
	include("exprtypes.jl")
end
