-module(ecsv2sqlite_loader).

-export([open/1]).

-spec open(string()) -> list().
open(FileName) ->
	case file:read_file(FileName) of
		{ok, BinaryData} -> parse(unicode:characters_to_list(BinaryData, utf8), 0, [], [], []);
		Error -> Error
	end.
	
parse([], RowNo, _, _, R) -> 
	R2 = lists:reverse(R),
	{ok, RowNo, R2};	
parse(";" ++ T, RowNo, Column, L, R) ->
	Column2 = lists:reverse(Column),
	%io:format("new column1 ~p\n", [Column2]),
	parse(T, RowNo, [], [Column2 | L], R);
parse("\n" ++ T, RowNo, Column, L, R) ->
	Column2 = lists:reverse(Column),
	%io:format("new column2 ~p\n", [Column2]),
	RowNo2 = RowNo + 1,
	L2 = list_to_tuple(lists:reverse([Column2 | L])),
	parse(T, RowNo2, [], [], [L2 | R]);
parse([H|T], RowNo, Column, L, R) ->
	parse(T, RowNo, [H | Column], L, R).
