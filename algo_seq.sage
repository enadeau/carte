load('Elmsey.sage')
load('fonction_melange.sage')

def m_and_k(n):
    r"""Return m,k such that n=2^k*m with m odd"""
    k=0
    while n%2==0:
        k=k+1        
        n=n/2
    return n,k

def seq_to_middle(n,x):
    r"""Compute the shortest the sequence to bring x to a middle card in a deck of n cards
    Results about tree T and T_M are are require to validate this algorithm"""
    if x in position_frontiere(n):
        return None 
    
    m,k=m_and_k(n)
    position_mod=[i for i in range((m-1)/2)]
    last_line=[(m-1)/2]
    tree=DiGraph()
    tree.add_vertex((m-1)/2) 
    while position_mod!=[]:
        added_vertices=[]
        for p in last_line:
            if p%2==0 and p/2 in position_mod:
                position_mod.remove(p/2)
                added_vertices.extend([p/2,m-1-p/2])
                tree.add_vertices([p/2,m-1-p/2])
                tree.add_edges([(p,p/2,1),(p,m-1-p/2,4)])
            elif (p-1)/2 in position_mod:
                position_mod.remove((p-1)/2)
                added_vertices.extend([(p-1)/2,m-1-(p-1)/2])
                tree.add_vertices([(p-1)/2,m-1-(p-1)/2])
                tree.add_edges([(p,(p-1)/2,2),(p,m-1-(p-1)/2,3)])
        last_line=added_vertices

    seq=""
    while x%m!=(m-1)/2:
        op=tree.incoming_edges(x%m)[0][2]
        if op==1 or op==3:
            seq=seq+'o'
            x=out(n,x)
        else:
            seq=seq+'i'
            x=inn(n,x)
        
    return seq
