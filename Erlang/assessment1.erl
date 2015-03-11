-module(assessment1).
-export([fib/1, fib2/1,
        area/1, perimeter/1, overlap/2,
        product/1, occurs/2,
        evens/1,
        game_score/1]).

%Fibinacci
%I assumed that N is always positive
fib(0) -> 0;
fib(1) -> 1;
fib(N) -> fib(N-2) + fib(N-1).

%Hand evaluation of fib(4)
%fib(4) = fib(3) + fib(2)
%       = fib(1) + fib(2)  +  fib(0) + fib(1)
%       = 1 + fib(0) + fib(1)  + 0 + 1
%       = 1 + 0 + 1 + 0 + 1
%       = 3

fib2(N, {A, B}) when N > 0 -> fib2(N - 1, {B, A+B});
fib2(_, {A, B}) -> {A, B}.
fib2(N) -> fib2(N, {0, 1}).

%Hand evaluation of fib2(4)
%fib2(4) = fib2(4, {0, 1})
%        = fib2(4-1, {1, 0 + 1})
%        = fib2(3-1, {1, 1 + 1})
%        = fib2(2-1, {2, 1 + 2})
%        = fib2(1-1, {3, 3 + 2})
%        = {3, 5}
%        This differs from the fib() evaluation because in this function we start from 0, and passing the N and N+1 solutions to the next level instead of going down to 0 with the recurssion as in the 1st implementation.

%Pattern matching
area({circle, {_,_}, R})
    -> math:pi() * R * R;
area({rectangle, {_,_}, H, W})
    -> H*W.

%Assuming there are only circles and rectangles.
perimeter({circle, {_,_}, R})
    -> 2 * math:pi() * R;
perimeter({rectangle, {_,_}, H, W})
    -> 2 * H + 2 * W.

% Assuming that 2 points on the same coordiates do not overlap.

%between 2 rectangles.
overlap({rectangle, {Xa,Ya}, Ha, Wa}, {rectangle, {Xb,Yb}, Hb, Wb}) ->
    if
    Xb > Xa + Wa; Xb + Wb < Xa; Yb > Ya + Ha; Yb + Hb < Ya -> false;
    true -> true
    end;
%between 2 circles.
overlap({circle, {Xa,Ya}, Ra}, {circle, {Xb,Yb}, Rb}) ->
    D = (Xa-Xb)*(Xa-Xb)+(Ya-Yb)*(Ya-Yb),
    if
    D > (Ra+Rb)*(Ra+Rb) -> false;
    true -> true
    end;
%between circle and rectangle
overlap({rectangle, {Xb,Yb}, H, W},{circle, {Xa,Ya}, R}) ->
    overlap({circle, {Xa,Ya}, R}, {rectangle, {Xb,Yb}, H, W});
overlap({circle, {Xa,Ya}, R}, {rectangle, {Xb,Yb}, H, W}) ->
    DistX = abs(Xa - Xb),
    DistY = abs(Ya - Yb),
    if
    DistX > W/2 + R; DistY > H/2 + R -> false;
    true -> true
    end.


%Recursion over lists
product([]) -> 1;
product([X|Xs]) -> X * product(Xs).

occurs(_, []) -> 0;
occurs(N, [X|Xs]) when N == X -> 1 + occurs(N, Xs);
occurs(N, [_|Xs])-> occurs(N, Xs).

evens([]) -> [];
evens([X|Xs]) -> if
    X rem 2 == 0 -> [X|evens(Xs)];
    true -> evens(Xs)
end.
%Rock-paper-scissors
calcWinner({X,X}) -> 0;
calcWinner({paper,rock}) -> 1;
calcWinner({scissors,paper}) -> 1;
calcWinner({rock,scissors}) -> 1;
calcWinner({_,_}) -> -1.
game_score([]) -> 0;
game_score([X|Xs]) -> calcWinner(X) + game_score(Xs).
