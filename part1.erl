-module(part1).
-export([fib/1, adjacent_duplicates/1, deep_sum/1]).

% A function for calculating the Fibonacci Sequence.
fib(N)           when N < 0  -> "Error: sequence number must be 0 or greater.";
fib(N)           when N == 0 -> 0;
fib(N)           when N > 0  -> fib(N, 1, 0, 1).

% A helper function for calculating the Fibonacci Sequence.
fib(N, A, _, C) when N =< A -> C;
fib(N, A, B, C)  when N > A -> fib(N, A + 1, C, B + C).

% A function to return duplicates from a list where they are adjacent.
adjacent_duplicates(L) when L == [] -> [];
adjacent_duplicates(L)              -> adjacent_duplicates(hd(L), tl(L), []).

% A helper function to return adjacent duplicates from a list.
adjacent_duplicates(_, T, N) when T == [], N == [] -> [];
adjacent_duplicates(_, T, N) when T == [], N /= [] -> reverseDuplicates([hd(N)|[]], tl(N));
adjacent_duplicates(H, T, N) when H == hd(T)       -> adjacent_duplicates(hd(T), tl(T), [H|N]);
adjacent_duplicates(_, T, N)                       -> adjacent_duplicates(hd(T), tl(T), N).

% A helper function to reverse the duplicates list.
reverseDuplicates(H, T) when T == [] -> H;
reverseDuplicates(H, T)              -> reverseDuplicates([hd(T)|H], tl(T)).

% A function to sum a list of integers.
deep_sum(L) -> deep_sum(lists:flatten(L), 0).

% A helper function for summing a deep list.
deep_sum(L, I) when L == [] -> I;
deep_sum(L, I)              -> deep_sum(tl(L), I+hd(L)).
