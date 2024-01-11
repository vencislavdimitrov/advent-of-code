from collections import defaultdict

input = open(f"{__file__.replace('py', 'input')}").read().strip().split("\n")

graph = defaultdict(lambda: [])
for line in input:
    left, right = line.split(": ")
    for r in right.split(" "):
        graph[left].append(r)
        graph[r].append(left)

connections = defaultdict(lambda: 0)
for node in graph.keys():
    visited = {}

    queue = [node]
    while queue:
        current = queue.pop(0)
        visited[current] = True

        for to in graph[current]:
            if to in visited or to in queue:
                continue

            connections[":".join(sorted([current, to]))] += 1

            queue.append(to)

for nodes, _ in sorted(connections.items(), key=lambda x: x[1])[-3:]:
    node1, node2 = nodes.split(":")
    graph[node1].remove(node2)
    graph[node2].remove(node1)

visited = {}
queue = [list(graph.keys())[0]]

while queue:
    current = queue.pop(0)
    visited[current] = True

    for to in graph[current]:
        if to in visited or to in queue:
            continue

        queue.append(to)

print((len(graph) - len(visited)) * len(visited))
