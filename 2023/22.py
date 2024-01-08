from collections import defaultdict

input = open(f"{__file__.replace('py', 'input')}").read().strip().split("\n")

bricks = []
for line in input:
    start, end = line.split("~")
    start = [int(x) for x in start.split(",")]
    end = [int(x) for x in end.split(",")]

    bricks.append([])
    for x in range(start[0], end[0] + 1):
        for y in range(start[1], end[1] + 1):
            for z in range(start[2], end[2] + 1):
                bricks[-1].append([x, y, z])

bricks = sorted(bricks, key=lambda x: min([y[2] for y in x]))


def fall(bricks):
    fallen = []
    max_z = defaultdict(lambda: 0)
    for i in range(len(bricks)):
        diff = (
            min([x[2] for x in bricks[i]])
            - max([max_z[(x[0], x[1])] for x in bricks[i]])
            - 1
        )
        moved_brick = [[x[0], x[1], x[2] - diff] for x in bricks[i]]

        fallen.append(moved_brick)
        for b in bricks[i]:
            max_z[(b[0], b[1])] = max(
                [max_z[(b[0], b[1])], max([x[2] for x in moved_brick])]
            )
    return fallen


def count_fallen(bricks):
    moved = 0
    max_z = defaultdict(lambda: 0)
    for i in range(len(bricks)):
        diff = (
            min([x[2] for x in bricks[i]])
            - max([max_z[(x[0], x[1])] for x in bricks[i]])
            - 1
        )
        moved_brick = [[x[0], x[1], x[2] - diff] for x in bricks[i]]

        if diff > 0:
            moved += 1

        for b in bricks[i]:
            max_z[(b[0], b[1])] = max(
                [max_z[(b[0], b[1])], max([x[2] for x in moved_brick])]
            )
    return moved


bricks = fall(bricks)

safe_bricks = 0
unsafe_bricks = 0
for i in range(len(bricks)):
    fallen = count_fallen(bricks[0:i] + bricks[i + 1 :])
    unsafe_bricks += fallen
    if fallen == 0:
        safe_bricks += 1
print(safe_bricks)
print(unsafe_bricks)
