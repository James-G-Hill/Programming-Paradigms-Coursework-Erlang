-module(dictionary_server).
-export([start/0, stop/0, insert/2]).

%% The record structure.

-record(item, {key, value}).


%% Functions for creating and initializing the server.

start() ->
    register(?MODULE, spawn(fun () -> init() end)).

init() ->
    loop().


%% Client functions.

stop()   -> call(stop).
insert(K, V) -> call({insert, K, V}).


%% Message passing.

call(Message) ->
    dictionary_server ! {request, self(), Message},
    receive
	{reply, Reply} ->
	    Reply
end.


%% The main loop.

loop() ->
    receive
	{request, Pid, stop} ->
	    reply(Pid, stopped), loop();
	{request, Pid, {insert, K, V}} ->
	    #item{key=K, value=V}, reply(Pid, inserted), loop()
end.

reply(Pid, Message) -> Pid ! {reply, Message}.
