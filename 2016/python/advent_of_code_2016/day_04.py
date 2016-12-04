from definitions import INPUT_DIR
from collections import Counter
import re

def get_n_most_common_chars(text, n):
    freq = Counter(text).most_common()
    return "".join([c for (c, f) in sorted(freq, key=lambda x: (-x[1],
                                                                x[0]))][0:n])
def is_room_real(data):
    encrypted_name, _, checksum = parse_room_data(data)
    most_freq = get_n_most_common_chars(encrypted_name.replace('-', ''), 5)
    
    return most_freq == checksum

def parse_room_data(data):
    sector_id = re.findall(r'\d+', data)[0]
    checksum = re.findall(r'\[(.*?)\]', data)[0]
    encrypted_name = re.split(r'-\d+', data)[0]

    return encrypted_name, int(sector_id), checksum

def get_sector_id_sum(data):
    return sum([parse_room_data(d)[1] for d in data if is_room_real(d)])

if __name__ == "__main__":
    with open(INPUT_DIR + 'day_04.txt') as f:
        input_data = [line.rstrip('\n') for line in f]

    print get_sector_id_sum(input_data)
