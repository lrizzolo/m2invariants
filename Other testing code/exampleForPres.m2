needsPackage "InvariantRing"
R = QQ[x_1..x_3]
dimen = {5,5}
W = matrix {{1,0,1},{0,1,1}}
A = diagonalAction(W,dimen,R)
invariants A
