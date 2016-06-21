def A(k):
	return set(range(1,2^k,2))

def power_A(k,n):
	return list(cartesian_product([A(k) for _ in range(n)]))

def s(i,j,k,m):
	return (i*m-j)/(2^k)

def test(m,k):
	for i,j,x,y in power_A(k,4):
		if i>x and s(i,j,k,m)<s(x,y,k,m):
		    if s(i,j,k,m)==floor(s(i,j,k,m)) and s(x,y,k,m)==floor(s(x,y,k,m)):
		        print (i,j,s(i,j,k,m)),(x,y,s(x,y,k,m))
