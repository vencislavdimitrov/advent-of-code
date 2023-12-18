input = open(f"{__file__.replace('py', 'input')}").read().strip().split("\n")

dir1 = {
    "R": [0, 1],
    "D": [1, 0],
    "L": [0, -1],
    "U": [-1, 0],
}
dir2 = {
    "0": [0, 1],
    "1": [1, 0],
    "2": [0, -1],
    "3": [-1, 0],
}


def calc_area(get_direction, get_length):
    current = [0, 0]
    perimeter = 0
    area = 0
    for line in input:
        direction = get_direction(line)
        length = get_length(line)
        new_current = [
            current[0] + length * direction[0],
            current[1] + length * direction[1],
        ]

        area -= current[0] * new_current[1]
        area += current[1] * new_current[0]

        current[0] += length * direction[0]
        current[1] += length * direction[1]
        perimeter += length
    return (area + perimeter) // 2 + 1


print(calc_area(lambda x: dir1[x.split(" ")[0]], lambda x: int(x.split(" ")[1])))
print(
    calc_area(
        lambda x: dir2[x.split(" ")[-1][-2]], lambda x: int(x.split(" ")[-1][2:-2], 16)
    )
)
