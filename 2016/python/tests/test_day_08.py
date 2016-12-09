from advent_of_code_2016.day_08 import Screen
import numpy as np

def test_screen_create():
    s = Screen(50, 6)
    expected = np.zeros([6, 50])

    assert s.array.shape == expected.shape
    assert np.count_nonzero(s.array) == 0

def test_create_rect():
    s = Screen(3,3)
    s.create_rect(2, 2)

    expected = np.zeros([3,3])
    expected[:2, :2] = 1

    np.testing.assert_equal(s.array, expected)
    assert s.lit_pixels_count() == 4

def test_parse_rect_instruction():
    s = Screen(3,3)
    s.parse_instruction('rect 2,1')

    expected = np.zeros([3,3])
    expected[:1,:2] = 1

    np.testing.assert_equal(s.array, expected)
    assert s.lit_pixels_count() == 2

def test_parse_rotate_column_instruction_no_overflow():
    s = Screen(3,3)
    s.create_rect(2, 1)
    s.parse_instruction('rotate column x=1 by 1')

    expected = np.array([[1, 0, 0], [0, 1, 0], [0,0,0]])
    np.testing.assert_equal(s.array, expected)
    assert s.lit_pixels_count() == 2


def test_parse_rotate_row_instruction_no_overflow():
    s = Screen(3,3)
    s.create_rect(2,1)
    s.parse_instruction('rotate row y=0 by 1')
    
    expected = np.array([[0, 1, 1], [0, 0, 0], [0, 0, 0]])
    np.testing.assert_equal(s.array, expected)
    assert s.lit_pixels_count() == 2

def test_parse_rotate_row_instruction_overflow():
    s = Screen(3,3)
    s.create_rect(2,1)
    s.parse_instruction('rotate row y=0 by 2')
    
    expected = np.array([[1, 0, 1], [0, 0, 0], [0, 0, 0]])
    np.testing.assert_equal(s.array, expected)
    assert s.lit_pixels_count() == 2

def test_parse_rotate_column_instruction_overflow():
    s = Screen(3,3)
    s.create_rect(2, 1)
    s.parse_instruction('rotate column x=1 by 3')

    expected = np.array([[1, 1, 0], [0, 0, 0], [0,0,0]])
    np.testing.assert_equal(s.array, expected)
    assert s.lit_pixels_count() == 2

def test_instrution_sequence():
    i1 = 'rect 3x2'
    i2 = 'rotate column x=1 by 1'
    i3 = 'rotate row y=0 by 4'
    i4 = 'rotate column x=1 by 1'

    s = Screen(7,3)
    s.parse_instruction(i1)

    test_arr = np.array([[1, 1, 1, 0, 0, 0, 0], 
                         [1, 1, 1, 0, 0, 0, 0], 
                         [0, 0, 0, 0, 0, 0, 0]])

    np.testing.assert_equal(s.array, test_arr)

    s.parse_instruction(i2)
    test_arr = np.array([[1, 0, 1, 0, 0, 0, 0], 
                         [1, 1, 1, 0, 0, 0, 0], 
                         [0, 1, 0, 0, 0, 0, 0]])
    np.testing.assert_equal(s.array, test_arr)

    s.parse_instruction(i3)
    test_arr = np.array([[0, 0, 0, 0, 1, 0, 1], 
                         [1, 1, 1, 0, 0, 0, 0], 
                         [0, 1, 0, 0, 0, 0, 0]])
    np.testing.assert_equal(s.array, test_arr)

    s.parse_instruction(i4)
    test_arr = np.array([[0, 1, 0, 0, 1, 0, 1], 
                         [1, 0, 1, 0, 0, 0, 0], 
                         [0, 1, 0, 0, 0, 0, 0]])
    np.testing.assert_equal(s.array, test_arr)

    assert s.lit_pixels_count() == np.count_nonzero(test_arr) == 6
