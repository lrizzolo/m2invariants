--CLASS: Node
--DESCRIPTION: Creates Node objects, to be used for a LinkedList object
--DATE: Thu Jun 3
--Author: Lucas Rizzolo

--Functions for creating a new node
makeNode = (e,n) -> hashTable{elem => e, next => n}
--f = s -> "--hashTable of Node--"
--new Type of hashTable from Function := (A,B,f) -> hashTable{net => f}
Node = new Type of HashTable --from makeNode

--Returns the next node
getNext = method()
getNext Node := n -> (n#next)

setNext = method()
setNext (Node, Node) := (n1,n2) -> (n1 = new Node from makeNode(n1#elem,n2))

clearNode = method()
clearNode Node := n -> (n = new Node from makeNode(0,0))


--Testing Section--

n1 = new Node from makeNode(1,null)
peek n1

n2 = new Node from makeNode(2,null)
peek n2

clearNode n2
n1 = setNext(n1,n2)
getNext n1
