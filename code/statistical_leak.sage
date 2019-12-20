###############################################################
## This code performs the numerical experiments
## presented in Chapter 5 in my thesis.
## For a given choice of log_n, q and log_m (where n is the 
## dimension, q is the modulus, and m is the maximum number 
## of samples), it can be run by writting 
##
##   sage experiments_statistical_attack.sage log_n q log_m
##
## in a terminal.
## For example, the first picture in the thesis can be
## obtained by writting
##
##   sage experiments_statistical_attack.sage 6 12289 14
##
## It should run in a few minutes (between 10 and 20 minutes)
## on a personal laptop
###############################################################


#### Fix the random seed for reproducibility ####
set_random_seed(12)


##################################################
## Setting the input and defining the rings
##################################################
import sys 
logn = ZZ(sys.argv[1])
n = 2**logn
q = ZZ(sys.argv[2])
logm = ZZ(sys.argv[3])

Zq = IntegerModRing(q)
P.<XX> = ZZ['XX']
R.<X> = P.quotient(XX^n + 1)
Pq.<YY> = Zq['YY']
Rq.<Y> = Pq.quotient(YY^n + 1)


##################################################
## Auxilliary functions (used to convert a 
## polynomial modulo q into an integer polynomial 
## and conversly
##################################################
def genP():
    v = Rq(0)
    for i in range(n):
        v += randint(0, q-1) * Y^i
    return v


def lift(e):
    s = R(0)
    for i in range(n):
        a = ZZ(e[i])
        if a>q/2:
            s += (a-q) * (X^i)
        else:
            s += a * (X^i)
    return s


def modq(e):
    s = sum([Zq(e[i]) * Y^i for i in range(n)])
    return s


def conj(e):
    s = sum([e[i] * X^(2*n-i) for i in range(n)])
    return s    

###################################################
## Sampling of the z_i's.
## We observe that sampling each z_i independently
## and uniformly in R_q is equivalent to sampling
## zz uniformly in R_q (zz being the product of 
## the z_i's) and then sampling all the z_i except
## for the last one uniformly in R_q. The last one
## is set so that the product is equal to zz.
##################################################

zz = genP()

def make_sample():
    # sample a z_v uniformly at random in R_q
    # and outputs z_v * z_\tilde{v}
    while True:
        a1 = genP()
        try: 
            a1i = 1/a1
            break
        except:
            continue
    a2l = lift(a1i * zz)
    assert a1 * modq(a2l) == zz
    return lift(a1) * a2l


def experiment(M):
    # Computes the empirical means for different values of m.
    # The first terms are shared between the computations
    m = max(M)
    s = R(0)
    L = []
    with open("n%dq%dm%d.txt"%(n,q,logm), "w") as text_file:
        for j in range(m):
            v = make_sample()
            s += v*conj(v)
            if j+1 in M:
                aa = vector(RR, [s[i]/s[0] for i in range(n)])
                res = max([abs(a) for a in aa[1:]])
                text_file.write(str(((j+1), res))+"\n")
                text_file.flush()
                L += [(j+1, res)]
    return L

######################################################
## Running the experiment and saving it in a text file
## as well as a svg file
######################################################

x_pts = [2**i for i in range(4, logm+1)]
LL = experiment(x_pts)

L = line(LL)
L.save("n%dq%dm%d.svg"%(n,q,logm), scale="loglog", base=2, gridlines=True, aspect_ratio=1., fontsize=16)
