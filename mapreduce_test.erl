-module(mapreduce_test).
-export([run/0]).

run() ->
    I1 = integers_list:start(lists:seq(11, 20)),
    I2 = integers_list:start(lists:seq(1, 10)),
    I3 = integers_list:start(lists:seq(21, 30)),
    L = [I1, I2, I3],
    F = fun(X) -> if X rem 2 == 0 -> true; true -> false end end,
    find_integers:find_integers(L, F).
