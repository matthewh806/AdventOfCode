from read_input import get_input
from assembunny import AssemBunny

if __name__ == "__main__":
    puzzle_input = get_input(23)
    ab = AssemBunny({'a':7, 'b':0, 'c':0, 'd':0})
    ab.parse_instructions(puzzle_input)

    print ab.registers
