#=
Handed a text file of numbers, e.g.,

'''
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
'''

We are to calculate how much each 'elf' is carrying. A new elf is distinguished by
each new line. So elf 1 is carry 6000 calories, elf 2 so on.

Part 1 requires us to find the elf and in particular, how many calories that elf is carrying.
=#


function read_lines(arr::Vector{String})
    # initialize our calorie counting var and elf list
    cc = 0;
    elves = [];

    # loop over list of calories
    for num in arr
        # if empty line, new elf, so add elves calorie count to the elf list and reset
        # calorie counter
        if num == ""
            push!(elves, cc);
            cc = 0;
        else
            cc += parse(Int, num);
        end
    end

    # final elf push as there is no trailing new line for the last elf.
    push!(elves, cc);
    return elves

end

contents = open("./dayone/nums.txt", "r");
arr = readlines(contents);
elf_list = read_lines(arr);
max_elf = maximum(elf_list); # answer to part 1

#= part 2 we want to know the total calories carried by the top three elves
easiest solution is to reverse sort the existing elf list, and sum the top
3 elf results
=#

sort!(elf_list, rev=true)
top_three_elves = sum(+, elf_list[begin:3]) # answer to part 2

