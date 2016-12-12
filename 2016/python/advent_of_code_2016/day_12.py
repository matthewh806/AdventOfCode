from definitions import INPUT_DIR
import re

class AssemBunny():
    def __init__(self, registers):
        self.registers = registers

    def copy(self, instr):
        _, v, reg = instr.split(' ')
        self.registers[reg] = int(v) if str.isdigit(v) else self.registers[v] 
        
    def increment(self, instr):
        _, reg = instr.split(' ')
        self.registers[reg] += 1 

    def decrement(self, instr):
        _, reg = instr.split(' ')
        self.registers[reg] -= 1 

    def parse_instructions(self, instr):
        idx = 0
        while idx < len(instr):
            i = instr[idx]
            
            if i.startswith('cpy'):
                self.copy(i)
            elif i.startswith('inc'):
                self.increment(i)
            elif i.startswith('dec'):
                self.decrement(i)
            elif i.startswith('jnz'):
                _, reg, offset = i.split(' ')

                if str.isdigit(reg) or self.registers[reg] != 0:
                    idx+=int(offset)
                    continue

            idx=idx+1

if __name__ == "__main__":
    with open(INPUT_DIR + 'day_12.txt') as f:
        instr = [l.rstrip('\n') for l in f]

    p1 = AssemBunny({'a':0,'b':0,'c':0,'d':0})
    p2 = AssemBunny({'a':0,'b':0,'c':1,'d':0})
    p1.parse_instructions(instr)
    p2.parse_instructions(instr)
    print p1.registers
    print p2.registers

