data = read("data/4.txt", String)
chunks = split(data, "\n\n")
numbers = map(c -> parse(Int, c), split(chunks[1], ','))
boards = [
      reshape([parse(Int, c) for c in split(chunk)], (5, 5))
      for chunk in chunks[2:end]
]

function is_winner(marker_board)
    any(all(marker_board, dims=1)) ||
    any(all(marker_board, dims=2))
end

function solve(boards, numbers)
    marker_boards = [fill(false, (5, 5)) for _ in boards]
    for number in numbers
        for i in 1:length(boards)
            new_markers = (boards[i] .== number)
            marker_boards[i] = broadcast(max, marker_boards[i], new_markers)
            if is_winner(marker_boards[i])
                mask = marker_boards[i]
                return number * sum(boards[i] .* (1 .- marker_boards[i]))
            end
        end
    end
end
answer = solve(boards, numbers)
println(answer)

function solve2(boards, numbers)
    marker_boards = [fill(false, (5, 5)) for _ in boards]
    won = zeros(length(boards))
    for number in numbers
        for i in 1:length(boards)
            if won[i] == 0
                new_markers = (boards[i] .== number)
                marker_boards[i] = broadcast(max, marker_boards[i], new_markers)
                if is_winner(marker_boards[i])
                    if length(boards) - sum(won) == 1
                        mask = marker_boards[i]
                        score = number * sum(boards[i] .* (1 .- marker_boards[i]))
                        return score
                    else
                        won[i] = 1
                    end
                end
            end
        end
    end
end

answer = solve2(boards, numbers)
println(answer)

