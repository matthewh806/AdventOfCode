import hashlib
import string
import functools32

@functools32.lru_cache(maxsize=None)
def get_md5_hash(input_str):
    return hashlib.md5(input_str).hexdigest()

@functools32.lru_cache(maxsize=None)
def get_stretched_md5_hash(input_str):
    for _ in range(0,2017):
        input_str = hashlib.md5(input_str).hexdigest()
    return input_str
    
def get_first_repeated_substr(string, char_set):
    sub_strs = {}
    for c in char_set:
        if c in string:
            sub_strs[c] = string.find(c)
            continue
    return min(sub_strs,key=sub_strs.get) if len(sub_strs) > 0 else None

def generate_md5_hashes(salt, n, start_idx=-1, stretch=False):
    idx = start_idx
    hashes = []
    hexdigits_three = [s*3 for s in set(string.hexdigits.lower())]

    fn = get_stretched_md5_hash if stretch else get_md5_hash

    while len(hashes) < n:
        idx+=1
        h = fn(salt + str(idx))
        substr = get_first_repeated_substr(h, hexdigits_three)

        if substr == None:
            continue

        for i in range(1, 1001):
            h2 = fn(salt+str(idx+i))
            if get_first_repeated_substr(h2, [substr[0]*5]):
                hashes.append(h)
                break

    return hashes, idx
         
if __name__ == "__main__":
    puzzle_input = 'ahsbgdzn'
    print generate_md5_hashes(puzzle_input, 64)
    print generate_md5_hashes(puzzle_input, 64, -1, True)
