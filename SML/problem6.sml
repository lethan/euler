(* en bedre løsning *)

fun dif (0, a) = a
  | dif (n, a) = dif (n-1, a + n*n);

fun calcProblem6 n = let 
                        val a = n + 1
	             in 
                       (n*n*a*a div 4) - dif (n, 0)
		     end;