module Smartrek

export get_bool_vec,
    Circuit,
    sum_ans,
    XOR, XNOR, AND, NAND, OR, NOR, NOT

# define logical operators
XOR(a,b) = ⊻(a,b)
XNOR(a,b) = !⊻(a,b)
AND(a,b) = a & b
NAND(a,b) = !(a & b)
OR(a,b) = a | b
NOR(a,b) = !(a | b)
NOT(a) = !a

# convert integer into a vector its boolean representation
function get_bool_vec(n::Int; size)
    Bool.(digits(n, base=2, pad=size))
end

# Circuit - containes size and fucntion which returns the circuit output given input
struct Circuit{F}
    size::Int
    f::F
end

# overload structure with function returning the output for a given vector of Bool
function (c::Circuit)(x::BitVector)
    @assert c.size == length(x)
    return c.f(x)
end

# circuit result from integer input
function (c::Circuit)(x::Int)
    x_vec = get_bool_vec(x, size=10)
    return c.f(x_vec)
end

# return sum and list of validation numbers
function sum_ans(c::Circuit)
    x = 0
    l = Vector{Int}()
    for i in 0:2^c.size-1
        if c(get_bool_vec(i, size=c.size))
            x += i
            push!(l, i)
        end
    end
    return (sum=x, list=l)
end

end # module
