-module(terminal3).
-export([append/2, merge/2, ms/1, ms/2,
build/2, product/1, product/2, prod/1, member/2, greater/2]).

% Seminar 2
append([], Ys) -> Ys;
append([X|Xs], Ys) -> [X|append(Xs, Ys)].

merge([], Ys) -> Ys;
merge(Xs, []) -> Xs;
merge([], []) -> [];
merge([X|Xs], [Y|Ys]) when X >= Y -> [Y|merge([X|Xs], Ys)];
merge([X|Xs], [Y|Ys]) when X < Y -> [X|merge(Xs, [Y|Ys])].

ms(L) ->
    {N, M} = lists:split(length(L) div 2, L),
    ms(N, M).

ms([X],[Y]) when X >= Y -> [Y,X];
ms([X],[Y]) when Y > X -> [X,Y];
ms([], [L]) -> [L];
ms([L], []) -> [L];
ms(N, M) ->
    merge(ms(N), ms(M)).

% Practical 3
build(N, M) when N > M -> build(M, N);
build(N, M) when N == M -> [M];
build(N, M) -> lists:append([N], build(N+1, M)).

product([]) -> 0;
product([X]) -> X;
product([X|Xs]) -> product(X, Xs).
product(N, [X]) when N >= X -> N;
product(N, [X]) when X >= N -> X;
product(N, [X|Xs]) when N >= X -> product(N,Xs);
product(N, [X|Xs]) when X > N -> product(X,Xs).

%second way to do "product" function
prod([]) -> 0;
prod([X]) -> X;
prod([X|Xs]) -> T = prod(Xs),
    if T >= X -> T;
    true -> X
    end.

member(N, [X|_]) when X == N -> true;
member(N, [X|Xs]) when X=/= N -> member(N, Xs);
member(N, [X]) when X == N -> true;
member(_, _) -> false.

greater(_, []) -> [];
greater(N, [X|Xs]) when X > N -> lists:append([X], greater(N, Xs));
greater(N, [_|Xs]) -> greater(N, Xs).
