def listemoins(liste,n):
    retour=[]
    for i in liste:
        if i-n>0:
            retour.append(i-n)
        else:
            retour.append(0)
    return retour

def nombre_position(taille,p):
    liste=mot_sspaquet(taille)
    indice=liste.index(1)-p
    return liste[indice]
