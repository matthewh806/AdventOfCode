from definitions import INPUT_DIR

def get_input(day):
    with open(INPUT_DIR + 'day_%s.txt' % day) as f:
        return [l.rstrip('\n') for l in f]
