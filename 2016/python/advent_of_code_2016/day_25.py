import sys
from read_input import get_input
from assembunny import AssemBunny
from itertools import repeat

def first(iterable): 
	return next(iter(iterable))

def repeating_signal(a, instructions, target_signal, steps=10**6, signal_len = 100):
	signal = AssemBunny({'a':a, 'b':0, 'c':0, 'd':0}).parse_instructions(instructions, steps=steps)
	count = 0
	for i, (s, t) in enumerate(zip(signal, target_signal)):
		count = i
		if signal != t:
			return False
	return count >= signal_len

if __name__ == "__main__":
	first(a for a in range(0, 10**6) if repeating_signal(a, get_input(25), repeat((0,1))))