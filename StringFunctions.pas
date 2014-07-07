unit StringFunctions;

interface
	uses
		IntegerList, SysUtils, Classes;

	function findPattern(text:string; pattern:string)                                                          : TIntegerList;
	function findSinglePatternAfterIndex(text, pattern:string; index : integer)                                : integer;
	function getLastSubstring(text:string; pattern:string)                                                     : string;
	function findStringInStringList(text:string; list:TStringList)                                             : integer;
	function getNextSection(str:string; opening_sequences, closing_sequences:TStringList; start_index:integer) : string;

implementation

function findPattern(text:string; pattern:string) : TIntegerList;
  var
  	ii:integer;
  begin
  	result := TIntegerList.create;
  	for ii := 1 to (length(text) - length(pattern)) do
  	  begin
  	  	if (AnsiCompareStr(copy(text, ii, length(pattern)), pattern) = 0) then
  	  		result.addInt(ii);
  	  end;
  end;

function findSinglePatternAfterIndex(text, pattern:string; index : integer) : integer; 
  var
    ii:integer;
    substring : string;
  begin
  	result := -1;
  	for ii := index to (length(text) - length(pattern) + 1) do
  	  begin
  	  	substring := copy(text, ii, length(pattern));
  	  	if (AnsiCompareStr(pattern, substring) = 0) then
  	  	  begin
  	  	  	result := ii;
  	  	  	break;
  	  	  end;
  	  end;
  end;

function getLastSubstring(text:string; pattern:string) : string;
  var
    list:TIntegerList;
  begin
  	list := findPattern(text, pattern);
  	result := copy(text, list.getInt(list.countInt - 1) + length(pattern), length(text));
  end;

function findStringInStringList(text:string; list:TStringList) : integer;
  var
  	ii:integer;
  begin
  	result := -1;
  	for ii := 0 to list.count -1 do
  	  begin
  	  	if (AnsiCompareStr(text, list[ii]) = 0) then
  	  		result := ii;
  	  end;
  end;

function getNextSection(str:string; opening_sequences, closing_sequences:TStringList; start_index:integer) : string;
var
  open, ii, jj, s_index, e_index : integer;
  substring, opening : string;
begin
  result := '';
  open := -1;
  e_index := -1;

  for ii := start_index to length(str) do
  	begin
  	  for jj := 0 to opening_sequences.count - 1 do
  	  	begin
  	  	  if length(opening_sequences[jj]) <= (length(str) - ii + 1) then
  	  	  	begin
  	  	  	  substring := copy(str, ii, length(opening_sequences[jj]));
  	  	  	  if (AnsiCompareStr(substring, opening_sequences[jj]) = 0) then
  	  	  	  	begin
  	  	  	  	  open := jj;
  	  	  	  	  break;
  	  	  	  	end;
  	  	  	end; 
  	  	end;
  	  if open <> -1 then
  	  	break;
  	end;

  if open <> -1 then 
  	begin
  	  s_index := ii;
  	  ii := ii + length(opening_sequences[open]);
  	  for ii := ii to length(str) do
  	  	begin
  	  	  opening := opening_sequences[open];
  	  	  for jj := 0 to opening_sequences.count - 1 do
  	  	  	begin
  	  	  	  if (AnsiCompareStr(opening_sequences[jj], opening) = 0) then
  	  	  	    begin
			      if length(closing_sequences[jj]) <= (length(str) - ii + 1) then
  	  	  	        begin
  	  	  	          substring := copy(str, ii, length(closing_sequences[jj]));
  	  	  	          if (AnsiCompareStr(substring, closing_sequences[jj]) = 0) then
  	  	  	          	begin
  	  	  	          	  e_index := ii + length(substring);
  	  	  	          	  break;
  	  	  	          	end;
  	  	  	        end; 
  	  	  	    end;
  	  	  	end;
  	  	  if(e_index <> -1) then
  	  	  	break;
  	  	end;
  	  	if(e_index <> -1) then
  	  	  result := copy(str, s_index, e_index - s_index);
  	end;
end;

end.
