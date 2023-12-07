struct Race
    duration::Int # milliseconds
    record_distance::Int # millimeters
end

function distance(race_duration::Int, time_held::Int)
    time_held * (race_duration - time_held)
end

function ways_to_win(race::Race)
    # + 1 to include the 0 millisecond hold
    half_amount_of_durations = div(race.duration + 1, 2)
    extra = (race.duration + 1) % 2

    counter = 0
    for hold_time in reverse(0:half_amount_of_durations-1)
        if distance(race.duration, hold_time) > race.record_distance
            counter += 1
        else
            break
        end
    end

    counter * 2 + extra
end

function f1(lines::Vector{String})
    times = [parse(Int, strip(i)) for i in split(split(lines[1], ":")[2])]
    distances = [parse(Int, strip(i)) for i in split(split(lines[2], ":")[2])]

    races = Vector{Race}()
    for (t, d) in zip(times, distances)
        push!(races, Race(t, d))
    end

    reduce(*, [ways_to_win(race) for race in races])
end

function f2(lines::Vector{String})
    time = parse(Int, replace(String(split(lines[1], ":")[2]), (" " => "")))
    distance = parse(Int, replace(String(split(lines[2], ":")[2]), (" " => "")))

    race = Race(time, distance)

    ways_to_win(race)
end
