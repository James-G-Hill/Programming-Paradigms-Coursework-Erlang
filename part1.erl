-module(part1).
-export([fib/1]).

% A function for calculating the Fibonacci Sequence.
fib(N)           when N < 0  -> "Error: sequence number must be 0 or greater.";
fib(N)           when N == 0 -> 0;
fib(N)           when N > 0  -> fib(N, 1, 0, 1).

% A helper function for calculating the Fibonacci Sequence.
fib(N, A, _B, C) when N =< A -> C;
fib(N, A, B, C)  when N > A  -> fib(N, A + 1, C, B + C).
