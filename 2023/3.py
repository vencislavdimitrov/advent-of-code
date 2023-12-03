import re
from collections import defaultdict

input = open(f"{__file__.replace('py', 'input')}").readlines()

total = 0
gears = defaultdict(list)


def neighbors(x, y, num):
    for i in range(x - 1, x + 2):
        for j in range(y - 1, y + len(num) + 1):
            if i >= 0 and i < len(input) and j >= 0 and j < len(input[i]):
                if input[i][j] in ["+", "-", "*", "/", "$", "&", "@", "#", "=", "%"]:
                    if input[i][j] == "*":
                        gears[(i, j)].append(int(num))
                    return True
    return False


num_pattern = re.compile("\d+")

for row_num in range(len(input)):
    for number in re.finditer(num_pattern, input[row_num]):
        if neighbors(row_num, number.start(), number.group(0)):
            total += int(number.group(0))

print(total)

gears_total = 0
for v in gears.values():
    if len(v) == 2:
        gears_total += v[0] * v[1]
print(gears_total)
