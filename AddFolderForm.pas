unit AddFolderForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, FileCtrl, Defines;

type
  TAddFolder = class(TForm)
    SetDirectoryLabel: TLabel;
    DirectoryLine: TEdit;
    BrowseForDirectoryBtn: TButton;
    subfoldersCheck: TCheckBox;
    searchBtn: TButton;
    resultsListBox: TListBox;
    statusLabel: TLabel;
    cancelBtn: TButton;
    addAllBtn: TButton;
    addSelectedBtn: TButton;
    procedure BrowseForDirectoryBtnClick(Sender: TObject);
    procedure searchBtnClick(Sender: TObject);
    procedure cancelBtnClick(Sender: TObject);
    procedure addAllBtnClick(Sender: TObject);
    procedure addSelectedBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    procedure recusiveFileSearch(dir:string);
  public
    { Public declarations }
  end;

var
  AddFolder: TAddFolder;

implementation

{$R *.dfm}
uses
  Converter;


procedure TAddFolder.BrowseForDirectoryBtnClick(Sender: TObject);
var
  baseDir : string;
begin
  if SelectDirectory('Select a directory','My Computer',baseDir)then
    DirectoryLine.Text := baseDir;
end;

procedure TAddFolder.searchBtnClick(Sender: TObject);
begin
  if not (AnsiCompareStr(DirectoryLine.Text, '') = 0) then
    begin
      statusLabel.Caption := format('Searching...   %d files found.', [resultsListBox.Items.Count]);
      Application.ProcessMessages;
      recusiveFileSearch(DirectoryLine.Text);
      statusLabel.Caption := format('Search Complete.   %d files found.', [resultsListBox.Items.Count]);
      Application.ProcessMessages;
    end
  else
    ShowMessage('Initial File Path is empty. Please enter a file path.');
end;

procedure TAddFolder.recusiveFileSearch(dir:string);
var
  Rec:TSearchRec;
  filename : string;
  ii : integer;
  found : boolean;
begin
  if FindFirst(dir + '\*.xml', faAnyFile - faDirectory, Rec) = 0 then
    try
      repeat
        filename := dir + '\' + Rec.Name;
        found := false;
        for ii := 0 to resultsListBox.Items.count - 1 do
          begin
            if (AnsiCompareStr(resultsListBox.Items[ii], filename) = 0) then
              begin
                found := true;
                break;
              end;
          end;
        if not found then
          begin
            resultsListBox.Items.add(filename);
            statusLabel.Caption := format('Searching...   %d files found.', [resultsListBox.Items.Count]);
            Application.ProcessMessages;
          end;
      until
        FindNext(Rec) <> 0
    finally
       FindClose(Rec);
    end;

    if subfoldersCheck.Checked then
      begin
        if FindFirst(dir + '\*', faDirectory, Rec) = 0 then
          begin
            try
              repeat
                if ( Rec.Name <> '.') and (Rec.Name <> '..') then
                  recusiveFileSearch(dir + '\' + Rec.Name);
              until
                FindNext(Rec) <> 0
            finally
              FindClose(Rec);
            end;
          end;
      end;
end;

procedure TAddFolder.cancelBtnClick(Sender: TObject);
var
  selected : integer;
  ii : integer;
begin
  if resultsListBox.Items.Count <> 0 then
    begin
      selected := MessageDlg('Add found items?',  mtWarning, mbYesNoCancel, 0);
      if selected = mrYes then
        begin
          for ii := 0 to resultsListBox.Items.Count - 1 do
            MainForm.addToFileBox(resultsListBox.Items[ii]);
          resultsListBox.Items.Clear;
          AddFolder.Close;
        end
      else if selected = mrNo then
        AddFolder.Visible := false;
      resultsListBox.Items.Clear;
      if not selected = mrCancel then
        AddFolder.Close;
    end
  else
    AddFolder.Close;
end;

procedure TAddFolder.addAllBtnClick(Sender: TObject);
var
  ii : integer;
begin
  if resultsListBox.Items.Count <> 0 then
    begin
      for ii := 0 to resultsListBox.Items.Count - 1 do
        MainForm.addToFileBox(resultsListBox.Items[ii]);
      resultsListBox.Items.Clear;
    end
  else
    ShowMessage('No files have been found. No files added.');
end;

procedure TAddFolder.addSelectedBtnClick(Sender: TObject);
var
  any_selected : boolean;
  ii : integer;
begin
  any_selected := false;
  if resultsListBox.Items.Count <> 0 then
    begin
      for ii := resultsListBox.Items.count - 1 downto 0 do
        begin
          if resultsListBox.Selected[ii] then
            begin
              MainForm.addToFileBox(resultsListBox.Items[ii]);
              resultsListBox.Items.Delete(ii);
              any_selected := true;
            end;
        end;
        if not any_selected then
          ShowMessage('No files have been selected.');
    end
  else
    ShowMessage('No files have been found. No files added.');
end;

procedure TAddFolder.FormClose(Sender: TObject; var Action: TCloseAction);
var
  selected : integer;
  ii : integer;
begin
  if resultsListBox.Items.Count <> 0 then
    begin
      selected := MessageDlg('Add found items?',  mtWarning, [mbYes, MbNo], 0);
      if selected = mrYes then
        begin
          for ii := 0 to resultsListBox.Items.Count - 1 do
            MainForm.addToFileBox(resultsListBox.Items[ii]);
        end;
    end;
  resultsListBox.Items.Clear;
end;

procedure TAddFolder.FormShow(Sender: TObject);
begin
  if (AnsiCompareStr(DirectoryLine.Text, '') = 0) then
    AddFolder.DirectoryLine.Text := Defines.initial_directory;
end;

end.
