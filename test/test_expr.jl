using FAST
using Base.Test

import NumericExtensions.Add, NumericExtensions.AbsFun


c = constant(1.0)
@test isa(c, Constant{Float64})
@test c == c

x = scalarvar(:x, Float64)
@test isa(x, ScalarVar{Float64})
@test symbol(x) == :x
@test x == x

y = vectorvar(:y, Int32)
@test isa(y, VectorVar{Int32})
@test symbol(y) == :y
@test y == y

z = matrixvar(:z, Bool)
@test isa(z, MatrixVar{Bool})
@test symbol(z) == :z
@test z == z

a = abs(x)
@test isa(a, MapExpr{AbsFun, (ScalarVar{Float64},)})
@test a == mapexpr(AbsFun, x)
@test !(a != a)

a = x + y
@test isa(a, MapExpr{Add, (ScalarVar{Float64}, VectorVar{Int32})})
@test a == mapexpr(Add, x, y)
@test !(a != a)

