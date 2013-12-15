module DelayExpr

	export 

	# exprtypes
	DelayedExpr, DelayedArray, 
	DelayedMap, DelayedUnaryMap, DelayedBinaryMap, DelayedTernaryMap,
	dex, funsym, arguments, result_size


	# include sources

	include("exprtypes.jl")
	include("exprshow.jl")
	include("mathfuns.jl")

	include("codegen.jl")
	include("devectorize.jl")
end
