input = open(f"{__file__.replace('py', 'input')}").read().strip().split("\n\n")

seeds = [int(x) for x in input[0].split()[1::]]
maps = [
    [[int(y) for y in x.split(" ")] for x in map.split("\n")[1::]] for map in input[1::]
]

for i, seed in enumerate(seeds):
    for map in maps:
        for line in map:
            if line[1] <= seeds[i] < line[1] + line[2]:
                seeds[i] = line[0] + seeds[i] - line[1]
                break

print(min(seeds))


seeds = [int(x) for x in input[0].split()[1::]]
seed_ranges = []
for i in range(0, len(seeds), 2):
    seed_ranges.append([seeds[i], seeds[i + 1]])


def in_seeds(n):
    for seed in seed_ranges:
        if seed[0] <= n < seed[0] + seed[1]:
            return True
    return False


i = 100_000_000
while True:
    n = i
    for map in reversed(maps):
        for line in map:
            if line[0] <= n < line[0] + line[2]:
                n = line[1] + n - line[0]
                break

    if in_seeds(n):
        break
    i += 1

print(i)
