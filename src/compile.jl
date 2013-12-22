# Compile functions into an expression graph

#################################################
#
#   Compilation context
#
#################################################

type CompilationContext
	varmap::Dict{Symbol, Variable}  # symbol name -> variable
	
end





#################################################
#
#   Compiling
#
#################################################

nonvalid_function_err() = error("compile_function: The input expression is not a valid function.")

function compile_function(fex::Expr)
	if fex.head == :(=)   # f(params...) = ...
		@assert length(fex.args) == 2

		decl = fex.args[1]
		body = fex.args[2]

		decl.head == :(call) || nonvalid_function_err()
		compile_function(decl, body)
			
	elseif fex.head == :(function)  
		@assert length(fex.args) == 2

		decl = fex.args[1]
		decl = fex.args[2]
		@assert decl.head == :(call)

		compile_function(decl, body)

	else
		nonvalid_function_err()
	end
end


function compile_function(decl::Expr, body::Expr)

end

