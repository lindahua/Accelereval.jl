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

# Simple functions

export SMax, SMin, SAbs, SAbs2, SSign, SCopysign

@def_sfunc SMax max
@def_sfunc SMin min

@def_sfunc SAbs abs
@def_sfunc SAbs2 abs2
@def_sfunc SSign sign

# Elementary functions

export SSqrt, SCbrt, SHypot
export SExp, SExp2, SExp10, SExpm1, SLog, SLog2, SLog10, SLog1p, SExponent, SSignificand

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




