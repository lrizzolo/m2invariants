# m2invariants
## Authors: Mallory Dolorfino, Francesca Gandini, Daniel Qin, Sam Ratliff, and Lucas Rizzolo
### Created for distribution after the Youth Math Conference at Ohio State University (2021)
### License: GNU General Public License v3.0 as described in the LICENSE.md

> Copyright 2021, Mallory Dolorfino, Francesca Gandini, Daniel Qin, Sam Ratliff, and Lucas Rizzolo.
>  You may redistribute this file under the terms of the GNU General Public
   License as published by the Free Software Foundation, either version 2 of
   the License, or any later version.

The project explores Invariant Theory using Macaulay2. The following files and folders are provided:
1.  Generating Random Systems
    + primeList.m2    --->  Holds a list of large primes, used to pseudo-generate random primes
    + rMat.m2         --->  Original code from creating random systems to test, considered unstable
    + sam_rMat.m2     --->  Testing and benchmarking for the Derksen-Gandini algorithm and modifications of it
    + testInv.m2      --->  Tests the generation of invariants using a seed monomial
    + testInv_rMat.m2 --->  Uses rMat and testInv to test a potential hash table algorithm
    + README.md       ---> README
2.  M2 Object Testing
    + LinkedList2.m2  --->  Establishes a LinkedList object similar to Java.util.LinkedList
    + Node2.m2        --->  Required to make the LinkedList
    + README.md       ---> README
3.  Non-Packaged Algorithms
    + generator_algorithm.m2  --->  The Ratliff-Rizzolo-Gandini Algorithm that uses seed invariants. Makes comparison to Derksen-Gandini
    + README.md               ---> README
4.  Other testing code
    + DFS_Invariants.java       ---> Searches for invariants using a depth-first search
    + Invariants.java           ---> Used with DFS_Invariants.java
    + exampleForPres.java       ---> An example of the Derksen-Gandini algorithm as inmplemented in Macaulay2
    + invariantsLinearSpace.m2  ---> Other explorations
    + invariants_exploration.m2 ---> Other explorations
    + README.md                 ---> README
5. InvariantCalculator v1.1
    + dat
        + test.dat      --->  location for stored data
        + vals.dat      --->  sample save data
    + gensAlg.m2        --->  contains the two algorithms for use
    + inputParser.m2    ---> parses the inputs taken from files or users
    + inputs.m2         ---> takes inputs from the user
    + invarDriver_2.m2  ---> driver for the code
    + men
        + credits.txt   ---> Credits menu, not finished
        + kSymb.txt     ---> K College symbol at first print
        + man.txt       ---> manual, not finished
        + menu.txt      ---> main menu
        + opts.txt      ---> options menu
        + pref.txt      ---> preferences menu
    + printSig.m2       ---> print beginning signature
    + README.txt        ---> Extrememly valuable README
    + vals.dat          ---> Result of buggy code. Please ignore :)
6. LICENSE.md ---> GNU General Public License v3.0
7. README.md  ---> This file

Please read the README files in each folder for a better explanation of the separation of the code

# For more information regarding this repository, please contact:
+ Lucas Rizzolo: 
  + email: lucasrizzolo (at) icloud (dot) com
  + github: @lrizzolo
