#=
In this puzzle, we have rucksacks filled with items. Each item is of a given type, and
are meant ot go into exactly one of the two compartments. Here, the elf packing the
rucksacks has failed to follow this rule, so there are items the rucksack that appear
in each compartment.

Rucksacks are given by the following txt file:

'''
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
'''

Each compartment has equal items in it, so the first half of the rucksack string is given
by the first half of the string, and the second compartment is the other half.

Each item has a priority, 

a ... z -> 1 ... 26
A ... Z -> 27 ... 52


We want to find the item type that appears in both compartments, and sum the total priority
=#

function similar_items(rucksack::Vector{String})
    priority = 0
    for sack in rucksack
        first, second = sack[begin:length(sack)÷2], sack[(length(sack)÷2) + 1:end];

        similar_item = first ∩ second;

        islowercase(similar_item[1]) ? 
            priority += similar_item[1] - ' ' - 64 : 
            priority += similar_item[1] - ' ' - 6;
    end
    return priority
end

contents = open("./daythree/rucksack.txt", "r");
rucksack = readlines(contents);

similar_items(rucksack);

#=
Part Two!!

Elves are divided into groups of three (each line is a new elf), and each elf in the group
hold the same badge. But someone forgot to put the year's updated authenticity sticker
on the badges.

We need to find the common item between the three elves rucksacks in the group, and that is
groups badge.

Then need to calculate the total priority for the groups.
=#

function group_badges(rucksack::Vector{String})
    priority = 0
    groups = []
    for sack in rucksack
        push!(groups, sack);

        if length(groups) == 3
            similar_item = intersect(groups[1], groups[2], groups[3]);
            println(similar_item)
            islowercase(similar_item[1]) ? 
                priority += similar_item[1] - ' ' - 64 : 
                priority += similar_item[1] - ' ' - 6;
            groups = [];
        end
    end
    return priority
end

@show group_badges(rucksack)