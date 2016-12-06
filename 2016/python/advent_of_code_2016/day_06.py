from definitions import INPUT_DIR
from collections import Counter

def get_error_corrected_message(data):
    l = [ list(i) for i in zip(*data)]
    most_freq = [ Counter("".join(i)).most_common(1) for i in l]
    arr = [x[0][0] for x in most_freq]
    return "".join(f for f in arr)

if __name__ == "__main__":
    with open(INPUT_DIR + 'day_06.txt') as f:
        data = [l.replace("\n", "") for l in f]

    print get_error_corrected_message(data)
