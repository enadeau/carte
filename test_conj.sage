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
        
