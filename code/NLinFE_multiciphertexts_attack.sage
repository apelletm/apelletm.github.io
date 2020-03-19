#####################################################
## Check that the multi-ciphertexts attack 
## indeed output a small noise term.
## Because we are only concerned with the
## structure of the noise terms, the code below
## uses elements of ZZ instead of elements of R.
##
## You can run 'sage RLWE_correlated.sage',
## it will output the value of q, and the value of
## the noise term obtained after applying the attack
## both in the case of random elements and in
## the case of RLWE with correlated noise elements
#####################################################


## Defining the parameters

q = 1000000000003 #q is the modulus, it should be large enough for the attack to work
while not q in Primes():
    q = q+2
b =10
Zq = Integers(q)

print "q = ", q,"\n";


## Case RLWE with correlated noise

# Creating the small elements
g1,g2 = 0,0
while g1 == 0:
   g1 = Zq(ZZ.random_element(-b,b))
while g2 == 0:
   g2 = Zq(ZZ.random_element(-b,b))

t1 = Zq(ZZ.random_element(-b,b))
t2 = Zq(ZZ.random_element(-b,b))
t1_prime = Zq(ZZ.random_element(-b,b))
t2_prime = Zq(ZZ.random_element(-b,b))
f1 = Zq(ZZ.random_element(-b,b))
f2 = Zq(ZZ.random_element(-b,b))
f3 = Zq(ZZ.random_element(-b,b))
f4 = Zq(ZZ.random_element(-b,b))

# Creating the encodings

a1 = [f1/g1*t1+Zq(ZZ.random_element(-b,b))*g2, f3/g1*t1+Zq(ZZ.random_element(-b,b))*g2]
a2 = [f2/g2*t2+Zq(ZZ.random_element(-b,b))*g1, f4/g2*t2+Zq(ZZ.random_element(-b,b))*g1]
a3 = [f3/g1*t1_prime+Zq(ZZ.random_element(-b,b))*g2, f1/g1*t1_prime+Zq(ZZ.random_element(-b,b))*g2]
a4 = [f4/g2*t2_prime+Zq(ZZ.random_element(-b,b))*g1, f2/g2*t2_prime+Zq(ZZ.random_element(-b,b))*g1]

res = a1[0]*a2[0]*a3[0]*a4[0] - a1[1]*a2[0]*a3[1]*a4[0] - a1[0]*a2[1]*a3[0]*a4[1] + a1[1]*a2[1]*a3[1]*a4[1];
print "For RLWE with correlated noise, the result is ", min(res,-res),"\n";


## Case uniform modulo q

a1 = [Zq.random_element(), Zq.random_element()]
a2 = [Zq.random_element(), Zq.random_element()]
a3 = [Zq.random_element(), Zq.random_element()]
a4 = [Zq.random_element(), Zq.random_element()]

res = a1[0]*a2[0]*a3[0]*a4[0] - a1[1]*a2[0]*a3[1]*a4[0] - a1[0]*a2[1]*a3[0]*a4[1] + a1[1]*a2[1]*a3[1]*a4[1];

print "For uniform modulo q, the result is ", min(res,-res),"\n";


