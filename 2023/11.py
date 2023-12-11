input = open(f"{__file__.replace('py', 'input')}").read().strip().split("\n")

gaps_x = []
gaps_y = []

for i in range(len(input)):
    if all(x == "." for x in input[i]):
        gaps_x.append(i)

for i in range(len(input[i])):
    if all(x[i] == "." for x in input):
        gaps_y.append(i)

galaxies = []
for i in range(len(input)):
    for j in range(len(input[i])):
        if input[i][j] == "#":
            galaxies.append([i, j])


def distance(galaxies, gaps_x, gaps_y, n):
    distances = []
    for i in range(len(galaxies) - 1):
        for j in range(i + 1, len(galaxies)):
            ix = sum(1 for x in gaps_x if x < galaxies[i][0]) * n
            iy = sum(1 for x in gaps_y if x < galaxies[i][1]) * n
            jx = sum(1 for x in gaps_x if x < galaxies[j][0]) * n
            jy = sum(1 for x in gaps_y if x < galaxies[j][1]) * n
            (
                distances.append(
                    abs(galaxies[j][0] + jx - galaxies[i][0] - ix)
                    + abs(galaxies[j][1] + jy - galaxies[i][1] - iy)
                )
            )
    return sum(distances)


print(distance(galaxies, gaps_x, gaps_y, 1))
print(distance(galaxies, gaps_x, gaps_y, 999_999))
