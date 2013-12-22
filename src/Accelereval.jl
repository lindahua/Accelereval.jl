module Accelereval
	import 

	Base.show, Base.symbol,

	# arithmetics
	Base.+, Base.-, Base.*, Base./, Base.\, Base.^, Base.%,
	Base.(.+), Base.(.-), Base.(.*), Base.(./), Base.(.\), Base.(.^), 

	# algebraic math functions
	Base.max, Base.min, 
	Base.abs, Base.abs2, Base.sqrt, Base.cbrt

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
