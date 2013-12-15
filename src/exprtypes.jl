# Types of delayed expressions

abstract DelayedExpr

immutable DelayedArray{Arr<:AbstractArray} <: DelayedExpr
	arr::Arr
end

DelayedArray{Arr<:AbstractArray}(arr::Arr) = DelayedArray{Arr}(arr)

# delayed map expression

typealias DeArg Union(DelayedExpr,Number)

immutable DelayedUnaryMap{F,A1<:DeArg}
	a1::A1
end

DelayedUnaryMap{F,A1<:DeArg}(f::Symbol, a1::A1) = DelayedUnaryMap{F,A1}(f,a1)
funsym{F}(x::DelayedUnaryMap{F}) = F
arguments(x::DelayedUnaryMap) = (x.a1,)

immutable DelayedBinaryMap{F,A1<:DeArg,A2<:DeArg}
	a1::A1
	a2::A2
end

DelayedBinaryMap{F,A1<:DeArg,A2<:DeArg}(f::Symbol, a1::A1, a2::A2) = DelayedBinaryMap{F,A1,A2}(f,a1,a2)
funsym{F}(x::DelayedBinaryMap{F}) = F
arguments(x::DelayedBinaryMap) = (x.a1, x.a2)

immutable DelayedTernaryMap{F,A1<:DeArg,A2<:DeArg,A3<:DeArg}
	a1::A1
	a2::A2
	a3::A3
end

DelayedTernaryMap{F,A1<:DeArg,A2<:DeArg,A3<:DeArg}(f::Symbol, a1::A1, a2::A2, a3::A3) = DelayedTernaryMap{F,A1,A2,A3}(f,a1,a2,a3)
funsym{F}(x::DelayedTernaryMap{F}) = F
arguments(x::DelayedTernaryMap) = (x.a1, x.a2, x.a3)

typealias DelayedMap Union(DelayedUnaryMap, DelayedBinaryMap, DelayedTernaryMap)


# uniform syntax to construct delayed expressions

dex(arr::AbstractArray) = DelayedArray(arr)

dex(f::Symbol, a1::DeArg) = DelayedUnaryMap(f, a1)
dex(f::Symbol, a1::DeArg, a2::DeArg) = DelayedBinaryMap(f, a1, a2)
dex(f::Symbol, a1::DeArg, a2::DeArg, a3::DeArg) = DelayedTernaryMap(f, a1, a2, a3)

