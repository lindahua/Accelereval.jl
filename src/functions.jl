# Math functions

########################################
#
#   symbolic function types
#
########################################

abstract SFunc

macro def_sfunc(cname, sym)
	quote
		type $(cname) <: SFunc end

		global symbol
		symbol(::Type{$(cname)}) = $(Meta.quot(sym))
	end
end

# Arithmetics

export SNegate, SAdd, SSubtract, SMultiply, SDivide, SPower
export SDiv, SFld, SRem, SMod

@def_sfunc SNegate (-) 
@def_sfunc SAdd (+)
@def_sfunc SSubtract (-)
@def_sfunc SMultiply (*)
@def_sfunc SDivide (/)
@def_sfunc SPower (^)

@def_sfunc SDiv div
@def_sfunc SFld fld
@def_sfunc SRem rem
@def_sfunc SMod mod

# Compare

export SGreater, SLess, SGreaterEqual, SLessEqual, SEqual, SNotEqual

@def_sfunc SGreater (>)
@def_sfunc SLess (<)
@def_sfunc SGreaterEqual (>=)
@def_sfunc SLessEqual (<=)
@def_sfunc SEqual (==)
@def_sfunc SNotEqual (!=)

# Bit operations

export SBitwiseNot, SBitwiseAnd, SBitwiseOr, SBitwiseXor

type SBitwiseNot <: SFunc end
symbol(::Type{SBitwiseNot}) = :~

type SBitwiseAnd <: SFunc end
symbol(::Type{SBitwiseAnd}) = :&

type SBitwiseOr <: SFunc end
symbol(::Type{SBitwiseOr}) = :|

type SBitwiseXor <: SFunc end
symbol(::Type{SBitwiseXor}) = :$	


# Simple functions

export SMax, SMin, SAbs, SAbs2, SSign
export SFloor, SCeil, SRound, STrunc, SIfloor, SIceil, SIround, SItrunc

@def_sfunc SMax max
@def_sfunc SMin min

@def_sfunc SAbs abs
@def_sfunc SAbs2 abs2
@def_sfunc SSign sign

@def_sfunc SFloor floor
@def_sfunc SCeil  ceil
@def_sfunc SRound round
@def_sfunc STrunc trunc

@def_sfunc SIfloor ifloor
@def_sfunc SIceil  iceil
@def_sfunc SIround iround
@def_sfunc SItrunc itrunc


# Elementary functions

export SSqrt, SCbrt, SHypot
export SExp, SExp2, SExp10, SExpm1, SLog, SLog2, SLog10, SLog1p, SExponent, SSignificand
export SSin, SCos, STan, SCot, SSec, SCsc, SAsin, SAcos, SAtan, SAcot, SAsec, SAcsc, SAtan2
export SSinh, SCosh, STanh, SCoth, SSech, SCsch, SAsinh, SAcosh, SAtanh, SAcoth, SAsech, SAcsch
export SSind, SCosd, STand, SCotd, SSecd, SCscd, SAsind, SAcosd, SAtand, SAcotd, SAsecd, SAcscd

@def_sfunc SSqrt sqrt
@def_sfunc SCbrt cbrt
@def_sfunc SHypot hypot

@def_sfunc SExp exp
@def_sfunc SExp2 exp2
@def_sfunc SExp10 exp10
@def_sfunc SExpm1 expm1

@def_sfunc SLog log
@def_sfunc SLog2 log2
@def_sfunc SLog10 log10
@def_sfunc SLog1p log1p

@def_sfunc SExponent exponent
@def_sfunc SSignificand significand

@def_sfunc SSin sin
@def_sfunc SCos cos
@def_sfunc STan tan
@def_sfunc SCot cot
@def_sfunc SSec sec
@def_sfunc SCsc csc

@def_sfunc SAsin asin
@def_sfunc SAcos acos
@def_sfunc SAtan atan
@def_sfunc SAcot acot
@def_sfunc SAsec asec
@def_sfunc SAcsc acsc
@def_sfunc SAtan2 atan2

@def_sfunc SSinh sinh
@def_sfunc SCosh cosh
@def_sfunc STanh tanh
@def_sfunc SCoth coth
@def_sfunc SSech sech
@def_sfunc SCsch csch

@def_sfunc SAsinh asinh
@def_sfunc SAcosh acosh
@def_sfunc SAtanh atanh
@def_sfunc SAcoth acoth
@def_sfunc SAsech asech
@def_sfunc SAcsch acsch

@def_sfunc SSind sind
@def_sfunc SCosd cosd
@def_sfunc STand tand
@def_sfunc SCotd cotd
@def_sfunc SSecd secd
@def_sfunc SCscd cscd

@def_sfunc SAsind asind
@def_sfunc SAcosd acosd
@def_sfunc SAtand atand
@def_sfunc SAcotd acotd
@def_sfunc SAsecd asecd
@def_sfunc SAcscd acscd


# Special functions

export SErf, SErfc, SErfinv, SErfcinv
export SGamma, SLgamma, SDigamma, SBeta, SLbeta, SEta, SZeta

@def_sfunc SErf erf
@def_sfunc SErfc erfc
@def_sfunc SErfinv erfinv
@def_sfunc SErfcinv erfcinv

@def_sfunc SGamma gamma
@def_sfunc SLgamma lgamma
@def_sfunc SDigamma digamma
@def_sfunc SBeta beta
@def_sfunc SLbeta lbeta
@def_sfunc SEta eta
@def_sfunc SZeta zeta


