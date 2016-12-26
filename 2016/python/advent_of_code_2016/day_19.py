def elves(num):
    return list(range(1, num+1))

def winner(elves, fn):
    while len(elves) > 1:
       elves = fn(elves)
    return elves[0] 

def round_part_one(elves):
    return elves[::2] if len(elves) % 2 == 0 else elves[2::2]

def round_part_two(elves):
    idx = 0
    while idx < len(elves):
        elves.pop((idx + len(elves) / 2) % len(elves))
        idx+=1
    return elves

if __name__ == "__main__":
    puzzle_input = 3005290

    print winner(elves(puzzle_input), round_part_one)
    print winner(elves(puzzle_input), round_part_two)
