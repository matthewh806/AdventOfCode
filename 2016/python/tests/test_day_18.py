from advent_of_code_2016.day_18 import *

def test_generate_row():
    assert generate_row('..^^.') == '.^^^^'
    assert generate_row('.^^^^') == '^^..^'

    assert generate_row('.^^.^.^^^^') == '^^^...^..^'
    assert generate_row('^^^...^..^') == '^.^^.^.^^.'

def test_generate_trap_map():
    assert count_safe_tiles(generate_trap_map('.^^.^.^^^^', 10)) == 38
