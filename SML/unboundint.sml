load "Int";
load "String";

signature UnboundInteger = 
sig
   type unboundint
   val toString		: unboundint -> string
   val fromString	: string -> unboundint
   val fromInt		: int -> unboundint
   val zero		: unboundint
   val isZero		: unboundint -> bool
   val ++		: unboundint * unboundint -> unboundint
   val --		: unboundint * unboundint -> unboundint
   val **		: unboundint * unboundint -> unboundint
   val divmodU          : unboundint * unboundint -> unboundint * unboundint (* Raise Div *)
   val //		: unboundint * unboundint -> unboundint (* Raise Div *)
   val modU		: unboundint * unboundint -> unboundint (* Raise Div *)
   val ==		: unboundint * unboundint -> bool
   val <<		: unboundint * unboundint -> bool
   val >>		: unboundint * unboundint -> bool
   val <<==		: unboundint * unboundint -> bool
   val >>==		: unboundint * unboundint -> bool
end

(*structure UnboundInteger : UnboundInteger = 
struct *)
   datatype fortegn = POSITIV | NEGATIV;
   type unboundint = fortegn * int list;

   val base = 1000; (*32768;*)

   fun controlFortegn (NEGATIV, []) = (POSITIV, [])
     | controlFortegn (x      ,  y) = (x, y);

   fun clean (fortgn, a) = 
      let
         fun controlList (   [], y, z) = rev y
	   | controlList (x::xs, y, z) = if x = 0 then controlList(xs, y, x::z) else controlList(xs, x::z@y, [])
      in 
	 controlFortegn(fortgn, controlList (a, [], []))
      end;

   val zero = (POSITIV, []);

   fun isZero (POSITIV, []) = true
     | isZero            _  = false;

   fun fraInt base x = 
         let
	    val fortegn = if x < 0 then NEGATIV else POSITIV
	    val y = if fortegn = NEGATIV then x * ~1 else x
	    fun tmp z = if z div base = 0 then [z] else (z mod base)::tmp (z div base)
	 in
	    clean(fortegn, tmp y)
	 end;

   fun fromInt x = fraInt base x;

   fun compare((POSITIV, _), (NEGATIV, _)) = GREATER : order
     | compare((NEGATIV, _), (POSITIV, _)) = LESS
     | compare( (fortgn, x),       (_, y)) = 
          let
	    fun test (   [],    [], status) = status
	      | test (   [], y::ys,      _) = if fortgn = POSITIV then LESS else GREATER
	      | test (x::xs,    [],      _) = if fortgn = POSITIV then GREATER else LESS
	      | test (x::xs, y::ys, status) = if x=y then test (xs, ys, status) else if x < y then test (xs, ys, if fortgn = POSITIV then LESS else GREATER) else test (xs, ys, if fortgn = POSITIV then GREATER else LESS)
	  in
            test (x, y, EQUAL)
	  end;

   fun op == (x, y) = compare(x,y) = EQUAL;
   
   fun op << (x, y) = compare(x,y) = LESS;

   fun op >> (x, y) = compare(x,y) = GREATER;

   fun op <<== (x, y) = compare(x,y) <> GREATER;

   fun op >>== (x, y) = compare(x,y) <> LESS;

   infix 4 ==;
   infix 4 <<;
   infix 4 >>;
   infix 4 <<==;
   infix 4 >>==; 

   local
     fun sum (ba,    [],    [], mente) = [mente]
       | sum (ba, x::xs,    [], mente) = ((x+mente) mod ba)::sum(ba,xs, [], (x+mente) div ba)
       | sum (ba,    [],     y, mente) = sum (ba, y, [], mente)
       | sum (ba, x::xs, y::ys, mente) = ((x+y+mente) mod ba)::sum(ba, xs, ys, (x+y+mente) div ba)

     fun diff (ba,    [],    [], laan) = [laan]
       | diff (ba, x::xs,    [], laan) = ((x+laan) mod ba)::diff(ba, xs, [], (x+laan) div ba)
       | diff (ba, x::xs, y::ys, laan) = ((x-y+laan) mod ba)::diff(ba, xs, ys, (x-y+laan) div ba)
   in 
     fun plus base ((POSITIV, a), (POSITIV, b)) = clean(POSITIV, sum (base, a, b, 0))
       | plus base ((POSITIV, a), (NEGATIV, b)) = if (POSITIV, a) >>== (POSITIV, b) then clean(POSITIV, diff(base, a, b, 0)) else clean(NEGATIV, diff(base, b, a, 0))
       | plus base ((NEGATIV, a), (NEGATIV, b)) = clean (NEGATIV, sum(base, a, b, 0))
       | plus base ((NEGATIV, a), (POSITIV, b)) = plus base ((POSITIV, b), (NEGATIV, a))

     fun minus base ((NEGATIV, a), (NEGATIV, b)) = if  (POSITIV, b) >>== (POSITIV, a) then clean(POSITIV, diff(base, b, a, 0)) else clean(NEGATIV, diff(base, a, b, 0))
       | minus base ((NEGATIV, a), (POSITIV, b)) = clean(NEGATIV, sum (base, a, b, 0))
       | minus base ((POSITIV, a), (NEGATIV, b)) = clean(POSITIV, sum (base, a, b, 0))
       | minus base ((POSITIV, a), (POSITIV, b)) = minus base ((NEGATIV, b), (NEGATIV, a))
   end;

   fun op ++ (x, y) = plus base (x, y);

   fun op -- (x, y) = minus base (x, y);

   infix 6 ++;
   infix 6 --;
   
   local
     fun produkt ( _, 0, _,     _,     _) = []
       | produkt ( _, _, 0,    [], mente) = [mente]
       | produkt (ba, x, 0, y::ys, mente) = ((x*y + mente) mod ba) :: produkt(ba, x, 0, ys, (x*y + mente) div ba)
       | produkt (ba, x, n,    ys, mente) = 0::produkt(ba, x, n-1, ys, mente)

     fun multi (ba,    [], _, _, z) = z
       | multi (ba, x::xs, y, n, z) = multi(ba, xs, y, n+1, plus ba ((POSITIV, produkt (ba, x, n, y, 0)), z))

   in
     fun gange base ((POSITIV, a), (NEGATIV, b)) = if (POSITIV, a) >>== (POSITIV, b) then let val (_,z) = multi (base, b, a, 0, (POSITIV, [])) in (NEGATIV,z) end else let val (_,z) = multi (base, a, b, 0, (POSITIV, [])) in (NEGATIV,z) end
       | gange base ((NEGATIV, a), (POSITIV, b)) = gange base ((POSITIV, b), (NEGATIV, a))
       | gange base ((      _, a), (      _, b)) = if (POSITIV, a) >>== (POSITIV, b) then multi (base, b, a, 0, (POSITIV, [])) else multi (base, a, b, 0, (POSITIV, []))
   end;

   fun op ** (x, y) = gange base (x,y);
   
   infix 7 **;

   fun tilMakrociffer (base,    [], y) = y
     | tilMakrociffer (base, x::xs, y) = tilMakrociffer(base, xs, base*y + x);

   fun divmod (ba, x, (POSITIV, [])) = raise Div
     | divmod (ba, x, y)             = if x << y then (0, x) else 
                                       let
                                          fun seek (a, b) = if b<=a then a else
					                    let
					                       val midt = (a+b+1) div 2
					                       val sk   = y ** fromInt midt
					                    in
					                       if sk >> x then seek(a,midt-1) else if sk == x then midt else seek(midt, b)
					                    end
					  
					  val sk = seek(0, ba-1)
				       in
					  (sk, x--y**fromInt sk)
				       end;

   local
     fun helper (_ ,    [], _, v, w) = (v, w)
       | helper (ba, z::zs, y, v, w) = let
			                 val (q,(_,r)) = divmod(ba, (POSITIV, rev(w@[z])), (POSITIV, y))
			               in
				         helper(ba, zs, y, q::v, rev(r)) 
				       end

   in
     fun division base ((fx, x), (fy, y)) = let
                                              val (q,r) = helper(base, (rev (x)),y,[],[])
				              val fortegn = if fx = fy then POSITIV else NEGATIV
					    in
					      (clean((fortegn, q)), clean((fortegn, rev r)))
					    end
   end;
   
   fun divmodU (x,y) = division base (x,y);

   fun op // (x, y) = #1 (divmodU(x,y));

   infix 7 //;

   fun op modU (x, y) = #2 (divmodU(x,y));

   infix 7 modU;

   fun convertBase (x, fraBase, tilBase) = let
                                             val (q, (_, r)) = division fraBase (x, fraInt fraBase tilBase)
					     val (_, liste)  = fraInt tilBase (tilMakrociffer(fraBase, rev r, 0))
					     val resu = if liste = [] then [0] else liste
					   in
					     if isZero q then resu else resu @ convertBase(q, fraBase, tilBase)
					   end;

   fun appendZero x = if size x < 3
                      then appendZero("0"^x)
	              else x;

   fun removeZero x = if size x > 1
                      then 
			if String.sub (x,0) = #"0"
		        then removeZero(String.substring(x,1,size x-1))
		        else x
		      else 
			x;


   fun unboundTilStreng [] = "0"
     | unboundTilStreng (x::xs) = unboundTilStreng (xs) ^ appendZero (Int.toString (x));

   fun toString	(x) = let
                         val (fortegn, _) = x;
                         val fortgn = if fortegn = NEGATIV then "-" else ""
                         val streng  = removeZero(unboundTilStreng(convertBase(x, base, 1000)))
		      in
			 fortgn^streng
		      end;

   fun strengTilListe x = if size x > 3
			  then valOf (Int.fromString (String.substring (x,size x-3,3))) :: strengTilListe (String.substring (x,0,size x - 3))
			  else valOf (Int.fromString x) :: [];

   fun fromString x = let
                        val fortegn = if String.sub (x,0) = #"-" then NEGATIV else POSITIV
			val liste = if fortegn = NEGATIV then strengTilListe (String.substring(x,1,size x-1)) else strengTilListe(x)
		      in
		        clean(fortegn, convertBase((fortegn, liste), 1000, base))
		      end;
