-module(dictionary_server).
-export([start/0, stop/0, insert/2, lookup/1, remove/1, clear/0, size/0]).

%% Functions for creating and initializing the server.

start() ->
    register(?MODULE, spawn(fun () -> init() end)).

init() ->
    D = dict:new(),
    loop(D).


%% Client functions.

stop()       -> call(stop).
insert(K, V) -> call({insert, K, V}).
lookup(K)    -> call({lookup, K}).
remove(K)    -> call({remove, K}).
clear()      -> call(clear).
size()       -> call(size).


%% Message passing.

call(Message) ->
    ?MODULE ! {request, self(), Message},
    receive
	{reply, Reply} ->
	    Reply
end.


%% The main loop.

loop(D) ->
    receive
	{request, Pid, stop}           ->
	    reply(Pid, ok);
	{request, Pid, {insert, K, V}} ->
	    D2 = dict:store(K, V, D),
	    reply(Pid, ok),
	    loop(D2);
	{request, Pid, {lookup, K}}    ->
	    V = dict:find(K, D),
	    if
		V == error -> reply(Pid, notfound);
		true       -> reply(Pid, V)
	    end,
	    loop(D);
	{request, Pid, {remove, K}}    ->
	    D2 = dict:erase(K, D),
	    V = dict:find(K, D),
	    if
		V == error -> reply(Pid, notfound);
		true       -> reply(Pid, ok)
	    end,
	    loop(D2);
	{request, Pid, clear}            ->
	    reply(Pid, cleared),
	    loop(dict:new());
	{request, Pid, size}           ->
	    reply(Pid, dict:size(D)),
	    loop(D)
end.

reply(Pid, Message) -> Pid ! {reply, Message}.
