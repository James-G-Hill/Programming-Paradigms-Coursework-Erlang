-module(dictionary_server).
-export([start/0, stop/0, insert/2, lookup/1]).

%% The record structure.

-record(item, {key, value}).


%% Functions for creating and initializing the server.

start() ->
    register(?MODULE, spawn(fun () -> init() end)).

init() ->
    loop().


%% Client functions.

stop()       -> call(stop).
insert(K, V) -> call({insert, K, V}).
lookup(K)    -> call({lookup, K}).

%% Message passing.

call(Message) ->
    ?MODULE ! {request, self(), Message},
    receive
	{reply, Reply} ->
	    Reply
end.


%% The main loop.

loop() ->
    receive
	{request, Pid, stop}           ->
	    reply(Pid, ok);
	{request, Pid, {insert, K, V}} ->
	    put(K, V), reply(Pid, ok), loop();
	{request, Pid, {lookup, K}}    ->
	    V = get(K),
	    if
		V == undefined -> reply(Pid, notfound);
		true           -> reply(Pid, {ok, V})
	    end,
	    loop()
end.

reply(Pid, Message) -> Pid ! {reply, Message}.
