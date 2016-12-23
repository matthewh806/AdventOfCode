from read_input import get_input
from collections import deque

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

def reverse_by_chars(string, ch_1, ch_2):
    idx_1, idx_2 = string.index(ch_1), string.index(ch_2)
    

def move_by_index(string, idx_1, idx_2):
    pass

def parse_instructions(input_str, instructions):
    for ins in instructions:
        if ins.begins_with('swap position'):
            pass
        if ins.begins_with('swap letter'):
            pass
        if ins.begins_with('rotate left'):
            pass
        if ins.begins_with('rotate right'):
            pass
        if ins.begins_with('rotate based'):
            pass
        if ins.begins_with('reverse'):
            pass
        if ins.begins_with('move'):
            pass

if __name__=="__main__":
    instructions = get_input(21)
    puzzle_input = 'abcdefgh'
