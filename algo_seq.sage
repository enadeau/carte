load('Elmsey.sage')
load('fonction_melange.sage')

def m_and_k(n):
    r"""Return m,k such that n=2^k*m with m odd"""
    k=0
    while n%2==0:
        k=k+1
        n=n/2
    return n,k

def shuffle(n,x,op):
    if op==0:
        return out(n,x)
    else:
        return inn(n,x)

def seq_to_middle(n,x):
    r"""Compute the shortest the sequence to bring x to a middle card in a deck of n cards
    Results about tree T and T_M are are require to validate this algorithm"""
    if x in position_frontiere(n):
        return None

    #Creating the tree T_m with only the first apparition of each integers
    #On pourrait optimiser la recherche dans les listes en utilisant une structure ordonné.
    m,k=m_and_k(n)
    position_mod=[i for i in range((m-1)/2)]
    last_line=[(m-1)/2]
    tree=DiGraph()
    tree.add_vertex((m-1)/2)
    while position_mod!=[]:
        added_vertices=[]
        for p in last_line:
            if p/2 in position_mod:
                position_mod.remove(p/2)
                added_vertices.extend([p/2,m-1-p/2])
                tree.add_vertices([p/2,m-1-p/2])
                tree.add_edges([(p,p/2,0),(p,m-1-p/2,1)])
            elif (p-1)/2 in position_mod:
                position_mod.remove((p-1)/2)
                added_vertices.extend([(p-1)/2,m-1-(p-1)/2])
                tree.add_vertices([(p-1)/2,m-1-(p-1)/2])
                tree.add_edges([(p,(p-1)/2,1),(p,m-1-(p-1)/2,0)])
        last_line=added_vertices

    #Reading the tree to construct the sequence
    seq=""
    sommet=x%m
    while sommet!=(m-1)/2:
        op=tree.incoming_edges(sommet)[0][2]
        if sommet==x%m:
            x=shuffle(n,x,op)
            if op==0:
                seq+='o'
            else:
                seq+='i'
        else:
            x=shuffle(n,x,(op+1)%2)
            if op==0:
                seq+='i'
            else:
                seq+='o'
        sommet=tree.incoming_edges(sommet)[0][0]
    return seq
