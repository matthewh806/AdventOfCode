from read_input import get_test_input
from advent_of_code_2016.day_20 import *

def test_get_sorted_intervals():
    i = get_sorted_intervals(get_test_input(20))

    assert i[0] == [0,2] 
    assert i[1] == [4,7]
    assert i[2] == [5,8]

def test_get_smallest_allowed_ip():
    i = get_smallest_allowed_ip(get_test_input(20), 0, 9)
    assert i == 3 
