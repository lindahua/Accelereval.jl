# Math functions on delayed expressions


# Import base arithmetic & math functions for extension

import 

	# arithmetics
	Base.+, Base.-, Base.*, Base./, Base.^,
	Base.(.+), Base.(.-), Base.(.*), Base.(./), Base.(.^),

	# elementary functions
	Base.abs, Base.abs2



# Extensions

# some specialized definitions to work around ambiguities

^ (x1::DelayedExpr, x2::Integer) = dex(:^, x1, x2)

# generic definitions

const unary_ops = [:-, :abs, :abs2]

for op in unary_ops
	@eval ($op)(x::DelayedExpr) = dex($(Meta.quot(op)), x)
end

const binary_ops = [:+, :-, :*, :/, :^, :.+, :.-, :.*, :./, :.^]

for op in binary_ops
	@eval ($op)(x1::DelayedExpr, x2::DelayedExpr) = dex($(Meta.quot(op)), x1, x2)
	@eval ($op)(x1::DelayedExpr, x2::Number) = dex($(Meta.quot(op)), x1, x2)
	@eval ($op)(x1::Number, x2::DelayedExpr) = dex($(Meta.quot(op)), x1, x2)
end


