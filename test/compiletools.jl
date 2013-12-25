# Testing on compile tools

using Accelereval
using Base.Test

import Accelereval: parse_vardecl, parse_funhead

# parse variables

@test_throws parse_vardecl(:a)   # no type annotation

@test parse_vardecl(:(a::Float64)) == variable(:a, Float64, 0)
@test_throws parse_vardecl(:(a::FloatingPoint))   # non-recognized type

@test parse_vardecl(:(x::Vector{Int})) == variable(:x, Int, 1)
@test parse_vardecl(:(x::Matrix{Int})) == variable(:x, Int, 2)
@test_throws parse_vardecl(:(a::Vector))   # no annotation of element type
@test_throws parse_vardecl(:(a::Matrix{Number}))   # non-recognized element type

# parse function header

(fname, vars) = parse_funhead(:(myf(x::Float64, y::Matrix{Int})))
@test isa(fname, Symbol) && fname == :myf
@test length(vars) == 2
@test vars[1] == variable(:x, Float64, 0)
@test vars[2] == variable(:y, Int, 2)

