# Types of expressions


abstract AbstractNumExpr

== (x::AbstractNumExpr, y::AbstractNumExpr) = false
!= (x::AbstractNumExpr, y::AbstractNumExpr) = !(x == y)

########################################
#
#   Constants & Variables
#
########################################

# constant

type Constant{T<:Number} <: AbstractNumExpr
	value::T
end

constant{T<:Number}(v::T) = Constant{T}(v)

== (x::Constant, y::Constant) = (x.value === y.value)

# variable

type Variable{T,D} <: AbstractNumExpr
	sym::Symbol
end

== {T,D}(x::Variable{T,D}, y::Variable{T,D}) = (x.sym == y.sym)

typealias ScalarVar{T} Variable{T,0}
typealias VectorVar{T} Variable{T,1}
typealias MatrixVar{T} Variable{T,2}

variable{T<:Number}(s::Symbol, t::Type{T}, D::Int) = Variable{T,D}(s)

scalarvar{T<:Number}(s::Symbol, t::Type{T}) = variable(s, t, 0)
vectorvar{T<:Number}(s::Symbol, t::Type{T}) = variable(s, t, 1)
matrixvar{T<:Number}(s::Symbol, t::Type{T}) = variable(s, t, 2)

symbol(v::Variable) = v.sym


########################################
#
#   Maps
#
########################################

type MapExpr{F<:Functor, Args<:(AbstractNumExpr...)}
	args::Args
end

MapExpr{F<:Functor,Args<:(AbstractNumExpr...)}(::Type{F}, args::Args) = MapExpr{F,Args}(args)

mapexpr{F<:Functor}(::Type{F}, args::AbstractNumExpr...) = MapExpr(F, args)

== {F,Args}(x::MapExpr{F,Args}, y::MapExpr{F,Args}) = (x.args == y.args)


## arithmetics

- (x::AbstractNumExpr) = mapexpr(Negate, x)

+ (x::AbstractNumExpr, y::AbstractNumExpr) = mapexpr(Add, x, y)
- (x::AbstractNumExpr, y::AbstractNumExpr) = mapexpr(Subtract, x, y)

.+ (x::AbstractNumExpr, y::AbstractNumExpr) = mapexpr(Add, x, y)
.- (x::AbstractNumExpr, y::AbstractNumExpr) = mapexpr(Subtract, x, y)
.* (x::AbstractNumExpr, y::AbstractNumExpr) = mapexpr(Multiply, x, y)
./ (x::AbstractNumExpr, y::AbstractNumExpr) = mapexpr(Divide, x, y)
.\ (x::AbstractNumExpr, y::AbstractNumExpr) = mapexpr(Divide, y, x)

.^ (x::AbstractNumExpr, y::AbstractNumExpr) = mapexpr(Pow, x, y)

# algebraic functions

max(x::AbstractNumExpr, y::AbstractNumExpr) = mapexpr(MaxFun, x, y)
min(x::AbstractNumExpr, y::AbstractNumExpr) = mapexpr(MinFun, x, y)

abs(x::AbstractNumExpr) = mapexpr(AbsFun, x)
abs2(x::AbstractNumExpr) = mapexpr(Abs2Fun, x)
sqrt(x::AbstractNumExpr) = mapexpr(SqrtFun, x)
cbrt(x::AbstractNumExpr) = mapexpr(CbrtFun, x)

