input = open(f"{__file__.replace('py', 'input')}").read().strip().split("\n")


cache = {}


def arrangements(string, template):
    if string + str(template) in cache:
        return cache[string + str(template)]
    if len(string) == 0:
        cache[string + str(template)] = 1 if len(template) == 0 else 0
        return cache[string + str(template)]
    if string.startswith("."):
        cache[string + str(template)] = arrangements(string.strip("."), template)
        return cache[string + str(template)]
    if string.startswith("?"):
        cache[string + str(template)] = arrangements(
            string.replace("?", ".", 1), template
        ) + arrangements(string.replace("?", "#", 1), template)
        return cache[string + str(template)]
    if string.startswith("#"):
        if (
            len(template) == 0
            or len(string) < template[0]
            or any(c == "." for c in string[0 : template[0]])
        ):
            return 0
        if len(template) > 1:
            if len(string) < template[0] + 1 or string[template[0]] == "#":
                return 0
            cache[string + str(template)] = arrangements(
                string[template[0] + 1 :], template[1:]
            )
            return cache[string + str(template)]
        else:
            cache[string + str(template)] = arrangements(
                string[template[0] :], template[1:]
            )
            return cache[string + str(template)]


total_sum = 0
for line in input:
    string, template = line.split(" ")
    template = [int(x) for x in template.split(",")]
    total_sum += arrangements(string, template)
print(total_sum)

total_sum = 0
for line in input:
    string, template = line.split(" ")
    template = [int(x) for x in template.split(",")]

    string = "?".join([string] * 5)
    template = template * 5
    total_sum += arrangements(string, template)
print(total_sum)
