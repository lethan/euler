(* en løsning *)

use "unboundint.sml";

fun palindrome str = if size str <= 1 then true else if String.sub (str,0) = String.sub (str, (size str) - 1) then palindrome (String.substring (str,1,(size str)-2)) else false;

fun power 0 a = 1
  | power n a = a*power (n-1) a;

fun calcProblem4 n = let
                        fun values a b max sum = let 
			                            val produkt = a**b
						 in
						    if 
						       a >> max 
						    then 
						       sum 
						    else 
						       if 
						          b >> max 
						       then 
						          values (a++fromInt 1) (a++fromInt 1) max sum 
						       else 
						          if 
							     palindrome (toString(produkt)) 
							  then 
							     values a (b++fromInt 1) max (if produkt >> sum then produkt else sum)
							  else
					         	     values a (b++fromInt 1) max sum
					         end
			val maxval = fromInt((power (n) 10) - 1)
			val minval = fromInt(power (n-1) 10)
		     in
		        toString(values minval minval maxval zero)
		     end;
;