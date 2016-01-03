def un(p,m):
    r"""Compute the inverse out modulo m as if x was even"""
    return p/2

def deux(p,m):
    r"""Compute the inverse out modulo m as if x was odd"""
    return m-(p+1)/2

def trois(p,m):
    r"""Compute the inverse in modulo m as if x was odd"""
    return (p-1)/2

def quatre(p,m):
    r"""Compute the inverse out modulo m as if x was even"""
    return m-(p+2)/2

def graph_modulo(n):
	r"""Directed tree representing the four possible position obtain by applying the four inverse operation possible"""
	G=DiGraph()
	starting_vertex=(1,1,1)
	G.add_vertex(starting_vertex)
	for t in range(1,n):
	     for vertex in G:
	         if vertex[2]==t:
	             i=vertex[0]
		     j=vertex[1]
		     k=vertex[2]
		     print str(i)+"   "+str(j)+"   "+str(k)
	             son1=(i,j,k+1)
		     son2=(2^(k+1)-i,2^k-j,k+1)
		     son3=(i,2^k+j,k+1)
		     son4=(2^(k+1)-i,2^(k+1)-j,k+1)
		     G.add_edge(vertex,son1,'1')
		     G.add_edge(vertex,son2,'2')
		     G.add_edge(vertex,son3,'3')
		     G.add_edge(vertex,son4,'4')
	return G

def vertex_to_position(vertex,m):
    i=vertex[0]
    j=vertex[1]
    k=vertex[2]
    return (i*m-j)/(2^(k+1))
