# Math functions on delayed expressions


# Import base arithmetic & math functions for extension

import 

	# arithmetics
	Base.+, Base.-, Base.*, Base./, Base.\, Base.^,
	Base.(.+), Base.(.-), Base.(.*), Base.(./), Base.(.^),

	# logical & comparison
	Base.&, Base.|, Base.~, Base.$, 
	Base.(.==), Base.(.!=), Base.(.>), Base.(.<), Base.(.>=), Base.(.<=),

	# math functions
	Base.div, Base.fld, Base.rem, Base.mod,
	Base.isnan, Base.isfinite, Base.isinf, 
	Base.abs, Base.abs2, Base.sign, Base.sqrt, Base.cbrt, Base.hypot,
	Base.floor, Base.ceil, Base.round, Base.trunc, 
	Base.ifloor, Base.iceil, Base.iround, Base.itrunc,
	Base.exp, Base.exp2, Base.exp10, Base.expm1,
	Base.log, Base.log2, Base.log10, Base.log1p,
	Base.sin, Base.cos, Base.tan, Base.cot, Base.sec, Base.csc,
	Base.sinh, Base.cosh, Base.tanh, Base.coth, Base.sech, Base.csch,
	Base.asin, Base.acos, Base.atan, Base.acot, Base.asec, Base.acsc, Base.atan2,
	Base.asinh, Base.acosh, Base.atanh, Base.acoth, Base.asech, Base.acsch,
	Base.sind, Base.cosd, Base.tand, Base.cotd, Base.secd, Base.cscd,
	Base.asind, Base.acosd, Base.atand, Base.acotd, Base.asecd, Base.acscd,
	Base.erf, Base.erfc, Base.erfinv, Base.erfcinv, Base.gamma, Base.lgamma, Base.digamma, 
	Base.beta, Base.lbeta, Base.eta, Base.zeta


# Extensions

# some specialized definitions for *, /, \

* (x1::DelayedExpr, x2::Number) = dex(:*, x1, x2)
* (x1::Number, x2::DelayedExpr) = dex(:*, x1, x2)
/ (x1::DelayedExpr, x2::Number) = dex(:/, x1, x2)
/ (x1::Number, x2::DelayedExpr) = dex(:/, x1, x2)
\ (x1::DelayedExpr, x2::Number) = dex(:\, x1, x2)
\ (x1::Number, x2::DelayedExpr) = dex(:\, x1, x2)

# generic definitions

const unary_ewise_ops = [
	:-, :~, :isnan, :isfinite, :isinf, :abs, :abs2, :sign, :sqrt, :cbrt, 
	:floor, :ceil, :round, :trunc, :ifloor, :iceil, :iround, :itrunc, 
	:exp, :exp2, :exp10, :expm1, :log, :log2, :log10, :log1p,
	:sin, :cos, :tan, :cot, :sec, :csc, :sinc, :cosc,
	:sinh, :cosh, :tanh, :coth, :sech, :csch,
	:asin, :acos, :atan, :acot, :asec, :acsc,
	:asinh, :acosh, :atanh, :acoth, :asech, :acsch,
	:sind, :cosd, :tand, :cotd, :secd, :cscd, 
	:asind, :acosd, :atand, :acotd, :asecd, :acscd, 
	:erf, :erfc, :erfinv, :erfcinv, :gamma, :lgamma, :digamma]

for op in unary_ewise_ops
	@eval ($op)(x::DelayedExpr) = dex($(Meta.quot(op)), x)
end

const binary_ewise_ops = [
	:+, :-, :.+, :.-, :.*, :./, :.^, :div, :fld, :rem, :mod, 
	:&, :|, :$, :.==, :.!=, :.<, :.>, :.<=, :.>=, 
	:hypot, :atan2, :beta, :lbeta, :eta, :zeta]

for op in binary_ewise_ops
	@eval ($op)(x1::DelayedExpr, x2::DelayedExpr) = dex($(Meta.quot(op)), x1, x2)
	@eval ($op)(x1::DelayedExpr, x2::Number) = dex($(Meta.quot(op)), x1, x2)
	@eval ($op)(x1::Number, x2::DelayedExpr) = dex($(Meta.quot(op)), x1, x2)
end

