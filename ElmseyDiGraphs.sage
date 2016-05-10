load("Melange.sage")


def frontiere_elements(l):
    r"""
    Compute the "frontiere" elements from a list of cards.
    """
    def frontiere_elements_iter(l):
        if len(l) % 2 != 0:
            yield l[0]
            yield l[-1]
        else:
            l1, l2 = l[:len(l)/2], l[len(l)/2:]
            yield l1[-1]
            yield l2[0]
            for half in [l1, l2]:
                for x in frontiere_elements(half):
                    yield x

    return sorted(set(frontiere_elements_iter(l)))


def horseshoe_shuffles_as_permutations(n):
    r"""
    Return a dictionary with keys 'in' and 'out' and values
    the in and out horseshoe shuffles seen as permutations.
    """
    shuffles = {}

    deck = Melange(n)
    deck.in_horse()
    #shuffles['in'] = deck.to_permutation().inverse()
    shuffles['in'] = deck.to_permutation()

    deck = Melange(n)
    deck.out_horse()
    #shuffles['out'] = deck.to_permutation().inverse()
    shuffles['out'] = deck.to_permutation()


    return shuffles

def permutation_action_digraph(perm_dict):
    r"""
    Given a dictionary whose values are permutations,
    draw a directed graph representing the action of
    the permutations.

    OUTPUT:

    A directed graph with an arrow from `i` to `j` labelled `k`,
    if ``perm_dict[k](i) = j``.
    """
    H = DiGraph()
    n = len(perm_dict.keys()[0])
    for (label, perm) in perm_dict.iteritems():
        for (u, v) in enumerate(perm, start=1):
            H.add_edge(u, v, label=label)
    return H


def elmsey_digraph(n):
    r"""
    Directed graph representing the minimal distance from any vertex to the
    initial vertex (1) under the action of the in and out horseshoe shuffles.
    """
    shuffles = horseshoe_shuffles_as_permutations(n)

    H = permutation_action_digraph(shuffles)

    G = DiGraph()
    starting_vertex = 1
    G.add_vertex(starting_vertex)
    N = H.num_verts()
    while G.num_verts() != N:
        in_degrees = G.in_degree(labels=True)
        last_level = [u for u in in_degrees if in_degrees[u] == 0]
        new_edges = [(u, x, H.edge_label(u, x))
                        for x in last_level
                        for u in H.neighbors_in(x) if u not in G]
        G.add_edges(new_edges)
    return G


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
        'color_by_label' : { "in":"blue", "out":"red"},
        }
    if x._latex_opts is not None:
        latex_options.update(x._latex_opts._options)
    x = copy(x)
    x.set_latex_options(**latex_options)
    view(x, **options)

