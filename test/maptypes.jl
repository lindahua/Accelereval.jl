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

function test_maptypes(pairs, ts)
	for (sf, vf) in pairs
		println("    testing $sf ...")
		for t in ts
			test_maptype(sf, vf, t)
		end
	end
end

function test_maptypes(pairs, t1s, t2s)
	for (sf, vf) in pairs
		println("    testing $sf ...")
		for t1 in t1s, t2 in t2s
			test_maptype(sf, vf, t1, t2)
		end
	end
end

## type lists

const inttypes = [Int8, Int16, Int32, Int64, Uint8, Uint16, Uint32, Uint64, Bool]
const fptypes = [Float32, Float64]
const cplxtypes = [Complex64, Complex128]

const realtypes = [inttypes, fptypes]
const numtypes = [realtypes, cplxtypes]

## Arithmetics

println("Arithmetics")

test_maptypes([(SNegate, -)], realtypes)

test_maptypes([(SAdd,+), (SSubtract,-), (SMultiply,.*), (SDivide,./), 
	(SPower,.^), (SDiv, div), (SMod, mod)], realtypes, realtypes)

# ignoring SFld, SRem


## Comparison

println("Comparison")

test_maptypes([(SEqual, .==), (SNotEqual, .!=), (SGreater, .>), (SLess, .<), 
	(SGreaterEqual, .>=), (SLessEqual, .<=)], realtypes, realtypes)


## Bit operations

println("Bit operations")

test_maptypes([(SBitwiseNot, ~)], inttypes)
test_maptypes([(SBitwiseAnd, &), (SBitwiseOr, |), (SBitwiseXor, $)], inttypes, inttypes)


## Simple functions

println("Simple functions")

test_maptypes([(SAbs, abs), (SAbs2, abs2), (SSign, sign)], realtypes)

test_maptypes([(SMax, max), (SMin, min)], realtypes, realtypes)

test_maptypes([
	(SFloor, floor), (SCeil, ceil), (SRound, round), (STrunc, trunc),
	(SIfloor, ifloor), (SIceil, iceil), (SIround, iround), (SItrunc, itrunc)], realtypes)


## Elementary functions

println("Elementary functions")

test_maptypes([(SSqrt, sqrt), (SCbrt, cbrt), 
	(SExp, exp), (SExp2, exp2), (SExp10, exp10), (SExpm1, expm1), 
	(SLog, log), (SLog2, log2), (SLog10, log10), (SLog1p, log1p), 
	(SSin, sin), (SCos, cos), (STan, tan), (SCot, cot), (SSec, sec), (SCsc, csc), 
	(SAsin, asin), (SAcos, acos), (SAtan, atan), (SAcot, acot), (SAsec, asec), (SAcsc, acsc), 
	(SSinh, sinh), (SCosh, cosh), (STanh, tanh), (SCoth, coth), (SSech, sech), (SCsch, csch), 
	(SAsinh, asinh), (SAcosh, acosh), (SAtanh, atanh), (SAcoth, acoth), (SAsech, asech), (SAcsch, acsch)],  
	realtypes)

# ignoring: sind, asind, ...

test_maptypes([(SExponent, exponent), (SSignificand, significand)], fptypes)

test_maptypes([(SHypot, hypot), (SAtan2, atan2)], realtypes, realtypes)


## Special functions

println("Special functions")

test_maptypes([(SErf, erf), (SErfc, erfc), (SErfinv, erfinv), (SErfcinv, erfcinv), 
	(SGamma, gamma), (SLgamma, lgamma), (SEta, eta), (SZeta, zeta)], fptypes) 

test_maptypes([(SBeta, beta), (SLbeta, lbeta)], fptypes, fptypes)


