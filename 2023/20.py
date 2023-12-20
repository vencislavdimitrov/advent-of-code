import math

input = open(f"{__file__.replace('py', 'input')}").read().strip().split("\n")
input = [x.split(" -> ") for x in input]
types = {}
modules = {}
acc = {}
state = {}

for line in input:
    modules[line[0][1:]] = line[1].split(", ")
    types[line[0][1:]] = line[0][0]
    state[line[0][1:]] = False

for t in [x for x in types if types[x] == "&"]:
    acc[t] = {}
    for k in modules:
        for vv in modules[k]:
            if vv == t:
                acc[t][k] = False

low = 0
high = 0
t = 0
cache = {}
steps = []
rx = ["br", "fk", "lf", "rz"]

while True:
    queue = [["roadcaster", "", False]]
    while queue:
        to, pulse_from, pulse = queue.pop(0)

        if pulse:
            high += 1
        else:
            if to in rx and to in cache:
                steps.append(t - cache[to])
            cache[to] = t
            low += 1

        if len(steps) == len(rx):
            print(math.lcm(*steps))
            exit()

        if not to in modules:
            continue

        if types[to] == "b":
            for new_to in modules[to]:
                queue.append([new_to, to, pulse])
        elif types[to] == "%":
            if not pulse:
                state[to] = not state[to]
                pulse = state[to]
                for new_to in modules[to]:
                    queue.append([new_to, to, pulse])
        elif types[to] == "&":
            acc[to][pulse_from] = pulse
            pulse = not all(x for x in acc[to].values())
            for new_to in modules[to]:
                queue.append([new_to, to, pulse])

    t += 1
    if t == 1000:
        print(low * high)
