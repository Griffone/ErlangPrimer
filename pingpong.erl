-module(pingpong).

-export([ping/1, listen/0]).

listener() ->
    receive
        {ping, Id, Secret} ->
            io:format("Received a message from ~w~n", [Id]),
            Id ! {pong, Secret},
            listener();
        quit ->
            ok
    end.

pinger(Id, Secret) ->
    Id ! {ping, self(), Secret},
    receive
        {pong, Secret} ->
            io:format("~w responded!~n", [Id]),
            ok;
        quit ->
            ok
    end.

ping(Id) ->
    Secret = 12,
    io:format("Pinging ~w~n", [Id]),
    spawn(fun() -> pinger(Id, Secret) end).

listen() ->
    io:format("Setting up listening process, don't forget to register it!~n"),
    spawn(fun() -> listener() end).