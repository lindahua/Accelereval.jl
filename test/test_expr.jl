using DelayExpr
using Base.Test

a = [1, 2, 3]
b = [3, 5, 6]

println(dex(a))
println(dex(a) + abs2(dex(b)))
