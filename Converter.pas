unit Converter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,
  Defines, StringFunctions;

type
  TMainForm = class(TForm)
    FileBox: TListBox;
    LogBox: TListBox;
    IndividualProgressBar: TProgressBar;
    OverallProgressBar: TProgressBar;
    AddFilesBtn: TButton;
    AddFolderBtn: TButton;
    DeleteFilesBtn: TButton;
    ClearFilesBtn: TButton;
    SettingsBtn: TButton;
    OutputPathBtn: TButton;
    ConvertBtn: TButton;
    IndividualStatusLabel: TLabel;
    OverallStatusLabel: TLabel;
    procedure AddFilesBtnClick(Sender: TObject);
    procedure AddFolderBtnClick(Sender: TObject);
    procedure DeleteFilesBtnClick(Sender: TObject);
    procedure ClearFilesBtnClick(Sender: TObject);
    procedure OutputPathBtnClick(Sender: TObject);
    procedure ConvertBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure addToLog(text:string);
    procedure addToFileBox(text:string);
    procedure createLogFile(filename:string);
    procedure deleteFromFileBox(index:integer);


  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  AddFolderForm, setOutputPathForm, XML_Parser;

procedure TMainForm.createLogFile(filename:string);
  var
  	FileHandle:TextFile;
  begin
  	AssignFile(FileHandle, logfile_path);
  	ReWrite(FileHandle);
  	CloseFile(FileHandle);
  end;

procedure TMainForm.addToLog(text:string);
  var
    FileHandle:TextFile;
  begin
  	LogBox.items.add(text);
  	LogBox.topindex := LogBox.items.count - 1;
  	AssignFile(FileHandle, logfile_path);
  	Append(FileHandle);
  	writeln(FileHandle, text);
  	CloseFile(FileHandle);
  end;

procedure TMainForm.addToFileBox(text:string);
  begin
  	if findStringInStringList(text, XML_FileList) = -1 then
  	  begin
		XML_FileList.add(text);
		FileBox.Items.add(getLastSubstring(text, '\'));
		addToLog('Using file ' + text);
	  end
	else
	  addToLog('File ' + text + ' is already marked for conversion');
  end;

procedure TMainForm.deleteFromFileBox(index:integer);
  begin
  	addToLog('Removing file ' + XML_FileList[index]);
  	XML_FileList.delete(index);
  	FileBox.Items.delete(index);
  end;




procedure TMainForm.AddFilesBtnClick(Sender: TObject);
  var
  	GetFiles:TOpenDialog;
  	ii:integer;
  begin
	GetFiles            := TOpenDialog.create(self);
	GetFiles.InitialDir := initial_directory;
	GetFiles.Options    := [ofAllowMultiSelect];
	GetFiles.Filter     := 'XML Files|*.xml';

	addToLog('Add Files Button clicked');
	addToLog('Initial Directory = ' + initial_directory);
	addToLog('MultiSelect selected. XML files filtered');

	if not GetFiles.execute then addToLog('Add files dialog canceled')
	else
	  begin
	  	for ii := 0 to GetFiles.Files.count - 1 do
	  	  begin
	  	  	addToFileBox(GetFiles.Files[ii]);
	  	  end;
	  end;
	GetFiles.free;
  end;


procedure TMainForm.AddFolderBtnClick(Sender: TObject);
begin
  addToLog('Add Folder Button Clicked.');
  AddFolder.Visible := true;
end;

procedure TMainForm.DeleteFilesBtnClick(Sender: TObject);
var
  any_selected : boolean;
  ii           : integer;
begin
  addToLog('Add Folder Button Clicked.');
  any_selected := false;
  for ii := FileBox.Items.count - 1 downto 0 do
  	begin
  	  if FileBox.Selected[ii] then
  	  	begin
  	  	  deleteFromFileBox(ii);
  	  	  any_selected := true;
  	  	end;
  	end;
  if not any_selected then begin
  	ShowMessage('No Files selected for deletion.');
  	addToLog('No Files selected for deletion.');
  end;
end;

procedure TMainForm.ClearFilesBtnClick(Sender: TObject);
var
  ii : integer;
begin
  addToLog('Clear Files Button Clicked.');
  for ii := FileBox.Items.Count - 1 downto 0 do
  	deleteFromFileBox(ii);
  addToLog('All files removed'); 
end;

procedure TMainForm.OutputPathBtnClick(Sender: TObject);
begin
  addToLog('Output Path Button Clicked.');
  addToLog('Current output path: ' + output_filepath);
  outputPathForm.Show;
end;

procedure TMainForm.ConvertBtnClick(Sender: TObject);
var
  overall_increment : Extended;
  ii : integer;
  parser : TXML_Parser;
begin
  addToLog('Convert button clicked.');
  if FileBox.Items.Count <> 0 then
  	begin
	  addToLog('Starting conversion...');
	  IndividualStatusLabel.caption := 'Starting conversion...';
	  OverallStatusLabel.caption := 'Starting conversion...';
	  IndividualProgressBar.position := 0;
	  OverallProgressBar.position := 0;
	  overall_increment := 100.0 / FileBox.Items.count;
	  Application.ProcessMessages;

	  parser := TXML_Parser.create;

	  for ii := 0 to FileBox.Items.count - 1 do begin
	  	addToLog('Converting ' + FileBox.Items[ii]);
	  	OverallStatusLabel.caption := 'Converting ' + FileBox.Items[ii];
	  	IndividualProgressBar.position := 0;
	  	Application.ProcessMessages;

	  	addToLog('Parsing ' + FileBox.Items[ii]);
	  	OverallStatusLabel.caption := 'Parsing ' + FileBox.Items[ii];
	  	parser.parseXML(XML_FileList[ii]);

	  	IndividualProgressBar.position := 100;
	  	IndividualStatusLabel.caption := 'Done.';
	  	OverallProgressBar.position := OverallProgressBar.position + Round(overall_increment);
	  	Application.ProcessMessages;
	  end;
	  OverallProgressBar.position := 100;
	  OverallStatusLabel.caption := 'Done.';
	  Application.ProcessMessages;
	 end
  else
  	begin
  	  ShowMessage('No files to convert.');
  	  addToLog('No files to convert.');
  	end;
end;

initialization
  begin
  	MainForm.createLogFile(logfile_path);
  end;

end.
