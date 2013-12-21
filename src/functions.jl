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

export SNegate, SAdd, SSubtract, SMultiply, SDivide, SPower, SModulo

@def_sfunc SNegate (-) 
@def_sfunc SAdd (+)
@def_sfunc SSubtract (-)
@def_sfunc SMultiply (*)
@def_sfunc SDivide (/)
@def_sfunc SPower (^)
@def_sfunc SModulo (%)

@def_sfunc SDiv div
@def_sfunc SFld fld
@def_sfunc SRem rem
@def_sfunc SMod mod

# Compare

export SMax, SMin
export SGreater, SLess, SGreaterEqual, SLessEqual, SEqual, SNotEqual

@def_sfunc SMax max
@def_sfunc SMin min

@def_sfunc SGreater (>)
@def_sfunc SLess (<)
@def_sfunc SGreaterEqual (>=)
@def_sfunc SLessEqual (<=)
@def_sfunc SEqual (==)
@def_sfunc SNotEqual (!=)

# Algebraic

export SAbs, SAbs2, SSqrt, SCbrt

@def_sfunc SAbs abs
@def_sfunc SAbs2 abs2
@def_sfunc SSqrt sqrt
@def_sfunc SCbrt cbrt

