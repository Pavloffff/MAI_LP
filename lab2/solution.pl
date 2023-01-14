head([X], X).
head([H|T], H).

remove([], K, []).
remove([K|T], K, R) :- remove(T, K, R), !.
remove([H|T], K, [H|R]) :- remove(T, K, R).

intersection([],_,[]).
intersection([H|T],Y,[H|R]) :-
    member(H,Y),
    intersection(T,Y,R), !.
intersection([_|T],Y,R) :-
    intersection(T,Y,R).

delete_occurrences_sph(_,[],[]).
delete_occurrences_sph(H,[H|T],T1):-
    delete_occurrences_sph(H,T,T1).
delete_occurrences_sph(H,[X|T],[X|T1]):-
    not(H=X),
    delete_occurrences_sph(H,T,T1).
 
delete_occurrences([],L,L).
delete_occurrences([H|T],L,R):-
    delete_occurrences_sph(H,L,T1),
    delete_occurrences(T,T1,R).

closed(shoe, 1).
closed(hardware, 2).
closed(grocery, 4).
closed(prefume, 2).
closed(prefume, 4).
closed(shoe, 7).
closed(hardware, 7).
closed(grocery, 7).
closed(prefume, 7).

shops_close_today(X, L) :-
    findall(Y, closed(Y, X), L).

shops_open_today(X, L) :-
    findall(Y, closed(Y, X), L1),
    delete_occurrences(L1, [shoe, hardware, grocery, prefume], L).

days_shops_closed(S, L) :-
    findall(X, closed(S, X), L).

days_shops_opened(S, L) :-
    days_shops_closed(S, L1),
    delete_occurrences(L1, [1,2,3,4,5,6,7], L).

day_opened(X) :-
    days_shops_opened(shoe, L1),
    days_shops_opened(hardware, L2),
    days_shops_opened(grocery, L3),
    days_shops_opened(prefume, L4),
    intersection(L1, L2, R1),
    intersection(L3, L4, R2),
    intersection(R1, R2, [R|T]),
    head([R|T], X).

solve_klava(X, R) :-
    X1 is X - 1,
    shops_open_today(X1, R1),
    X2 is X1 - 1,
    shops_open_today(X2, R2),
    intersection(R1, R2, R3),
    head(R3, R).

solve_jenya(X, R) :-
    X1 is X - 1,
    shops_open_today(X1, R1),
    X2 is X + 1,
    shops_open_today(X2, R2),
    intersection(R1, R2, R3),
    head(R3, R).

solve_ira(X, R) :-
    X1 is X + 1,
    findall(T, closed(T, X1), L),
    solve(klava, RK),
    solve(jenya, RJ),
    remove(L, RK, R1),
    remove(R1, RJ, R2),
    head(R2, R).

solve(klava, R) :-
    day_opened(X),
    solve_klava(X, R).

solve(jenya, R) :-
    day_opened(X),
    solve_jenya(X, R).

solve(ira, R) :-
    day_opened(X),
    solve_ira(X, R).

solve(asa, R) :-
    solve(klava, RK),
    solve(jenya, RJ),
    solve(ira, RI),
    remove([shoe, grocery, hardware, prefume], RK, R1),
    remove(R1, RJ, R2),
    remove(R2, RI, R3),
    head(R3, R).