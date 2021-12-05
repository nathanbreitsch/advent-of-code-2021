integers = [
    [parse(Int, c) for c in line]
    for line in readlines("data/3.txt")
]

# multiply by 1 to make Vec{Int}
gamma_bits = (sum(integers) .>= 500) * 1 
epsilon_bits = 1 .- gamma_bits
gamma = parse(Int, join(gamma_bits), base=2)
epsilon = parse(Int, join(epsilon_bits), base=2)
println(gamma * epsilon)

# Part 2
function find_last_remaining_row(_mat, most_common=true)
    mat = copy(_mat)
    for column in 1:12
        bit_sum = sum([row[column] for row in mat])
        println(bit_sum)
        next_bit = if most_common
            if bit_sum >= length(mat) / 2
                1
            else
                0
            end
        else
            if bit_sum >= length(mat) / 2
                0
            else
                1
            end
        end

        filter!(r -> r[column] == next_bit, mat)
        if length(mat) == 1
            return mat[1]
        end
    end
end


oxygen_bits = find_last_remaining_row(integers)
co2_bits = find_last_remaining_row(integers, false)
oxygen = parse(Int, join(oxygen_bits), base=2)
co2 = parse(Int, join(co2_bits), base=2)
println(co2 * oxygen)

