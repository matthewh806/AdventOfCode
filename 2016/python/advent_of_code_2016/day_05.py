import hashlib

def generate_hash_with_n_leading_zeros(door_input, start_idx, n):
    idx = start_idx
    while True:
        h = hashlib.md5(door_input + str(idx)).hexdigest()
        if h[:n] == len(h[:n]) * '0':
            break
        idx = idx + 1 

    return h, idx

def get_door_code(door_id, length):
    code = [] 
    
    idx = 0
    while len(code) < length:
        h, idx = generate_hash_with_n_leading_zeros(door_id, idx, 5)
        code.append(h[5])
        idx = idx + 1 
    return ''.join([c for c in code])

if __name__ == "__main__":
    puzzle_input = "cxdnnyjw"
    print get_door_code(puzzle_input, 8)    


