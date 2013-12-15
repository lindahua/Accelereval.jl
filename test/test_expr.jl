using DelayExpr
using Base.Test

amat = rand(2, 3)
bmat = rand(2, 3)
cmat = rand(2, 3)

a = dex(amat)
b = dex(bmat)
c = dex(cmat)

typealias DelayedFMat DelayedArray{Array{Float64, 2}}

@test typeof(a) == DelayedFMat
@test typeof(b) == DelayedFMat
@test typeof(c) == DelayedFMat

@test a.arr === amat
@test b.arr === bmat
@test c.arr === cmat

@test typeof(abs(a)) == DelayedUnaryMap{:abs, DelayedFMat}
@test typeof(a + b) == DelayedBinaryMap{:+, DelayedFMat, DelayedFMat}
