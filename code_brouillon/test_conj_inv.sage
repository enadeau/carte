load('Elmsey.sage')

r"""Contains the code to test the conjecture about inverse inverse horseshoe shuffle"""

def sequence_elmsley_inv(nombre_carte,position):
    r"""Compute the inverse elmsley's sequence for the inverses horseshoe shuffle

    Return the shortest words for wich the card at the position in a deck of
    nombre_carte is on top after performing the sequence of horseshoe shuffle 
    describe by the words.
    
    You can have more tham one word that satisfied the condition"""
    melange=Melange(nombre_carte)
    melange.inverse_out_horse()
    out=melange.to_permutation()
    melange=Melange(nombre_carte)
    melange.inverse_in_horse()
    inn=melange.to_permutation()
    g=words('io')
    mot=g.next()
    s=word_to_permutation(mot,inn,out)
    while s[0]!=position+1:
        mot=g.next()
        s=word_to_permutation(mot,inn,out)
    longueur=len(mot)
    solution=[]
    for mot in words_by_length('io',longueur):
        s=word_to_permutation(mot,inn,out)
        if s[0]==position+1:
            solution.append(mot)
    return set(solution)

def plus_grande_puissance(n):
    r"""Return the biggest integer i such that 2^i < n"""
    i=0
    while 2^i<n :
        i+=1
    return i-1

def binaire_to_sequence(position_bin):
    r"""Take a binary position of a card and return a in and out sequence according to the conjecture"""
    if Integer(position_bin)==0:
        return ''
    seq=""
    nbr=str(position_bin)[::-1]
    for c in nbr:
        if c=='0':
            seq+='o'
        if c=='1':
            seq+='i'
    return seq

def sequence_elmsley_inv_selon_conj(nombre_carte,position):
    r"""Return the sequence of elmsey according to our conjecture"""
    retour=set([binaire_to_sequence(Integer(position).binary())])
    if position>=2^plus_grande_puissance(nombre_carte) and 2*nombre_carte-position<=2^(plus_grande_puissance(nombre_carte)+1):
        retour.add(binaire_to_sequence(Integer(2*nombre_carte-position-1).binary()))
    return retour

def run_test(max):
    for n in range(2,max+1,2):
        for j in range(n):
            if  not sequence_elmsley_inv(n,j)==sequence_elmsley_inv_selon_conj(n,j):
                print n
                print j
                return False
        print n
    return True

