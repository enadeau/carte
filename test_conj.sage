def test_conj_for(borne):
    for n in range(0,borne+1,2):
        for i in range(n):
            if len(sequence_elmsley(n,i))!=nb_sol_conjecture(n,i):
                print str(n)+':'+str(i)+':'+str(len(sequence_elmsley(n,i)))
    print 'end'

def aff_unique_sol(minn,borne):
    for n in range(minn,borne+1,2):
        for i in range(0,n,1):
            seq=sequence_elmsley(n,i)
            if len(seq)==1:
                print str(n)+':'+str(i)+':'+seq[0]

def test_puissance2():
    r""" Test si la méthode sequence_elmseley et sequence_elmsley sont cohérente entre elle"""
    for n in range(1,8):
        for i in range(2^n):
            sqr=sequence_elmsley(2^n,i)
            assert len(sqr)==1
            if sqr[0]!=sequence_elmsley_puissance2(2^n,i):
                print (2^n,i)
                return false
    return true
