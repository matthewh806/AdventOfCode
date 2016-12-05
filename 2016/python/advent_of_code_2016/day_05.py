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

def get_positional_door_code(door_id, length):
    code = [''] * length

    idx = 0
    found = 0
    while found < length:
        h, idx = generate_hash_with_n_leading_zeros(door_id, idx, 5)
        idx = idx+1

        if not h[5].isdigit():
            continue
        
        if int(h[5]) >= length:
            continue
        
        if code[int(h[5])] != '':
            continue
        
        code[int(h[5])] = h[6]
        found = found+1
        
    return ''.join([c for c in code])
                

if __name__ == "__main__":
    puzzle_input = "cxdnnyjw"
    print get_door_code(puzzle_input, 8)    
    print get_positional_door_code(puzzle_input, 8)


