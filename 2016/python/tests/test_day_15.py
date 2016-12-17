from read_input import get_test_input
from advent_of_code_2016.day_15 import *

data = get_test_input(15)

def test_parse_input():
    i = parse_input(data)

    assert len(i) == 2
    assert i[0] == ['1', 5, 4]
    assert i[1] == ['2', 2, 1]

def test_disc():
    d1= Disc('a', 5, 3)
    d2 = Disc(*['b', 2, 1])

    assert d1.name == 'a'
    assert d1.num_positions == 5
    assert d1.current_pos == 3

    assert d2.name == 'b'
    assert d2.num_positions == 2
    assert d2.current_pos == 1

def test_disc_update():
    d = Disc('a', 3, 0)

    d.update()
    assert d.current_pos == 1

    d.update()
    assert d.current_pos == 2

    d.update()
    assert d.current_pos == 0

def test_run():
    t = run(data)

    assert t == 5
