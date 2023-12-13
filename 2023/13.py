input = open(f"{__file__.replace('py', 'input')}").read().strip().split("\n\n")


def reflection(pattern, smudge):
    for i in range(len(pattern) - 1):
        diff = 0
        for j in range(len(pattern)):
            if (
                i + (i - j) + 1 in range(len(pattern))
                and pattern[j] != pattern[i + (i - j) + 1]
            ):
                diff += len(
                    [
                        x
                        for x in range(len(pattern[j]))
                        if pattern[j][x] != pattern[i + (i - j) + 1][x]
                    ]
                )
        if diff == smudge:
            return i + 1
    return None


vertical = 0
horizontal = 0
for pattern in input:
    pattern = [x for x in pattern.split("\n")]
    ref = reflection(pattern, 0)
    if ref is not None:
        vertical += ref
    ref = reflection(list(map(list, zip(*pattern))), 0)
    if ref is not None:
        horizontal += ref
print(vertical * 100 + horizontal)

vertical = 0
horizontal = 0
for pattern in input:
    pattern = [x for x in pattern.split("\n")]
    ref = reflection(pattern, 2)
    if ref is not None:
        vertical += ref
    ref = reflection(list(map(list, zip(*pattern))), 2)
    if ref is not None:
        horizontal += ref
print(vertical * 100 + horizontal)
