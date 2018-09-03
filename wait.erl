-module(wait).

-export([hello/0]).

hello() ->
    receive
        Strange -> io:format("What? Something terrible must have happened!~n~s~n", [Strange])
    end.