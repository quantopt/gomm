#!/usr/bin/python

class LensBank(object):

    def __init__(self, filename=None, bank=None):
        self.bank = bank or {}
        self.perms = []
        self.perm_count = None
        if filename:
            self.load_from_file(filename)            
        self.backup = self.bank.copy()
        self.permutations()
        
    def add(self, f, q=1):
        self.bank[f] = q

    def remove(self, f):
        if self.bank[f] > 1:
            self.bank[f] = self.bank[f] - 1
        else:
            self.bank.pop(f)

    def permutations(self):
        perms = []
        for lens1, count in self.backup.iteritems():
            self.remove(lens1)
            for lens2, count in self.bank.iteritems():
                perms.append((lens1, lens2))
            self.bank = self.backup.copy()
        self.perms = perms
        self.perm_count = len(perms)

    def load_from_file(self, filename):
        self.bank = dict((float(x) for x in line.split()) for line in file(filename)) 
        
    def __repr__(self):
        return ''.join("f=%s    Count: %s\n" % (lens, count) for lens, count in self.bank.iteritems()) 
    
if __name__ == "__main__":
    #b = LensBank(bank={500:1, 600:3, 100:4, 200:1})
    
    b = LensBank(filename='blue.txt')
    print b.perms
    print b.perm_count
