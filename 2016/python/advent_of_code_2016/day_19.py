import math

def elves(num):
    return list(range(1, num+1))

def winner(elves, fn):
    while len(elves) > 1:
       elves = fn(elves)
    return elves[0] 

def round_part_one(elves):
    return elves[::2] if len(elves) % 2 == 0 else elves[2::2]

def round_part_two(elves):
    elim = 0
    N = len(elves)
    for i in range(int(math.ceil(N / 3.0))):
        rem = i + elim + N / 2
        elves[rem] = None
        elim += 1
        N -= 1
    return list(filter(None, elves[i+1:] + elves[:i+1]))

if __name__ == "__main__":
    puzzle_input = 3005290

    print winner(elves(puzzle_input), round_part_one)
    print winner(elves(puzzle_input), round_part_two)
