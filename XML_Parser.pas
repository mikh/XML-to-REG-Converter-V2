unit XML_Parser;

interface

  type TXML_Parser = class
  	private
  		function loadXML(filename:string) : string;
  	public
  		//constructor create;
  		procedure parseXML(filename:string);
  	end;

implementation

procedure TXML_Parser.parseXML(filename:string);
var
  xml : string;
begin
  xml := loadXML(filename);
end;



function TXML_Parser.loadXML(filename:string) : string;
var
  f : TextFile;
  text : string;
begin
  AssignFile(f, filename);
  Result := '';
  Reset(f);

  while not eof(f) do
  	begin
  	  readln(f, text);
  	  result := result + text;
  	end;
  CloseFile(f);
end;


end.
