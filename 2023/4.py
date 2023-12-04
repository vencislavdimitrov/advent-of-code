input = open(f"{__file__.replace('py', 'input')}").readlines()

total_sum = 0
cards = [1] * len(input)
for i, line in enumerate(input):
    line = line.split(": ")[1]
    my, winning = line.split(" | ")
    my = my.split()
    winning = winning.split()
    common = len(set(my) & set(winning))

    if common > 0:
        total_sum += pow(2, common - 1)

        for j in range(common):
            cards[i + j + 1] += cards[i]

print(total_sum)
print(sum(cards))
