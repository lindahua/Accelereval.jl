# common facilities


#### Typed symbol

type TSym{S} end

TSym(s::Symbol) = TSym{s}()
Base.symbol{S}(::TSym{S}) = S


#### Abstract expression types

abstract NumericExpr{T,D}
abstract ScalarExpr{T} <: NumericExpr{T,0}

eltype{T}(::NumericExpr{T}) = T
ndims{T,D}(::NumericExpr{T,D}) = D

== (x::NumericExpr, y::NumericExpr) = false
!= (x::NumericExpr, y::NumericExpr) = !(x == y)

#### Var types

# constant

immutable Constant{T<:Number} <: ScalarExpr{T}
    value::T
end

Constant{T<:Number}(v::T) = Constant{T}(v)
== (x::Constant, y::Constant) = (x.value === y.value)

# scalar variable

immutable ScalarVar{T} <: ScalarExpr{T}
    sym::Symbol
end

ScalarVar{T<:Number}(s::Symbol, ::Type{T}) = ScalarVar{T}(s)
== {T}(x::ScalarVar{T}, y::ScalarVar{T}) = (x.sym == y.sym)

# array variable

immutable ArrayVar{T,D} <: NumericExpr{T,D}
    sym::Symbol
end

ArrayVar{T<:Number}(s::Symbol, ::Type{T}, D::Int) = ArrayVar{T,D}(s)
== {T,D}(x::ArrayVar{T,D}, y::ArrayVar{T,D}) = (x.sym == y.sym)

typealias VectorVar{T} ArrayVar{T,1}
typealias MatrixVar{T} ArrayVar{T,2}

