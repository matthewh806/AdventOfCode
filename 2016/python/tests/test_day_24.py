from advent_of_code_2016.day_24 import *
from read_input import get_test_input

def test_input():
    return get_test_input(24)

def test_get_valid_moves():
    m = Maze(test_input())

    assert m.get_valid_moves(0,0) == []
    assert m.get_valid_moves(1,1) == [(2,1), (1,2)]
    assert m.get_valid_moves(5,3) == [(6,3), (4,3)]
