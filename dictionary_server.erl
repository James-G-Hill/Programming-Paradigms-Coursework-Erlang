-module(dictionary_server).
-export([start/0, stop/0]).

%% Functions for creating and initializing the server.

start() ->
    register(?MODULE, spawn(fun () -> init() end)).

init() ->
    loop().


%% Client functions.

stop() -> call(stop).


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
	    reply(Pid, ok)
end.

reply(Pid, Message) ->
    Pid ! {reply, Message}.
