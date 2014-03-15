using Accelereval
using Base.Test

@test funsym(SFuns.Plus) == :+
@test funsym(SFuns.Minus) == :-
@test funsym(SFuns.Multiply) == :*
@test funsym(SFuns.Divide) == :/
@test funsym(SFuns.RDivide) == :\
@test funsym(SFuns.Pow) == :^
