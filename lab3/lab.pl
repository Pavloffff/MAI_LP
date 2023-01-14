move([[HLeft|TLeft], Tupik, Right], [TLeft, [HLeft|Tupik], Right]).
move([Left, [HTupik|TTupik], Right], [Left, TTupik, [HTupik|Right]]).
move([[HLeft|TLeft], Tupik, Right], [TLeft, Tupik, [HLeft|Right]]).

prolong([X|T], [Y,X|T]) :-
    move(X, Y),
    not(member(Y, [X|T])).

end_state([], [], _).
end_state([_ | [_ | Tail]], [w|[b|EndState]], w) :-
    end_state(Tail, EndState, w).
end_state([_ | [_ | Tail]], [b|[w|EndState]], b) :-
    end_state(Tail, EndState, b).

% Поиск в глубину
ddts([X|T], X, [X|T]).
ddts(P, Y, R) :-
    prolong(P, P1),
    ddts(P1, Y, R).

dfs(State) :-
    end_state(State, EndState, w),
    ddts([[State, [], []]], [[], [], EndState], Path),
    write(Path), write('\n').

dfs(State) :-
    end_state(State, EndState, b),
    ddts([[State, [], []]], [[], [], EndState], Path),
    write(Path), write('\n').

% Поиск в ширину
bdts([[X|T]|_], X, [X|T]).
bdts([P|QI], X, R) :-
    findall(Z, prolong(P, Z), T),
    append(QI, T, QO),
    bdts(QO, X, R).

bfs(State) :-
    end_state(State, EndState, w),
    bdts([[[State, [], []]]], [[], [], EndState], Path),
    write(Path), write('\n').

bfs(State) :-
    end_state(State, EndState, b),
    bdts([[[State, [], []]]], [[], [], EndState], Path),
    write(Path), write('\n').

% Поиск в глубину с итеративным погружением
search_id(Start, Finish, Path, Limit) :-
    between(1, Limit, Level),
    depth_id([Start], Finish, Path, Level).

depth_id([Finish|T], Finish, [Finish|T], 0).
depth_id(Path, Finish, R, N) :-
    N > 0,
    prolong(Path, NewPath),
    N1 is N - 1,
    depth_id(NewPath, Finish, R, N1).

itdfs(State, Limit) :-
    end_state(State, EndState, w),
    search_id([State, [], []], [[], [], EndState], Path, Limit),
    write(Path), write('\n').

itdfs(State, Limit) :-
    end_state(State, EndState, b),
    search_id([State, [], []], [[], [], EndState], Path, Limit),
    write(Path), write('\n').
