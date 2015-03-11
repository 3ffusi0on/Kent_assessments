-module(seminar1).
-export([maxThree/3, howManyEqual/3, result/2]).


maxTwo(X, Y) when X > Y -> X;
maxTwo(X, Y) when X < Y -> Y.

maxThree(X, Y, Z) ->
    maxTwo(maxTwo(X, Y), Z).


howManyEqual(X, X, _) -> 2;
howManyEqual(X, _, X) -> 2;
howManyEqual(_, Y, Y) -> 2;
howManyEqual(Y, Y, Y) -> 3;
howManyEqual(_, _, _) -> 0.

%--------------------------------------

beat(rock) -> paper;
beat(paper) -> scissor;
beat(scissor) -> rock.

lose(rock) -> scissor;
lose(scissor) -> paper;
lose(paper) -> rock.

result(A, A) -> tie;
result(A, B) ->
    case beat(A) of
    B -> B;
    _ -> A
    end.
