def out(n,i):
    assert Mod(n,2)==0
    assert 0<=i and i<n
    if i<n/2:
        return 2*i
    else:
        return 2*n-2*i-1

def inn(n,i):
    assert Mod(n,2)==0
    assert 0<=i and i<n
    if i<n/2:
        return 2*i+1
    else:
        return 2*n-2*i-2

def inv_in(n,i):
    assert Mod(n,2)==0
    assert 0<=i and i<n
    if Mod(i,2)==0:
        return n-floor(i/2)-1
    else:
        return floor(i/2) 

def inv_out(n,i):
    assert Mod(n,2)==0
    assert 0<=i and i<n
    if Mod(i,2)==1:
        return n-floor(i/2)-1
    else:
        return floor(i/2) 

def prec(n,i):
    assert Mod(n,2)==0
    assert 0<=i and i<n
    return [floor(i/2), n-floor(i/2)-1]
