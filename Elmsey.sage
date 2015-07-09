load('Melange.sage')

def words(alphabet):
    yield ""
    for word in words(alphabet):
        for letter in alphabet:
            yield letter+word

def word_to_permutation(mot,inn,out):
    if mot=='':
        return Permutation([i for i in range(1,len(inn)+1)])
    s=Permutation([])
    for lettre in mot[::-1]:
        if lettre=='i':
            s=s*inn
        if lettre=='o':
            s=s*out
    return s

def words_by_length(alphabet, length):
    if length==0:
        yield ""
    else:
        for letter in alphabet:
            for word in words_by_length(alphabet, length-1):
                yield letter+word

def sequence_elmsley(nombre_carte,position):
    #pour les mélanges horse, donne le mot en "io" pour amener carte position vers le top
    melange=Melange(nombre_carte)
    melange.out_horse()
    out=melange.to_permutation()
    melange=Melange(nombre_carte)
    melange.in_horse()
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
    return solution

def construire_dictionnaire(nombre_carte,longueur):
    melange=Melange(nombre_carte)
    melange.out_horse()
    out=melange.to_permutation()
    melange=Melange(nombre_carte)
    melange.in_horse()
    inn=melange.to_permutation()

    dictionnaire={}
    g=words('io')
    mot=g.next()
    dictionnaire[mot]=Permutation([i for i in range(1,nombre_carte+1)])
    aide=0
    while len(mot)<=longueur:
        if len(mot)>aide:
            aide=len(mot)
            print(aide)
        mot=g.next()
        if mot[-1:]=='i':
            dictionnaire[mot]=inn*dictionnaire[mot[:-1]]
        else:
            dictionnaire[mot]=out*dictionnaire[mot[:-1]]
    print 'end'
    return dictionnaire

def nb_sol_conjecture(y,x):
    n=1
    if x==y-1 or x==0:
        return 1
    while Mod(y,2^n)==0:
#        if y==2^n:
#            return 1
        for i in range(1,2^n,2):
            if y==2^n*x/i or y==2^n*(x+1)/i:
                return 1
        n+=1
    return 2

def construire_table(max):
    nb_carte=max
    table=[[[]] * nb_carte for _ in range(nb_carte/2)]
    for n in range(2,nb_carte+1,2):
        for i in range(n):
            table[n/2-1][i]=sequence_elmsley(n,i)
    return table

def dessin_card(table):
    dessin_card=points((0,0),color='black')
    for n in range(2,len(table)*2+1,2):
        for i in range(n):
            if len(table[n/2-1][i])==1:
                dessin_card+=points((i,n),color='red')
	    elif len(table[n/2-1][i])==2:
                dessin_card+=points((i,n),color='green',alpha=0.4)
            else:
                dessin_card+=points((i,n),color='black')
    return dessin_card

def set_color(n):
    if n==1:
        return 'gold'
    elif n==2:
        return 'red'
    elif n==3:
        return 'orange'
    elif n==4:
        return 'yellow'
    elif n==5:
        return 'green'
    elif n==6:
        return 'blue'
    elif n==7:
        return 'purple'
    elif n==8:
        return 'pink'
    else:
        return 'black'

def dessin_length(table):
    dessin=points((0,0),color='black')
    for n in range(2,len(table)*2+1,2):
        for i in range(n):
            dessin+=points((i,n),color=set_color(len(table[n/2-1][i][0])))
    return dessin

def sequence_elmsley_puissance2(nbcarte, position):
    r"""Prend un deck de 2^n carte de retourne la sequence pour amerner la carte àa la position sur le dessus

    >>>> sequence_elmsey_puissance2(8,0)
    ''
    >>>> sequence_elmsey_puissance2(8,6)
    'ooi'
    t"""
    assert position<nbcarte
    position_bit=Integer(position).bits()[::-1]
    k=log(nbcarte,2)
    while len(position_bit)<k:
        position_bit.insert(0,0) 
    while 1 in position_bit:
        tr=position_bit[0]
        if position_bit[0]==0:
            for i in range(k-1):
                position_bit[i]=position_bit[i+1]
        else:
            for i in range(k-1):
                if position_bit[i+1]==0 or position_bit[i+1]==1:
                    position_bit[i]=1-position_bit[i+1]
                elif position_bit[i+1][0]=='+':
                    position_bit[i]=position_bit[i+1]
                    position_bit[i][0]='-'
                else:
                    position_bit[i]=position_bit[i+1]
                    position_bit[i][0]='+'
        position_bit[k-1]=['+',tr]
    i=k-1
    chaine=''
    while position_bit.count(1)+position_bit.count(0)!=k:
        if position_bit[i]==['+',1] or position_bit[i]==['-',0]:
            chaine='i'+chaine
        else:
            chaine='o'+chaine
        position_bit[i]=0
        i=i-1
    return chaine

def longueur_selon_2n(n):
    liste=[len(sequence_elmsley(n,i)[0]) for i in range(n)]
    return liste

def position_frontiere(n):
    factorisation=factor(n)
    k=list(factorisation)[0][1]
    liste=[n/2^k*t for t in range (2^k)]+[n/2^k*t-1 for t in range(1,2^k+1)]
    liste.sort()    
    return liste

def graphe_longueur(n):
    longueur=longueur_selon_2n(n)
    fr=position_frontiere(n)
    dessin=line([(i,longueur[i]) for i in range(n)])
    maxi=max(longueur)
    for i in range(1,len(fr)-1,2):
        pos=(fr[i]+fr[i+1])/2
        dessin=dessin+line([(pos,0),(pos,maxi)],color='red')
    return dessin

def sequence_elmsley_formater(n,i):
    factorisation=factor(n)
    k=list(factorisation)[0][1]
    if i in position_frontiere(n):
        return sequence_elmsley(n,i)
    else:
        retour=[]
        for w in sequence_elmsley(n,i):
            w=w[:(-(k+1))]+'|*|'+w[-(k+1):]
            retour.append(w)
        return retour 
