-module(terminal2).
-export([product_range/2, pieces/1]).

product_range(M, N) when M > N -> product_range(N, M);
product_range(M, N) when M =:= N -> M*N;
product_range(M, N) ->
   M * product_range(M + 1, N).

pieces(N) when N =:= 1 -> 2;
pieces(N) ->
    pieces(N-1) + N.
