from read_input import get_input
import re

def get_sorted_intervals(intervals):
    intervals = [map(int, re.findall('\d+', i)) for i in intervals]
    return sorted(intervals, key=lambda x:x[0])

def get_smallest_allowed_ip(data, min_ip, max_ip):
    intervals = get_sorted_intervals(data)

    ip = min_ip
    for l,h in intervals:
        if l <= ip+1:
            ip = max(h, ip)
        else:
            return ip+1
    return -1 if ip > max_ip else max_ip
       
if __name__ == "__main__":
    puzzle_input = get_input(20)
    print get_smallest_allowed_ip(puzzle_input, 0, 2**32-1)
