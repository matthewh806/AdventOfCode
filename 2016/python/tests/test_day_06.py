from advent_of_code_2016.definitions import TEST_INPUT_DIR
from advent_of_code_2016.day_06 import get_error_corrected_message

def get_test_input():
    with open(TEST_INPUT_DIR + 'day_06.txt') as f:
        data = [l.replace("\n", "") for l in f]
    return data

def test_get_error_corrected_message():
    res = get_error_corrected_message(get_test_input()) 
    assert res == "easter"
