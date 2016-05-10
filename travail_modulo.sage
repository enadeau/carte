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

def my_view(x, **options):
    r"""
    In order to use this function to output nice PDF images of the
    digraphs, one needs to have graphviz installed and the dot2tex
    sage package:

    (1) To install graphviz, go to the website: www.graphviz.org

    (2) To install the dot2tex Sage package, execute from the command line::

        sage -i dot2tex && sage -br

    """
    options["tightpage"] = True
    options["pdflatex"] = True
    latex_options = {
        'format': "dot2tex",
        'prog' : 'dot',
        'edge_labels': True,
        'color_by_label' : { "1":"blue", "2":"red","3":"green","4":"yellow"},
        }
    if x._latex_opts is not None:
        latex_options.update(x._latex_opts._options)
    x = copy(x)
    x.set_latex_options(**latex_options)
    view(x, **options)

