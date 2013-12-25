# Compile functions into an expression graph


###########################################################
#
#   Compilation context
#
#   A compilation context maintains useful information 
#   for compilation, which includes:
#
#   - a list of variables (together with their types & ranks)
#   - a list of compiled statements
#
#   A new context should be created for each compilation
#   process.
#
###########################################################


type CompilationContext
	funname::Symbol       # function name
	funparams::Vector     # list of (annotated) function parameters
	varmap::Dict{Symbol, Variable}  # symbol name -> variable
	compiled_codes::Vector{Expr}

	function CompilationContext(decl::Expr; verbose=false)
		@assert decl.head == :(call)
		funname = decl.args[1]
		funparams = decl.args[2:end]

		verbose && compile_log("function name: $(funname)")
		varmap = (Symbol=>Variable)[]

		# extract variables from function parameters
		if isempty(funparams)
			verbose && compile_log("no function parameters.")
		else
			verbose && compile_log("function parameters:")
			for t in funparams
				v = parse_paramdecl(t)
				s = symbol(v)
				haskey(varmap, s) && compile_error("repeated declaration of parameter $(s).")
				verbose && compile_log("  $s : {eltype(v), ndims(v)}")
				varmap[s] = v
			end
		end

		new(funname, funparams, varmap, Expr[])
	end
end



#################################################
#
#   Compiling
#
#################################################



