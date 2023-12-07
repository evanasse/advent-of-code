struct Relation
    dest::Int
    source::Int
    length::Int
    range::UnitRange
    offset::Int

    function Relation(dest::Int, source::Int, length::Int)
        range = source:source+length-1
        offset = dest - source
        new(dest, source, length, range, offset)
    end
end

function sort_by_source(relation::Relation, other::Relation)
    relation.source < other.source
end

struct Map
    relations::Vector{Relation}
    range::UnitRange

    function Map(relations::Vector{Relation})
        sorted_relations = sort(relations, lt=sort_by_source)

        min_source = sorted_relations[1].source
        max_source = sorted_relations[end].source
        range_end = max_source + sorted_relations[end].length - 1

        new(relations, min_source:range_end)
    end
end

struct Seed
    value::Int
    range_length::Int
end

struct Almanac
    seeds::Vector{Seed}
    maps::Vector{Map}
end

function Almanac(lines::Vector{String})
    seeds = [Seed(parse(Int, strip(i)), 0) for i in split(split(lines[1], ":")[2])]

    maps = Vector{Map}()

    relations = Vector{Relation}()
    for line in lines[2:end]
        if line == ""
            if !isempty(relations)
                push!(maps, Map(relations))
            end
        elseif isdigit(line[1])
            dest, source, length = [parse(Int, i) for i in split(line)]

            push!(relations, Relation(dest, source, length))
        elseif contains(line, ":")
            relations = Vector{Relation}()
        end
    end
    push!(maps, Map(relations))

    Almanac(seeds, maps)
end

function destination(source::Int, map::Map)
    if source in map.range
        for relation in map.relations
            if source in relation.range
                return source + relation.offset
            end
        end
    end

    source
end

function smallestlocation(almanac::Almanac)
    smallest_location = Inf

    for seed in almanac.seeds
        println("Seed $(seed.value) range: $(seed.range_length)")
        for s in seed.value:seed.value+max(seed.range_length - 1, 0)
            next_value = s

            for map in almanac.maps
                next_value = destination(next_value, map)
            end

            smallest_location = min(next_value, smallest_location)
        end
    end

    Int(smallest_location)
end

function f1(lines::Vector{String})
    almanac = Almanac(lines)

    smallestlocation(almanac)
end

function Almanac2(lines::Vector{String})
    seeds_values = [parse(Int, strip(i)) for i in split(split(lines[1], ":")[2])]

    seeds = Vector{Seed}()

    for i in 1:2:length(seeds_values)
        push!(seeds, Seed(seeds_values[i], seeds_values[i+1]))
    end

    maps = Vector{Map}()

    relations = Vector{Relation}()
    for line in lines[2:end]
        if line == ""
            if !isempty(relations)
                push!(maps, Map(relations))
            end
        elseif isdigit(line[1])
            dest, source, length = [parse(Int, i) for i in split(line)]

            push!(relations, Relation(dest, source, length))
        elseif contains(line, ":")
            relations = Vector{Relation}()
        end
    end
    push!(maps, Map(relations))

    Almanac(seeds, maps)
end

function f2(lines::Vector{String})
    almanac = Almanac2(lines)

    println("Almanac ready.")
    smallestlocation(almanac)
end