(*end

open UnboundInteger; *)
infix 7 **;
infix 7 //;
infix 7 modU;
infix 6 ++;
infix 6 --;
infix 4 ==;
infix 4 <<;
infix 4 >>;
infix 4 <<==;
infix 4 >>==;

(* fun potmodulo (b,a,m)  (* b i a-te potens modulo m *)
    = if isZero a then fromInt 1 else if a modU (fromInt 2) == zero then potmodulo (b ** b modU m,a // (fromInt 2),m)
       else b ** potmodulo (b,a -- (fromInt 1),m) modU m;


fun udveuklid (a,b)    (* (s,t), så s*a+t*b = gcd (a,b) *)
    = if isZero a then (fromInt 0,fromInt 1)
      else let val d = b // a
	   val m = b modU a
           val (s,t) = udveuklid (m,a) 
           in (t -- s ** d,s) end;

fun invers (a,m) = let val b = #1 (udveuklid (a,m)) 
                   in if b << zero then b ++ m else b end;

val e = "9007";
val n = "114381625757888867669235779976146612010218296721242362562561842935706935245733897830597123563958705058989075147599290026879543541";
val y = "96869613754622061477140922254355882905759991124574319874695120930816298225145708356931476622883989628013391990551829945157815154";
val p = "3490529510847650949147849619903898133417764638493387843990820577";
val q = "32769132993266709549961988190834461413177642967992942539798288533";

val e = fromString e;
val n = fromString n;
val y = fromString y;
val p = fromString p;
val q = fromString q;

val m = (p-- fromInt 1)**(q-- fromInt 1) // fromInt 2;
val d = invers(e,m);
val result = toString (potmodulo (y,d,n)); *)
