# Testing on compile tools

using Accelereval
using Base.Test

import Accelereval: parse_vardecl

@test_throws parse_vardecl(:a)   # no type annotation

@test parse_vardecl(:(a::Float64)) == variable(:a, Float64, 0)
@test_throws parse_vardecl(:(a::FloatingPoint))   # non-recognized type

@test parse_vardecl(:(x::Vector{Int})) == variable(:x, Int, 1)
@test parse_vardecl(:(x::Matrix{Int})) == variable(:x, Int, 2)
@test_throws parse_vardecl(:(a::Vector))   # no annotation of element type
@test_throws parse_vardecl(:(a::Matrix{Number}))   # non-recognized element type

