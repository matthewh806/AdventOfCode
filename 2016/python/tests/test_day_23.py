from read_input import get_test_input
from assembunny import AssemBunny

def test_toggle_instruction():
    test_input = get_test_input(23)
    ab = AssemBunny({'a':0}) 
    ab.parse_instructions(test_input)
    
    assert ab.registers['a'] == 3


