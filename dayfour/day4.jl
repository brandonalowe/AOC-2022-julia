#=
Elves are assigned a range of section IDs to clean. Elves pair
up and compare their ranges to see where the elves might be 
overlapping.

Example code:

2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8

Assignment is to count how many pairs of elves range fully contain
their partners range.
=#

function contain_range(list_of_elves)
    count = 0
    for elf_pair in list_of_elves
        elf_one, elf_two = split(elf_pair, ',')
        elf_one_split = parse.(Int, split(elf_one, '-'))
        elf_two_split = parse.(Int, split(elf_two, '-'))

        if elf_one_split[1] == elf_two_split[1] ||
           elf_one_split[2] == elf_two_split[2]
            count += 1
        elseif elf_one_split[1] < elf_two_split[1] &&
               elf_two_split[2] < elf_one_split[2]
            count += 1
        elseif elf_two_split[1] < elf_one_split[1] &&
               elf_one_split[2] < elf_two_split[2]
            count += 1
        end
    end
    return count
end

contents = open("./aoc-2022-julia/dayfour/sections.txt", "r");
list_of_elves = readlines(contents);

@show contain_range(list_of_elves);

function overlap(list_of_elves)
    count = 0

    for elf_pair in list_of_elves
        elf_one, elf_two = split(elf_pair, ',')
        elf_one_split = parse.(Int, split(elf_one, '-'))
        elf_two_split = parse.(Int, split(elf_two, '-'))

        if elf_one_split[1] in elf_two_split ||
           elf_one_split[2] in elf_two_split
            count += 1
        elseif elf_one_split[1] < elf_two_split[1] &&
               elf_one_split[2] > elf_two_split[1]
            count += 1
        elseif elf_two_split[1] < elf_one_split[1] &&
               elf_two_split[2] > elf_one_split[1]
            count += 1
        end
    end
    return count
end

@show overlap(list_of_elves);
