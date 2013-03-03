(* en god løsning *)

use "unboundint.sml";

use "sieve.sml";

fun findNumber number sieve = if 
                                 let
				    val tmp = fromInt (Sieve.value sieve)
				 in
                                    tmp**tmp >> number
				 end
                              then 
			         toString(number) 
			      else 
			         if 
				    isZero(number modU fromInt (Sieve.value sieve)) 
			         then
				    findNumber (number // fromInt (Sieve.value sieve)) sieve
				 else
				    findNumber number (Sieve.next sieve);

fun calcProblem3 n = let
                        val number = fromString n
			val primes = Sieve.start
		     in
		        findNumber number primes
	             end;