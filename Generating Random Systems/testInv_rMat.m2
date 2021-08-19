-- TITLE:           testInv_rMat.m2
-- AUTHORS:         Francesca Gandini, Sam Ratliff, Lucas Rizzolo
-- DESCRIPTION:     Tests the hash-table generation algorithm 
-- LAST MODIFIED:   Monday, August 19


needsPackage "InvariantRing"

-- **** First section: a bunch of functions that I probably could have found but just made myself **** --

-- concat list by appending the second to the end of the last
listAdd = (a,b) -> (m=0; i=#a; j=#b; for n from 0 to i+j-1 list if m==0 then a#n else b#(n-i) do if n+1-i>=0 then m=1)
-- the built-in function join(List, List, List) accomplishes this better

--


-- find max because I don't want to import a function to do that for me
maximum = (a,b) -> (if a>b then return a else return b)

-- Runs the Derksen-Gandini Algorithm on a specified ring size, dimension, and weightmatrix
-- @param t the number of variables in the ring
-- @param dimen the list of primes for the Z_p products forming the group
-- @param wts the weight matrix
minimalInvariants = (t,d,wts) ->(
    R = QQ[x_1..x_t];
    dimen = d;
    W = wts;
    A = diagonalAction(W,dimen,R);
    print W;
    print invariants A;
)

-- **** Second Section: messing around with ways to randomize weights, variables in the ring, order of the group, etc. **** --
--Note: Each function has a different flavor of randomness. Make sure you choose the one that you want.


-- Generates a random weight matrix
-- @param n dim1 of the matrix
-- @param m dim2 of the matrix
-- @param k the max a weight can be in the weight matrix
weightMatNM = (n,m,k) -> (L = for i from 1 to n list(for j from 1 to m list random(0,k)); return matrix L)

-- First way of randomly finding invariants. I don't know how to explain this one I guess
-- @param i the max number a random weight could be
-- @param t the number of variables in the ring
-- @param d the max a number p for Z_p could be
randInvariants = (i,t,d) -> (
    R = QQ[x_1..x_t];
    dimen = {(random d)+1,(random d)+1};
    W = weightMatNM(2,t,i);
    A = diagonalAction(W,dimen,R);
    print W;
    print invariants A)

------------------------------------ HASH TABLE CODE STARTS HERE ---------------------------------------------------
-- testing hash table approach
load "testInv.m2"
R= QQ[x_1..x_3]

d0 = 4
--random weight matrix. Last argument is the cap on the randomized weights
--W0 = weightMatNM(2,3,d0-1)

--weight matrix from Dr. G's pdf example of a weight matrix that needs two generators.
W0= matrix{{1,1,1},{1,3,1}};
print "W0"
print W0
print "Smith Normal Form"

print (smithNormalForm(W0))
print "Minors"
print (gens (minors(2,W0)))
base0= {d0,d0};

A0 = diagonalAction(W0,base0,R);
(l0,h0)= testInv(R,W0,base0);

print (netList l0)
print (h0#(l0_0))
print (invariants A0)


d1 = 16
--random weight matrix, last argument is cap on weights
--W1 = weightMatNM(2,3,d1-1)

--weight matrix that has the true, false, true, false behavior in the net output (i.e. only coprime numbers)
--but the minors of the matrix are not zero divisors of 16 and the program crashes when it tries to extract information from the hash table.
--W1 = matrix{{13,9,14}, {7,8,7}}


--misc. other tests
--W1 = matrix{{ 13,8,14}, {7,8,10}}
W1 = matrix{{ 1,0,4}, {0,4,4}}
print "Smith Normal Form"
print (smithNormalForm(W1,ChangeMatrix=>{false,false}))
--W1 = matrix{{ 2,0,2}, {0,2,2}}

print "W1"
print W1
print "Minors"
print (minors(2,W1))
base1= {d1,d1};
A1 = diagonalAction(W1,base1,R);

I1 = invariants A1
I1 = sort I1
print "Invariants"
print I1
(l1,h1)= testInv(R,W1,base1);

print (netList pack(4,l1))

I1 = invariants A1
I1 = sort I1
print "Invariants"
print I1

--recover generated invariants using list element as key


-- if the entry in the list is associated with "true" then I get a crash that says that the entry could not be found in the hash table.
--but this outputs all of the things found in the hash table and it doesn't generate all of the invariants...
-- it seems like the entries that are "true" will generate all of the invariants but I can't seem to get those from the hash table.
print "Hash table algorithm"
for i from 0 to (#l1-1) do ( if ((l1_i)_1) == false then ( 
print (sort (unique ( h1#(l1_i)))))
)

--print (l1_1)
--print (sort (unique ( h1#(l1_1))))
--print (sort (unique (h1#(l1_2))))
--print (sort (unique (h1#(l1_3))))
--print (isSubset(I1, h1#(l1_3)))
--print (isSubset(h1#(l1_3), I1))


--------------------------------------------------------- HASH TABLE CODE ENDS HERE -----------------------------------------------------------------

--Loads a list of primes, checks that it worked with a print
load "primeList.m2"

-- get a sampling of primes within a range i of size m
-- for example, samplePrimes(3,3) might return (2,5,3) or (3,3,3) etc.
-- max m allowed is 999 which corresponds to 7919
samplePrimes = (m,i) -> (for n from 1 to m list primeList#(random i))

-- Randomly find invariants but only for a specific idea:
-- There are t variables in the ring
-- G \cong Z_p^d
-- W is not set yet
--
-- @param t the number of variables in the ring
-- @param d the number of Z_p in the ring
-- @param p the p
doInvariants = (t,d,p) -> (
    R = QQ[x_1..x_t];
    dimen = for n from 1 to d list p;
    --Need to generate a W
    A = diagonalAction(W,dimen,R);
    print W;
    print invariants A
)

-- Randomly find invariants, but this time with more rules:
--
-- Each Z_p has a random prime p
-- There are a d Z_p's forming your group
-- There are t variables in the ring
-- Weight matrix still isn't solid
--
-- @param t the number of variables in the ring
-- @param d the number of Z_p's in your group thing or whatever
-- @param p the highest allowable index for a prime (p(0)=2, p(1)=3, p(2)=5, ...)
testInvariants = (t,d,p) -> (
    R = QQ[x_1..x_t];
    dimen = samplePrimes(d,p);
    --Need to generate a W still
    A = diagonalAction(W,dimen,R);
    print W;
    print invaraints A
)


-- Randomly finds invariants, but this time with more randomness:
--
-- Each Z_p has a random prime p
-- There are a random amount of Z_p's forming your group
-- There are a random amount of variables in the ring
-- Weight matrix is not solid, again
--
-- @param t the highest number allowed for a random number of variables in the ring
-- @param d the highest number allowed for a random selection of primes
-- there is no param p because we are randomly selecting primes
testInvariants = (t,d) -> (

    R = QQ[x_1..x_t];
    dimen = samplePrimes(d,#samplePrimes);
    --Need to generate a W still
    A = diagonalAction(W,dimen,R);
    print W;
    print invaraints A
)

--**** Section Four: Notes ****--
-- Notes:
--
--* The dimension is a list of each Z_p. Ex.: (3,5,7) -> Z_3, Z_5, Z_7.
--
--* I want to make a parallel version of a lot of this
--
