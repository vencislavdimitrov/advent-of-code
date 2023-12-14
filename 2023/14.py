from copy import deepcopy

input = open(f"{__file__.replace('py', 'input')}").read().strip().split("\n")
input = [[*x] for x in input]


def tilt(platform):
    for i in range(len(platform)):
        for j in range(len(platform[i])):
            if platform[i][j] != "O":
                continue

            k = i - 1
            while True:
                if k == -1 or platform[k][j] == "#" or platform[k][j] == "O":
                    break
                k -= 1
            platform[i][j], platform[k + 1][j] = platform[k + 1][j], platform[i][j]
    return platform


def load(platform):
    total_sum = 0
    for i in range(len(platform)):
        total_sum += (len(platform) - i) * platform[i].count("O")
    return total_sum


print(load(tilt(deepcopy(input))))

cache = {}
platform = input
t = 0
while t < 1_000_000_000:
    if repr(platform) in cache:
        t = 1_000_000_000 - ((1_000_000_000 - t) % (t - cache[repr(platform)]))
    cache[repr(platform)] = t
    t += 1

    platform = [list(r) for r in zip(*tilt(platform)[::-1])]
    platform = [list(r) for r in zip(*tilt(platform)[::-1])]
    platform = [list(r) for r in zip(*tilt(platform)[::-1])]
    platform = [list(r) for r in zip(*tilt(platform)[::-1])]

print(load(platform))
