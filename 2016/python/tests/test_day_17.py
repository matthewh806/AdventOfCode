from advent_of_code_2016.day_17 import *

test_grid = Grid(4,4,'hijkl')

def test_grid_get_valid_moves():
    l = test_grid.get_valid_moves(0,0, [])

    assert len(l) == 1
    assert l == [(0,1)]

def test_grid_get_dir():
    assert test_grid.get_dir((0,0), (0,1)) == 'D'
    assert test_grid.get_dir((2,1), (3,1)) == 'R'
    assert test_grid.get_dir((1,3), (1,2)) == 'U'
    assert test_grid.get_dir((2,2), (1,2)) == 'L'

def test_shortest_route():
    assert Grid(4,4, 'ihgpwlah').get_goal_paths((3,3))[0] == 'DDRRRD'
    assert Grid(4,4, 'kglvqrro').get_goal_paths((3,3))[0] == 'DDUDRLRRUDRD'
    assert Grid(4,4, 'ulqzkmiv').get_goal_paths((3,3))[0] == 'DRURDRUDDLLDLUURRDULRLDUUDDDRR'

def test_longest_route():
    assert len(Grid(4,4, 'ihgpwlah').get_goal_paths((3,3))[-1]) == 370 
    assert len(Grid(4,4, 'kglvqrro').get_goal_paths((3,3))[-1]) == 492 
    assert len(Grid(4,4, 'ulqzkmiv').get_goal_paths((3,3))[-1]) == 830 
