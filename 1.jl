function rolling_sum(x, w)
    [sum(x[s:s+w-1]) for s in 1:(length(x)-w+1)]
end

function count_increases(x)
    sum(x[2:end] .> x[1:end-1])
end

lines = readlines("data/1.txt")
numbers = map(s -> parse(Int, s), lines)

# first
answer = count_increases(numbers)
println(answer)

# second
rsum = rolling_sum(numbers, 3)
answer = count_increases(rsum)
println(answer)
