--NAME:             printSig.m2
--DESCRIPTION:      Adds functionality for printing the signature and exit codes
--AUTHORS:          Lucas Rizzolo
--LAST MODIFIED:    Thurs Jul 28

--Get the K College logo for the signature
s1 = get "./men/kSymb.txt"

--Function for restart that supresses String AfterPrint
--that also prints the signature
rest = i ->(String#{Standard,AfterPrint}=r-> r; <<s1<<"\n";)

--Adds the function to the restart
addStartFunction rest

--Functions for printing exit message before exit
extt = i ->(<<"\nGoodbye friend!\n")
addEndFunction extt
