-module(find_integers).
-export([find_integers/2]).

find_integers(Pids, F) ->
    Jobs = lists:map(fun(Pid) -> {Pid, {filter, F, self()}} end, Pids),
    Combinor = fun(H, T) -> lists:sort(lists:append(H, T)) end,
    mapreduce:mapreduce(Jobs, Combinor, []).
