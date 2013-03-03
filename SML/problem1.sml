(* If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.

Find the sum of all the multiples of 3 or 5 below 1000.*)

(* Opgaven er løst i O(1) = optimal løsning *)

fun gcd (a, 0) = a
  | gcd (a, b) = gcd (b, a mod b);

fun sum n a = 
   let 
     val elementer = n div a
     val dubletter = elementer div 2
   in 
     if (elementer mod 2) = 1 then dubletter * (elementer+1) + dubletter + 1 else dubletter * (elementer+1)
   end;
     

fun calcProblem1 n a b = (* n = alle tal skal være under denne. a = først tal der skal kunne deles med, b = anden tal der skal kunne deles med *)
   let
     val lcm = a*b div gcd(a,b)
     val m = n - 1
   in
     a*(sum m a) + b*(sum m b) - lcm*(sum m lcm)
   end;