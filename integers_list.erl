-module(integers_list).
-export([start/1, stop/1]).

%% Spawns a new process.

start(IntList) ->
    spawn(fun () -> run(IntList) end).


stop(IntListPid) ->
    IntListPid ! {stop, self()},
    receive
	ok ->
	    ok
    end.


run(IntList) ->
    receive
	{stop, ReplyPid} ->
	    ReplyPid ! ok;
	{filter, Filter, ReplyPid} ->
	    NewList = lists:filtermap(Filter, IntList),
	    ReplyPid ! NewList,
	    run(IntList)
    end.
