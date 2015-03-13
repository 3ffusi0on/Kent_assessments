-module(assessment3).
-compile([export_all]).

%%
%% The Dining Philosophers
%%

% Manager process
college() ->
    Report = spawn(?MODULE, report, []),
    Fork1 =  spawn(?MODULE, fork, [1, Report, free]),
    Fork2 =  spawn(?MODULE, fork, [2, Report, free]),
    Fork3 =  spawn(?MODULE, fork, [3, Report, free]),
    Fork4 =  spawn(?MODULE, fork, [4, Report, free]),
    Fork5 =  spawn(?MODULE, fork, [5, Report, free]),
    spawn(?MODULE, philosopher, ["William ", Report, Fork2, Fork1]),
    spawn(?MODULE, philosopher, ["Valentin", Report, Fork2, Fork3]),
    spawn(?MODULE, philosopher, ["Geoffrey", Report, Fork3, Fork4]),
    spawn(?MODULE, philosopher, ["Ashwini ", Report, Fork4, Fork5]),
    spawn(?MODULE, philosopher, ["Vincent ", Report, Fork1, Fork5]).

% Output process
report() ->
    receive
        {fork, Number, State} ->
            io:format("Fork ~p: ~s~n", [Number, State]);
        {phil, Name,   State} ->
            io:format("~s: ~p~n", [Name, State]);
        {left, Name} ->
            io:format("~s: got left fork~n", [Name]);
        {right, Name} ->
            io:format("~s: got right fork~n", [Name])
    end,
    report().

% Stick/Fork process
fork(Number, Report, State) ->
    receive {ask, PID} ->
        if State == free ->
            PID ! {self(), yes},
            Report ! {fork, Number, "in use"},
            fork(Number, Report, used);
        true ->
            PID ! {self(), no}
        end;
        {free} ->
            Report ! {fork, Number, "free"},
            fork(Number, Report, free)
    end,
    fork(Number, Report, State).

get_fork(Fork) ->
    Fork ! {ask, self()},
    receive
        {Fork, no} ->
            timer:sleep(100),
            get_fork(Fork);
        {Fork, yes} -> ok
    end.

% Philosopher process
philosopher(Name, Report, ForkL, ForkR) ->
    Report ! {phil, Name, thinking},
    random:seed(erlang:now()),
    N1 = random:uniform(900) + 100,
    N2 = random:uniform(900) + 100,
    timer:sleep(N1),
    Report ! {phil, Name, hungry},
    get_fork(ForkL),
    Report ! {left, Name},
    get_fork(ForkR),
    Report ! {right, Name},
    Report ! {phil, Name, eating},
    timer:sleep(N2),
    ForkL ! {free},
    ForkR ! {free},
    philosopher(Name, Report, ForkL, ForkR).

%%%%%%%%%%%%%%%
%% Challenge %%
%% %%%%%%%%% %%
% 1]  Is there any possibility of deadlock in your system? If there is, explain
%     the situation in which deadlock could occur
%
% In my implementation, there is a case of deadlock: if at some point every philosophers
% try to pick one fork a the same time, none of them will be able to pick the second one
% (already used by their neighbor).
%
%
% 2]  Assuming that there is a danger of deadlock in the system,
%     How could the deadlock be detected?
%
% We can detect a deadlock by implementing a timeout system while picking the fork.
% For example, after 2-3seconds trying to pick a fork, instead of continue waiting
% as i did in my implementation, we could free the 1st fork, thus, one of the neigbor
% can pick the second fork he needs, and the system continue to work.
%
%
