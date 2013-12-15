module DelayExpr

	export 

	# exprtypes
	DelayedExpr, DelayedArray, 
	DelayedMap, DelayedUnaryMap, DelayedBinaryMap, DelayedTernaryMap,
	dex, funsym, arguments

	include("exprtypes.jl")
	include("exprshape.jl")
	include("exprshow.jl")
	include("mathfuns.jl")

end
