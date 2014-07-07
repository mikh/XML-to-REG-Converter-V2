unit setOutputPathForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl;

type
  ToutputPathForm = class(TForm)
    outputPathLabel: TLabel;
    outputPathEdit: TEdit;
    browseBtn: TButton;
    newFolderBtn: TButton;
    saveBtn: TButton;
    cancelBtn: TButton;
    newFolderEdit: TEdit;
    procedure browseBtnClick(Sender: TObject);
    procedure newFolderBtnClick(Sender: TObject);
    procedure saveBtnClick(Sender: TObject);
    procedure cancelBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  outputPathForm: ToutputPathForm;

implementation

{$R *.dfm}
uses
  Defines;

procedure ToutputPathForm.browseBtnClick(Sender: TObject);
var
  baseDir : string;
begin
  if SelectDirectory('Select a directory','My Computer',baseDir)then
    outputPathEdit.Text := baseDir;
end;

procedure ToutputPathForm.newFolderBtnClick(Sender: TObject);
var
  temp_name : string;
begin
  if (AnsiCompareStr(outputPathEdit.Text, '') = 0) then
    ShowMessage('Need to set the output path before adding a folder.')
  else
    begin
      if (AnsiCompareStr(newFolderEdit.Text, '') = 0) then
        ShowMessage('Need to set new folder name before adding.')
      else
        begin
          temp_name := outputPathEdit.Text + '\' + newFolderEdit.Text;
          if CreateDir(temp_name) then
            outputPathEdit.Text := temp_name
          else
            ShowMessage('Folder creation failed. Please check folder name and file path for invalid characters or illegal location.');
        end;
    end;
end;

procedure ToutputPathForm.saveBtnClick(Sender: TObject);
begin
  if (AnsiCompareStr(outputPathEdit.Text, '') = 0) then
    ShowMessage('Need to set filepath before saving it.')
  else
    begin
      output_filepath := outputPathEdit.Text;
      outputPathForm.close;
    end;
end;

procedure ToutputPathForm.cancelBtnClick(Sender: TObject);
var
  selected:integer;
begin
  if not (AnsiCompareStr(outputPathEdit.Text, '') = 0) and not (AnsiCompareStr(outputPathEdit.Text, output_filepath) = 0) then
    begin
      selected := MessageDlg('Save new file path',  mtWarning, [mbYes, MbNo, mbCancel], 0);
      if selected = mrYes then
        begin
          output_filepath := outputPathEdit.Text;
          outputPathForm.close;
        end
      else if selected = mrNo then
        outputPathForm.close;
    end
  else
    outputPathForm.close;
end;

procedure ToutputPathForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  selected:integer;
begin
  if not (AnsiCompareStr(outputPathEdit.Text, '') = 0) and not (AnsiCompareStr(outputPathEdit.Text, output_filepath) = 0) then
    begin
      selected := MessageDlg('Save new file path',  mtWarning, [mbYes, MbNo], 0);
      if selected = mrYes then
        output_filepath := outputPathEdit.Text
    end;
end;

procedure ToutputPathForm.FormShow(Sender: TObject);
begin
  outputPathEdit.Text := output_filepath;
end;

end.
