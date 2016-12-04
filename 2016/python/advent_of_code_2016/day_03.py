from definitions import INPUT_DIR
import re

def is_valid_triangle(s1, s2, s3):
    v = sorted([s1, s2, s3])
    return v[0] + v[1] > v[2] 

def list_to_chunks(l, n):
    return [l[i:i+n] for i in xrange(0, len(l), n)]

def parse_input(data, rows=True):
    data = [map(int,re.findall('\d+', d)) for d in data]

    if rows != True:
        data = [x for t in zip(*data) for x in t]

        if len(data) % 3 !=0:
            return
        data = list_to_chunks(data, 3)

    return sum(is_valid_triangle(*d) for d in data)

if __name__ == "__main__":
    test_input = ['5 10 25']
    
    with open(INPUT_DIR  + 'day_03.txt') as f:
        input_data = [line.rstrip('\n') for line in f]
    with open(INPUT_DIR + 'test/day_03.txt') as f:
        test_data = [line.rstrip('\n') for line in f]
    
    print parse_input(test_data)
    print parse_input(input_data)

    print parse_input(test_data, rows=False)
    print parse_input(input_data, rows=False)
