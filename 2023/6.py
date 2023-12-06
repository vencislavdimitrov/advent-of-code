input = open(f"{__file__.replace('py', 'input')}").read().strip().split("\n")

time, distance = input
time = [int(x) for x in time.split()[1::]]
distance = [int(x) for x in distance.split()[1::]]

total = 1
for i, _ in enumerate(time):
    ways = 0
    for t in range(0, time[i]):
        if distance[i] < (time[i] - t) * t:
            ways += 1
    total *= ways
print(total)

time = int("".join([str(x) for x in time]))
distance = int("".join([str(x) for x in distance]))
ways = 0
for t in range(0, time):
    if distance < (time - t) * t:
        ways += 1
print(ways)
