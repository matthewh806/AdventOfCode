from read_input import get_input
import re
from itertools import combinations, permutations

class Node():
    def __init__(self, name, size, used, avail):
        self.name = name
        self.size = size
        self.used = used
        self.avail = avail

    def is_empty(self):
        return self.used == 0
    
    def can_store(self, size):
        return size <= self.avail

    def __repr__(self):
        return "<Node name:%s, size:%s, used:%s, avail:%s>" % (self.name,
                                                               self.size,
                                                               self.used,
                                                               self.avail)

    def __str__(self):
        return "Node: name is %s, size is %s, used is %s, avail is %s" % (self.name,
                                                                          self.size,
                                                                          self.used,
                                                                          self.avail)

class Grid():
    def __init__(self, node_data):
        self.nodes = self.parse_df(node_data)

    def is_viable_pair(self, a, b):
        return (not a.is_empty()) and (b.can_store(a.used))

    def get_viable_pairs(self):
        pairs = map(tuple, permutations(self.nodes.values(), r=2))
        return [ (a, b) for a, b in pairs if self.is_viable_pair(a,b)]

    def parse_df(self, node_data):
        nodes = {}
        for nd in node_data[2:]:
            name = re.search('node-x\d+-y\d+', nd).group(0)
            storage = re.findall('\d+T', nd)
            size, used, avail = [ int(s.strip('T')) for s in storage]
            nodes[name] = Node(name, size, used, avail)
        return nodes

if __name__ == "__main__":
    puzzle_input = get_input(22)
    n = Node('node-x0-y0', 86, 73, 13)
    print n
    g = Grid(puzzle_input)
    print len(g.get_viable_pairs())
