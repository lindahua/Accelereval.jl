using Accelereval
using Base.Test

import Accelereval: NumericExpr, ScalarExpr
import Accelereval: Constant, ScalarVar, ArrayVar

@test ScalarExpr <: NumericExpr
@test Constant   <: ScalarExpr
@test ScalarVar  <: ScalarExpr
@test ArrayVar   <: NumericExpr

v = Constant(2.5)
@test isa(v, Constant)
@test v.value == 2.5
@test eltype(v) == Float64
@test ndims(v) == 0

@test v == Constant(2.5)
@test v != Constant(3.0)

v = ScalarVar(:x, Int32)
@test isa(v, ScalarVar)
@test v.sym == :x
@test eltype(v) == Int32
@test ndims(v) == 0

@test v == ScalarVar(:x, Int32)
@test v != ScalarVar(:y, Int32)


v = ArrayVar(:a, Float32, 3)
@test isa(v, ArrayVar)
@test v.sym == :a
@test eltype(v) == Float32
@test ndims(v) == 3

@test v == ArrayVar(:a, Float32, 3)
@test v != ArrayVar(:a, Float32, 2)

