parent(alice, bob).
parent(alice, betsy).
parent(alice, bill).
parent(bob, carl).
parent(bob,charlie).
parent(albert,bob).
parent(albert,betsy).
parent(albert,bill).
get_grandchild:-
parent(albert , X),
parent(X,Y),
write('alberts gc is'),
write(Y), nl.
