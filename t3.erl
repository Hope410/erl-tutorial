-module(t3).
-export([input/1]).

input({Val1, plus, Val2}) ->
  Val1 + Val2;
input({Val1, "-", Val2}) ->
  Val1 - Val2;
input({Val1, "*", Val2}) ->
  Val1 * Val2;
input({Val1, "/", Val2}) ->
  Val1 / Val2.
