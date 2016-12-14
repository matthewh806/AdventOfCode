import hashlib
import string

def get_first_repeated_substr(string, char_set):
    sub_strs = {}
    for c in char_set:
        if c in string:
            sub_strs[c] = string.find(c)
            continue
    return min(sub_strs,key=sub_strs.get) if len(sub_strs) > 0 else None

def generate_md5_hashes(salt, n, start_idx=-1):
    idx = start_idx
    hashes = []
    hexdigits_three = [s*3 for s in set(string.hexdigits.lower())]

    while len(hashes) < n:
        idx+=1
        h = hashlib.md5(salt + str(idx)).hexdigest()
        substr = get_first_repeated_substr(h, hexdigits_three)

        if substr == None:
            continue

        for i in range(1, 1001):
            h2 = hashlib.md5(salt+str(idx+i)).hexdigest()
            if get_first_repeated_substr(h2, [substr[0]*5]):
                hashes.append(h)
                break

    return hashes, idx
         
if __name__ == "__main__":
    puzzle_input = 'ahsbgdzn'
    print generate_md5_hashes(puzzle_input, 64)
