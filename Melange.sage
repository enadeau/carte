load("Carte.sage")

class Melange:
    r"""Class giving to to perform different shuffle on a deck of cards
    for detail on the different shuffle see Butler, Steve, Persi Diaconis, and Ron Graham. "The mathematics of the flip and horseshoe shuffles." arXiv preprint arXiv:1412.8533 (2014)."""

    def __init__(self, length):
        r"""Crée un mélange avec les cartes dans l'ordre """
        self.melange=[Carte(i,false) for i in range(length)]
        self.length=length

    def __repr__(self):
        r"""Make a string representation of the deck, seperating cards by |"""
        chaine="|"
        for carte in self.melange:
            chaine=chaine+carte.__repr__()+"|"
        return chaine

    def __eq__(self,other):
        r"""Shuffle are egal, if and only if each number is at the same place et de flip state of each card is the same"""
        if(self.length!=other.length):
            return false
        egal=true
        for i in range(self.length):
            #egal=egal and self.melange[i].__eq__(other.melange[i])
            egal=egal and self.melange[i]==other.melange[i]
        return egal

    def to_permutation(self):
        r"""Return de permutation associate with the deck given in comparison with the intial non-suffled deck. It don't take in consideration whatever the aards are flip or not"""
        return Permutation([carte.numero+1 for carte in self.melange])

    @staticmethod
    def to_melange(permutation):
        r"""Take a permutation and return the shuffle associate with"""
        paquet=Melange(len(permutation))
        for i in range(len(permutation)):
            paquet.melange[i]=Carte(permutation[i]-1,False)
        return paquet

    def flipper(self):
        r"""Flip each card of the deck"""
        for carte in self.melange:
            carte.flipper()

    def reverse_order(self):
        r"""Reverse the order of the deck. The first card become the last et the last card become the first"""
        self.melange.reverse()

    def out_flip(self):
        r"""Perform an out version of the flip shuffle on the deck"""
        n=self.length/2
        top=[self.melange[i] for i in range(n)]
        bottom=[self.melange[i] for i in range(n,2*n)]
        for carte in bottom:
            carte.flipper()
        self.melange=[]
        for i in range(n):
            self.melange.append(top[i])
            self.melange.append(bottom[n-1-i])

    def inverse_out_flip(self):
        r"""Perfomr the inverse of the out version of the flip shuffle on the deck"""
        pile1=[]
        pile2=[]
        for i in range(0,self.length,2):
            self.melange[self.length-(i+1)].flipper()
            pile1.append(self.melange[i])
            pile2.append(self.melange[self.length-(i+1)])
        self.melange=[]
        self.melange.extend(pile1)
        self.melange.extend(pile2)

    def in_flip(self):
        r"""Perform the in version of the flip shuffle on the deck"""
        n=self.length/2
        top=[self.melange[i] for i in range(n)]
        bottom=[self.melange[i] for i in range(n,2*n)]
        for carte in bottom:
            carte.flipper()
        self.melange=[]
        for i in range(n):
            self.melange.append(bottom[n-1-i])
            self.melange.append(top[i])

    def inverse_in_flip(self):
        r"""Perform the inverse of the in version of the flip shuffle on the deck"""
        pile1=[]
        pile2=[]
        for i in range(0,self.length,2):
            self.melange[self.length-(i+2)].flipper()
            pile1.append(self.melange[self.length-(i+2)])
            pile2.append(self.melange[i+1])
        self.melange=[]
        self.melange.extend(pile2)
        self.melange.extend(pile1)

    def out_faro(self):
        r"""Perform the out version of the faro shuffle on the deck"""
        pile1=[]
        pile2=[]
        n=self.length/2
        pile1=[self.melange[i] for i in range(0,n)]
        pile2=[self.melange[i]for i in range(n,2*n)]
        self.melange=[]
        for i in range(0,self.length/2):
            self.melange.append(pile1[i])
            self.melange.append(pile2[i])

    def in_faro(self):
        r"""Perform the in version of the faro shuffle on the deck"""
        self.melange.append(Carte(0,True))
        self.melange.insert(0,Carte(0,True))
        self.length+=2
        self.out_faro()
        self.melange.pop()
        self.melange.pop(0)
        self.length-=2
        
    def out_horse(self):
        r"""Perform the out version of the horseshoe shuffle on the deck"""
        n=self.length/2
        top=[self.melange[i] for i in range(n)]
        bottom=[self.melange[i] for i in range(n,2*n)]
        self.melange=[]
        for i in range(n):
            self.melange.append(top[i])
            self.melange.append(bottom[n-1-i])
            
    def in_horse(self):
        r"""Perform the in version of the horseshoe shuffle on the deck"""
        n=self.length/2
        top=[self.melange[i] for i in range(n)]
        bottom=[self.melange[i] for i in range(n,2*n)]
        self.melange=[]
        for i in range(n):
            self.melange.append(bottom[n-1-i])
            self.melange.append(top[i])

    def inverse_out_horse(self):
        r"""Perform the inverse of the out version of the horseshoe shuffle on the deck"""
        top=[]
        bottom=[]
        for i in range(0,self.length,2):
            top.append(self.melange[i])
            bottom.append(self.melange[self.length-1-i])
        self.melange=[]
        self.melange.extend(top)
        self.melange.extend(bottom)

    def inverse_in_horse(self):
        r"""Perform the inverse of the in version of the horseshoe shuffle on the deck"""
        top=[]
        bottom=[]
        for i in range(0,self.length,2):
            top.append(self.melange[i+1])
            bottom.append(self.melange[self.length-2-i])
        self.melange=[]
        self.melange.extend(top)
        self.melange.extend(bottom)
