-module(part1).
-export([fib/1]).

% A function for calculating the Fibonacci Sequence.
fib(N)          when N > 0 -> fib(N, 1, 0, 1).
fib(N, A, B, C) when N = A -> C.
fib(N, A, B, C) when N < A -> fib(N, A + 1, C, B + C).
