from read_input import get_input
from collections import deque
import re

def swap_by_index(string, idx_1, idx_2):
    l = list(string)
    l[idx_1], l[idx_2] = l[idx_2], l[idx_1]
    return ''.join(l)

def swap_by_char(string, ch_1, ch_2):
    l = list(string)
    idx_1, idx_2 = l.index(ch_1), l.index(ch_2)
    return swap_by_index(string, idx_1, idx_2)
  

def rotate_n_steps(string, steps):
    d = deque(list(string))
    d.rotate(steps)
    return ''.join(d)

def rotate_on_char_pos(string, char):
    l = list(string)
    idx = l.index(char)
    steps = 1 + idx + (1 if idx >=4 else 0)
    return rotate_n_steps(string, steps)

def reverse_by_index(string, idx_1, idx_2):
    l = list(string)
    l[idx_1:idx_2+1] = reversed(l[idx_1:idx_2+1])

    return "".join(l)
    

def move_by_index(string, idx_1, idx_2):
    l = list(string)
    char = l.pop(idx_1)
    l.insert(idx_2, char) 

    return "".join(l)

def parse_instructions(input_str, instructions):
    scrambled_input = input_str
    for ins in instructions:
        split_str = ins.split(' ')
        if ins.startswith('swap position'):
            idx_1, idx_2 = [int(m) for m in re.findall('\d+', ins)]
            scrambled_input = swap_by_index(scrambled_input, idx_1, idx_2) 
        if ins.startswith('swap letter'):
            scrambled_input = swap_by_char(scrambled_input, split_str[2],
                                           split_str[5])
        if ins.startswith('rotate left'):
            scrambled_input = rotate_n_steps(scrambled_input, -int(split_str[2]))    
        if ins.startswith('rotate right'):
            scrambled_input = rotate_n_steps(scrambled_input, int(split_str[2]))    
        if ins.startswith('rotate based'):
            scrambled_input = rotate_on_char_pos(scrambled_input,
                                                 split_str[-1])
        if ins.startswith('reverse'):
            scrambled_input = reverse_by_index(scrambled_input,
                                               int(split_str[2]),
                                               int(split_str[4]))
        if ins.startswith('move'):
            scrambled_input = move_by_index(scrambled_input, int(split_str[2]),
                                            int(split_str[5]))
    return scrambled_input

if __name__=="__main__":
    instructions = get_input(21)
    puzzle_input = 'abcdefgh'

    print parse_instructions(puzzle_input, instructions)
