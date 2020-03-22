-module(calc).
-export([input/0]).

input() -> parseInput(p0, io:get_line("input> ")).

replaceList(Input, Regex, OpResult) -> re:replace(Input, Regex, OpResult, [{return,list}]).
toString(OpResult) -> 
  [StrResult] = io_lib:format("~p",[OpResult]),
  StrResult.

parseNumber(List) ->
  Float = "([0-9]+\\.[0-9])",
  Result = re:run(List, Float, [global, {capture, all, list}]),
  case Result of
    {match, Data} ->
      list_to_float(List);
    nomatch ->
      list_to_integer(List)
  end.

parseInput(p0, RawInput) ->
  Regex = "\\(((?:[\\w \\+\\*\\/\\-])*)\\)",
  Input = replaceList(RawInput, "\\n", ""),
  Result = re:run(Input, Regex, [{capture, all, list}]),
  case Result of
    {match, Match} ->
      [Full, Statement] = Match,
      % io:fwrite("~p ~p ", [p0, Full]),
      OpResult = parseInput(p1, Statement),
      parseInput(p0, replaceList(Input, Regex, toString(OpResult)));
    nomatch ->
      parseInput(p1, Input)
  end;

parseInput(p1, Input) -> 
  Regex = "(\\-?[0-9]+\\.?[0-9]*)\s*(\\/|\\*)\s*(\\-?[0-9]+\\.?[0-9]*)",
  Result = re:run(Input, Regex, [{capture, all, list}]),
  case Result of
    {match, Match} ->
      % io:fwrite("~p ", [p1]),
      parseInput(p1, replaceList(Input, Regex, toString(operate(Match))));
    nomatch ->
      parseInput(p2, Input)
  end;

parseInput(p2, Input) -> 
  Regex = "(\\-?[0-9]+\\.?[0-9]*)\s*(\\+|\\-)\s*(\\-?[0-9]+\\.?[0-9]*)",
  Result = re:run(Input, Regex, [{capture, all, list}]),
  case Result of
    {match, Match} ->
      % io:fwrite("~p ", [p2]),
      parseInput(p2, replaceList(Input, Regex, toString(operate(Match))));
    nomatch ->
      parseNumber(Input)
  end.

operate([Full, Op1, Operator, Op2]) -> 
  % io:fwrite("~p ~p ~p ~p ~n", [parseNumber(Op1), Operator, parseNumber(Op2), operateFun(parseNumber(Op1), Operator, parseNumber(Op2))]),
  operateFun(parseNumber(Op1), Operator, parseNumber(Op2)).

operateFun(X, "+", Y) -> X + Y;
operateFun(X, "-", Y) -> X - Y;
operateFun(X, "*", Y) -> X * Y;
operateFun(X, "/", Y) -> X / Y.
