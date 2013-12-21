module ACE
	import 

	Base.show, Base.symbol,

	# arithmetics
	Base.+, Base.-, Base.*, Base./, Base.\, Base.^, Base.%,
	Base.(.+), Base.(.-), Base.(.*), Base.(./), Base.(.\), Base.(.^), 

	# algebraic math functions
	Base.max, Base.min, 
	Base.abs, Base.abs2, Base.sqrt, Base.cbrt

	export 

	# exprtypes
	AbstractNumExpr, Constant, constant,
	Variable, ScalarVar, VectorVar, MatrixVar, 
	variable, scalarvar, vectorvar, matrixvar,
	SFunc, funsym, MapExpr, mapexpr

	# include sources

	include("exprtypes.jl")
end
