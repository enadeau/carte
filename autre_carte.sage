load('fonction_melange.sage')

def m(n):
    r"""Compute de m if we decompose n=2^km where m is odd.
    It's the size of the smallest sub deck"""
    while n%2==0:
        n=n/2
    return n

def classeA(n,p):
    r"""Return all the cards in the type A class of a card in position p in a deck of n cards"""
    p=p%m(n)
    return set([i for i in range(p,n,m(n))])

def classeB(n,p):
    r"""Return all the cards in the type B class of a card in position p in a deck of n cards"""
    p=p%(2*m(n))
    return set([i for i in range(p,n,2*m(n))]+[i for i in range(2*m(n)-p-1,n,2*m(n))])

def U(n,nb_carte):
    r"""Compute de U_n set as describe in the section autre carte in conjecture"""
    if n==1:
        return classeA(nb_carte,(m(nb_carte)-1)/2)
    
    Umoins=U(n-1,nb_carte)
    Uact=set()
    for carte in Umoins:
        Uact.add(inv_out(nb_carte,carte))
        Uact.add(inv_in(nb_carte,carte))
    return Uact

def is_first_apparition_unique(nb_carte):
    r"""Verify if the first apparition of a card in U_n as only one move that bring that cards to the U_n-1"""
    i=2
    list_U={1:U(1,nb_carte)}
    while len(list_U[i-1])<nb_carte:
        list_U[i]=U(i,nb_carte)
        i+=1

    carte=set(range(nb_carte)).difference(list_U[1])
    for i in list_U.keys():
        if i==1:
            continue
        for c in list_U[i]:
            if c in carte:
                carte.remove(c)
                if out(nb_carte,c) in list_U[i-1] and inn(nb_carte,c) in list_U[i-1]:
                    return False
    return True
