--CLASS: LinkedList
--DESCRIPTION: A LinkedList object, which is functionally the same as a stack
--DATE: Thu Jun 3
--AUTHOR: Lucas Rizzolo

--Loads the Node code
load "Node.m2"

--functions and definitions for creating a LinkedList

--preps a HashTable to be made into a LinkedList
--@param f the first element in the LinkedList
--@param s the size of the LinkedList. this should normally
--          be set to zero
makeList = (f,s) -> hashTable{first => f, size=> s}

--Class Declaration
LinkedList = new Type of MutableHashTable

--constructor method for creating a LinkedList from a List
newLinkedList = method()
--@param l1 the list to be converted into a LinkedList
newLinkedList List := l1 -> (
    linkList = new LinkedList from makeList(null,0);
    for l in l1 do addElement(linkList,l);
    return linkList;
)

--Adds an element to the linked list
addElement = method()

--Creates a node for the ZZ and then adds it to the list
--@param l1 the LinkedList to which a node will be inserted
--@param n the number in ZZ, which will be made the element
--      of the node to be added
addElement (LinkedList,ZZ) := (l1,n) ->(
    n1 = new Node from makeNode(n,l1#first);
    l1#first = n1;
    l1#size = l1#size+1;
)

--Adds the node to the linked list
--@param l1 the LinkedList to which a node will be inserted
--@param n the Node to be inserted
addElement (LinkedList,Node) := (l1,n) ->(
    n = new Node from makeNode(n#elem, l1#first);
    l1#first=n;
    l1#size = l1#size+1;
)

--Checks to see if something is empty
isEmpty = method()

--Checks to see if a LinkedList is empty
--@param l the LinkedList to be checked
isEmpty LinkedList := l -> (
    if l#size == 0 then true else false
)

--This is really just a pop
removeElement = method()

--Removes the first element from the LinkedList and returns it
--@param l the LinkedList from which the first element will be
--      popped
removeElement LinkedList := l->(
    n = l#first;
    l#first = l#first#next;
    n#next = new Node from makeNode(n#elem,null);
    return n;
)

--Looks at the first element of the thing.
peekFirst = method()

--returns the first element of a LinkedList without popping.
--functionally the same as list#first, so this is
--rendundant
peekFirst LinkedList := l -> l#first

--Returns the size of the thing
sizeOf = method()

--Returns the size of the LinkedList
--functionally the same as list#size, so this is
--redundant
sizeOf LinkedList := l -> l#size

--clears the thing
clear = method()

--Clears a LinkedList, returning an empty LinkedList with size 0
clear LinkedList := l -> l=new LinkedList from makeList(null,0)

--Testing section--
n1 = new Node from makeNode(node1, 0)
list1 = new LinkedList from makeList(n1,1)
list1 = clear list1
