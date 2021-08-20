

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
        try
        inp = eRead "\nInput the matrix ({m1,m2,m3},{m4,m5,m6},...):\n";
        if instance(inp,Boolean) and inp == false then (cont=false; continue)
        else if not instance(inp,String) then(
            <<"\nError with input, please try again!";
            continue;
        );
        try(wList = prepMat(inp))
        then(
            wList = prepMat(inp);
            if #wList > 0 then(wMat = matrix wList;) else (<<"Error, could not read list! Please try again\n"; continue);
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
            if #d == 0 then(<<"Error, could not read list! Please try again\n"; continue);
        )
        else (
            <<"\n Could not read your input! Please try again!\n";
            continue;
        );
        
        --Pass off the data to the algorithms
        if useGenAlg then(
            try(genAlg(R,wMat,d))
            then(
                genAlg(R,wMat,d)
            )
            else(
                <<"\nError with input data! Please try again\n"
            )
        )
        else(
            if useDGAlg then(
                try(DGAlg(R,wMat,d))
                then(
                    DGAlg(R,wMat,d)
                )
                else(
                    <<"\nError with input data! Please try again\n"
                )
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
--not implemented
fileIn = method()
fileIn Boolean := (cont) -> (
    while cont and not term do(
        <<"File input/output has not been implemented in this build due to a lack of stability.\nDefaulting to console in/out";
        cont = false;
    );
    userIn true;
    exit;
)

--def console-out
--not implemented
consOut = method()
consOut Boolean := (cont) ->(
    exit;
)

--def file-out
--not implemented
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
        if(instance(in2,Symbol)) then (<<"Error! Could not read number, please try again!"; continue);
        R = consoleRing(in1,in2);
        
        inp = eRead "\nInput the matrix ({m1,m2,m3},{m4,m5,m6},...):\n";
        if instance(inp,Boolean) and inp == false then (cont=false; continue)
        else if not instance(inp,String) then(
            <<"\nError with input, please try again!";
            continue;
        );
        try(wList = prepMat(inp))
        then(
            wList = prepMat(inp);
            if #wList == 0 then(<<"Error, could not read list! Please try again\n"; continue);
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
            if #d==0 then (<<"Error, could not read list! Please try again!"; continue)
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

--def calling method for the algorithms
--Not implemented.
inPass = method()
inPass (Ring,Matrix,List,Boolean) := (r,mat,lis,runGens) ->(
    if runGens then genAlg(r,mat,lis) else dGAlg(r,mat,lis)
)
