:- ['Pavlovs.pl'].

rodstvo(X, Y) :-
    parents(X, _, Y); 
    parents(Y, X, _); 
    parents(Y, _, X); 
    parents(X, Y, _).

prolong([H|T], [New, H|T]) :-
    rodstvo(H, New),
    not(member(New, [H|T])).

bfs([[F|T]|_], F, [F|T]).
bfs([R|S], F, R1):-
    findall(W, prolong(R,W), J),
    append(S, J, K),
    bfs(K, F, R1).

map(child, X, Y) :-
    parents(Y, X, _);
    parents(Y, _, X).

map(dad, X, Y) :-
    parents(X, Y, _).

map(mom, X, Y) :-
    parents(X, _, Y).

mapping([_], []).
mapping([X,Y|T], [R1|R]) :-
    map(R1, X, Y),
    mapping([Y|T], R).

parent(mom).
parent(dad).

sophisticatedMap(cousin, [P1, P2, child, child]) :-
    parent(P1),
    parent(P2).

sophisticatedMap(sibling, [P1, child]) :-
    parent(P1).

searchSophMap(R, R1) :-
    append(S, X, R), append(Y, E, X),
    sophisticatedMap(T1, Y),
    append(S, [T1|E], T),
    searchSophMap(T, R1).
searchSophMap(R, R).

relative(T, X, Y) :-
    bfs([[X]], Y, RP),
    reverse(RP, R1),
    mapping(R1, R),
    searchSophMap(R, T).
