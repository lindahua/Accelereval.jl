# Types of expressions


abstract AbstractNumExpr

########################################
#
#   Constants & Variables
#
########################################

type Constant{T<:Number} <: AbstractNumExpr
	value::T
end

constant{T<:Number}(v::T) = Constant{T}(v)

type Variable{T,D} <: AbstractNumExpr
	sym::Symbol
end

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
	f::F
	args::Args
end

MapExpr{F<:Functor,Args<:(AbstractNumExpr...)}(f::F, args::Args) = MapExpr{F,Args}(f,args)

mapexpr(f::Functor, args::AbstractNumExpr...) = MapExpr(f, args)

