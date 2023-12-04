const GameResult = String

struct GameSubset
    color::String
    amount::Int
end

function gameid(gr::GameResult)
    space_index = findfirst(" ", gr)[1]
    colon_index = findfirst(":", gr)[1]

    id = gr[space_index+1:colon_index-1]

    parse(Int, id)
end

function gamesets(gs::GameResult)
    sets = split(gs, ":")[2]
    sets = split(sets, ";")
    [String(strip(set)) for set in sets]
end

function most_of_each_cube_in_game(gamesets::Vector{String})::Dict{String,Int}
    cubes = Dict("red" => 0, "green" => 0, "blue" => 0)

    for set in gamesets
        subsets = [strip(subset) for subset in split(set, ",")]

        for subset in subsets
            amount, color = split(subset)
            ss = GameSubset(color, parse(Int, amount))

            if ss.color == "red" && ss.amount > cubes[ss.color]
                cubes[ss.color] = ss.amount
            elseif ss.color == "green" && ss.amount > cubes[ss.color]
                cubes[ss.color] = ss.amount
            elseif ss.color == "blue" && ss.amount > cubes[ss.color]
                cubes[ss.color] = ss.amount
            end
        end
    end

    cubes
end

function ispossible(gr::GameResult)
    cubes = most_of_each_cube_in_game(gamesets(gr))

    cubes["red"] <= 12 && cubes["green"] <= 13 && cubes["blue"] <= 14
end

function f1(lines::Vector{String})
    sum_possible_games = 0
    for line in lines
        if ispossible(line)
            sum_possible_games += gameid(line)
        end
    end

    sum_possible_games
end

function f2(lines::Vector{String})
    sum_power = 0

    for line in lines
        cubes = most_of_each_cube_in_game(gamesets(line))
        sum_power += cubes["red"] * cubes["green"] * cubes["blue"]
    end

    sum_power
end
