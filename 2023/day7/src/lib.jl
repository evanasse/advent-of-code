import Base: <, >, isless

const CARDS = Dict(
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9,
    'T' => 10,
    # 'J' => 11, # (Un)comment for part 1
    'J' => 1, # (Un)comment for part 2
    'Q' => 12,
    'K' => 13,
    'A' => 14,
)
const HAND_TYPES = Dict(
    "HIGH_CARD" => 1,
    "ONE_PAIR" => 2,
    "TWO_PAIRS" => 3,
    "THREE_OF_A_KIND" => 4,
    "FULL_HOUSE" => 5,
    "FOUR_OF_A_KIND" => 6,
    "FIVE_OF_A_KIND" => 7,
)

struct Hand
    cards::Vector{Char}
    bid::Int
end

function hasjoker(handdict::Dict{Char,Int})
    haskey(handdict, 'J')
end

function jokers(handdict::Dict{Char,Int})
    if !hasjoker(handdict)
        return 0
    end
    handdict['J']
end

function handtype(hand::Hand)::Int
    d = Dict{Char,Int}()

    for c in hand.cards
        if haskey(d, c)
            d[c] += 1
        else
            d[c] = 1
        end
    end

    hand_type = 0

    if length(d) == 1
        hand_type = HAND_TYPES["FIVE_OF_A_KIND"]
    elseif length(d) == 2
        if hasjoker(d)
            hand_type = HAND_TYPES["FIVE_OF_A_KIND"]
        elseif 4 in values(d)
            hand_type = HAND_TYPES["FOUR_OF_A_KIND"]
        else
            hand_type = HAND_TYPES["FULL_HOUSE"]
        end
    elseif length(d) == 3
        if 3 in values(d)
            if hasjoker(d)
                hand_type = HAND_TYPES["FOUR_OF_A_KIND"]
            else
                hand_type = HAND_TYPES["THREE_OF_A_KIND"]
            end
        else
            if hasjoker(d)
                if jokers(d) == 2
                    hand_type = HAND_TYPES["FOUR_OF_A_KIND"]
                else
                    hand_type = HAND_TYPES["FULL_HOUSE"]
                end
            else
                hand_type = HAND_TYPES["TWO_PAIRS"]
            end
        end
    elseif length(d) == 4
        if hasjoker(d)
            hand_type = HAND_TYPES["THREE_OF_A_KIND"]
        else
            hand_type = HAND_TYPES["ONE_PAIR"]
        end
    elseif length(d) == 5
        if hasjoker(d)
            hand_type = HAND_TYPES["ONE_PAIR"]
        else
            hand_type = HAND_TYPES["HIGH_CARD"]
        end
    end

    hand_type
end

function <(hand::Hand, other::Hand)
    hand_type_hand = handtype(hand)
    hand_type_other = handtype(other)

    if hand_type_hand < hand_type_other
        return true
    elseif hand_type_hand > hand_type_other
        return false
    else
        for (ch, co) in zip(hand.cards, other.cards)
            if CARDS[ch] < CARDS[co]
                return true
            elseif CARDS[ch] > CARDS[co]
                return false
            end
        end
    end

    false
end

function >(hand::Hand, other::Hand)
    hand_type_hand = handtype(hand)
    hand_type_other = handtype(other)

    if hand_type_hand > hand_type_other
        return true
    elseif hand_type_hand < hand_type_other
        return false
    else
        for (ch, co) in zip(hand.cards, other.cards)
            if CARDS[ch] > CARDS[co]
                return true
            elseif CARDS[ch] < CARDS[co]
                return false
            end
        end
    end
    false
end

isless(hand::Hand, other::Hand) = hand < other


function f1(lines::Vector{String})
    hands = Vector{Hand}()
    for line in lines
        cards, bid = split(line)

        cards = [Char(c) for c in cards]

        bid = parse(Int, bid)

        push!(hands, Hand(cards, bid))
    end

    winnings = [hand.bid * i for (i, hand) in enumerate(sort(hands))]

    sum(winnings)
end

function f2(lines::Vector{String})
    hands = Vector{Hand}()
    for line in lines
        cards, bid = split(line)

        cards = [Char(c) for c in cards]

        bid = parse(Int, bid)

        push!(hands, Hand(cards, bid))
    end

    winnings = [hand.bid * i for (i, hand) in enumerate(sort(hands))]

    sum(winnings)
end
