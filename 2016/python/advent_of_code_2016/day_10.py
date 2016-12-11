from definitions import INPUT_DIR
from collections import defaultdict
import re

bot = defaultdict(list)
output = defaultdict(list)

def parse_initial_condition(instr):
    m = re.findall('\d+', instr)
    return int(m[1]), int(m[0])

def set_initial_conditions(data):
    allocs = [parse_initial_condition(d) for d in data if len(re.findall('\d+', d)) == 2]
    
    for k, v in allocs:
        bot[k].append(v)
    return bot

def read_bot_instructions(data):
    pipeline = {}
    instructions = [d for d in data if len(re.findall('\d+', d)) == 3]
    
    for i in instructions:
        b, l, h = map(int, re.findall('\d+', i))
        t1, t2 = re.findall(r'\s(bot|output)',i)
        
        pipeline[b] = (t1, l), (t2, h)
    return pipeline

def simulate_bots(data, v1, v2):
    set_initial_conditions(data)
    instructions = read_bot_instructions(data)

    while bot:
        for k, v in bot.items():
            if len(v) == 2:
                l, h = sorted(bot.pop(k))
                if l == v1 and h == v2: print k
                (t1, n1), (t2, n2) = instructions[k]
                eval(t1)[n1].append(l)
                eval(t2)[n2].append(h)

if __name__ == "__main__":
    with open(INPUT_DIR + 'day_10.txt') as f:
        data = [d.rstrip('\n') for d in f]
    simulate_bots(data, 17, 61)
    print reduce(lambda x,y: x*y, [output[o][0] for o in [0, 1, 2]])
