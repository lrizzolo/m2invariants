needsPackage "InvariantRing"

--def method echo
echo = method()

--Method for printing one net
echo Net := n -> (<< n;)

--Method for printing two nets together
--@param n1 the first net to be printed
--@param n2 the second net to be printed
echo (Net, Net) := (n1, n2) -> (<< n1 << n2;)

echo("You said"," potato")

