input = open(f"{__file__.replace('py', 'input')}").read().strip().split("\n\n")
input[0] = [x.split("{") for x in input[0].split("\n")]
workflows = {}
for w in input[0]:
    workflows[w[0]] = w[1][:-1].split(",")

parts = []
for part in input[1].split("\n"):
    new_part = {}
    for p in part[1:-1].split(","):
        new_part[p.split("=")[0]] = int(p.split("=")[1])
    parts.append(new_part)

total_sum = 0
for part in parts:

    def accepted(part):
        name = "in"
        while True:
            if name == "A":
                return sum(part.values())
            if name == "R":
                return 0

            for workflow in workflows[name]:
                if workflow == "A":
                    return sum(part.values())
                if workflow == "R":
                    return 0

                if not ":" in workflow:
                    name = workflow
                    break

                w, new_w = workflow.split(":")
                if w[1] == ">":
                    if part[w[0]] > int(w[2:]):
                        name = new_w
                        break
                elif w[1] == "<":
                    if part[w[0]] < int(w[2:]):
                        name = new_w
                        break

    total_sum += accepted(part)
print(total_sum)


def partition(condition, value, arr):
    accepted, rejected = [], []
    if condition == ">":
        for el in arr:
            (accepted if el > value else rejected).append(el)
    else:
        for el in arr:
            (accepted if el < value else rejected).append(el)
    return [accepted, rejected]


def count_accepted(name, x, m, a, s):
    if name == "A":
        return len(x) * len(m) * len(a) * len(s)
    if name == "R":
        return 0

    res = 0

    for workflow in workflows[name]:
        if not ":" in workflow:
            res += count_accepted(workflow, x, m, a, s)
            continue

        w, new_w = workflow.split(":")
        if w[0] == "x":
            x_accepted, x_rejected = partition(w[1], int(w[2:]), x)
            if len(x_accepted):
                res += count_accepted(new_w, x_accepted, m, a, s)
            x = x_rejected
        elif w[0] == "m":
            m_accepted, m_rejected = partition(w[1], int(w[2:]), m)
            if len(m_accepted):
                res += count_accepted(new_w, x, m_accepted, a, s)
            m = m_rejected
        elif w[0] == "a":
            a_accepted, a_rejected = partition(w[1], int(w[2:]), a)
            if len(a_accepted):
                res += count_accepted(new_w, x, m, a_accepted, s)
            a = a_rejected
        elif w[0] == "s":
            s_accepted, s_rejected = partition(w[1], int(w[2:]), s)
            if len(s_accepted):
                res += count_accepted(new_w, x, m, a, s_accepted)
            s = s_rejected
    return res


print(
    count_accepted(
        "in",
        list(range(1, 4001)),
        list(range(1, 4001)),
        list(range(1, 4001)),
        list(range(1, 4001)),
    )
)
