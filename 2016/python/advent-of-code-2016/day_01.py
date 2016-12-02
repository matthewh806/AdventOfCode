from definitions import INPUT_DIR
from math import fabs
import collections

def taxicab_distance(initial, final):
    return sum(fabs(p-q) for p, q in zip(initial, final))    

def parse_instructions(data):
    instr = data.replace(" ", "").split(',')
    dir_x, dir_y = 0, 1
    pos_x, pos_y = 0, 0
    
    unique_positions = set({0,0}) 
    first_repeat=None
    for i in instr:
        direction = i[0]
        steps = i[1:]
        
        if direction=='R':
            new_x = 0 * dir_x + 1 * dir_y
            new_y = -1 * dir_x + 0 * dir_y

        if direction=='L':
            new_x = 0 * dir_x + -1 * dir_y
            new_y = 1 * dir_x + 0 * dir_y

        dir_x, dir_y = new_x, new_y
        new_pos_x = pos_x + int(steps) * dir_x
        new_pos_y = pos_y + int(steps) * dir_y
        
        visited_x, visited_y = [pos_x] * int(steps), [pos_y] * int(steps)

        if(new_pos_x != pos_x):
            visited_x = [ pos_x + (i+1) * dir_x for i in range(int(steps))]
        if(new_pos_y != pos_y):
            visited_y = [ pos_y + (i+1) * dir_y for i in range(int(steps))]
        
        visited = [(x,y) for x,y in zip(visited_x, visited_y)]
        
        if first_repeat == None:
            repeats = [p for p in visited if p in unique_positions] 
            first_repeat = repeats[0] if len(repeats) > 0 else None

        unique_positions.update(visited)
        pos_x, pos_y = visited_x[-1], visited_y[-1] 
    return (pos_x, pos_y), first_repeat

def get_repeated_locations(positions):
    return [i for i, count in collections.Counter(positions).items() if count > 1] 

if __name__ == "__main__":
    with open(INPUT_DIR + 'day_01.txt') as f:
        input_data = f.read()
    
    positions = parse_instructions('R8, R4, R4, R8')
    positions = parse_instructions(input_data)
    print taxicab_distance((0,0), positions[0])
    if positions[1] != None:
        print taxicab_distance((0,0), positions[1])
