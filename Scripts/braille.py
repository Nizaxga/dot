be = [
    [1, 0, 0],  # a
    [1, 1, 0],  # b
    [3, 0, 0],  # c
    [3, 2, 0],  # d
    [1, 2, 0],  # e
    [3, 1, 0],  # f
    [3, 3, 0],  # g
    [1, 3, 0],  # h
    [2, 1, 0],  # i
    [2, 3, 0],  # j
    [1, 0, 1],  # k
    [1, 1, 1],  # l
    [3, 0, 1],  # m
    [3, 2, 1],  # n
    [1, 2, 1],  # o
    [3, 1, 1],  # p
    [3, 3, 1],  # q
    [1, 3, 1],  # r
    [2, 1, 1],  # s
    [2, 3, 1],  # t
    [1, 0, 3],  # u
    [1, 1, 3],  # v
    [2, 3, 2],  # w
    [3, 0, 3],  # x
    [3, 2, 3],  # y
    [1, 2, 3],  # z
]

ne = [
    [2, 3, 0],  # 0
    [1, 0, 0],  # 1
    [1, 1, 0],  # 2
    [3, 0, 0],  # 3
    [3, 2, 0],  # 4
    [1, 2, 0],  # 5
    [3, 1, 0],  # 6
    [3, 3, 0],  # 7
    [1, 3, 0],  # 8
    [2, 3, 0],  # 9
]


def star(a):
    if a == 3:
        return "**| "
    if a == 2:
        return "*_| "
    if a == 1:
        return "_*| "
    return "__| "


def f(s):
    l = ["", "", ""]
    for i in s:
        if i == " ":
            l[0] += star(0)
            l[1] += star(0)
            l[2] += star(0)
        elif i.isnumeric():
            l[0] += star(ne[ord(i) - ord("0")][0])
            l[1] += star(ne[ord(i) - ord("0")][1])
            l[2] += star(ne[ord(i) - ord("0")][2])
            l[0] += star(2)
            l[1] += star(2)
            l[2] += star(3)
        else:
            l[0] += star(be[ord(i) - ord("a")][0])
            l[1] += star(be[ord(i) - ord("a")][1])
            l[2] += star(be[ord(i) - ord("a")][2])
    return l


s = input()

for i in f(s[::-1]):
    print(i)
