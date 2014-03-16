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


#### variable types

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


#### map expression types

abstract SFunction
global funsym
global result_type

immutable MapExpr{T,D,F<:SFunction,Args<:(NumericExpr...)} <: NumericExpr{T,D}
    args::Args
end

immutable MapExprX{T,D,F<:SFunction,Args<:(NumericExpr...)} <: NumericExpr{T,D}
    args::Args
end

function MapExpr{F<:SFunction,A1<:NumericExpr}(::Type{F}, a1::A1)
    T = result_type(F, eltype(a1))
    D = ndims(a1)
    MapExpr{T,D,F,(A1,)}(args)
end

function MapExpr{F<:SFunction,A1<:NumericExpr,A2<:NumericExpr}(::Type{F}, a1::A1, a2::A2)
    T = result_type(F, eltype(a1), eltype(a2))
    D = max(ndims(a1), ndims(a2))
    MapExpr{T,D,F,(A1,A2)}(args)
end

function MapExpr{F<:SFunction,A1<:NumericExpr,
                              A2<:NumericExpr,
                              A3<:NumericExpr}(::Type{F}, a1::A1, a2::A2, a3::A3)
    T = result_type(F, eltype(a1), eltype(a2), eltype(a3))
    D = max(ndims(a1), ndims(a2), ndims(a3))
    MapExpr{T,D,F,(A1,A2,A3)}(args)
end

tcall(f::Symbol, x1) = tcall(TSym(f), texpr(x1))
tcall(f::Symbol, x1, x2) = tcall(TSym(f), texpr(x1), texpr(x2))
tcall(f::Symbol, x1, x2, x3) = tcall(TSym(f), texpr(x1), texpr(x2), texpr(x3))





