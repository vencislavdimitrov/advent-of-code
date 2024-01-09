from collections import defaultdict

input = open(f"{__file__.replace('py', 'input')}").read().strip().split("\n")

start = [0, 1]
finish = [len(input) - 1, len(input[0]) - 2]


def longest_path(part1):
    vertices = [start, finish]

    for i in range(len(input)):
        for j in range(len(input)):
            if input[i][j] == "#":
                continue

            next_steps = []
            for dir in [[0, 1], [0, -1], [1, 0], [-1, 0]]:
                next_step = [i + dir[0], j + dir[1]]
                if (
                    next_step[0] < 0
                    or next_step[0] >= len(input)
                    or next_step[1] < 0
                    or next_step[1] >= len(input[0])
                    or input[next_step[0]][next_step[1]] == "#"
                ):
                    continue

                if part1:
                    if input[i][j] == ">":
                        if dir == [0, 1]:
                            next_steps.append(next_step)
                    elif input[i][j] == "<":
                        if dir == [0, -1]:
                            next_steps.append(next_step)
                    elif input[i][j] == "^":
                        if dir == [-1, 0]:
                            next_steps.append(next_step)
                    elif input[i][j] == "v":
                        if dir == [1, 0]:
                            next_steps.append(next_step)
                    else:
                        next_steps.append(next_step)
                else:
                    next_steps.append(next_step)
            if len(next_steps) > 2:
                vertices.append([i, j])

    distances = {}
    edges = defaultdict(lambda: [])
    for v in vertices:
        distance = 0
        visited = {}
        queue = [(v, 0)]

        while queue:
            current, distance = queue.pop(0)

            if current != v and current in vertices:
                distances[repr([v, current])] = distance
                edges[repr(v)].append(current)
                continue

            visited[repr(current)] = True

            next_steps = []
            for dir in [[0, 1], [0, -1], [1, 0], [-1, 0]]:
                next_step = [current[0] + dir[0], current[1] + dir[1]]
                if (
                    next_step[0] < 0
                    or next_step[0] >= len(input)
                    or next_step[1] < 0
                    or next_step[1] >= len(input[0])
                    or repr(next_step) in visited
                    or input[next_step[0]][next_step[1]] == "#"
                ):
                    continue

                if part1:
                    if input[current[0]][current[1]] == ">":
                        if dir == [0, 1]:
                            next_steps.append(next_step)
                    elif input[current[0]][current[1]] == "<":
                        if dir == [0, -1]:
                            next_steps.append(next_step)
                    elif input[current[0]][current[1]] == "^":
                        if dir == [-1, 0]:
                            next_steps.append(next_step)
                    elif input[current[0]][current[1]] == "v":
                        if dir == [1, 0]:
                            next_steps.append(next_step)
                    else:
                        next_steps.append(next_step)
                else:
                    next_steps.append(next_step)

            for step in next_steps:
                queue.append((step, distance + 1))

    visited = set()
    max_dist = 0
    queue = [(start, 0)]

    while queue:
        current, dist = queue.pop()
        if dist == -1:
            visited.remove(repr(current))
            continue

        if repr(current) in visited:
            continue

        visited.add(repr(current))

        if current == finish and dist > max_dist:
            max_dist = dist

        queue.append((current, -1))
        for step in edges[repr(current)]:
            queue.append((step, distances[repr([current, step])] + dist))

    return max_dist


print(longest_path(True))
print(longest_path(False))
