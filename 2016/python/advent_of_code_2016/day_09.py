from definitions import INPUT_DIR
import re

def parse_marker(marker):
    m = re.findall('\d+', marker)
    return int(m[0]), int(m[1])

def decompress_string(input_str):
    start_idx = 0 
    while True:
        markers = re.findall('\(.*?\)', input_str[start_idx:])
        if len(markers) == 0:
            break

        m = markers.pop(0)

        chars, repeat = parse_marker(m)
        s_idx = input_str[start_idx:].find(m) + len(m)
        e_idx = s_idx + chars

        sub_str = input_str[start_idx + s_idx:start_idx + e_idx]
        new_sub_str = sub_str * repeat
        new_str = input_str[start_idx:].replace(sub_str, new_sub_str)
        
        input_str = input_str[:start_idx] + new_str
        input_str = input_str[:start_idx] + input_str[start_idx:].replace(m, '', 1)
        start_idx = input_str.find(new_sub_str) + len(new_sub_str) 

    return input_str

def decompress_length(input_str):
    idx = 0
    decompressed_length = 0

    while idx < len(input_str):
        matcher = re.compile(r'[(](\d+)x(\d+)[)]').match
        m = matcher(input_str, idx)
        if m:
            chars, replace = map(int, m.groups())
            idx = m.end(0)
            decompressed_length += replace *\
                    decompress_length(input_str[idx:idx+chars])
            idx += chars
        else:
            decompressed_length += 1
            idx += 1
    return decompressed_length

    return decompressed_length

if __name__ == "__main__":
    with open(INPUT_DIR + 'day_09.txt') as f:
        data = [l.rstrip('/n') for l in f]
    
    output = "".join([decompress_string(d) for d in data])
    print len(output.replace(" ", ""))
    print decompress_length("".join([d for d in data]))
