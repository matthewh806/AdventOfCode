from definitions import INPUT_DIR

legal_moves = {
    '1': {'R':'2', 'D':'4'},
    '2': {'L':'1', 'R':'3', 'D':'5'},
    '3': {'L':'2', 'D':'6'},
    '4': {'U':'1', 'D':'7', 'R':'5'},
    '5': {'U':'2', 'D':'8', 'L':'4', 'R':'6'},
    '6': {'U':'3', 'D':'9', 'L':'5'},
    '7': {'U':'4', 'R':'8'},
    '8': {'U':'5', 'L':'7', 'R':'9'},
    '9': {'U':'6', 'L':'8'}
}

def parse_instructions(data):
    pos = '5'
    code = []

    for i in data:
        instr = i.rstrip('\n')
        for c in instr:
            if c in legal_moves.get(pos):
                pos = legal_moves.get(pos).get(c)   
        code.append(pos)
    return code


if __name__ == "__main__":
    
    with open(INPUT_DIR + 'test/day_02.txt') as f:
        test_input = f.readlines()

    with open(INPUT_DIR + 'day_02.txt') as f:
        input_data = f.readlines()

    print parse_instructions(test_input)
    print parse_instructions(input_data)


