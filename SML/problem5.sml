(* en god løsning *)

use "unboundint.sml";

fun gcd (a, b) = if isZero(b) then a else gcd (b, a modU b);

fun lcm (a, b) = (a ** b) // gcd (a, b);

fun smallestNumber (n, lm) = 
                       let 
		          val tmp = lcm(n,lm)
		       in
		          if isZero n then lm else if tmp >> lm then smallestNumber(n -- (fromInt 1), tmp) else smallestNumber(n -- (fromInt 1), lm)
		       end;

fun calcProblem5 lessthan = toString(smallestNumber (fromInt lessthan, fromInt(1)));