from advent_of_code_2016.day_13 import Maze

def test_is_wall():
    m = Maze(1, 1, 10)

    assert m.is_wall(1,0)
    assert not m.is_wall(8, 2)
    assert m.is_wall(4, 6)

def test_valid_moves():
    m = Maze(1, 1, 10)
    
    assert m.get_valid_moves(0,0) == [(0,1)]
    assert m.get_valid_moves(7,1) == [(7,0), (8,1),(7,2),(6,1)]
    assert m.get_valid_moves(5,3) == []

def test_shortest_route():
    m = Maze(1,1, 10)

    assert len(m.shortest_route(7,4)) == 11
