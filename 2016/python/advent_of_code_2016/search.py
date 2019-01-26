class Node():
    def __init__(self, state, path):
        self.state = state
        self.path = path


def breadth_first_search(target_x, target_y, valid_moves_fn):
    node = Node((target_x, target_y), [])
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
            [frontier.put(Node(l, node.path + [l])) for l in valid_moves_fn(node.state[0],
                                                         node.state[1])]


def a_star_search(start, heuristic_fn, valid_moves_fn):
    pass
    
