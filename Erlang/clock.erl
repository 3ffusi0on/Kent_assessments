% clock.erl -- simple clock processes in Erlang
% Fred Barnes, University of Kent, March 2015.

-module (clock).
-compile ([export_all]).

% simple ticking clock
clock (N) ->
    receive
    after N -> io:format ("tick!~n")
    end,
    clock (N).
