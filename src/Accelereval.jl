module Accelereval

	import Base: show, symbol, eltype, ndims
	import Base: +, -, *, /, \, ^, %, .+, .-, .*, ./, .\, .^
	import Base: max, min
	import Base: abs, abs2, sqrt, cbrt

	export 

	# functions
	SFunc, funsym,

	# maptype
	maptype,

	# exprtypes
	AbstractNumExpr, Constant, constant,
	Variable, ScalarVar, VectorVar, MatrixVar, 
	variable, scalarvar, vectorvar, matrixvar,
	MapExpr, mapexpr

	# include sources

	include("functions.jl")
	include("maptype.jl")

	include("exprtypes.jl")
	include("exparse.jl")
end
