from heapq import heappop, heappush
from collections import defaultdict

input = open(f"{__file__.replace('py', 'input')}").read().strip().split("\n")
input = [[int(x) for x in y] for y in input]


def dijkstra(start, finish, min_steps, max_steps):
    dist = defaultdict(lambda: 999_999)
    visited = {}
    unvisited = [[0, start, []]]
    dist[repr(start + [])] = 0

    while unvisited:
        cost, current, dir = heappop(unvisited)

        if repr(current + dir) in visited:
            continue

        visited[repr(current + dir)] = True

        for new_dir in [[0, 1], [1, 0], [0, -1], [-1, 0]]:
            new_cost = 0

            if (
                new_dir == dir
                or (len(dir) and new_dir[0] == dir[0] and new_dir[1] != dir[1])
                or (len(dir) and new_dir[0] != dir[0] and new_dir[1] == dir[1])
            ):
                continue

            for stretch in range(1, max_steps + 1):
                step = [
                    current[0] + new_dir[0] * stretch,
                    current[1] + new_dir[1] * stretch,
                ]
                if (
                    step[0] < 0
                    or step[0] >= len(input)
                    or step[1] < 0
                    or step[1] >= len(input[0])
                ):
                    continue

                new_cost += input[step[0]][step[1]]
                if stretch < min_steps:
                    continue

                if new_cost + cost < dist[repr(step + new_dir)]:
                    dist[repr(step + new_dir)] = new_cost + cost
                    heappush(unvisited, [new_cost + cost, step, new_dir])

    return min([dist[repr(finish + x)] for x in [[0, 1], [1, 0], [0, -1], [-1, 0]]])


print(dijkstra([0, 0], [len(input) - 1, len(input[0]) - 1], 1, 3))
print(dijkstra([0, 0], [len(input) - 1, len(input[0]) - 1], 4, 10))
