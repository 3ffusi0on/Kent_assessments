-module (prodconsrep).
-export ([program/0, producer/2, consumer/1]).

waitdone (0) -> finished;
waitdone (N) -> receive finished -> waitdone (N-1) end.

producer (Parent, Target) ->
    Target ! {msg, self(), "hello, Erlang world!"},
    receive
        ack -> ack
    end,
    timer:sleep(500),
    Target ! {msg, self(), "this is another message"},
    receive
        ack -> ack
    end,
    timer:sleep(500),
    Target ! {shutdown, self()},
    receive
        ack -> ack
    end,
    timer:sleep(500),
    Parent ! finished.


consumer (Parent) ->
    receive
        {msg, Pid, M} -> Pid ! ack,
        io:format ("Message was: ~s~n", [M]),
            consumer (Parent);
        {shutdown, Pid} -> Pid ! ack,
        Parent ! finished
    end.


program () ->
    % spawn 'producer' and 'consumer' processes.
    C1 = spawn (?MODULE, consumer, [self ()]),
    spawn (?MODULE, producer, [self (), C1]),
    spawn (?MODULE, producer, [self (), C1]),

    % wait for them to finish -- they send messages back to us.
    waitdone (2).
