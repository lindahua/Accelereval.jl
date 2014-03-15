# Math functions

# abstract base type for all symbolic function
abstract SFunction
global funsym

# the module containing all symbolic functions
module SFuns

import Accelereval: SFunction, funsym

# macro to define a SFunction type
macro define_sfun(T, ssym)
    quote
        type $T <: SFunction end
        global funsym
        funsym(::Type{$T}) = Meta.quot($ssym)
    end
end

## arithmetics

@define_sfun Plus (+) 
@define_sfun Minus (-) 
@define_sfun Multiply (*)
@define_sfun Divide (/)
@define_sfun RDivide (\)
@define_sfun Pow (^)

end # module SFuns

