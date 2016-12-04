from definitions import INPUT_DIR

legal_moves_1 = {
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

legal_moves_2 = {
    '1': {'D':'3'},
    '2': {'R':'3', 'D':'6'},
    '3': {'U':'1', 'L':'2', 'R':'4', 'D':'7'},
    '4': {'L':'3', 'D':'8'},
    '5': {'R':'6'},
    '6': {'U':'2', 'L':'5', 'D':'A', 'R':'7'},
    '7': {'U':'3', 'L':'6', 'D':'B', 'R':'8'},
    '8': {'U':'4', 'L':'7', 'D':'C', 'R':'9'},
    '9': {'L':'8'},
    'A': {'U':'6', 'R':'B'},
    'B': {'U':'7', 'L':'A', 'D':'D', 'R':'C'},
    'C': {'U':'8', 'L':'B'},
    'D': {'U':'B'}
}

def parse_instructions(data, part=1):
    pos = '5'
    code = []

    legal_moves = legal_moves_1 if part==1 else legal_moves_2

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

    print parse_instructions(test_input, 2)
    print parse_instructions(input_data, 2)


