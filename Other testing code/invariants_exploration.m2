needsPackage "InvariantRing"

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

R = QQ[x_1..x_3]
W = matrix{{1,0,1},{0,1,1}}
d = {3,5}
print W
T = diagonalAction(W, d, R)
print T
print cyclicFactors T
b1 = benchmark "S1 = invariants T"
b2 = benchmark "S2 = invariants2 T"
S1 = sort S1
S2 = sort S2
if (S1 != S2) then print "DIFFERENT"
print S1
print b1
print S2
print b2
--print (invariants T)
