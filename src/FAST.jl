module FAST
	using NumericExtensions

	import Base.show
	import Base.symbol

	export 

	# exprtypes
	AbstractNumExpr, 
	Variable, ScalarVar, VectorVar, MatrixVar, 
	variable, scalarvar, vectorvar, matrixvar,
	MapExpr, mapexpr

	# include sources

	include("exprtypes.jl")
end
