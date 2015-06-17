class Carte:

    def __init__(self,numero,flip):
        self.numero=numero
        self.flip=flip

    def __repr__(self):
        if self.flip:
            return str(self.numero)+"F"
        else:
            return str(self.numero)+" "
    def __eq__(self, other):
        return self.numero == other.numero and self.flip == other.flip

    def flipper(self):
        if self.flip:
            self.flip=false
        else:
            self.flip=true