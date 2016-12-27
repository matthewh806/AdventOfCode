from read_input import get_input
from assembunny import AssemBunny

if __name__ == "__main__":
    puzzle_input = get_input(23)
    ab = AssemBunny({'a':7, 'b':0, 'c':0, 'd':0})
    ab.parse_instructions(puzzle_input)

    print ab.registers

    puzzle_input_2 = get_input('23_ii')
    ab2 = AssemBunny({'a':12, 'b':0, 'c':0, 'd':0})
    ab2.parse_instructions(puzzle_input_2)

    print ab2.registers
