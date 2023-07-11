#=
This is a fun one.
=#

import DataStructures

function split_instructions(things)
    visual = []
    instructions = []
    for i in enumerate(things)
        if i[2] == ""
            instructions = things[i[1]+1:end]
            break
        end
        push!(visual, i[2])
    end

    instruction_set = []
    for move in instructions
        tmp = []
        for i in split(move)
            if tryparse(Int, i) !== nothing
                push!(tmp, i)
            end
        end
        push!(instruction_set, parse.(Int, tmp))
    end

    containers = pop!(visual)
    container_cols = parse.(Int, split(containers))

    container_stacks = []
    for i in container_cols
        push!(container_stacks, [" "])
    end

    reverse!(visual)

    for j in visual
        ind = 1
        tmp_counter = 0
        split_char = split(j, ' ')
        for val in (split_char)
            if val != ""
                if (ind % length(container_cols)) == 0
                    push!(container_stacks[length(container_stacks)], val)
                    ind += 1
                else
                    push!(container_stacks[ind%length(container_stacks)], val)
                    ind += 1
                end
            else
                if tmp_counter == 3
                    ind += 1
                    tmp_counter = 0
                else
                    tmp_counter += 1
                end
            end
        end
    end
    return instruction_set, container_stacks
end

function make_moves(instructions, container_stacks)
    for move in instructions
        for i = 1:move[1]
            push!(container_stacks[move[3]], pop!(container_stacks[move[2]]))
        end
    end
    return container_stacks
end


contents = open("./aoc-2022-julia/dayfive/instructions.txt", "r");
things = readlines(contents);

instructions, container_stacks = split_instructions(things);
# final_position = make_moves(instructions, container_stacks);

# for i in final_position
#     print(strip(pop!(i), ['[', ']']))
# end

function make_moves_9001(instructions, container_stacks)
    for move in instructions
        tmp = []
        for i = 1:move[1]
            push!(tmp, pop!(container_stacks[move[2]]))
        end
        reverse!(tmp)
        append!(container_stacks[move[3]], tmp)
    end
    return container_stacks
end

final_position_9001 = make_moves_9001(instructions, container_stacks)

for i in final_position_9001
    print(strip(pop!(i), ['[', ']']))
end


