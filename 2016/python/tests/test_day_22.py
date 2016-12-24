from advent_of_code_2016.day_22 import *
from read_input import get_test_input

test_input = get_test_input(22)

def test_node_is_empty():
    n = Node('empty', 100, 0, 0)
    assert n.is_empty() == True

    n = Node('not-empty', 100, 80, 0)
    assert n.is_empty() == False

def test_can_store():
    n1 = Node('a', 100, 20, 80)
    n2 = Node('b', 150, 20, 130)
    n3 = Node('c', 100, 90, 10)

    assert n2.can_store(n1.used) == True
    assert n3.can_store(n2.used) == False


def test_get_viable_pairs():
    g = Grid(test_input)
    pairs = g.get_viable_pairs()
    assert len(pairs) == 2

