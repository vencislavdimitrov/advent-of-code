input = open(f"{__file__.replace('py', 'input')}")

total_sum = 0
power = 0
for i, game in enumerate(input):
    possible = True
    mins = {"red": 0, "green": 0, "blue": 0}
    for s in game.split(":")[1].split(";"):
        limits = {"red": 12, "green": 13, "blue": 14}
        for rev in s.split(", "):
            rev = rev.strip()
            limits[rev.split(" ")[1]] -= int(rev.split(" ")[0])
            mins[rev.split(" ")[1]] = max(
                mins[rev.split(" ")[1]], int(rev.split(" ")[0])
            )
        if any(limit < 0 for limit in limits.values()):
            possible = False
    if possible:
        total_sum += i + 1
    power += mins["red"] * mins["green"] * mins["blue"]

print(total_sum)
print(power)
