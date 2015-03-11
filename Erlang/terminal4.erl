-module(terminal4).
-export([doubleAll/1,event/1, member/2, largest_peri/1]).

% Seminar functions



% Trerminal 4 functions
double(X) -> 2 * X.
doubleAll(L) -> lists:map(fun double/1, L).

isPair(X) when X rem 2 == 0 -> true;
isPair(_) -> false.
event(L) -> lists:filter(fun isPair/1, L).

member(_, []) -> false;
member(N, [X|_]) when X == N -> true;
member(N, [_|Xs]) -> member(N, Xs).


% TODO : Not working
%match rectangle
peri({_, _, X, Y}) -> 2 * X + 2 * Y;
%match cercle
peri({_, _, Z}) -> math:pi() * Z * Z.
largest_peri([X]) -> X;
largest_peri([X|Xs]) ->
    T = peri(X),
    T2 = largest_peri(Xs),
    if T >= T2 -> X;
    true -> largest_peri(Xs)
    end.
