unit IntegerList;

interface

uses
	Classes, SysUtils;

  type TIntegerList = class
  	private
  	    list:TStringList;
  	public
  		constructor create;
  		destructor destroy; override;
		procedure addInt(ii:integer);
		procedure deleteInt(ind:integer);
		function getInt(ind:integer):integer;
		procedure setInt(ind:integer; ii:integer);
		function findInt(ii:integer):integer;
		function countInt:integer;

		procedure clearIntList;
		procedure copy(list1:TIntegerList; list2:TIntegerList);
		function printIntList : string;
	end;


implementation


constructor TIntegerList.Create;
	begin
		list := TStringList.Create;
	end;

destructor TIntegerList.destroy;
	var
		ii:integer;
	begin
		for ii := 0 to list.count - 1 do
			list.Objects[ii].free;
		list.clear;
		list.free;
	end;

procedure TIntegerList.addInt(ii:integer);
	begin
		list.Add(IntToStr(ii));
	end;

procedure TIntegerList.deleteInt(ind:integer);
	begin
		list.Delete(ind);
	end;

function TIntegerList.getInt(ind:integer):integer;
	begin
		Result := StrToInt(list[ind]);
	end;

procedure TIntegerList.setInt(ind:integer; ii:integer);
	begin
		list[ind] := IntToStr(ii);
	end;

function TIntegerList.findInt(ii:integer):integer;
	var
		loop_var:integer;
	begin
		Result := -1;
		for loop_var := 0 to list.Count do begin
			if StrToInt(list[loop_var]) = ii then
				Result := loop_var;
		end;
	end;

function TIntegerList.countInt:integer;
	begin
		Result := list.Count;
	end;

procedure TIntegerList.clearIntList;
	var
		ii:integer;
	begin
		list.Clear;
	end;

procedure TIntegerList.copy(list1:TIntegerList; list2:TIntegerList);
	var
		ii:integer;
	begin
		list1.clearIntList;
		for ii := 0 to list2.countInt - 1 do 
			list1.addInt(list2.getInt(ii));

	end;

function TIntegerList.printIntList : string;
	var 
		ii:integer;
		temp:string;
	begin
		temp := '';
		for ii := 0 to list.Count - 1 do
			temp := temp  + list[ii] + sLineBreak;
		result := temp;
	end;

end.

