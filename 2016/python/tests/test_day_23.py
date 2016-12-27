from read_input import get_test_input
from advent_of_code_2016.assembunny import AssemBunny

def test_toggle_instruction():
    test_input = get_test_input(23)
    ab = AssemBunny({'a':0}) 
    ab.parse_instructions(test_input)
    
    assert ab.registers['a'] == 3

def test_multiply_instruction():
	ab = AssemBunny({'a':0, 'b':3, 'c':5})
	ab.parse_instructions(['mul b c a'])

	assert ab.registers['a'] == 15
	assert ab.registers['b'] == 3
	assert ab.registers['c'] == 5

