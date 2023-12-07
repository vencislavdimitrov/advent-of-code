from collections import Counter

input = open(f"{__file__.replace('py', 'input')}").read().strip().split("\n")

input = [[hand, int(bid)] for hand, bid in [line.split(" ") for line in input]]


def trans(hand, part2=False):
    hand = list(hand)
    for i in range(len(hand)):
        hand[i] = str(hand[i]).replace("T", "10")
        hand[i] = str(hand[i]).replace("J", "0" if part2 else "11")
        hand[i] = str(hand[i]).replace("Q", "12")
        hand[i] = str(hand[i]).replace("K", "13")
        hand[i] = str(hand[i]).replace("A", "14")
    return hand


def comp(hand):
    order = [
        [1, 1, 1, 1, 1],
        [1, 1, 1, 2],
        [1, 2, 2],
        [1, 1, 3],
        [2, 3],
        [1, 4],
        [5],
    ]
    hand = trans(hand[0])
    tally = Counter(hand)
    return [order.index(sorted(tally.values()))] + [int(x) for x in hand]


hands = sorted(input, key=comp)
print(sum([int(hand[1]) * (ind + 1) for ind, hand in enumerate(hands)]))


def comp2(hand):
    order = [
        [1, 1, 1, 1, 1],
        [1, 1, 1, 2],
        [1, 2, 2],
        [1, 1, 3],
        [2, 3],
        [1, 4],
        [5],
    ]
    max_hand = hand[0]
    for c in ["J", "2", "3", "4", "5", "6", "7", "8", "9", "T", "Q", "K", "A"]:
        new_hand = hand[0].replace("J", c)
        max_hand = new_hand if comp([new_hand]) > comp([max_hand]) else max_hand

    tally = Counter(trans(max_hand))
    return [order.index(sorted(tally.values()))] + [
        int(x) for x in trans(hand[0], True)
    ]


hands = sorted(input, key=comp2)
print(sum([int(hand[1]) * (ind + 1) for ind, hand in enumerate(hands)]))
