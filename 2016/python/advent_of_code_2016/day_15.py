from read_input import get_input
import re

class Disc:
    def __init__(self, name, num_positions, initial_pos):
        self.name = name
        self.num_positions = num_positions
        self.initial_pos = initial_pos
        self.current_pos = initial_pos

    def update(self):
        self.current_pos = (self.current_pos + 1) % self.num_positions
        return self.current_pos

    def update_n_times(self, n):
        self.current_pos = (self.current_pos + n) % self.num_positions
        return self.current_pos

    def reset_position(self):
        self.current_pos = self.initial_pos

def parse_input(data):
    parsed = [re.findall('\d+',l) for l in data]
    return [[p[0], int(p[1]), int(p[3])] for p in parsed]

def run(data):
    initial_t = -1 
    disc_data = parse_input(data)
    discs = [Disc(*d) for d in disc_data]
    
    complete = False
    while not complete:
        [d.reset_position() for d in discs]
        initial_t += 1
        complete = all([d.update_n_times(initial_t + idx+1) == 0 for idx, d in
             enumerate(discs)])
    return initial_t

if __name__=="__main__":
    data = get_input(15)
    print run(data)

    data.append('Disc #7 has 11 positions; at time=0, it is at position 0.')
    print run(data)
