r"""Contient les fonction qui retourne la position d'une carte après un certains mélange de
type horseshoe"""

def out(n,i):
    r""" Returne the potistion of the i-th cards in a deck of n cards after a out horsehoe shuffle"""
    assert Mod(n,2)==0
    assert 0<=i and i<n
    if i<n/2:
        return 2*i
    else:
        return 2*n-2*i-1

def inn(n,i):
    r""" Returne the potistion of the i-th cards in a deck of n cards after a in horsehoe shuffle"""
    assert Mod(n,2)==0
    assert 0<=i and i<n
    if i<n/2:
        return 2*i+1
    else:
        return 2*n-2*i-2

def inv_in(n,i):
    r""" Returne the potistion of the i-th cards in a deck of n cards after a inverse in horsehoe shuffle"""
    assert Mod(n,2)==0
    assert 0<=i and i<n
    if Mod(i,2)==0:
        return n-floor(i/2)-1
    else:
        return floor(i/2) 

def inv_out(n,i):
    r""" Returne the potistion of the i-th cards in a deck of n cards after a inverse in horsehoe shuffle"""
    assert Mod(n,2)==0
    assert 0<=i and i<n
    if Mod(i,2)==1:
        return n-floor(i/2)-1
    else:
        return floor(i/2) 

def prec(n,i):
    r"""Je ne comprend à quoi sert cette méthode"""
    assert Mod(n,2)==0
    assert 0<=i and i<n
    return dict([(0,floor(i/2)), (1,n-floor(i/2)-1)])
