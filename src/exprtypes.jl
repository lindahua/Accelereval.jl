# Types of delayed expressions

abstract DelayedExpr

immutable DelayedArray{Arr<:AbstractArray} <: DelayedExpr
	arr::Arr
end

DelayedArray{Arr<:AbstractArray}(arr::Arr) = DelayedArray{Arr}(arr)

# delayed map expression

typealias DeArg Union(DelayedExpr,Number)

immutable DelayedUnaryMap{F,A1<:DeArg} <: DelayedExpr
	a1::A1
end

DelayedUnaryMap{A1<:DeArg}(f::Symbol, a1::A1) = DelayedUnaryMap{f,A1}(a1)
funsym{F}(x::DelayedUnaryMap{F}) = F
arguments(x::DelayedUnaryMap) = (x.a1,)

immutable DelayedBinaryMap{F,A1<:DeArg,A2<:DeArg} <: DelayedExpr
	a1::A1
	a2::A2
end

DelayedBinaryMap{A1<:DeArg,A2<:DeArg}(f::Symbol, a1::A1, a2::A2) = DelayedBinaryMap{f,A1,A2}(a1,a2)
funsym{F}(x::DelayedBinaryMap{F}) = F
arguments(x::DelayedBinaryMap) = (x.a1, x.a2)

immutable DelayedTernaryMap{F,A1<:DeArg,A2<:DeArg,A3<:DeArg} <: DelayedExpr
	a1::A1
	a2::A2
	a3::A3
end

DelayedTernaryMap{A1<:DeArg,A2<:DeArg,A3<:DeArg}(f::Symbol, a1::A1, a2::A2, a3::A3) = DelayedTernaryMap{f,A1,A2,A3}(a1,a2,a3)
funsym{F}(x::DelayedTernaryMap{F}) = F
arguments(x::DelayedTernaryMap) = (x.a1, x.a2, x.a3)

typealias DelayedMap Union(DelayedUnaryMap, DelayedBinaryMap, DelayedTernaryMap)


# uniform syntax to construct delayed expressions

dex(x::Number) = x
dex(arr::AbstractArray) = DelayedArray(arr)

dex(f::Symbol, a1::DeArg) = DelayedUnaryMap(f, a1)
dex(f::Symbol, a1::DeArg, a2::DeArg) = DelayedBinaryMap(f, a1, a2)
dex(f::Symbol, a1::DeArg, a2::DeArg, a3::DeArg) = DelayedTernaryMap(f, a1, a2, a3)


# Shape of expressions

result_size(x::DelayedArray) = size(x.arr)

result_size(x::DelayedUnaryMap) = result_size(x.a1)
result_size(x::DelayedBinaryMap) = mapsize(x.a1, x.a2)
result_size(x::DelayedTernaryMap) = mapsize(x.a1, x.a2, x.a3)

mapsize(x1::DelayedExpr, x2::DelayedExpr) = promote_shape(result_size(x1), result_size(x2))
mapsize(x1::DelayedExpr, x2::Number) = result_size(x1)
mapsize(x1::Number, x2::DelayedExpr) = result_size(x2)

mapsize(x1::DelayedExpr, x2::DelayedExpr, x3::DelayedExpr) = promote_shape(mapsize(x1, x2), result_size(x3))

mapsize(x1::DelayedExpr, x2::DelayedExpr, x3::Number) = promote_shape(result_size(x1), result_size(x2))
mapsize(x1::DelayedExpr, x2::Number, x3::DelayedExpr) = promote_shape(result_size(x1), result_size(x3))
mapsize(x1::Number, x2::DelayedExpr, x3::DelayedExpr) = promote_shape(result_size(x2), result_size(x3))

mapsize(x1::DelayedExpr, x2::Number, x3::Number) = result_size(x1)
mapsize(x1::Number, x2::DelayedExpr, x3::Number) = result_size(x2)
mapsize(x1::Number, x2::Number, x3::DelayedExpr) = result_size(x3)






