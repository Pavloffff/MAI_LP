/*
9. Реализовать разбор фраз языка (вопросов), выделяя в них неизвестный объекты
………………………………………………………………………………………………
Запрос: 
?- an_q([“Кто”, “любит”, “шоколад” “?”],X)
?- an_q([“Где”, “лежат”, “деньги” “?”],X)
?- an_q([“Что”,я “любит”, “Даша” “?”],X)
Результат: 
X=’любить’(agent(Y), object(’шоколад’)),
X=’лежать’(object(‘деньги’), loc(X)),
X=’любить’(agent(“Даша”), object(Y)). 
*/

% agent - кто?
% object - что?
% loc - место?

% Фраза - Вопросное_Слово Действие Объект/Агент/Место/Время '?'


concatenate(StringList, StringResult) :-
    maplist(atom_chars, StringList, Lists),
    append(Lists, List),
    atom_chars(StringResult, List).

gl('любить', ['любить', 'любит', 'любима']).
gl('лежать', ['лежать', 'лежит', 'лежат']).
gl('хотеть', ['хочешь', 'хотите', 'хотят']).

find_form(Form, Res) :-
    gl(Res, List),
    member(Form, List).

quest('Кто', agent).
quest('Кому', agent).
quest('Кого', agent).
quest('Чей', agent).

quest('Что', object).
quest('Чего', object).
quest('Чему', object).

quest('Где', loc).

write_verb(Act, FPred, FArg, SPred, SArg, Res) :-
    concatenate([Act, '(', FPred, '(', FArg, '), ', SPred, '(', SArg, ')', ')'], Res).

verb(agent, SType, S, Act, Res) :-
    write_verb(Act, agent, 'Y', SType, S, Res).
verb(object, SType, S, Act, Res) :-
    write_verb(Act, SType, S, object, 'Y', Res).
verb(loc, SType, S, Act, Res) :-
    write_verb(Act, SType, S, loc, 'Y', Res).

s('тут', loc).
s('там', loc).
s('здесь', loc).
s('поблизости', loc).

s('Даша', agent).

s('шоколад', object).
s('деньги', object).


an_q([QuestWord, Action, S, '?'], X) :-
    find_form(Action, NormAction),
    quest(QuestWord, Q),
    s(S, SType),
    verb(Q, SType, S, NormAction, X).

