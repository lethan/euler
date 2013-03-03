(* Opgaven er løst optimalt O(n) *)

fun fib (x, y, lessthan, total) = 
             let 
	        val sum = x + y
             in
	        if sum > lessthan then total else fib (x + 2*y, 2*x + 3*y, lessthan, total + sum)
             end;


fun calcProblem2 lessthan = fib (1, 1, lessthan, 0);