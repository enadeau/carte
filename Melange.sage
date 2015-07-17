load("Carte.sage")

class Melange:

    def __init__(self, length):
        self.melange=[Carte(i,false) for i in range(length)]
        self.length=length

    def __repr__(self):
        chaine="|"
        for carte in self.melange:
            chaine=chaine+carte.__repr__()+"|"
        return chaine

    def __eq__(self,other):
        if(self.length!=other.length):
            return false
        egal=true
        for i in range(self.length):
            #egal=egal and self.melange[i].__eq__(other.melange[i])
            egal=egal and self.melange[i]==other.melange[i]
        return egal

    def to_permutation(self):
        return Permutation([carte.numero+1 for carte in self.melange]).inverse()

    @staticmethod
    def to_melange(permutation):
        paquet=Melange(len(permutation))
        for i in range(len(permutation)):
            paquet.melange[i]=Carte(permutation[i]-1,False)
        return paquet

    def flipper(self):
        for carte in self.melange:
            carte.flipper()

    def reverse_order(self):
        self.melange.reverse()

    def out_flip(self):
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
        self.melange.append(Carte(0,True))
        self.melange.insert(0,Carte(0,True))
        self.length+=2
        self.out_faro()
        self.melange.pop()
        self.melange.pop(0)
        self.length-=2
        
    def out_horse(self):
        n=self.length/2
        top=[self.melange[i] for i in range(n)]
        bottom=[self.melange[i] for i in range(n,2*n)]
        self.melange=[]
        for i in range(n):
            self.melange.append(top[i])
            self.melange.append(bottom[n-1-i])
            
    def in_horse(self):
        n=self.length/2
        top=[self.melange[i] for i in range(n)]
        bottom=[self.melange[i] for i in range(n,2*n)]
        self.melange=[]
        for i in range(n):
            self.melange.append(bottom[n-1-i])
            self.melange.append(top[i])

    def inverse_out_horse(self):
        top=[]
        bottom=[]
        for i in range(0,self.length,2):
            top.append(self.melange[i])
            bottom.append(self.melange[self.length-1-i])
        self.melange=[]
        self.melange.extend(top)
        self.melange.extend(bottom)

    def inverse_in_horse(self):
        top=[]
        bottom=[]
        for i in range(0,self.length,2):
            top.append(self.melange[i+1])
            bottom.append(self.melange[self.length-2-i])
        self.melange=[]
        self.melange.extend(top)
        self.melange.extend(bottom)
