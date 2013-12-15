module DelayExpr

	export 

	# exprtypes
	DelayedExpr, DelayedArray, 
	DelayedMap, DelayedUnaryMap, DelayedBinaryMap, DelayedTernaryMap,
	dex, funsym, arguments, result_size


	include("exprtypes.jl")
	include("exprshow.jl")
	include("mathfuns.jl")

end
