# The basic facilities for compilation

compile_log(s::String) = println(s)
compile_error(msg::String) = error("[Accelereval]: $msg")

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

typealias VariableMap Dict{Symbol,Variable}

type CompilationContext
	funname::Symbol                 # function name
	funparams::Vector{Variable}     # list of (annotated) function parameters
	varmap::VariableMap  			# symbol name -> variable
	compiled_codes::Vector{Expr}

	function CompilationContext(fname::Symbol, fparams::Vector{Variable})
		varmap = (Symbol=>Variable)[]

		# initialize variable map using function parameters
		for p in fparams
			s = symbol(p)
			if haskey(varmap, s)
				compile_error("function parameter $s is repeatedly declared.")
			end
			varmap[s] = p
		end

		compiled_codes = Expr[]
		new(fname, fparams, varmap, compiled_codes)
	end
end



