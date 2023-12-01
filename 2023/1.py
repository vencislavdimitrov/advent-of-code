import re

input = open(f"{__file__.replace('py', 'input')}")

sum = 0
for i in input:
    z = re.findall(r"\d", i)
    sum += int(z[0] + z[-1])

print(sum)

input.seek(0)
digits_map = {
    "one": 1,
    "two": 2,
    "three": 3,
    "four": 4,
    "five": 5,
    "six": 6,
    "seven": 7,
    "eight": 8,
    "nine": 9,
}
sum = 0
for i in input:
    for k in digits_map:
        i = i.replace(k, k + str(digits_map[k]) + k)
        digits = re.findall(r"\d", i)
    sum += int(digits[0] + digits[-1])

print(sum)
