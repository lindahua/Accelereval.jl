# Type inference facilities

#################################################
#
#    Numeric type to float types
#
#################################################

_fptype{T<:FloatingPoint}(::Type{T}) = T

# according to base/float.jl
_fptype(::Type{Bool}) = Float32

_fptype(::Type{Int8}) = Float32
_fptype(::Type{Int16}) = Float32
_fptype(::Type{Int32}) = Float64
_fptype(::Type{Int64}) = Float64
_fptype(::Type{Int128}) = Float64

_fptype(::Type{Uint8}) = Float32
_fptype(::Type{Uint16}) = Float32
_fptype(::Type{Uint32}) = Float64
_fptype(::Type{Uint64}) = Float64
_fptype(::Type{Uint128}) = Float64

_fptype{T<:FloatingPoint}(::Type{Complex{T}}) = Complex{T}
_fptype{T<:Number}(::Type{Complex{T}}) = Complex{_fptype(T)}

promote_fptype{T1<:FloatingPoint, T2<:FloatingPoint}(::Type{T1}, ::Type{T2}) = promote_type(T1, T2)
promote_fptype{T1<:FloatingPoint, T2<:Integer}(::Type{T1}, ::Type{T2}) = T1
promote_fptype{T1<:Integer, T2<:FloatingPoint}(::Type{T1}, ::Type{T2}) = T2
promote_fptype{T1<:Number, T2<:Number}(::Type{T1}, ::Type{T2}) = promote_type(_fptype(T1), _fptype(T2))


#################################################
#
#    Arithmetic operations
#
#################################################

for C in [SAdd, SSubtract, SMultiply, SDiv, SFld, SRem, SMod]
	@eval maptype{T1<:Number, T2<:Number}(::Type{$C}, ::Type{T1}, ::Type{T2}) = promote_type(T1, T2)
end

maptype(::Type{SAdd}, ::Type{Bool}, ::Type{Bool}) = Int
maptype(::Type{SSubtract}, ::Type{Bool}, ::Type{Bool}) = Int

# SNegate

maptype{T<:FloatingPoint}(::Type{SNegate}, ::Type{T}) = T
maptype{T<:Integer}(::Type{SNegate}, ::Type{T}) = T
maptype(::Type{SNegate}, ::Type{Bool}) = Int

# SDivide

maptype{T1<:Number,T2<:Number}(::Type{SDivide}, ::Type{T1}, ::Type{T2}) = promote_fptype(T1, T2)

# SPower

maptype{T1<:FloatingPoint, T2<:FloatingPoint}(::Type{SPower}, ::Type{T1}, ::Type{T2}) = promote_type(T1, T2)
maptype{T1<:FloatingPoint, T2<:Integer}(::Type{SPower}, ::Type{T1}, ::Type{T2}) = T1
maptype{T1<:Integer, T2<:FloatingPoint}(::Type{SPower}, ::Type{T1}, ::Type{T2}) = T2
maptype{T1<:Integer, T2<:Integer}(::Type{SPower}, ::Type{T1}, ::Type{T2}) = promote_type(T1, T2)
maptype{T2<:Integer}(::Type{SPower}, ::Type{Bool}, ::Type{T2}) = Bool


#################################################
#
#    comparison
#
#################################################

for C in [SEqual, SNotEqual]
	@eval maptype{T1<:Number, T2<:Number}(::Type{$C}, ::Type{T1}, ::Type{T2}) = Bool
end

for C in [SGreater, SLess, SGreaterEqual, SLessEqual]
	@eval maptype{T1<:Real, T2<:Real}(::Type{$C}, ::Type{T1}, ::Type{T2}) = Bool
end


#################################################
#
#    bit operations
#
#################################################

maptype{T<:Integer}(::Type{SBitwiseNot}, ::Type{T}) = T

for C in [SBitwiseAnd, SBitwiseOr, SBitwiseXor]
	@eval maptype{T1<:Integer, T2<:Integer}(::Type{$C}, ::Type{T1}, ::Type{T2}) = promote_type(T1, T2)
end


#################################################
#
#    simple functions
#
#################################################

# max & min
for C in [SMax, SMin]
	@eval maptype{T1<:Number, T2<:Number}(::Type{$C}, ::Type{T1}, ::Type{T2}) = promote_type(T1, T2)
end

# abs
maptype(::Type{SAbs}, ::Type{Bool}) = Bool
maptype{T<:Unsigned}(::Type{SAbs}, ::Type{T}) = T
maptype{T<:Signed}(::Type{SAbs}, ::Type{T}) = promote_type(T, Int)
maptype{T<:FloatingPoint}(::Type{SAbs}, ::Type{T}) = T

# abs2
maptype{T<:FloatingPoint}(::Type{SAbs2}, ::Type{T}) = T
maptype{T<:Signed}(::Type{SAbs2}, ::Type{T}) = promote_type(T, Int)
maptype{T<:Unsigned}(::Type{SAbs2}, ::Type{T}) = promote_type(T, Uint)
maptype(::Type{SAbs2}, ::Type{Bool}) = Bool

# sign
maptype{T<:Real}(::Type{SSign},::Type{T}) = T

# rounding

for C in [SFloor, SCeil, SRound, STrunc]
	@eval maptype{T<:Real}(::Type{$C}, ::Type{T}) = T
end

for C in [SIfloor, SIceil, SIround, SItrunc]
	@eval maptype{T<:Integer}(::Type{$C}, ::Type{T}) = T
	@eval maptype{T<:FloatingPoint}(::Type{$C}, ::Type{T}) = Int64
end


#################################################
#
#    elementary functions
#
#################################################

for C in [SSqrt, SCbrt,
	SExp, SExp2, SExp10, SExpm1, SLog, SLog2, SLog10, SLog1p, 
	SSin, SCos, STan, SCot, SSec, SCsc, SAsin, SAcos, SAtan, SAcot, SAsec, SAcsc, 
	SSinh, SCosh, STanh, SCoth, SSech, SCsch, SAsinh, SAcosh, SAtanh, SAcoth, SAsech, SAcsch, 
	SSind, SCosd, STand, SCotd, SSecd, SCscd, SAsind, SAcosd, SAtand, SAcotd, SAsecd, SAcscd]

	@eval maptype{T<:Real}(::Type{$C}, ::Type{T}) = _fptype(T)
end

for C in [SHypot, SAtan2]
	@eval maptype{T<:Real}(::Type{$C}, ::Type{T}, ::Type{T}) = _fptype(T)
	@eval maptype{T1<:Real, T2<:Real}(::Type{$C}, ::Type{T1}, ::Type{T2}) = promote_type(_fptype(T1), _fptype(T2))
end

maptype{T<:FloatingPoint}(::Type{SExponent}, ::Type{T}) = Int
maptype{T<:FloatingPoint}(::Type{SSignificand}, ::Type{T}) = T


#################################################
#
#    special functions
#
#################################################

for C in [SErf, SErfc, SErfinv, SErfcinv, SGamma, SLgamma, SDigamma, SEta, SZeta]
	@eval maptype{T<:Real}(::Type{$C}, ::Type{T}) = _fptype(T)
end

for C in [SBeta, SLbeta]
	@eval maptype{T<:Real}(::Type{$C}, ::Type{T}, ::Type{T}) = _fptype(T)
	@eval maptype{T1<:Real, T2<:Real}(::Type{$C}, ::Type{T1}, ::Type{T2}) = promote_type(_fptype(T1), _fptype(T2))
end



