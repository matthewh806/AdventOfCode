def generate_random_string(a):
    b = ''.join('1' if x=='0' else '0' for x in a[::-1])
    return ''.join([a, '0', b])

def generate_data(initial_state, length):
    data = initial_state 
    while len(data) < length:
        data = generate_random_string(data)
    return data[:length]

def generate_checksum(initial_state, length):
    data = generate_data(initial_state, length)
    
    checksum = data

    def get_char(pair):
        return '1' if pair[0]==pair[1] else '0'

    while len(checksum) % 2 == 0:
        pairs = [ checksum[i:i+2] for i in range(0, len(checksum), 2)]
        checksum = ''.join([get_char(p) for p in pairs])
    return checksum

if __name__ == "__main__":
    puzzle_input = '01110110101001000'
    disk_size = 272

    print generate_checksum(puzzle_input, disk_size)
