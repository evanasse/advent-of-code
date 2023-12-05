
struct Card
    id::Int
    winning_numbers::Vector{Int}
    player_numbers::Vector{Int}
    matching_numbers::Int

    function Card(line::String)
        description, game = split(line, ":")

        id = parse(Int, split(description)[2])

        winning_list, player_list = split(game, "|")

        winning_numbers = [parse(Int, i) for i in split(winning_list)]
        player_numbers = [parse(Int, i) for i in split(player_list)]

        matching_numbers = length([
            i for i in player_numbers if i in winning_numbers
        ])

        new(id, winning_numbers, player_numbers, matching_numbers)
    end
end

function count_points(card::Card)
    if card.matching_numbers == 0
        return 0
    elseif card.matching_numbers == 1
        return 1
    end

    2^(card.matching_numbers - 1)
end

function f1(lines::Vector{String})
    sum(count_points(Card(line)) for line in lines)
end

function f2(lines::Vector{String})
    cards = [Card(line) for line in lines]

    card_counter = [1 for _ in cards]

    for i in 1:length(cards)
        for _ in 1:card_counter[i]
            for j in 1:cards[i].matching_numbers
                card_counter[i+j] += 1
            end
        end
    end

    sum(card_counter)
end
