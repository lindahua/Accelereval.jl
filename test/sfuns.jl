using Accelereval
using Base.Test

import Accelereval: SFuns, funsym

@test funsym(SFuns.Plus) == :+
@test funsym(SFuns.Minus) == :-
@test funsym(SFuns.Multiply) == :*
@test funsym(SFuns.Divide) == :/
@test funsym(SFuns.RDivide) == :\
@test funsym(SFuns.Pow) == :^

@test funsym(SFuns.LT) == :<
@test funsym(SFuns.GT) == :>
@test funsym(SFuns.LE) == :<=
@test funsym(SFuns.GE) == :>=
@test funsym(SFuns.EQ) == :(==)
@test funsym(SFuns.NE) == :!=

@test funsym(SFuns.Not) == :~
@test funsym(SFuns.And) == :&
@test funsym(SFuns.Or) == :|
@test funsym(SFuns.Xor) == :$

@test funsym(SFuns.Abs) == :abs
@test funsym(SFuns.Exp) == :exp
@test funsym(SFuns.Sin) == :sin
@test funsym(SFuns.Erf) == :erf

