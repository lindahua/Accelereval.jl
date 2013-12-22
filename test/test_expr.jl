using Accelereval
using Base.Test

import NumericExtensions: Add, AbsFun


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
@test isa(a, MapExpr{SAbs, (ScalarVar{Float64},)})
@test funsym(a) == :abs
@test a == mapexpr(SAbs, x)
@test !(a != a)

a = x .+ y
@test isa(a, MapExpr{SAdd, (ScalarVar{Float64}, VectorVar{Int32})})
@test funsym(a) == :+
@test a == mapexpr(SAdd, x, y)
@test !(a != a)

