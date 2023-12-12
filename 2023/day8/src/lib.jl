struct Node
    left::String
    right::String
end

function createmap(lines::Vector{String})
    graph = Dict{String,Node}()

    for line in lines
        node_name, left_right = split(line, " = ")
        left, right = split(left_right[2:end-1], ", ")

        graph[String(node_name)] = Node(String(left), String(right))
    end

    graph
end

function f1(lines::Vector{String})
    instructions = lines[1]

    graph = createmap(lines[3:end])

    current_node = "AAA"
    steps_counter = 0
    instr_length = length(instructions)

    while current_node != "ZZZ"
        next_index = (steps_counter % instr_length) + 1

        if instructions[next_index] == 'L'
            current_node = graph[current_node].left
        else
            current_node = graph[current_node].right
        end

        steps_counter += 1
    end

    steps_counter
end

function done(nodes::Vector{String})
    all(node -> endswith(node, "Z"), nodes)
end

function f2(lines::Vector{String})
    instructions = lines[1]

    graph = createmap(lines[3:end])

    current_nodes = [node for node in keys(graph) if endswith(node, "A")]
    steps_counter = 0
    steps_counters = [i for i in fill(0, length(current_nodes))]
    done_nodes = [false for _ in fill(false, length(current_nodes))]
    instr_length = length(instructions)

    while !all(done_nodes)
        next_index = (steps_counter % instr_length) + 1

        for (i, _) in enumerate(current_nodes)
            if instructions[next_index] == 'L'
                current_nodes[i] = graph[current_nodes[i]].left
            else
                current_nodes[i] = graph[current_nodes[i]].right
            end

            if !done_nodes[i]
                steps_counters[i] += 1
            end

            if endswith(current_nodes[i], "Z")
                done_nodes[i] = true
            end
        end

        steps_counter += 1
    end

    lcm(steps_counters)
end
