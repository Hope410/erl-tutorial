-module(t4).
-export([middle/1, halfLength/1]).

halfLength(A) -> (length(A) div 2).

middle(String) 
  when length(String) rem 2 == 1 ->
    lists:sublist(String, halfLength(String) + 1, 1);
middle(String) 
  when length(String) rem 2 == 0 ->
    lists:sublist(String, halfLength(String), 2).