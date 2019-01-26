from search import breadth_first_search
from read_input import get_input

class Maze():
    def __init__(self, maze_input):
        self.grid = self.parse_input(maze_input)

    def get_valid_moves(self, x, y):
        moves = [(x, y-1), (x+1, y), (x, y+1), (x-1,y)]
        
        valid_moves = []
        for m in moves:
            if m[0] < 0 or m[0] >= len(self.grid[0]):
                continue
            
            if m[1] < 0 or m[1] >= len(self.grid):
                continue

            if self.grid[m[1]][m[0]] == '#':
                continue
            
            valid_moves.append((m[0], m[1]))
        return valid_moves

    def parse_input(self, maze_input):
        return [r for r in maze_input]


if __name__ == "__main__":
    pass
