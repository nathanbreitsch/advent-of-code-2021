struct Vent
    xstart::Int    
    ystart::Int    
    xend::Int    
    yend::Int    
end

function parse_line(str)
    pattern = r"(?<x0>\d+),(?<y0>\d+) -> (?<x1>\d+),(?<y1>\d+)"
    m = match(pattern, str)
    segment_str = (m[:x0], m[:y0], m[:x1], m[:y1])
    xstart, ystart, xend, yend = map(s -> parse(Int, s), segment_str)
    Vent(
         xstart,
         ystart,
         xend,
         yend
    )
end

function span(a1, a2)
    if a2 >= a1
        a1:a2
    else
        a1:-1:a2
    end
end


function list_points(vent)
    if vent.xstart == vent.xend
        [(vent.xstart, y) for y in span(vent.ystart, vent.yend)]
    elseif vent.ystart == vent.yend
        [(x, vent.ystart) for x in span(vent.xstart, vent.xend)]
    else
        [
            (x, y) 
            for (x, y) in zip(
                span(vent.xstart, vent.xend),
                span(vent.ystart, vent.yend)
            )
        ]
    end
end
vents = map(parse_line, readlines("data/5.txt"))
xmax = maximum([v.xend for v in vents])
ymax = maximum([v.yend for v in vents])
grid = zeros((xmax, ymax))
for vent in vents
    for (x, y) in list_points(vent)
        grid[x, y] += 1
    end
end


println(sum(grid .>= 2))


