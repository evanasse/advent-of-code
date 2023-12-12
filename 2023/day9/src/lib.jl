function difftree!(sequence::Vector{Integer}, aggregator::Vector{Vector{Integer}})
    diffs = Vector{Integer}()
    # println("AGG: $aggregator")

    for i in 1:length(sequence)-1
        push!(diffs, sequence[i+1] - sequence[i])
    end

    # println("SEQ: $sequence")
    # println("DIF: $diffs")

    push!(aggregator, diffs)

    if diffs[end] == 0
        return
    else
        return difftree!(diffs, aggregator)
    end

end

function extrapolate_right(difftree::Vector{Vector{Integer}})
    rev = reverse(difftree)

    for i in 2:length(rev)
        push!(rev[i], rev[i-1][end] + rev[i][end])
    end

    return rev[end][end]
end

function f1(lines::Vector{String})
    sequences = Vector{Vector{Integer}}()

    for line in lines
        push!(sequences, [parse(Int, i) for i in split(line)])
    end

    counter = 0
    for seq in sequences
        aggregator = Vector{Vector{Integer}}()
        push!(aggregator, seq)
        difftree!(seq, aggregator)

        counter += extrapolate_right(aggregator)
    end

    counter
end

function extrapolate_left(difftree::Vector{Vector{Integer}})
    rev = reverse(difftree)

    for tree in rev
        reverse!(tree)
    end

    for i in 2:length(rev)
        extrapolated_value = rev[i][end] - rev[i-1][end]
        push!(rev[i], extrapolated_value)
    end

    return rev[end][end]
end

function f2(lines::Vector{String})
    sequences = Vector{Vector{Integer}}()

    for line in lines
        push!(sequences, [parse(Int, i) for i in split(line)])
    end

    counter = 0
    for seq in sequences
        aggregator = Vector{Vector{Integer}}()
        push!(aggregator, seq)
        difftree!(seq, aggregator)

        counter += extrapolate_left(aggregator)
    end

    counter
end
