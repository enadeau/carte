class Carte:
    """Classe définissant une carte qui est cractérisé par un numéro et un état de flip (à savoir sir la carte est dans sa position normale ou si ellea ses chiffre sur le dessus."""
    
    def __init__(self,numero,flip):
        """Constructeur d'une carte. Prend en paramètre le numéro de la carte et true sir la carte est flipper, false sinon"""
        self.numero=numero
        self.flip=flip

    def __repr__(self):
        """Retourne une repésentation en string du numéro et du flip de la carte. Le numéro est suivi d'un F si la carte est flipé."""
        if self.flip:
            return str(self.numero)+"F"
        else:
            return str(self.numero)+" "

    def __eq__(self, other):
        r"""Vérifie si deux cartes sont bien égale

        >>> Carte(10,true)==Carte(10,true)
        True
        >>> Carte(6,true)==Carte(5,false)
        False
        """
        return self.numero == other.numero and self.flip == other.flip

    def flipper(self):
        """Modifie le flip de la carte
        
        >>> Carte(10,true).flipper()
        False
        >>> Carte(10,false).flipper()
        True
        """
        if self.flip:
            self.flip=false
        else:
            self.flip=true
        return self.flip
