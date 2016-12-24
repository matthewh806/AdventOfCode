from read_input import get_test_input
from advent_of_code_2016.day_21 import *

def test_swap_by_index():
    assert swap_by_index('abcde', 4, 0) == 'ebcda'
    
def test_swap_by_char():
    assert swap_by_char('ebcda', 'd', 'b') == 'edcba'

def test_rotate_n_steps():
    assert rotate_n_steps('abcd', 1) == 'dabc'
    assert rotate_n_steps('abcde', -1) == 'bcdea'

def test_rotate_on_char_pos():
    assert rotate_on_char_pos('abdec', 'b') == 'ecabd'
    assert rotate_on_char_pos('ecabd', 'd') == 'decab'

def test_reverse_by_index():
    assert reverse_by_index('edcba', 0, 4) == 'abcde'

def test_move_by_index():
    assert move_by_index('bcdea', 1, 4) == 'bdeac'
    assert move_by_index('bdeac', 3, 0) == 'abdec'

def test_parse_instructions():
    assert parse_instructions('abcde', ['swap position 4 with position 0']) == 'ebcda'
    assert parse_instructions('ebcda', ['swap letter d with letter b']) == 'edcba'
    assert parse_instructions('abcde', ['rotate left 1 step shifts']) == 'bcdea'
    assert parse_instructions('abdec', ['rotate based on position of letter\
                                        b']) == 'ecabd'
    assert parse_instructions('ecabd', ['rotate based on position of letter\
                                        d']) == 'decab'
    assert parse_instructions('edcba', ['reverse positions 0 through 4']) == 'abcde'
    assert parse_instructions('bcdea', ['move position 1 to position 4']) == 'bdeac'
    assert parse_instructions('bdeac', ['move position 3 to position 0']) =='abdec' 

    assert parse_instructions('abcde', get_test_input(21)) == 'decab'
