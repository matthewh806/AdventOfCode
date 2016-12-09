from definitions import INPUT_DIR
import re
import numpy as np

class Screen:
    def __init__(self, width, height):
        self.array = np.zeros([height, width])

    def create_rect(self, width, height):
        self.array[:height, :width] = 1

    def rotate_row(self, row, amount):
        self.array[row, :] = np.roll(self.array[row,:], amount)

    def rotate_column(self, col, amount):
        self.array[:,col] = np.roll(self.array[:,col], amount)

    def lit_pixels_count(self):
        return np.count_nonzero(self.array)

    def parse_instruction(self, inst):
        digits = [int(s) for s in re.findall(r'\d+', inst)]
        if inst.startswith('rect'):
            self.create_rect(digits[0], digits[1])
        elif inst.startswith('rotate column'):
            self.rotate_column(digits[0], digits[1])
        elif inst.startswith('rotate row'):
            self.rotate_row(digits[0], digits[1])

if __name__ == "__main__":
    with open(INPUT_DIR + 'day_08.txt') as f:
        data = [l.strip('\n') for l in f]
    s = Screen(50, 6)

    for i in data:
        s.parse_instruction(i)

    print s.lit_pixels_count()

