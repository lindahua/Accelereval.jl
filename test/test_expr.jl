using FAST
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
typealias DeBMat DelayedArray{BitMatrix}

@test_dex a DeFMat (2, 3)
@test_dex b DeFMat (2, 3)
@test_dex c DeFMat (2, 3)

@test a.arr === amat
@test b.arr === bmat
@test c.arr === cmat

la = dex(randbool(2, 3))
lb = dex(randbool(2, 3))

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

# logical & comparison

@test_dex ~la DelayedUnaryMap{:~, DeBMat} (2, 3)
@test_dex (la & lb) DelayedBinaryMap{:&, DeBMat, DeBMat} (2, 3)
@test_dex (la | lb) DelayedBinaryMap{:|, DeBMat, DeBMat} (2, 3)

@test_dex (la & true) DelayedBinaryMap{:&, DeBMat, Bool} (2, 3)
@test_dex (la | false) DelayedBinaryMap{:|, DeBMat, Bool} (2, 3)

@test_dex (a .== b) DelayedBinaryMap{:.==, DeFMat, DeFMat} (2, 3)
@test_dex (a .!= b) DelayedBinaryMap{:.!=, DeFMat, DeFMat} (2, 3)
@test_dex (a .> b)  DelayedBinaryMap{:.>,  DeFMat, DeFMat} (2, 3)
@test_dex (a .< b)  DelayedBinaryMap{:.<,  DeFMat, DeFMat} (2, 3)
@test_dex (a .>= b) DelayedBinaryMap{:.>=, DeFMat, DeFMat} (2, 3)
@test_dex (a .<= b) DelayedBinaryMap{:.<=, DeFMat, DeFMat} (2, 3)

# some math functions

@test_dex abs(a) DelayedUnaryMap{:abs, DeFMat} (2, 3)
@test_dex exp(a) DelayedUnaryMap{:exp, DeFMat} (2, 3)
@test_dex ifloor(a) DelayedUnaryMap{:ifloor, DeFMat} (2, 3)
@test_dex hypot(a, b) DelayedBinaryMap{:hypot, DeFMat, DeFMat} (2, 3)
@test_dex atan2(a, 2.0) DelayedBinaryMap{:atan2, DeFMat, Float64} (2, 3)
@test_dex sind(a) DelayedUnaryMap{:sind, DeFMat} (2, 3)
@test_dex lgamma(a) DelayedUnaryMap{:lgamma, DeFMat} (2, 3)
@test_dex beta(a, b) DelayedBinaryMap{:beta, DeFMat, DeFMat} (2, 3)

# compound expressions

T1 = DelayedUnaryMap{:exp, 
		DelayedBinaryMap{:.*, 
			DelayedUnaryMap{:abs2, DelayedBinaryMap{:-, DeFMat, DeFMat}}, 
			DelayedBinaryMap{:+, DeFMat, Float64}}}

@test_dex exp(abs2(a - b) .* (c + 1.0)) T1 (2, 3)
# println(exp(abs2(a - b) .* (c + 1.0)))


