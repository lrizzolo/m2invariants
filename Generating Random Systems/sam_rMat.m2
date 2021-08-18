-- TITLE:           rMat.m2
-- AUTHORS:         Lucas Rizzolo
-- DESCRIPTION:     Establishes various functions to test the Derksen-Gandini algorithm with varying data sets,
--                  of varying randomness
-- LAST MODIFIED:   Wed April 21

-- WIP, may not even compile. I'd recommend copy and pasting interesting things into a different place to test them.

needsPackage "InvariantRing"

-- **** First section: a bunch of functions that I probably could have found but just made myself **** --

invariants2 = method(Options => {
        Strategy => UseNormaliz,
        UseLinearAlgebra => false,
        UseCoefficientRing => false,
        DegreeBound => infinity,
        DegreeLimit => {},
        SubringLimit => infinity
        })
invariants2 DiagonalAction := List => o -> D -> (
    (W1, W2) := weights D;
    R := ring D;
    kk := coefficientRing R;
    p := char kk;
    d := cyclicFactors D;
    r := rank D;
    if p > 0 and o.UseCoefficientRing then (
	q := kk#order;
	if any(d, j -> q%j =!= 1) then (
	    print "-- Diagonal action is not defined over the given coefficient ring. \n-- Returning invariants over an infinite extension field over which the action is defined."
	    )
	else (
	    D' := diagonalAction(W1||W2, apply(r, i -> q - 1)|d, R);
	    return invariants2 D'
	    )
    	);
    R = kk[R_*, MonomialOrder => GLex];
    g := numgens D;
    n := dim D;
    mons := R_*;
    local C, local S, local U;
    local v, local m, local v', local u;
    
    if g > 0 then (
	t := product d;
	
	reduceWeight := w -> vector apply(g, i -> w_i%d#i);
	
	C = apply(n, i -> reduceWeight W2_i);
	
	S = new MutableHashTable from apply(C, w -> w => {});
	scan(#mons, i -> S#(reduceWeight W2_i) = S#(reduceWeight W2_i)|{mons#i});
	U = R_*;
	
	while  #U > 0 do(
            --print U;
	    m = U#0; 
            --m = min U;
	    v = first exponents m;
	    k := max positions(v, i -> i > 0);
	    v = reduceWeight(W2*(vector v));
	    
	    while k < n do(
	    	u = m*R_k;
	    	v' = reduceWeight(v + W2_k);
	    	if (not S#?v') then S#v' = {};
	    	if all(S#v', m' -> u%m' =!= 0_R) then (
		    S#v' = S#v'|{u};
		    if first degree u < t then (
                        --print U;
                        U = U | {u};
                        --print "ADDED";
                        --print u;
                        --print U;
                        );

		    );
	    	k = k + 1;
	    	);
	    U = delete(m, U);
	    );
    	if S#?(0_(ZZ^g)) then mons = S#(0_(ZZ^g)) else mons = {}
    	);
    if r == 0 then return apply(mons, m -> sub(m, ring D) );
    
    W1 = W1*(transpose matrix (mons/exponents/first));
    if o.Strategy == UsePolyhedra then (
	if r == 1 then C = convexHull W1 else C = convexHull( 2*r*W1|(-2*r*W1) );
	C = (latticePoints C)/vector;
	)
    else if o.Strategy == UseNormaliz then (
	if r == 1 then C = (normaliz(transpose W1, "polytope"))#"gen" 
	else C = (normaliz(transpose (2*r*W1|(-2*r*W1)), "polytope"))#"gen";
	C = transpose C_(apply(r, i -> i));
	C = apply(numColumns C, j -> C_j)
	);
    
    S = new MutableHashTable from apply(C, w -> w => {});
    scan(#mons, i -> S#(W1_i) = S#(W1_i)|{mons#i});
    U = new MutableHashTable from S;
    
    nonemptyU := select(keys U, w -> #(U#w) > 0);
    while  #nonemptyU > 0 do(
	v = first nonemptyU;
	m = first (U#v);
	
	scan(#mons, i -> (
		u := m*mons#i;
        	v' := v + W1_i;
        	if ((U#?v') and all(S#v', m' -> (
			    if u%m' =!= 0_R then true
			    else if g > 0 then (
				m'' := u//m';
			    	v'' := reduceWeight(W2*(vector first exponents m''));
			    	v'' =!= 0_(ZZ^g)
				)
			    else false
			    )
			)
		    ) 
		then( 
                    S#v' = S#v'|{u};
                    U#v' = U#v'|{u};
		    )
	    	)
	    );
	U#v = delete(m, U#v);
	nonemptyU = select(keys U, w -> #(U#w) > 0)
	);
    
    if S#?(0_(ZZ^r)) then mons = S#(0_(ZZ^r)) else mons = {};
    return apply(mons, m -> sub(m, ring D) )
    )
-- concat list by appending the second to the end of the last
listAdd = (a,b) -> (m=0; i=#a; j=#b; for n from 0 to i+j-1 list if m==0 then a#n else b#(n-i) do if n+1-i>=0 then m=1)

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
    --print W;
    --print A;
    --print cyclicFactors A;

    --b1 = benchmark "S1 = invariants A";
    --b2 = benchmark "S2 = invariants2 A";
    S1 = invariants A;
    S2 = invariants2 A;
    S1 = sort S1;
    S2 = sort S2;
    if (S1 != S2) then print "DIFFERENT";
    --print S1;
    --print b1;
    --print S2;
    --print b2;
    --print invariants A
    )
for n from 1 to 1000 do (
    i = random 50;
    print n;
    randInvariants(i+1,3,i+1);
);

--Loads a list of primes, checks that it worked with a print
load "primeList.m2"
--print primeList

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

--**** Section Three: Testing the code ****--
-- VERY MUCH WIP
--List of different things to test
varSizes = {1,2,3,4,5,6,7,8,9} -- Possible numbers for the variables in the ring
primeSizes = {} -- D
weightMatrices = {} --Different weight matrices to test. Code makes sure that it only uses ones that make sense


--run through every test case that we want


--**** Section Four: Notes ****--
-- Notes:
--
--* The dimension is a list of each Z_p. Ex.: (3,5,7) -> Z_3, Z_5, Z_7.
-- I'm making a concat to add lists together
-- This will be useful in creating a group of random order
--
--* Making a function to use a random prime would be useful. This could be
-- accomplished by searching through a list of primes?
--
--* I'm going to eventually try and make this a package, but it needs a lot of polish
--
--* I want to make a parallel version of a lot of this
--
--* to get size of list L do #L
