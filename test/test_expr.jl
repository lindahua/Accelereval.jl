using DelayExpr
using Base.Test

macro test_dex(x, ty, rsiz)
	quote
		xname = $(string(x))
		if !(typeof($x) == ($ty))
			error("The type of $xname does not match expected type: $($ty).")
		end
		if !(result_size($x) == ($rsiz))
			error("The result_size of $xname does not match expected size: $($rsiz).")
		end
	end
end


amat = rand(2, 3)
bmat = rand(2, 3)
cmat = rand(2, 3)

a = dex(amat)
b = dex(bmat)
c = dex(cmat)

typealias DeFMat DelayedArray{Array{Float64, 2}}

@test_dex a DeFMat (2, 3)
@test_dex b DeFMat (2, 3)
@test_dex c DeFMat (2, 3)

@test a.arr === amat
@test b.arr === bmat
@test c.arr === cmat

# arithmetic operations

@test_dex (-a) DelayedUnaryMap{:-, DeFMat} (2, 3)

@test_dex (a + b) DelayedBinaryMap{:+, DeFMat, DeFMat} (2, 3)
@test_dex (a - b) DelayedBinaryMap{:-, DeFMat, DeFMat} (2, 3)
@test_dex (a .+ b) DelayedBinaryMap{:.+, DeFMat, DeFMat} (2, 3)
@test_dex (a .- b) DelayedBinaryMap{:.-, DeFMat, DeFMat} (2, 3)
@test_dex (a .* b) DelayedBinaryMap{:.*, DeFMat, DeFMat} (2, 3)
@test_dex (a ./ b) DelayedBinaryMap{:./, DeFMat, DeFMat} (2, 3)
@test_dex (a .^ b) DelayedBinaryMap{:.^, DeFMat, DeFMat} (2, 3)

@test_dex (a + 2.0) DelayedBinaryMap{:+, DeFMat, Float64} (2, 3)
@test_dex (2.0 + a) DelayedBinaryMap{:+, Float64, DeFMat} (2, 3)
@test_dex (a * 2.0) DelayedBinaryMap{:*, DeFMat, Float64} (2, 3)
@test_dex (2.0 * a) DelayedBinaryMap{:*, Float64, DeFMat} (2, 3)
@test_dex (a / 2.0) DelayedBinaryMap{:/, DeFMat, Float64} (2, 3)
@test_dex (2.0 / a) DelayedBinaryMap{:/, Float64, DeFMat} (2, 3)

@test_throws a * b
@test_throws a ^ 2.0
@test_throws a ^ b

