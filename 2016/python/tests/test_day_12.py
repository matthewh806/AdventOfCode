from advent_of_code_2016.definitions import TEST_INPUT_DIR
from advent_of_code_2016.day_12 import AssemBunny

def get_input(v='i'):
    with open(TEST_INPUT_DIR + 'day_12_%s.txt' %v) as f: instr = [l.rstrip('\n') for l in f]
    return instr

def get_instance():
    return AssemBunny({'a':0,'b':0,'c':0,'d':0})

def test_copy():
    ab = get_instance()
    ab.copy('cpy 41 a')

    assert ab.registers['a'] == 41

def test_increment():
    ab = get_instance()
    ab.increment('inc a')

    assert ab.registers['a'] == 1

def test_decrement():
    ab = get_instance()
    ab.decrement('dec a')
    
    assert ab.registers['a'] == -1 
    
def test_parse_instructions_i():
    ab = get_instance()

    i = get_input()
    ab.parse_instructions(i)

    assert ab.registers['a'] == 43
    assert ab.registers['b'] == ab.registers['c'] == ab.registers['d'] == 0

def test_parse_instructions_ii():
    ab = get_instance()

    i = get_input(v='ii')
    ab.parse_instructions(i)

    assert ab.registers['a'] == -2
    assert ab.registers['b'] == 0
    ab.registers['c'] == 2
    ab.registers['d'] == 0
