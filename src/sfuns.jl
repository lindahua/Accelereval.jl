module SFuns

import Accelereval: TSym, NumericExpr, MapExpr, SFunction
import Accelereval: tcall, funsym

## operators

for (T, ss) in [

    # arithmetic operators 
    (:Plus, :+), 
    (:Minus, :-), 
    (:Multiply, :*), 
    (:Divide, :/), 
    (:RDivide, :\), 
    (:Pow, :^), 

    # comparison operators
    (:LT, :<), 
    (:GT, :>), 
    (:LE, :<=), 
    (:GE, :>=), 
    (:EQ, :(==)), 
    (:NE, :!=), 

    # logical operators
    (:Not, :~),
    (:And, :&), 
    (:Or,  :|),
    (:Xor, :$) ]

    @eval type $T <: SFunction end
    @eval funsym(::Type{$T}) = $(Meta.quot(ss))
end

## math functions

for fs in [

    # quotient & modulo
    :div, :fld, :rem, :mod, 

    # rounding
    :floor, :ceil, :trunc, :round, 
    :ifloor, :iceil, :itrunc, :iround, 

    # sign & abs
    :sign, :abs, :abs2,

    # algebraic
    :sqrt, :cbrt, :hypot, 

    # exp & log
    :exp, :exp2, :exp10, :expm1,
    :log, :log2, :log10, :log1p,

    # trigonometric
    :sin, :cos, :tan, :cot, :sec, :csc,
    :asin, :acos, :atan, :acot, :asec, :acsc,
    :sinc, :cosc, :atan2,

    # hyperbolic
    :sinh, :cosh, :tanh, :coth, :sech, :csch,
    :asinh, :acosh, :atanh, :acoth, :asech, :acsch,

    # error functions
    :erf, :erfc, :erfinv, :erfcinv, 

    # gamma, beta & friends
    :gamma, :lgamma, :digamma, 
    :beta, :lbeta, :eta, :zeta
    ]

    s = string(fs)
    T = symbol(string(uppercase(s[1]), s[2:end]))

    @eval type $T <: SFunction end
    @eval funsym(::Type{$T}) = $(Meta.quot(fs))
end





end # module SFuns

