import Queue

class Node():
    def __init__(self, state, path):
        self.state = state
        self.path = path

class Maze():
    def __init__(self, start_x, start_y, fav_num):
        self.x = start_x
        self.y = start_y
        self.fav_num = fav_num

    def is_wall(self, x, y):
       s = x*x + 3*x + 2*x*y + y + y*y 
       s += self.fav_num

       return bin(s).count('1') % 2 == 1 

    def get_valid_moves(self, x, y):
        moves = [(x,y-1), (x+1,y), (x,y+1), (x-1,y)]
        return [m for m in moves if m[0] >= 0 and m[1] >= 0 and not
                self.is_wall(m[0],m[1])]

    def shortest_route(self, target_x, target_y, max_steps=None):
        node = Node((self.x, self.y), [])
        goal = (target_x, target_y)

        if node.state == goal:
           return
        frontier = Queue.Queue()
        frontier.put(node)
        explored = set()

        while not frontier.empty():
            node = frontier.get()

            if max_steps and len(node.path) > max_steps:
                return explored

            if node.state==goal: return node.path

            if not node.state in explored:
                explored.add(node.state)
                [frontier.put(Node(l, node.path + [l])) for l in self.get_valid_moves(node.state[0],
                                                             node.state[1])]
    def max_distinct_locations(self, n_steps):
        return self.shortest_route(-1, -1, 50) 

    def pretty_print(size_x, size_y):
        pass

if __name__=="__main__":
    puzzle_input = 1350

    m = Maze(1,1,1350)
    print len(m.shortest_route(31,39))
    print (m.max_distinct_locations(50))
    print len(m.max_distinct_locations(50))
