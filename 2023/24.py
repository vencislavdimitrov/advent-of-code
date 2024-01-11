from itertools import combinations

input = open(f"{__file__.replace('py', 'input')}").read().strip().split("\n")

stones = []
for line in input:
    l, r = line.split(" @ ")
    stone = [int(x) for x in l.split(", ")]
    stone += [int(x) for x in r.split(", ")]
    stones.append(stone)

stones.sort()


def intersection_point(p1, p2, n1, n2):
    p1End = [p1[0] + n1[0], p1[1] + n1[1]]
    p2End = [p2[0] + n2[0], p2[1] + n2[1]]

    m1 = (p1End[1] - p1[1]) / (p1End[0] - p1[0])
    m2 = (p2End[1] - p2[1]) / (p2End[0] - p2[0])

    b1 = p1[1] - m1 * p1[0]
    b2 = p2[1] - m2 * p2[0]

    if m1 == m2:
        return [float("inf"), float("inf")]

    px = (b2 - b1) / (m1 - m2)
    py = m1 * px + b1

    if (
        (p1[0] > px and n1[0] > 0 or p1[0] < px and n1[0] < 0)
        or (p1[1] > py and n1[1] > 0 or p1[1] < py and n1[1] < 0)
        or (p2[0] > px and n2[0] > 0 or p2[0] < px and n2[0] < 0)
        or (p2[1] > py and n2[1] > 0 or p2[1] < py and n2[1] < 0)
    ):
        return [float("inf"), float("inf")]

    return [px, py]


count = 0
for i in range(len(stones) - 1):
    for j in range(i + 1, len(stones)):
        p1 = [stones[i][0], stones[i][1]]
        p2 = [stones[j][0], stones[j][1]]
        n1 = [stones[i][3], stones[i][4]]
        n2 = [stones[j][3], stones[j][4]]
        ip = intersection_point(p1, p2, n1, n2)
        if (
            ip[0] >= 200000000000000
            and ip[0] <= 400000000000000
            and ip[1] >= 200000000000000
            and ip[1] <= 400000000000000
        ):
            count += 1

print(count)


def rockPos(coord, stones):
    possible = set()

    for p1, p2 in combinations(stones, 2):
        p1_coord = p1[coord]
        p1_vel = p1[coord + 3]
        p2_coord = p2[coord]
        p2_vel = p2[coord + 3]

        if p1_vel == p2_vel:
            new_possible = set()
            diff = p2_coord - p1_coord
            for i in range(1000):
                if p1_vel == i:
                    continue

                if diff % (i - p1_vel) == 0:
                    new_possible.add(i)
            if len(possible) == 0:
                possible = new_possible.copy()
            else:
                possible = possible & new_possible

    return possible.pop()


rock_vel = [rockPos(0, stones), rockPos(1, stones), rockPos(2, stones)]

p1 = stones[0]
p2 = stones[1]
p1_acc = (p1[4] - rock_vel[1]) / (p1[3] - rock_vel[0])
p2_acc = (p2[4] - rock_vel[1]) / (p2[3] - rock_vel[0])
x_coord = p1[1] - (p1_acc * p1[0])
y_coord = p2[1] - (p2_acc * p2[0])
rock_x = int((y_coord - x_coord) / (p1_acc - p2_acc) + 1)
rock_y = int(p1_acc * rock_x + x_coord)
t = (rock_x - p1[0]) // (p1[3] - rock_vel[0])
rock_z = p1[2] + (p1[5] - rock_vel[2]) * t

print(rock_x + rock_y + rock_z)
