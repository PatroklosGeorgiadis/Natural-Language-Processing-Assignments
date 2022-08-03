expression(Value) --> number(X), {list_to_number(X,Value,_)}.
expression(Value) --> number(X), [+], expression(V),{list_to_number(X,A,_), Value is A+V}.
expression(Value) --> number(X), [-], expression(V),{list_to_number(X,A,_), Value is A-V}.
expression(Value) --> number(X), [*], expression(V),{list_to_number(X,A,_), Value is A*V}.
expression(Value) --> number(X), [/], expression(V),{list_to_number(X,A,_), V\=0, Value is A/V}.
expression(Value) --> left_parenthesis,expression(Value),right_parenthesis.

left_parenthesis --> ['('].
right_parenthesis --> [')'].

number(X) --> digit(I),{X=[I]}.
number(Value) --> digit(X),number(Y),{append([X],Y,Value)}.

digit(0) --> [0].
digit(1) --> [1].

list_to_number([],0,1).
list_to_number([H|T],N,C):-
     list_to_number(T,N1,C1),C is C1*2,N is N1+H*C1.

decimal_to_binary(0,V,_,V).
decimal_to_binary(D,V,C,N):-
     Digit is D mod 2,D1 is D//2,V1 is V+Digit*(10^C),
     C1 is C+1,
     decimal_to_binary(D1,V1,C1,N).

f_result(Decimal,Binary):- decimal_to_binary(Decimal,0,0,Binary).
