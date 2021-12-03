struct Position
    x::Int
    y::Int
    aim::Int
end

@enum Direction up down forward

struct Delta
    direction::Direction
    magnitude::Int
end

function parse_input_line(line::String)::Delta
    (direction_str, magnitude_str) = split(line)
    direction = if direction_str == "up"
        up
    elseif direction_str == "down"
        down
    elseif direction_str == "forward"
        forward
    end
    magnitude = parse(Int, magnitude_str)
    Delta(direction, magnitude)
end

function update_position(p::Position, d::Delta)
    if d.direction == up
        Position(p.x, p.y - d.magnitude, 0)
    elseif d.direction == down
        Position(p.x, p.y + d.magnitude, 0)
    elseif d.direction == forward
        Position(p.x + d.magnitude, p.y, 0)
    end
end

function update_position_aim(p::Position, d::Delta)
    if d.direction == up
        Position(p.x, p.y, p.aim - d.magnitude)
    elseif d.direction == down
        Position(p.x, p.y, p.aim + d.magnitude)
    elseif d.direction == forward
        Position(p.x + d.magnitude, p.y + p.aim * d.magnitude, p.aim)
    end

end

raw_lines = readlines("data/2.txt")
deltas = map(parse_input_line, raw_lines)
final_position = reduce(update_position, deltas, init = Position(0, 0, 0))
answer = final_position.x * final_position.y
println(answer)

final_position = reduce(update_position_aim, deltas, init = Position(0, 0, 0))
answer = final_position.x * final_position.y
println(answer)



