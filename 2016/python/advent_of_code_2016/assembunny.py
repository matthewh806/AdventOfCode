import re

def is_digit(n):
    try:
        int(n)
        return True
    except ValueError:
        return False

class AssemBunny():
    def __init__(self, registers):
        self.registers = registers

    def copy(self, instr):
        _, v, reg = instr.split(' ')[:3]
        if not str.isalpha(reg): return
        self.registers[reg] = int(v) if is_digit(v) else self.registers[v] 
        
    def increment(self, instr):
        _, reg = instr.split(' ')
        self.registers[reg] += 1 

    def decrement(self, instr):
        _, reg = instr.split(' ')
        self.registers[reg] -= 1 

    def multiply(self, instr):
        _, r1, r2, r3 = instr.split(' ')
        self.registers[r3] = self.registers[r1] * self.registers[r2]

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
            elif i.startswith('mul'):
                self.multiply(i)
            elif i.startswith('jnz'):
                _, reg, offset = i.split(' ')

                if str.isalpha(offset): offset = self.registers[offset]
                if str.isdigit(reg) or self.registers[reg] != 0:
                    idx+=int(offset)
                    continue
            elif i.startswith('tgl'):
                _, reg = i.split(' ')
                tgl_idx = idx + self.registers[reg]
                if tgl_idx >= len(instr):
                    idx+=1
                    continue
                
                tgl_instr = instr[tgl_idx].split(' ')
                if len(tgl_instr) == 2:
                    tgl_instr[0] = 'dec' if tgl_instr[0] == 'inc' else 'inc'
                    instr[tgl_idx] = " ".join(tgl_instr)
                elif len(tgl_instr) == 3:
                    tgl_instr[0] = 'cpy' if tgl_instr[0] == 'jnz' else 'jnz'
                    instr[tgl_idx] = " ".join(tgl_instr)
            idx+=1
