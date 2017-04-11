-module(find_integers).
-export([find_integers/2]).

find_integers(PidList, Filter) ->
    Jobs = lists:map(fun(Pid) -> {Pid, {filter, Filter, self()}} end, PidList),
    Combinor = fun(H, T) -> lists:append(H, T) end,
    mapreduce:mapreduce(Jobs, Combinor, []).
