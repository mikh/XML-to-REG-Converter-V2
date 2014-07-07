program Converter_v2;

uses
  Forms,
  Converter in 'Converter.pas' {MainForm},
  Defines in 'Defines.pas',
  StringFunctions in 'StringFunctions.pas',
  IntegerList in 'IntegerList.pas',
  AddFolderForm in 'AddFolderForm.pas' {AddFolder},
  setOutputPathForm in 'setOutputPathForm.pas' {outputPathForm},
  XML_Parser in 'XML_Parser.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAddFolder, AddFolder);
  Application.CreateForm(ToutputPathForm, outputPathForm);
  Application.Run;
end.
