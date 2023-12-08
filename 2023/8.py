from math import lcm

input = open(f"{__file__.replace('py', 'input')}").read().strip().split("\n\n")
instructions, nodes_input = input

nodes = {}
for n in nodes_input.split("\n"):
    s = n.split(" = ")
    nodes[s[0]] = s[1][1:-1].split(", ")


steps = 0
current_node = "AAA"
while True:
    if current_node == "ZZZ":
        print(steps)
        break

    current_node = (
        nodes[current_node][0]
        if instructions[steps % len(instructions)] == "L"
        else nodes[current_node][1]
    )
    steps += 1

current_nodes = list(filter(lambda x: x[-1] == "A", nodes.keys()))
loops = []
for current_node in current_nodes:
    steps = 0
    while True:
        if current_node[-1] == "Z":
            loops.append(steps)
            break

        current_node = (
            nodes[current_node][0]
            if instructions[steps % len(instructions)] == "L"
            else nodes[current_node][1]
        )
        steps += 1

print(lcm(*loops))
