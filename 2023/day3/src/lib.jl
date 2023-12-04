struct Position
    x::Int
    y::Int
end

struct SchematicNumber
    value::Int
    position::Position
    length::Int

    function SchematicNumber(value::Int, position::Position)
        new(value, position, length(string(value)))
    end
end

struct SchematicSymbol
    value::Char
    position::Position
end

struct SchematicLine
    numbers::Vector{SchematicNumber}
    symbols::Vector{SchematicSymbol}
end

struct EngineSchematic
    width::Int
    height::Int
    lines::Vector{SchematicLine}
end

function EngineSchematic(lines::Vector{String})
    width = length(lines[1])
    height = length(lines)
    schematic_lines = Vector{SchematicLine}()

    for (i, line) in enumerate(lines)
        numbers = Vector{SchematicNumber}()
        symbols = Vector{SchematicSymbol}()
        building_number = false
        number = ""
        for (j, char) in enumerate(line)
            if isdigit(char)
                building_number = true
                number = number * char
            elseif char == '.'
                if building_number
                    push!(numbers, SchematicNumber(parse(Int, number), Position(j - length(number), i)))
                end

                building_number = false
                number = ""
            else
                if building_number
                    push!(numbers, SchematicNumber(parse(Int, number), Position(j - length(number), i)))
                end
                push!(symbols, SchematicSymbol(char, Position(j, i)))

                building_number = false
                number = ""
            end
        end

        push!(schematic_lines, SchematicLine(numbers, symbols))
    end

    EngineSchematic(width, height, schematic_lines)
end

function ispart(number::SchematicNumber, schematic::EngineSchematic)
    line = number.position.y
    for symbol in schematic.lines[line].symbols
        if symbol.position.x == number.position.x - 1 || symbol.position.x == number.position.x + number.length
            return true
        end
    end

    line_above = line - 1
    if line_above > 0
        for symbol in schematic.lines[line_above].symbols
            if number.position.x - 1 <= symbol.position.x <= number.position.x + number.length
                return true
            end
        end
    end

    line_below = line + 1
    if line_below <= schematic.height
        for symbol in schematic.lines[line_below].symbols
            if number.position.x - 1 <= symbol.position.x <= number.position.x + number.length
                return true
            end
        end
    end

    false
end

function f1(lines::Vector{String})
    schematic = EngineSchematic(["." * line * "." for line in lines])

    sum = 0
    for line in schematic.lines
        for number in line.numbers
            if ispart(number, schematic)
                sum += number.value
            end
        end
    end

    sum
end

function gearvalue(symbol::SchematicSymbol, schematic::EngineSchematic)
    if symbol.value != '*'
        return 0
    end

    adjacent_values = []

    line = symbol.position.y
    for number in schematic.lines[line].numbers
        if number.position.x + number.length == symbol.position.x ||
           number.position.x == symbol.position.x + 1
            push!(adjacent_values, number.value)
        end
    end

    line_above = line - 1
    if line_above > 0
        for number in schematic.lines[line_above].numbers
            if symbol.position.x in number.position.x-1:number.position.x+number.length
                push!(adjacent_values, number.value)
            end
        end
    end

    line_below = line + 1
    if line_below <= schematic.height
        for number in schematic.lines[line_below].numbers
            if symbol.position.x in number.position.x-1:number.position.x+number.length
                push!(adjacent_values, number.value)
            end
        end
    end

    if length(adjacent_values) < 2
        return 0
    end

    reduce(*, adjacent_values)
end

function f2(lines::Vector{String})
    schematic = EngineSchematic(["." * line * "." for line in lines])

    sum = 0

    for line in schematic.lines
        for symbol in line.symbols
            sum += gearvalue(symbol, schematic)
        end
    end

    sum
end
