--NAME:             invarDriver.m2
--DESCRIPTION:      Driver for the "Invariant Calculator"
--AUTHORS:          Lucas Rizzolo
--LAST MODIFIED:    Thur Jul 29

--Load signature printing and exit code
load "printSig.m2"

--Load input formatter code
load "inputParser.m2"

--Load the algorithms
load "gensAlg.m2"

--Load the various input/Output methods
load "inputs.m2"

--Write to files for saving info
fDat = "vals.dat" << ""

--Initialize to some basic info
fDat << "QQ[x,y,z]\n2\n|1 0 1|\n|0 1 1|\n{9,9}"

--Get the menus
men = get "./men/menu.txt"
opts = get "./men/opts.txt"
pref = get "./men/pref.txt"
man = get "./men/man.txt"

--Init options for algorithms, outputs, and inputs
uIn = true
fIn = false
fOut = false
betIn = false
conOut = false
useGenAlg = true
useDGAlg = false
useParAlg = false
term = false

--def menu function for the menu
menu = method()
menu ZZ := n ->(
    if n==0 then (<<"\n"<<men<<"\n"; menu 100) else(
        if n==1 then (term = false;) else(
            if n==2 then (opMenu 0) else(
                if n==3 then (prefMenu 0) else(
                    if n==4 then << (manMenu 0) else(
                        if n==5 then (<<"EXITING"; term = true) else(
                            r = read "Enter in the menu option number:\t";
                            menu (value r);
                        )
                    )
                )
            )
        )
    )
)

--def options menu function
opMenu = method()
opMenu ZZ := n ->(
    if n==0 then (<<"\n"<<opts<<"\n"; opMenu 100)else(
            if n==1 then (<<"\n Now using the generating algorithm\n"; opMenu 0) else(
                if n==2 then (<<"\n Now using the Derksen-Gandini algorithm\n"; opMenu 0) else(
                    if n==3 then (<<"\nThis is not implemented yet, defaulting to 1"; opMenu 0) else(
                        if n==4 then (<<"EXITING"; menu 0) else(
                            r = read "Enter in the option number:\t";
                            opMenu (value r);
                        )
                    )
                )
            )
    )
)

--def preferences menu function

prefMenu = method()
prefMenu ZZ := n ->(
    if n==0 then (<<"\n"<<pref<<"\n"; prefMenu 100) else(
        if n==1 then (<<"\nNow using file in/out\n"; fIn = true; fOut = true; uIn = false; conOut = false; betIn = false; prefMenu 0;) else(
            if n==2 then (<<"\nNow using console in/out\n"; fIn = false; fOut = true; uIn = true; conOut = true; betIn = false; prefMenu 0;) else(
                if n==3 then (<<"\nNow using the direct read method\n"; fIn = false; fOut = true; uIn = false; conOut = true; betIn = true; prefMenu 0;) else(
                    if n==4 then (<<"EXITING"; menu 0;) else(
                        r = read "Enter in the preference number:\t";
                        prefMenu (value r);
                    )
                )
            )
        )
    )
)

--def manual menu function

manMenu = method()
manMenu ZZ := n ->(
    if n==0 then (<<"\n"<<man<<"\n"; manMenu 100) else(
        if n==1 then (<<"NOT YET IMPLEMENTED"; manMenu 0) else(
                if n==2 then (<<"NOT YET IMPLEMENTED"; manMenu 0) else(
                    if n==3 then (<<"NOT YET IMPLEMENTED"; manMenu 0) else(
                        if n==4 then (<<"EXITING"; menu 0) else(
                            r = read "Enter in the manual page number:\t";
                            menu (value r);
                        )
                    )
                )
        )
    )
)

--Drive the program
rest 1

while term == false do(
    menu 0;
    userIn uIn;
    fileIn fIn;
    betterIn betIn;
    fileOut fOut;
    consOut conOut;
)

fDat << close
exit


