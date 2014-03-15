module Accelereval

    import Base: show, symbol, eltype, ndims
    import Base: +, -, *, /, \, ^, %, .+, .-, .*, ./, .\, .^
    import Base: max, min
    import Base: abs, abs2, sqrt, cbrt

    # include sources

    include("common.jl")
    include("sfuns.jl")
end
