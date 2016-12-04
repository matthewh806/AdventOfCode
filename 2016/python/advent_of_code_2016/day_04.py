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

def get_real_rooms(data):
    return [parse_room_data(d) for d in data if is_room_real(d)]

def decrypt_cipher(cipher_text, shift):
    cipher_text = cipher_text.replace('-', ' ')
    shift = shift % 26
    decrypted_chars = []

    for c in cipher_text:
        if c == ' ':
            decrypted_chars.append(c)
            continue

        x = ord(c) + shift
        decrypted_chars.append(chr(x if 97<= x <=122 else 96+x%122))

    return "".join(decrypted_chars)

if __name__ == "__main__":
    with open(INPUT_DIR + 'day_04.txt') as f:
        input_data = [line.rstrip('\n') for line in f]

    sector_id = get_sector_id_sum(input_data)
    real_rooms = get_real_rooms(input_data)

    decrypted_rooms = [(decrypt_cipher(r[0], r[1]), r[1]) for r in real_rooms]
    print decrypted_rooms

