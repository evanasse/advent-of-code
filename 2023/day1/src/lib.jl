# Part 1
function firstlast1(s::String)
    s[findfirst(isdigit, s)] * s[findlast(isdigit, s)]
end

function f1(lines::Vector{String})
    calibration_values = [parse(Int, firstlast1(line)) for line in lines]

    sum(calibration_values)
end

# Part 2
function firstlast2(s::String)
    LETTER_DIGITS = Dict(
        "one" => "1",
        "two" => "2",
        "three" => "3",
        "four" => "4",
        "five" => "5",
        "six" => "6",
        "seven" => "7",
        "eight" => "8",
        "nine" => "9"
    )

    first_digit_index = findfirst(isdigit, s)

    smallest_index_range = 10000000:10000000
    for k in keys(LETTER_DIGITS)
        found_index_range = findfirst(k, s)
        if !isnothing(found_index_range) && found_index_range[1] < smallest_index_range[1]
            smallest_index_range = found_index_range
        end
    end

    first_digit_str = ""
    if !isnothing(first_digit_index) && first_digit_index < smallest_index_range[1]
        first_digit_str = s[first_digit_index]
    else
        first_digit_str = LETTER_DIGITS[s[smallest_index_range]]
    end


    last_digit_index = findlast(isdigit, s)

    largest_index_range = -10000000:10000000
    for k in keys(LETTER_DIGITS)
        found_index_range = findlast(k, s)
        if !isnothing(found_index_range) && found_index_range[1] > largest_index_range[1]
            largest_index_range = found_index_range
        end
    end

    last_digit_str = ""
    if !isnothing(last_digit_index) && last_digit_index > largest_index_range[1]
        last_digit_str = s[last_digit_index]
    else
        last_digit_str = LETTER_DIGITS[s[largest_index_range]]
    end

    first_digit_str * last_digit_str
end

function f2(lines::Vector{String})
    calibration_values = [parse(Int, firstlast2(line)) for line in lines]

    sum(calibration_values)
end
