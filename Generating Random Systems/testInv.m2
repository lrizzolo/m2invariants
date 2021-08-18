-------------------------------------------------------------------------------
--testing the generation of invariants via a seed monomial.  sample test at the
--end of this file
-------------------------------------------------------------------------------

needsPackage "InvariantRing"

--helper function to generate monomial from exponent vector
f= (ev, R) -> (
    var:= gens R;
    m:= product for i to #var-1 list (var#i)^(ev#i)
    )


--test function
testInv= {Support=> null} >> o -> (R,W,base) -> (
    T:= diagonalAction(W, base, R);
    S:= invariants T;
    
    --this option allows testing of seed moniomials with less than full support
    supp:= if o.Support === null then numgens R else o.Support;
    
    --separate seed candidates by number of variables
    parti:= partition(m -> length support m, S);
    testMonomials:= parti#supp;

    --works for the Z_n x Z_n case
    d:= lcm base;
    
    --hashTable to store results of test; to be returned by funtion
    resultTable:= new MutableHashTable;

    --get pure powers (obtained from list of invariants calculated by InvariantRing
    -- a cheat, clearly not usable for a general algorithm.  How do we determine minimal
    --purepower invariants?
    Mbase:= parti#1;

    --loop variables
    powers:= null; expos:= null; M:= null; test:= null;

    resultList=
    for m in testMonomials list (
    	--take powers of seed monomial m
    	powers= apply(d-1, n -> m^(n+1));		
    	--get their exponent vectors mod d
	expos= apply(flatten apply(powers,exponents), ev -> ev%d);
    	--append to list of purepower invariants
	M= Mbase | apply(expos, ev -> f(ev,R));
    	--to avoid the rigamarole of get minimal invariants, we simply test whether
	--our generated list contains all inavariants calculated by InvariantRing
	test= isSubset(S,M);
	if not test then resultTable#({m, test})= M;
    	{m, test}
	);
    return (resultList, resultTable);
    )
end

-----------------------------------------------------------------------------
--sample test----------------------------------------------------------------
-----------------------------------------------------------------------------
load "testInv.m2"
R= QQ[x_1..x_3]

W0= matrix{{1,0,3},{0,5,1}};
base0= {9,9};
(l0,h0)= testInv(R,W0,base0);

W1= matrix{{1,0,1},{0,1,1}}
base1= {16,16};
(l1,h1)= testInv(R,W1,base1);

netList l0
netList pack(4,l1)

--recover generated invariants using list element as key
h1#(l1_1)
h1#(l1_3)
