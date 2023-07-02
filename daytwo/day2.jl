#=
Given a "strategy guide" seen below for a rock, paper, scissors tournament
'''
A Y
B X
C Z
'''

where first column is what your opponent will play, and the second column (is assumed)
to be what you should play.

The guide can be read as follows, along with the scoring of the tournament:

Round outcome points:
0 for a loss
3 for a draw
6 for a win

Move played points:
1 for a rock
2 for a paper
3 for a scissors

A : opponent plays rock             X : you play rock
B : opponent plays paper            Y : you play paper
C : opponent plays scissors         Z : you play scissors

Want to calculate total score IF you were to follow the strategy guide
=#

function calculate_score_part_1(strat_guide::Vector{String}, grading)
    score = 0
    for round in strat_guide
        rs = split(round);

        score += grading[rs[2]]
        score += grading[round]
    end

    return score
end

contents = open("./daytwo/guide.txt");
strat_guide = readlines(contents);
grading = Dict(
    [("X", 1), 
    ("Y", 2), 
    ("Z", 3),
    ("A X", 3),
    ("A Y", 6),
    ("A Z", 0),
    ("B X", 0),
    ("B Y", 3),
    ("B Z", 6),
    ("C X", 6),
    ("C Y", 0),
    ("C Z", 3),
    ]
    );

optimal_score = calculate_score_part_1(strat_guide, grading)

#=
Part 2 lets you know that what is actually meant by X, Y, Z is that:

X : You need to lose
Y : You need to draw
Z : You need to win

So in part 2, you need to calculate what you need to play based on the opponent and what
your score is
=#

grading2 = Dict(
    [
        ("A", 1), # Rock
        ("B", 2), # Paper
        ("C", 3)  # Scissors
    ]
    );

function calculate_score(guide::Vector{String}, grading)
    score = 0;

    for round in guide
        opp, option = split(round);

        if option == "X"
            choice = (grading[opp] + 2) % 3
            score += (choice == 0) ? 3 : choice
        elseif option == "Y"
            score += grading[opp]
            score += 3
        else
            choice = (grading[opp] + 1) % 3
            score += (choice == 0) ? 3 : choice
            score += 6
        end
    end

    return score
end

score = calculate_score(strat_guide, grading2)
