-module(t2).
-export([format_temps/1]).

% show(V1, V2) ->
%     {{v1, V1}, {v2, V2}}.

%% Only this function is exported
format_temps([])->                        % No output for an empty list
  ok;
format_temps([City | Rest]) ->
  print_temp(convert_to_celsius(City)),
  format_temps(Rest).
convert_to_celsius({Name, {c, Temp}}) ->  % No conversion needed
  {Name, {c, Temp}};
convert_to_celsius({Name, {f, Temp}}) ->  % Do the conversion
  {Name, {c, (Temp - 32) * 5 / 9}}.
print_temp({Name, {c, Temp}}) ->
  io:format("~w ~w c~n", [Name, Temp]).
