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
fDat = "dat/vals.dat" << ""

--Create temporary file for all inputs. Read any stored information if possible
currentDat = temporaryFileName()

--def read method accepting exit at any point
eRead = method();
eRead String := s -> (ins = read s; if ins == "exit" then return false else return ins)

--Initialize to some basic info
fDat << "QQ[x,y,z]\n2\n{1 0 1}\n{0 1 1}\n{9,9}"

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
-- 0 -> Main menu
-- 1 -> Start program
-- 2 -> Options menu
-- 3 -> Preferences menu
-- 4 -> Manual/Documentation menu
-- 5 -> Exit
menu = method()
menu ZZ := n ->(
    if n==0 then (<<"\n"<<men<<"\n"; menu 100) else(
        if n==1 then (term = false;) else(
            if n==2 then (opMenu 0) else(
                if n==3 then (prefMenu 0) else(
                    if n==4 then << (<<"\nThis menu has not yet been implemented.\n"; menu 0) else(
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
-- 0 -> opts print
-- 1 -> Gandini-Ratliff-Rizzolo
-- 2 -> Derksen-Gandini Algorithm
-- 3 -> Unimplemented Paralled DG Alg
-- 4 -> Exit
opMenu = method()
opMenu ZZ := n ->(
    if n==0 then (<<"\n"<<opts<<"\n"; opMenu 100)else(
            if n==1 then (<<"\n Now using the generating algorithm\n"; opMenu 0) else(
                if n==2 then (<<"\n Now using the Derksen-Gandini algorithm\n"; opMenu 0) else(
                    if n==3 then (<<"\nThis is not implemented yet, defaulting to 2"; opMenu 0) else(
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
-- 0 -> prefs print
-- 1 -> File input/output
-- 2 -> Console input/output
-- 3 -> A better "direct-read" method
-- 4 -> Exit
prefMenu = method()
prefMenu ZZ := n ->(
    if n==0 then (<<"\n"<<pref<<"\n"; prefMenu 100) else(
        if n==1 then (<<"\nNow using file in/out. See test.dat for an example.\n"; fIn = true; fOut = true; uIn = false; conOut = false; betIn = false; prefMenu 0;) else(
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
--SHOULD NOT COME TO THIS MENU YET
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

--def file save
saveDat = method()
saveDat (String,List) := (fName,datList) ->(
    fName << datList
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
    <<"\nfileIn:\t"<<fIn<<endl;
)



fDat << close
exit
