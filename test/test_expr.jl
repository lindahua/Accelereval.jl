using FAST
using Base.Test

import NumericExtensions.Add, NumericExtensions.AbsFun


x = scalarvar(:x, Float64)
@test isa(x, ScalarVar{Float64})
@test symbol(x) == :x

y = vectorvar(:y, Int32)
@test isa(y, VectorVar{Int32})
@test symbol(y) == :y

z = matrixvar(:z, Bool)
@test isa(z, MatrixVar{Bool})
@test symbol(z) == :z

a = mapexpr(AbsFun(), x)
@test isa(a, MapExpr{AbsFun, (ScalarVar{Float64},)})

a = mapexpr(Add(), x, y)
@test isa(a, MapExpr{Add, (ScalarVar{Float64}, VectorVar{Int32})})

