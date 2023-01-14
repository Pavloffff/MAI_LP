:- ['three.pl'].

append([], L, L).
append([X|T], L, [X|R]) :- append(T, L, R).

member(A, [], 0).
member(A, [A|_], 1).
member(A, [_|Z], X) :- member(A, Z, X).

not(0, 1).
not(_, 0).

length([],0).
length([H|T],N) :- length(T,N1), N is N1+1.

sum([], 0).
sum([H|T], N) :- sum(T, N1), N is N1+H.

max([H],H).
max([H|T],H) :- max(T,N), H > N, !.
max([_|T],N) :- max(T,N).

concat([], L2, L2).
concat([H|T], L2, [H|T1]) :-
    concat(T, L2, T1).

pass(X, "Не сдал") :- X = 0.
pass(X, "Сдал") :- X = 1.

grades_stud(Num, L) :-
    findall(X, student(_, Num, [grade('LP',X),grade('MTH',_),grade('FP',_),grade('INF',_),grade('ENG',_),grade('PSY',_)]), LP),
    findall(X, student(_, Num, [grade('LP',_),grade('MTH',X),grade('FP',_),grade('INF',_),grade('ENG',_),grade('PSY',_)]), M),
    findall(X, student(_, Num, [grade('LP',_),grade('MTH',_),grade('FP',X),grade('INF',_),grade('ENG',_),grade('PSY',_)]), F),
    findall(X, student(_, Num, [grade('LP',_),grade('MTH',_),grade('FP',_),grade('INF',X),grade('ENG',_),grade('PSY',_)]), I),
    findall(X, student(_, Num, [grade('LP',_),grade('MTH',_),grade('FP',_),grade('INF',_),grade('ENG',X),grade('PSY',_)]), E),
    findall(X, student(_, Num, [grade('LP',_),grade('MTH',_),grade('FP',_),grade('INF',_),grade('ENG',_),grade('PSY',X)]), P),
    concat(LP, M, A),
    concat(F, I, B),
    concat(E, P, C),
    concat(A, B, D),
    concat(C, D, L1),
    concat([Num], L1, L).

stud_passed(X, R) :-
    grades_stud(X, [H|T]),
    member(2, T, P),
    not(P, R).

stud_sum_grades(X, R) :-
    grades_stud(X, [H|T]),
    sum(T, R).

stud_cnt_grades(X, R) :-
    grades_stud(X, [H|T]),
    length(T, R).

stud_avg_grade(X, R) :- 
    stud_sum_grades(X, S),
    stud_cnt_grades(X, C),
    R is S/C.

avg_print([]).
avg_print([H|T]) :-
    stud_avg_grade(H, R),
    stud_passed(H, P),
    pass(P, P1),
    write(H),
    write(" | "),
    write(R),
    write(" | "),
    write(P1),
    write('\n'),
    avg_print(T).


task1(S) :-
    findall(S, student(_, S, _), L),
    write("Студент | Средний балл | Cдал/не сдал\n"),
    avg_print(L).


task2(L) :-
    findall(X, student(_, X, [grade('LP',2),grade('MTH',_),grade('FP',_),grade('INF',_),grade('ENG',_),grade('PSY',_)]), LP),
    findall(X, student(_, X, [grade('LP',_),grade('MTH',2),grade('FP',_),grade('INF',_),grade('ENG',_),grade('PSY',_)]), MTH),
    findall(X, student(_, X, [grade('LP',_),grade('MTH',_),grade('FP',2),grade('INF',_),grade('ENG',_),grade('PSY',_)]), FP),
    findall(X, student(_, X, [grade('LP',_),grade('MTH',_),grade('FP',_),grade('INF',2),grade('ENG',_),grade('PSY',_)]), INF),
    findall(X, student(_, X, [grade('LP',_),grade('MTH',_),grade('FP',_),grade('INF',_),grade('ENG',2),grade('PSY',_)]), ENG),
    findall(X, student(_, X, [grade('LP',_),grade('MTH',_),grade('FP',_),grade('INF',_),grade('ENG',_),grade('PSY',2)]), PSY),
    length(LP, LPL),
    length(MTH, MTHL),
    length(FP, FPL),
    length(INF, INFL),
    length(ENG, ENGL),
    length(PSY, PSYL),
    write('Логическое программирование: '),
    write(LPL),
    write('\n'),
    write('Математический анализ: '),
    write(MTHL),
    write('\n'),
    write('Функциональное программирование: '),
    write(FPL),
    write('\n'),
    write('Информатика: '),
    write(FPL),
    write('\n'),
    write('Английский язык: '),
    write(FPL),
    write('\n'),
    write('Психология: '),
    write(PSYL),
    write('\n').



grades_stud2(Num, L) :-
    findall(X, student(_, Num, [grade('LP',X),grade('MTH',_),grade('FP',_),grade('INF',_),grade('ENG',_),grade('PSY',_)]), LP),
    findall(X, student(_, Num, [grade('LP',_),grade('MTH',X),grade('FP',_),grade('INF',_),grade('ENG',_),grade('PSY',_)]), M),
    findall(X, student(_, Num, [grade('LP',_),grade('MTH',_),grade('FP',X),grade('INF',_),grade('ENG',_),grade('PSY',_)]), F),
    findall(X, student(_, Num, [grade('LP',_),grade('MTH',_),grade('FP',_),grade('INF',X),grade('ENG',_),grade('PSY',_)]), I),
    findall(X, student(_, Num, [grade('LP',_),grade('MTH',_),grade('FP',_),grade('INF',_),grade('ENG',X),grade('PSY',_)]), E),
    findall(X, student(_, Num, [grade('LP',_),grade('MTH',_),grade('FP',_),grade('INF',_),grade('ENG',_),grade('PSY',X)]), P),
    concat(LP, M, A),
    concat(F, I, B),
    concat(E, P, C),
    concat(A, B, D),
    concat(C, D, L).

sum_student_grades([], 0).
sum_student_grades(Num, R) :-
    grades_stud2(Num, L),
    sum(L, R).

set([], []):-!.
set([X|X1], Y):-
      member(X, X1),
      !, set(X1, Y).
set([X|X1], [X|Y]):-
      !, set(X1, Y).

group_stud_list(Num, L) :- 
    findall(X, student(Num, X, Y), L).

max_grade([], 0).
max_grade([H|T], N) :-
    max_grade(T, B),
    sum_student_grades(H, A),
    A =< B, N is B.
max_grade([H|T], N) :-
    max_grade(T, B),
    sum_student_grades(H, A),
    A >= B, N is A.

max_grade_group([]).
max_grade_group([H|T]) :-
    group_stud_list(H, X),
    max_grade(X, N),
    findall(Y, (student(H, Y, _), sum_student_grades(Y, N)), L),
    write(H),
    write(": "),
    write(L),
    write("\n"),
    max_grade_group(T).

task3() :-
    findall(X, student(X, Y, Z), L1),
    set(L1, L2),
    max_grade_group(L2).