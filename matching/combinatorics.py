#!/usr/bin/python


def all_perms(str):
    if len(str) <=1:
        yield str
    else:
        for perm in all_perms(str[1:]):
            for i in range(len(perm)+1):
                yield perm[:i] + str[0:1] + perm[i:]

def permutations(L):
    if len(L) == 1:
        yield [L[0]]
    elif len(L) >= 2:
        (a, b) = (L[0:1], L[1:])
        for p in permutations(b):
            for i in range(len(p)+1):
                yield b[:i] + a + b[i:]

def generalized(f, items, n):
    if n==0: yield []
    else:
        for i in xrange(len(items)):
            for cc in generalized(f(items, i), n-1):
                yield [items[i]]+cc

def skipIthItem(items, i):
    return items[:i]+items[i+1:]

def afterIthItem(items, i):
    return items[i+1:]

def keepAllItems(items, i):
    return items

def xcombinations(items, n):
    return generalized(skipIthItem, items, n)

def xuniqueCombinations(items, n):
    return generalized(afterIthItem, items, n)

def xselections(items, n):
    return generalized(keepAllItems, items, n)
