module DelayExpr

	export 

	# exprtypes
	DelayedExpr, DelayedArray, 
	DelayedMap, DelayedUnaryMap, DelayedBinaryMap, DelayedTernaryMap,
	dex, funsym, arguments,

	# exprshape
	result_type


	include("exprtypes.jl")
	include("exprshow.jl")
	include("mathfuns.jl")

end
