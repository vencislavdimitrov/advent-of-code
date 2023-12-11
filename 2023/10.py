input = open(f"{__file__.replace('py', 'input')}").read().strip().split("\n")

for i in range(len(input)):
    for j in range(len(input[i])):
        if input[i][j] == "S":
            start = [i, j]

loop_length = 1
current_pos = [start[0] + 1, start[1]]  # manually choose starting direction
previous_pos = [-1, 0]
steps = {str(start): 1}

while input[current_pos[0]][current_pos[1]] != "S":
    steps[str(current_pos)] = max(steps.values()) + 1
    match input[current_pos[0]][current_pos[1]]:
        case "|":
            if previous_pos == [1, 0]:
                current_pos[0] -= 1
            elif previous_pos == [-1, 0]:
                current_pos[0] += 1
        case "-":
            if previous_pos == [0, 1]:
                current_pos[1] -= 1
            elif previous_pos == [0, -1]:
                current_pos[1] += 1
        case "L":
            if previous_pos == [-1, 0]:
                previous_pos = [0, -1]
                current_pos[1] += 1
            elif previous_pos == [0, 1]:
                previous_pos = [1, 0]
                current_pos[0] -= 1
        case "J":
            if previous_pos == [-1, 0]:
                previous_pos = [0, 1]
                current_pos[1] -= 1
            elif previous_pos == [0, -1]:
                previous_pos = [1, 0]
                current_pos[0] -= 1
        case "7":
            if previous_pos == [1, 0]:
                previous_pos = [0, 1]
                current_pos[1] -= 1
            elif previous_pos == [0, -1]:
                previous_pos = [-1, 0]
                current_pos[0] += 1
        case "F":
            if previous_pos == [1, 0]:
                previous_pos = [0, -1]
                current_pos[1] += 1
            elif previous_pos == [0, 1]:
                previous_pos = [-1, 0]
                current_pos[0] += 1
    loop_length += 1

print(loop_length // 2)

enclosed = 0
for i in range(len(input)):
    intersects = 0
    for j in range(len(input[i])):
        if str([i, j]) in steps:
            if (
                str([i + 1, j]) in steps
                and steps[str([i + 1, j])] - steps[str([i, j])] == 1
            ):
                intersects += 1
            elif (
                str([i + 1, j]) in steps
                and steps[str([i + 1, j])] - steps[str([i, j])] == -1
            ):
                intersects -= 1
        elif intersects == 1:
            enclosed += 1

print(enclosed)
