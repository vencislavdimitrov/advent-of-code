import re

input = open(f"{__file__.replace('py', 'input')}").read().strip().split(",")

p1, p2 = 0, 0


def hash(str):
    v = 0
    for c in str:
        v = ((v + ord(c)) * 17) % 256
    return v


print(sum(map(hash, input)))

boxes = [None] * 256
for lens in input:
    lens = re.split(r"=|-", lens)
    h = hash(lens[0])
    if boxes[h] == None:
        boxes[h] = [0] * 9

    if lens[1]:
        ind = [
            i
            for i in range(len(boxes[h]))
            if boxes[h][i] == 0 or boxes[h][i][0] == lens[0]
        ][0]
        if ind >= 0:
            boxes[h][ind] = lens
    else:
        boxes[h] = list(filter(lambda x: x != 0 and x[0] != lens[0], boxes[h]))
        boxes[h] += [0] * (9 - len(boxes[h]))

total_sum = 0
for i, box in enumerate(boxes):
    if box is None:
        continue

    lens_sum = 0
    for j, lens in enumerate(box):
        if lens == 0:
            continue
        lens_sum += (j + 1) * int(lens[1])
    total_sum += (i + 1) * lens_sum

print(total_sum)
