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

# symbolic functions

type SFunc{S} end 

SFunc(s::Symbol) = SFunc{s}()
symbol{S}(f::SFunc{S}) = S

# map expression

type MapExpr{S, Args<:(AbstractNumExpr...)}
	args::Args
end

MapExpr{Args<:(AbstractNumExpr...)}(S::Symbol, args::Args) = MapExpr{S,Args}(args)

mapexpr(S::Symbol, args::AbstractNumExpr...) = MapExpr(S, args)

funsym{S}(x::MapExpr{S}) = S

== {S,Args}(x::MapExpr{S,Args}, y::MapExpr{S,Args}) = (x.args == y.args)

macro decl_map1(s)
	quote
		global ($s)
		($s)(x::AbstractNumExpr) = mapexpr($(Meta.quot(s)), x)
	end
end

macro decl_map2(s)
	quote
		global ($s)
		($s)(x::AbstractNumExpr, y::AbstractNumExpr) = mapexpr($(Meta.quot(s)), x, y)
	end
end

## arithmetics

@decl_map1 -

@decl_map2 +
@decl_map2 -

.+ (x::AbstractNumExpr, y::AbstractNumExpr) = mapexpr(:+, x, y)
.- (x::AbstractNumExpr, y::AbstractNumExpr) = mapexpr(:-, x, y)
.* (x::AbstractNumExpr, y::AbstractNumExpr) = mapexpr(:*, x, y)
./ (x::AbstractNumExpr, y::AbstractNumExpr) = mapexpr(:/, x, y)
.\ (x::AbstractNumExpr, y::AbstractNumExpr) = mapexpr(:\, y, x)

.^ (x::AbstractNumExpr, y::AbstractNumExpr) = mapexpr(:^, x, y)

# algebraic functions

@decl_map2 max
@decl_map2 min

@decl_map1 abs
@decl_map1 abs2
@decl_map1 sqrt
@decl_map1 cbrt


