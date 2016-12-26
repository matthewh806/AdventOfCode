def elves(num):
    return range(1, num+1)

def winner(elves):
    while len(elves) > 1:
       elves = round(elves)
    return elves[0] 

def round(elves):
    return elves[::2] if len(elves) % 2 == 0 else elves[2::2]

if __name__ == "__main__":
    puzzle_input = 3005290

    print winner(elves(puzzle_input))
