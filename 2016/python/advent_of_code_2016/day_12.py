from definitions import INPUT_DIR
from assembunny import AssemBunny

if __name__ == "__main__":
    with open(INPUT_DIR + 'day_12.txt') as f:
        instr = [l.rstrip('\n') for l in f]

    p1 = AssemBunny({'a':0,'b':0,'c':0,'d':0})
    p2 = AssemBunny({'a':0,'b':0,'c':1,'d':0})
    p1.parse_instructions(instr)
    p2.parse_instructions(instr)
    print p1.registers
    print p2.registers

