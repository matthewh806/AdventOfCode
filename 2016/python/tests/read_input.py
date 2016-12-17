from advent_of_code_2016.definitions import TEST_INPUT_DIR

def get_test_input(day):
    with open(TEST_INPUT_DIR + 'day_%s.txt' % day) as f:
        return [l.rstrip('\n') for l in f]
