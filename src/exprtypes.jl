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

eltype{T,D}(v::Variable{T,D}) = T
ndims{T,D}(v::Variable{T,D}) = D

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

# map expression

type MapExpr{F<:SFunc, Args<:(AbstractNumExpr...)}
	args::Args
end

MapExpr{F<:SFunc, Args<:(AbstractNumExpr...)}(::Type{F}, args::Args) = MapExpr{F,Args}(args)

mapexpr{F<:SFunc}(::Type{F}, args::AbstractNumExpr...) = MapExpr(F, args)

funsym{F<:SFunc}(x::MapExpr{F}) = symbol(F)

== {F<:SFunc,Args}(x::MapExpr{F,Args}, y::MapExpr{F,Args}) = (x.args == y.args)


########################################
#
#   extended functions to construct
#   map expressions
#
########################################

macro decl_map1(s, F)
	quote
		global ($s)
		($s)(x::AbstractNumExpr) = mapexpr($F, x)
	end
end

macro decl_map2(s, F)
	quote
		global ($s)
		($s)(x::AbstractNumExpr, y::AbstractNumExpr) = mapexpr($F, x, y)
	end
end

## arithmetics

@decl_map1 (-) SNegate

@decl_map2 (+) SAdd
@decl_map2 (.+) SAdd
@decl_map2 (-) SSubtract
@decl_map2 (.-) SSubtract

@decl_map2 (.*) SMultiply
@decl_map2 (./) SDivide
@decl_map2 (.^) SPower

(.\)(x::AbstractNumExpr, y::AbstractNumExpr) = mapexpr(SDivide, y, x)

# algebraic functions

@decl_map2 max SMax
@decl_map2 min SMin

@decl_map1 abs SAbs
@decl_map1 abs2 SAbs2
@decl_map1 sqrt SSqrt
@decl_map1 cbrt SCbrt


