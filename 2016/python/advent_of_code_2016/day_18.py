from definitions import INPUT_DIR

def is_trap(l,c,r):
    if l=='^' and c=='^' and r=='.':
        return True
    if l=='.' and c=='^' and r=='^':
        return True
    if l=='^' and c=='.' and r=='.':
        return True
    if l=='.' and c=='.' and r=='^':
        return True

    return False

def generate_row(prev_row):
    len_row = len(prev_row)
    padded_row = '.'+prev_row+'.'

    return "".join(['^' if is_trap(padded_row[i], padded_row[i+1],
                                   padded_row[i+2]) else '.' for i in range(0,
                                                                            len_row)])

def generate_trap_map(input_data, rows):
    trap_map = [input_data]
    [trap_map.append(generate_row(trap_map[-1])) for r in range(0, rows-1)]

    return trap_map

def count_safe_tiles(trap_map):
    return ''.join(r for r in trap_map).count('.')

if __name__ == "__main__":
    with open(INPUT_DIR + 'day_18.txt') as f:
        data = f.read()

    print count_safe_tiles(generate_trap_map(data, 40))
