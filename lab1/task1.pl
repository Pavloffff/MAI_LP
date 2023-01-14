length([],0).
length([X|T],N) :- length(T,N1), N is N1+1.

member(A, [A|_]).
member(A, [_|Z]) :- member(A, Z).

append([], L, L).
append([X|T], L, [X|R]) :- append(T, L, R).

remove(X, [X|T], T).
remove(X, [Y|T], [Y|T1]) :- remove(X, T, T1).

permute([], []).
permute(L, [X|T]) :- remove(X, L, R), permute(R, T).

sublist(R, L) :- append(_, T, L), append(R, _, T).

shiftRightSt(L, N, S) :-
    append(X, Y, L),
    length(Y, N),
    append(Y, X, S).

delFirst([_|[]]).
delFirst([H|T]) :- 
    write(H), 
    write(" "),
    delFirst(T).

delLast([_|T]) :- delLast(T).
delLast([T]) :- write(T).

shiftRightNSt([H|T]) :- 
    delLast(T),
    write(" "),
    write(H),
    write(" "),
    delFirst(T).

min([H],H).
min([H|T],H) :- min(T,N), H < N, !.
min([_|T],N) :- min(T,N).

p(X) :- member(X, [1,2,3,4,5]), X > 3, !.
