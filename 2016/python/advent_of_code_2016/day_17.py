import hashlib
import Queue

class Node():
    def __init__(self, state, path):
        self.state = state
        self.path = path

class Grid():
    def __init__(self, size_x, size_y,  passcode):
        self.size_x, self.size_y = size_x, size_y
        self.base_passcode = passcode

    def generate_passcode_hash(self, passcode):
        return hashlib.md5(passcode).hexdigest()

    def is_open(self, char):
        return char in 'bcdef'

    def get_valid_moves(self, x, y, path):
        hashed_code = self.generate_passcode_hash(self.base_passcode +
                                             "".join(path))[:4]
        moves = [(x,y-1), (x,y+1), (x-1,y), (x+1,y)] 
        valid_moves = []

        for idx, m in enumerate(moves):
            if m[0] < 0 or m[0] >= self.size_x:
                continue
            if m[1] < 0 or m[1] >= self.size_y:
                continue
            if self.is_open(hashed_code[idx]):
                valid_moves.append(m)
        return valid_moves

    def get_dir(self, pos_1, pos_2):
        x1, y1 = pos_1
        x2, y2 = pos_2
        
        if not x1 == x2 and not y1 == y2:
            return None
        
        if x1 == x2:
            return 'U' if y2 < y1 else 'D'
        if y1 == y2:
            return 'L' if x2 < x1 else 'R'

    def shortest_route(self, goal):
        node = Node((0, 0), [])

        if node.state == goal: return "".join(node_path)
        
        frontier = Queue.Queue()
        frontier.put(node)
        
        while not frontier.empty():
            node = frontier.get()
            if node.state == goal: return "".join(node.path)
            valid_moves = self.get_valid_moves(node.state[0], node.state[1],
                                               node.path)
            for l in valid_moves:
                frontier.put(Node(l, node.path + [self.get_dir(node.state,l)]))
        return None


if __name__=="__main__":
    puzzle_input='bwnlcvfs'

    g = Grid(4,4,'bwnlcvfs')
    print g.shortest_route((3,3))
