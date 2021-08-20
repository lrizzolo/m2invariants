WELCOME TO THE INVARIANT CALCULATOR PACKAGE!

VERSION: 1.0
_______________________________________________________________________________________________________
A PACKAGE CREATED FOR EXPLORING INVARIANTS
WITH MACAULAY2

"Like the phoenix rising out of its ashes, the theory of invariants, pronounced dead at the turn of the
 century, is once again at the forefront of mathematics" - Kung and Rota, Invariant Theory on Binary
	Forms, 1984


———————————————————————————————————————————————————————————————————————————————————————————————————————

AUTHORS:
	Mallory Dolorfino
	Francesca Gandini
	Daniel Qin
	Sam Ratliff
	Lucas Rizzolo
_______________________________________________________________________________________________________

The following files/folders are included with the package:

Invariants.m2		------------->	The package file as required by Macaulay2
invarDriver.m2		~~~~~~~~~~~~~>	The driver for the invariant calculator
gensAlg.m2		------------->	The different algorithms for finding invariants
inputs.m2		~~~~~~~~~~~~~>	Code for different versions of inputting files
inputParser.m2		------------->	Code for formatting the input and parsing information
printSig.m2		~~~~~~~~~~~~~>	Code for printing the signature before the calculator start
README.txt		------------->	This file
dat			~~~~~~~~~~~~~>	Directory where data is stored
	-vals.dat	------------->	File where data is stored
	-test.dat	~~~~~~~~~~~~~>	File containing sample read data
men			------------->	Directory where text files containing menus are stored
	-menu.txt	~~~~~~~~~~~~~>	The text file for the menu output
	-man.txt		------------->	The text file for the manual output
	-opts.txt	~~~~~~~~~~~~~>	The text file for the options output
	-pref.txt	------------->	The text file for the preferences output

---------------------------------------------------------------------------------------------------------

INFORMATION:

After installation, the InvariantCalculator package is designed to be used in two ways:
	1. The package can be loaded in a Macaulay2 environment, upon where any of the functions and 
		variables can be accessed.
	2. By typing "m2 --script invarDriver_2.m2" in the command line, the calculator will start 
		running. It is designed to be an easily accessible enviornment to familiarize oneself 
		with the algorithms.
	3. At any point in time except for the menu, you can exit the current process by typing "exit"

---------------------------------------------------------------------------------------------------------

NOTES ON DESIGN
-Lucas Rizzolo

	Thank you for using the Invariant Calculator! In it's first form of existence, this was created
due to the nature of coding in Macaulay2. The way we were using M2 to examine invariants felt artificial
and did not play to the strengths of computer science. This was originally developed due to my laziness
in working with a supercomputer, upon where I realized the beneficial aspects of the implementation of a
UI in helping mathematicians who aren't familiar with computer science use our algorithms. Ultimately,
however, I felt that it would also be important to have our code be open source and available to be used
outside of the Calculator environment. I will be providing more documentation on how to use the algorithms
outside of the environment in the future.

	The best way to improve on what's been done is through community-driven improvements, so please
feel free to do whatever you wish to my code.

Thank you,
Lucas

---------------------------------------------------------------------------------------------------------

KNOWN ISSUES:

	1. There is no current implementation of the Derksen-Gandini algorithm.
	2. Typing exit doesn't always work
	3. Crashes are not handled gracefully 
	4. Not all inputs are validated, therefore it is possible to input something that will
		crash the program.
	5. No implementation of the Parallel Algorithm
	6. No implementation of the random generators.
	7. Information is not saved, including preferences

---------------------------------------------------------------------------------------------------------

PLANNED FEATURES:

	-Derksen-Gandini Algorithm
	-Parallel Algorithm
	-Random mode, where you can generate a specified amount of random scenarios and find invariants
		-Potential to use Automated Conjecture Theory to make conjectures about these systems?
	-Storage of session information,
	-Executable file to double click on instead of through command line
	-Potential GUI outside of the terminal?
	-Better coding practices, cleaner code.
	-Better output messages for the algorithms section (sorry Sam, I'm going to change things up)
