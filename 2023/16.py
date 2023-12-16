import sys

sys.setrecursionlimit(10000)

input = open(f"{__file__.replace('py', 'input')}").read().strip().split("\n")

dirs = {
    ".": {
        repr([0, 1]): [[0, 1]],
        repr([0, -1]): [[0, -1]],
        repr([1, 0]): [[1, 0]],
        repr([-1, 0]): [[-1, 0]],
    },
    "/": {
        repr([0, 1]): [[-1, 0]],
        repr([0, -1]): [[1, 0]],
        repr([1, 0]): [[0, -1]],
        repr([-1, 0]): [[0, 1]],
    },
    "\\": {
        repr([0, 1]): [[1, 0]],
        repr([0, -1]): [[-1, 0]],
        repr([1, 0]): [[0, 1]],
        repr([-1, 0]): [[0, -1]],
    },
    "-": {
        repr([0, 1]): [[0, 1]],
        repr([0, -1]): [[0, -1]],
        repr([1, 0]): [[0, 1], [0, -1]],
        repr([-1, 0]): [[0, 1], [0, -1]],
    },
    "|": {
        repr([0, 1]): [[1, 0], [-1, 0]],
        repr([0, -1]): [[1, 0], [-1, 0]],
        repr([1, 0]): [[1, 0]],
        repr([-1, 0]): [[-1, 0]],
    },
}


def count_energized(pos, dir):
    energized = {}

    def run(pos, dir):
        if (
            repr((pos, dir)) in energized
            or not (0 <= pos[0] < len(input))
            or not (0 <= pos[1] < len(input[0]))
        ):
            return

        energized[repr((pos, dir))] = pos
        for new_dir in dirs[input[pos[0]][pos[1]]][repr(dir)]:
            run([pos[0] + new_dir[0], pos[1] + new_dir[1]], new_dir)

    run(pos, dir)
    return len(set(repr(x) for x in energized.values()))


print(count_energized([0, 0], [0, 1]))

energized_array = []
for i in range(len(input)):
    energized_array.append(count_energized([0, i], [1, 0]))
    energized_array.append(count_energized([len(input) - 1, i], [-1, 0]))
for i in range(len(input[0])):
    energized_array.append(count_energized([i, 0], [0, 1]))
    energized_array.append(count_energized([i, len(input[0]) - 1], [0, -1]))

print(max(energized_array))
