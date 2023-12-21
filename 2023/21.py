input = open(f"{__file__.replace('py', 'input')}").read().strip().split("\n")
start = [0, 0]
for i in range(len(input)):
    for j in range(len(input[0])):
        if input[i][j] == "S":
            start = [i, j]
            break


def bfs(steps):
    if len(steps) > 64:
        return len(steps[-1])

    steps.append([])
    for c in steps[-2]:
        for dir in [[0, 1], [0, -1], [1, 0], [-1, 0]]:
            new_c = [c[0] + dir[0], c[1] + dir[1]]
            if (
                new_c[0] < 0
                or new_c[0] >= len(input)
                or new_c[1] < 0
                or new_c[1] >= len(input[0])
                or input[new_c[0]][new_c[1]] == "#"
                or new_c in steps[-1]
            ):
                continue
            steps[-1].append(new_c)
    return bfs(steps)


print(bfs([[start]]))

steps_memo = {}
stack = [start + [0, 0, 0]]

while stack:
    x, y, map_x, map_y, steps = stack.pop(0)
    if x < 0:
        map_x -= 1
        x += len(input)
    elif x >= len(input):
        map_x += 1
        x -= len(input)
    if y < 0:
        map_y -= 1
        y += len(input[0])
    elif y >= len(input[0]):
        map_y += 1
        y -= len(input[0])

    if (
        input[x][y] == "#"
        or repr([x, y, map_x, map_y]) in steps_memo
        or map_x < -1
        or map_x > 1
        or map_y < -1
        or map_y > 1
    ):
        continue

    steps_memo[repr([x, y, map_x, map_y])] = steps

    for dir in [[0, 1], [0, -1], [1, 0], [-1, 0]]:
        stack.append([x + dir[0], y + dir[1], map_x, map_y, steps + 1])


memo = {}


def repeat(steps, map_corner):
    total_steps = 26_501_365
    if repr([steps, map_corner, total_steps]) in memo:
        return memo[repr([steps, map_corner, total_steps])]

    res = 0
    for i in range(1, (total_steps - steps) // len(input) + 1):
        if steps + len(input) * i > total_steps or (steps + len(input) * i) % 2 == 0:
            continue

        res += 1
        if not map_corner:
            res += i

    memo[repr([steps, map_corner, total_steps])] = res
    return res


res = 0
for i in range(len(input)):
    for j in range(len(input[0])):
        if not repr([i, j, 0, 0]) in steps_memo:
            continue

        for map_x in [-1, 0, 1]:
            for map_y in [-1, 0, 1]:
                steps = steps_memo[repr([i, j, map_x, map_y])]
                if steps % 2 == 1:
                    res += 1

                if map_x == 0 and map_y == 0:
                    continue

                res += repeat(steps, map_x == 0 or map_y == 0)

print(res)
