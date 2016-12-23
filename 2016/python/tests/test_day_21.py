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
