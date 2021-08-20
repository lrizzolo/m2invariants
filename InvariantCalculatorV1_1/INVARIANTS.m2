-*
    Copyright 2021, Mallory Dolofino, Francesca Gandini,
    Daniel Qin, Sam Ratliff, Lucas Rizzolo
*-

newPackage(
    "INVARIANTS",
    Version => "1.0",
    Date => "July 26, 2021",
        Authors => {
        {Name => "Mallory Dolorfino"},
        {Name => "Francesca Gandini",
         Email => "fra.gandi.phd@gmail.com",
         HomePage => "https://sites.google.com/a/umich.edu/gandini/home"},
         {Name => "Daniel Qin"},
         {Name => "Sam Ratliff"},
         {Name => "Lucas Rizzolo"}
         },
         Headline => "algorithms for generating invariants in finite abelian groups",
         Keywords => {"Invariant Theory", "Representation Theory", "Group Theory"},
         Certification => {},
         AuxiliaryFiles => true,
         DebuggingMode => false,
         Reload => true
)

export {
    "INVARIANTS",
    "invarDriver"
}

needsPackage("InvariantRing")

-------------------------------------------
--- LOAD AUXILIARY FILES ------------------
-------------------------------------------

--Need to set a different file name. This won't work
load "~.m2/SummerWork/INVARIANTS/invarDriver.m2"

beginDocumentation()

document{
    Key => INVARIANTS,
    Headline => "algorithms for generating invariants",
    --EXAMPLE{},
    Caveat => {"warning"},
    Subnodes => {
        TO invarDriver
    }
}

document{
    Key => run,
    Headline => "driver code for the invariant calculator",
    Usage => "run",
    Inputs => {
        HR{},
        TO run,
        " is used to start the driver for the invariant ring calculator."
    },
    Outputs => {
        "The two outputs should be the start of the GUI or an error."
    },
    Caveat =>{"warning"}
}


end--

**************************************
Notes Section: Clean before submitting
**************************************

VERY WIP
-Lucas

This is just an idea of what a package of our code might look like. I'm including the idea of a basic GUI that I've been working on (see kSymb.txt for the neat intro), but it is completely not necessary. Ideally, I'd see the GUI function as a tutorial/simplified version of our code for those that aren't too familiar with Macaulay2. The other code could be used as normal outside of it.

-Lucas
