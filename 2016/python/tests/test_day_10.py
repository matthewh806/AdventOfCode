from advent_of_code_2016.definitions import TEST_INPUT_DIR
from advent_of_code_2016.day_10 import parse_initial_condition,\
                                        set_initial_conditions,\
                                        read_bot_instructions, simulate_bots

def read_input():
    with open(TEST_INPUT_DIR + 'day_10.txt') as f:
        data = [l.rstrip('\n') for l in f]
    return data

def test_parse_initial_condition():
    i1 = 'value 5 goes to bot 2'
    b, v = parse_initial_condition(i1)

    assert b == 2 
    assert v == 5

def test_set_initial_conditions():
    i = read_input()
    bots = set_initial_conditions(i)
    
    assert 3 in bots[1]
    assert 5 in bots[2] and 2 in bots[2]

def test_read_bot_instructions():
    i = read_input()
    instr = read_bot_instructions(i)

    assert True    

def test_simulate_bots():
    simulate_bots(read_input(), 2, 5)

    assert False
