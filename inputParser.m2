--Author:       Lucas Rizzolo
--Date:         Thu Jul 29
--Name:         inputParser
--Description:  defines various methods for parsing information from the user
--Notes:        See comments for detailed code explanation. Formerly stringToRing.m2


--define main function to parse ring from string
--input: RING[var1, var2, ...]
--takes input, converts to an actual ring in the data
--Throws error for CC or RR currently
stringToRing = method()
stringToRing String := i -> (l = select("[^, [\\]]+", i); if l#0 == "RR"
						--then return(RR l_{1..#l-1})
                        then error "RR is not a precise field"
					else (
						if l#0 == "QQ" 
							then return(QQ l_{1..#l-1}) 
						else (
							if l#0 == "CC" 
								--then return(CC l_{1..#l-1})
                                then error "CC is not a precise field"
							else (
								if l#0 == "ZZ" 
									then return (ZZ l_{1..#l-1}) 
								else (return -1)
							)
						)
					)
			)


--Explanation:

--select("regex", "input string") selects substrings matching the regex and puts them into a list

--"[^, [\\]]+" is the regex. Here's essentially what it says: The outer set of
--square brackets specifies that we'll look for anything within the range of
--characters specified between the braces. The + sign at the end says we want it to
--grab the specified sequence that appears one or more times. Next, everything
--inside of the bracket specifies what we're looking for. Starting with the ^, that
--tells us that we want everything that isn't anything specified to the left (think
-- of it like a negation). We then give the following symbols to look for: ','
--' ', '[', and ']' (comma, whitespace, open and closed square bracket). We have to
-- "escape" the closed square bracket, so it becomes '//]'. So, the regex in
--english is roughly: Select anything that is not a comma, whitespace, open square
--bracket, or closed square bracket, appearing more than once.

--So, the select function will take something of the form "QQ[x,y,z]" and put it
--into a list as {QQ,x,y,z}

--The rest of the code is just if-else to check which field is used, based off
--which fields M2 can recognize (returns sentitel value -1 if non-recognized field is given)

-- The statements of the form return(RING l_{1..#l-1}) takes the rest of the list
-- (values 1 through length(l)-1) and uses the SPACE operator with type Ring and
-- List, casting the list to type RingArray, then creating the ring.

--Implementation with read from user
--R = stringToRing(read "Input the ring (RING[var1,var2,...]\n")

--Checks to see if it worked
--vars R

--Ask for field and number of variables so then use symbol(x, n) to generate the ring
consoleRing = method()
consoleRing (String,String) := (s1,s2) ->(
    x = symbol x;
    r1 = select("CC|QQ|ZZ|RR",s1);
    r2 = value(r1#0);
    n = value(s2);
    return r2[x_1..x_n];
)

consoleMat = method()
consoleMat (String,String) := (numCol,ins) ->(
    cols = value numCols;
    mList = toList(deepSplice (toSequence ins));
    mList = pack(matList,cols);
)

--Method for grabbing a list from a string
stringToList = method()
stringToList String := s -> (l = select("[0-9]+",s); r = for i in l list value i; return r)

--Method for replacing strings with actual values in a matrix
parseMatVals = method()
parseMatVals List := matList ->(
    if(not isTable matList)
    then(
        consoleMat("1",matList)
    );
    
    l = for i in matList list(
        for j in i list value j
    );
    
    return l;
)

--Method for formatting a list for a matrix
prepMat = method()
prepMat String := s ->(
    l = select("{([0-9]+,*)+}",s);
    mat = for i in l list stringToList i;
    return mat;
)


