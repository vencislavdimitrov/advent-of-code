input = open(f"{__file__.replace('py', 'input')}").read().strip().split("\n")
input = [[int(x) for x in y.split()] for y in input]


def calc(line):
    history = [line]
    while not sum([l != 0 for l in line]) == 0:
        new_line = []
        for i in range(len(line) - 1):
            new_line.append(line[i + 1] - line[i])
        line = new_line
        history.append(line)

    last = None
    for i in range(len(history) - 1, 0, -1):
        history[i - 1].append(history[i][-1] + history[i - 1][-1])
        last = history[i - 1][-1]

    return last


print(sum([calc(x) for x in input]))
print(sum([calc(x[::-1]) for x in input]))
