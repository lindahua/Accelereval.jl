# Test maptypes

using Accelereval

## Facilities for type testing

function actual_maptype(vecfun::Function, t1::Type)
	a1 = ones(t1, (1,))
	eltype(vecfun(a1))
end

function actual_maptype(vecfun::Function, t1::Type, t2::Type)
	a1 = ones(t1, (1,))
	a2 = ones(t2, (1,))
	eltype(vecfun(a1, a2))
end

function test_maptype{F<:SFunc}(sf::Type{F}, vecfun::Function, ts::Type...)
	at = actual_maptype(vecfun, ts...)
	rt = maptype(F, ts...)
	if !(at == rt)
		error("maptype of $F on $ts ==> $rt (expecting $at).")
	end
end

const inttypes = [Int8, Int16, Int32, Int64, Uint8, Uint16, Uint32, Uint64, Bool]
const fptypes = [Float32, Float64]
const cplxtypes = [Complex64, Complex128]

const realtypes = [inttypes, fptypes]
const numtypes = [realtypes, cplxtypes]

## Arithmetics

println("Arithmetics")

for (sf, vf) in [(SNegate, -)]
	println("    testing $sf ...")
	for t in realtypes
		test_maptype(sf, vf, t)
	end
end

for (sf, vf) in [
	(SAdd,+), (SSubtract,-), (SMultiply,.*), (SDivide,./), (SPower,.^), 
	(SDiv, div), (SMod, mod)]  # ignoring: SFld, SRem

	println("    testing $sf ...")
	for t1 in realtypes, t2 in realtypes
		test_maptype(sf, vf, t1, t2)
	end
end

## Comparison

println("Comparison")

for (sf, vf) in [
	(SMax, max), (SMin, min), (SEqual, .==), (SNotEqual, .!=),
	(SGreater, .>), (SLess, .<), (SGreaterEqual, .>=), (SLessEqual, .<=)]

	println("    testing $sf ...")
	for t1 in realtypes, t2 in realtypes
		test_maptype(sf, vf, t1, t2)
	end
end

