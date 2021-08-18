--def read method accepting exit at any point
eRead = method();
eRead String := s -> (ins = read s; if ins == "exit" then return false else return ins)

--def user line-by-line input
userIn = method()
userIn Boolean := (cont) -> (
    --While the user still wants to run the code
    while cont and not term do(
        --Take input, check for exit with eRead
        inp = eRead "\nInput the ring (RING[var1,var2,...]):\n";
        if instance(inp,Boolean) and inp == false then (cont=false; continue);
        
        --Try to input the ring. If an error is thrown, handle it with grace
        try(R = stringToRing(inp))
        then(
            --Read the input as a ring
            R = stringToRing(inp);
        
            --If the format for the ring was incorrect, stringToRing will return -1
            --Check for this and inform the user of the issue
            try (if R == -1 then <<"\nCould not read ring! Please try again!\n") then (continue) else();
        )
        else (
            <<"\nThe use of CC and RR is currently not supported\n";
            continue;
        );
        
        --Try to input the weight matrix. If an error occurs, handle it with grace
        inp = eRead "\nInput the matrix ({m1,m2,m3},{m4,m5,m6},...):\n";
        if instance(inp,Boolean) and inp == false then (cont=false; continue);
        try(wList = prepMat(inp))
        then(
            wList = prepMat(inp);
            wMat = matrix wList;
        )
        else(
            <<"\nCould not read input! Please try again!\n";
            continue;
        );
        
        --Try to input the dimension list. If an error is thrown, handle it with grace
        inp = eRead "\nInput the dimension list ({dim1,dim2,...}):\n";
        if instance(inp,Boolean) and inp == false then (cont=false; continue);
        try(d = stringToList(inp))
        then(
            d = stringToList(inp);
            
            --check for improper input
        )
        else (
            <<"\n Could not read your input! Please try again!\n";
            continue;
        );
        
        --Pass off the data to the algorithms
        if useGenAlg then(
            genAlg(R,wMat,d)
        )
        else(
            if useDGAlg then(
                dGAlg(R,wMat,d)
            )
            else (
                if useParAlg then(
                    <<"\nThis option is currently not supported\n"
                )
            )
        );
        
        --See if the user wants to run the code again
        cond = eRead "\nWould you like to run again (y/n)?\t";
        if cond == "n" then (cont=false;term=true) else (cont=true;term=false)
    );
)

--def file-in
fileIn = method()
fileIn Boolean := (cont) -> (
    exit;
)

--def console-out
consOut = method()
consOut Boolean := (cont) ->(
    exit;
)

--def file-out
fileOut = method()
fileOut Boolean := (cont) ->(
    exit;
)

--def better input method using console
betterIn = method()
betterIn Boolean := (cont) ->(
    
    while cont and not term do(
        in1 = eRead "\nPlease input the field:\t";
        in2 = eRead "\nPlease input the number of variables:\t";
        R = consoleRing(in1,in2);
        
        inp = eRead "\nInput the matrix ({m1,m2,m3},{m4,m5,m6},...):\n";
        if instance(inp,Boolean) and inp == false then (cont=false; continue);
        try(wList = prepMat(inp))
        then(
            wList = prepMat(inp);
            wMat = matrix wList;
        )
        else(
            <<"\nCould not read input! Please try again!\n";
            continue;
        );
        
        --Try to input the dimension list. If an error is thrown, handle it with grace
        inp = eRead "\nInput the dimension list ({dim1,dim2,...}):\n";
        if instance(inp,Boolean) and inp == false then (cont=false; continue);
        try(d = stringToList(inp))
        then(
            d = stringToList(inp);
            
            --check for improper input
        )
        else (
            <<"\n Could not read your input! Please try again!\n";
            continue;
        );
        
        --Pass off the data to the algorithms
        if useGenAlg then(
            genAlg(R,wMat,d)
        )
        else(
            if useDGAlg then(
                dGAlg(R,wMat,d)
            )
            else (
                if useParAlg then(
                    <<"\nThis option is currently not supported\n"
                )
            )
        );
        
        --See if the user wants to run the code again
        cond = eRead "\nWould you like to run it again (y/n)?\t";
        if cond == "n" then (cont=false;term=true) else (cont=true;term=false)
    );
)

--def for saving info
saveCurrent

(Ring, List, Matrix)

--def calling method for the algorithms
inPass = method()
inPass (Ring,Matrix,List,Boolean) := (r,mat,lis,runGens) ->(
    if runGens then genAlg(r,mat,lis) else dGAlg(r,mat,lis)
)
