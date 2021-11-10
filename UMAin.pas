unit UMAin;
interface
uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  System.Classes,
  System.Inifiles,
  System.Masks,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Menus,
  System.Actions,
  Vcl.ActnList,
  Vcl.ComCtrls, Vcl.Mask;
type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    AL01: TActionList;
    AcSimpanAsetAktif: TAction;
    ActHapusAsetAktif: TAction;
    GroupBox1: TGroupBox;
    Button1: TButton;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    LPath: TLabel;
    FileName: TLabeledEdit;
    ListBox1: TListBox;
    Button2: TButton;
    ListView1: TListView;
    ActTambahAsetAktif: TAction;
    ActUbahAsetAktif: TAction;
    ActBukaAsetAktif: TAction;
    OpenDialog1: TOpenDialog;
    ActListFileAsetAktif: TAction;
    ActHapusFileAsetAktif: TAction;
    Edit1: TEdit;
    ActUbahFileAsetAktif: TAction;
    StatusBar1: TStatusBar;
    TabSheet2: TTabSheet;
    StatusBar2: TStatusBar;
    ListView2: TListView;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    FileAsetJual: TLabeledEdit;
    GroupBox4: TGroupBox;
    Button3: TButton;
    ListBox2: TListBox;
    Button4: TButton;
    Edit2: TEdit;
    PM01: TPopupMenu;
    Open1: TMenuItem;
    UbahFile1: TMenuItem;
    HapusFile1: TMenuItem;
    N1: TMenuItem;
    AcSimpan1: TMenuItem;
    ActHapus1: TMenuItem;
    ActTambah1: TMenuItem;
    ActUbah1: TMenuItem;
    actJualAset: TAction;
    JualAset1: TMenuItem;
    actSimpanAsetDijual: TAction;
    actHapusFileAsetDijual: TAction;
    actUbahAsetDijual: TAction;
    actHapusAsetDijual: TAction;
    actListFileAsetDijual: TAction;
    SimpanAsetDijual1: TMenuItem;
    actBukaAsetDijual: TAction;
    DaftarFileAsetAktif1: TMenuItem;
    DaftarBerkasAsetDijual1: TMenuItem;
    HapusAsetDijual1: TMenuItem;
    actBukaAsetDijual1: TMenuItem;
    UbahAsetDijual1: TMenuItem;
    actUbahFileAsetDijual: TAction;
    UbahFileAsetDijual1: TMenuItem;
    HapusFile2: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure ActTambahAsetAktifExecute(Sender: TObject);
    procedure ActHapusAsetAktifExecute(Sender: TObject);
    procedure ActUbahAsetAktifExecute(Sender: TObject);
    procedure AcSimpanAsetAktifExecute(Sender: TObject);
    procedure ActBukaAsetAktifExecute(Sender: TObject);
    procedure ActListFileAsetAktifExecute(Sender: TObject);
    procedure ListView1ColumnClick(Sender: TObject; Column: TListColumn);
    procedure ListBox1DblClick(Sender: TObject);
    procedure ActHapusFileAsetAktifExecute(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure ActUbahFileAsetAktifExecute(Sender: TObject);
    procedure actJualAsetExecute(Sender: TObject);
    procedure actSimpanAsetDijualExecute(Sender: TObject);
    procedure actUbahAsetDijualExecute(Sender: TObject);
    procedure actHapusFileAsetDijualExecute(Sender: TObject);
    procedure actHapusAsetDijualExecute(Sender: TObject);
    procedure actListFileAsetDijualExecute(Sender: TObject);
    procedure ListView2ColumnClick(Sender: TObject; Column: TListColumn);
    procedure actBukaAsetDijualExecute(Sender: TObject);
    procedure actUbahFileAsetDijualExecute(Sender: TObject);
    procedure ListBox2DblClick(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    function PathDirectory: string;
    function PathDirectory1: string;
    procedure FindFilePattern(root: String; pattern: String);
    procedure FindFilePattern2(root: String; pattern: String);
    procedure RefreshCount;
    procedure RefreshCount2;
  public
    { Public declarations }
  end;
  TCustomSortStyle = (cssAlphaNum, cssNumeric, cssDateTime);
var
  Form1: TForm1;
  { variable to hold the sort style }
  LvSortStyle: TCustomSortStyle;
  { array to hold the sort order }
  LvSortOrder: array [0 .. 6] of Boolean;
  // High[LvSortOrder] = Number of Lv Columns
implementation
{$R *.dfm}
function CustomSortProc(Item1, Item2: TListItem; SortColumn: Integer)
  : Integer; stdcall;
var
  s1, s2: string;
  i1, i2: Integer;
  r1, r2: Boolean;
  d1, d2: TDateTime;
  { Helper functions }
  function IsValidNumber(AString: string; var AInteger: Integer): Boolean;
  var
    Code: Integer;
  begin
    Val(AString, AInteger, Code);
    Result := (Code = 0);
  end;
  function IsValidDate(AString: string; var ADateTime: TDateTime): Boolean;
  begin
    Result := True;
    try
      ADateTime := StrToDateTime(AString);
    except
      ADateTime := 0;
      Result := False;
    end;
  end;
  function CompareDates(dt1, dt2: TDateTime): Integer;
  begin
    if (dt1 > dt2) then
      Result := 1
    else if (dt1 = dt2) then
      Result := 0
    else
      Result := -1;
  end;
  function CompareNumeric(AInt1, AInt2: Integer): Integer;
  begin
    if AInt1 > AInt2 then
      Result := 1
    else if AInt1 = AInt2 then
      Result := 0
    else
      Result := -1;
  end;
begin
  Result := 0;
  if (Item1 = nil) or (Item2 = nil) then
    Exit;
  case SortColumn of
    - 1:
      { Compare Captions }
      begin
        s1 := Item1.Caption;
        s2 := Item2.Caption;
      end;
  else
    { Compare Subitems }
    begin
      s1 := '';
      s2 := '';
      { Check Range }
      if (SortColumn < Item1.SubItems.Count) then
        s1 := Item1.SubItems[SortColumn];
      if (SortColumn < Item2.SubItems.Count) then
        s2 := Item2.SubItems[SortColumn]
    end;
  end;
  { Sort styles }
  case LvSortStyle of
    cssAlphaNum:
      Result := lstrcmp(PChar(s1), PChar(s2));
    cssNumeric:
      begin
        r1 := IsValidNumber(s1, i1);
        r2 := IsValidNumber(s2, i2);
        Result := ord(r1 or r2);
        if Result <> 0 then
          Result := CompareNumeric(i2, i1);
      end;
    cssDateTime:
      begin
        r1 := IsValidDate(s1, d1);
        r2 := IsValidDate(s2, d2);
        Result := ord(r1 or r2);
        if Result <> 0 then
          Result := CompareDates(d1, d2);
      end;
  end;
  { Sort direction }
  if LvSortOrder[SortColumn + 1] then
    Result := -Result;
end;
procedure TForm1.AcSimpanAsetAktifExecute(Sender: TObject);
var
  LIniFile: TIniFile;
  I: Integer;
begin
  /// Save Data IniFile Format
  try
    /// Delete File
    if FileExists(PathDirectory + '\' + FileName.Text) then
      DeleteFile(PathDirectory + '\' + FileName.Text);
    LIniFile := TIniFile.Create(PathDirectory + '\' + FileName.Text + '.ini');
    /// Save Record TO File
    with LIniFile, ListView1 do
    begin
      for I := 0 to Items.Count - 1 do
      begin
        WriteString(IntToStr(I), 'Tanggal Akuisisi', Items[I].SubItems[0]);
        WriteString(IntToStr(I), 'Detail Aset', Items[I].SubItems[1]);
        WriteString(IntToStr(I), 'Akun Aset', Items[I].SubItems[2]);
        WriteString(IntToStr(I), 'Biaya Akuisisi(IDR)', Items[I].SubItems[3]);
        WriteString(IntToStr(I), 'Nilai Buku(IDR)', Items[I].SubItems[4]);
      end;
    end;
    MessageDlg('Data Berhasil diSimpan', mtInformation, [mbOK], 0);
    ActListFileAsetAktifExecute(Sender);
    // Hitung Jumlah
    RefreshCount;
  finally
    LIniFile.Free;
  end;
end;
procedure TForm1.ActHapusAsetAktifExecute(Sender: TObject);
begin
  /// Delete ListView
  with ListView1 do
  begin
    case MessageDlg('Apakah Anda Ingin Menghapus  Aset?', mtConfirmation,
      [mbYes, mbNo], 0) of
      mrYes:
        begin
          Items[ItemIndex].Delete;
          // Hitung Jumlah
          RefreshCount;
        end;
      mrNo:
        ;
    end;
  end;
end;
procedure TForm1.actHapusAsetDijualExecute(Sender: TObject);
begin
  /// Delete ListView
  with ListView2 do
  begin
    case MessageDlg('Apakah Anda Ingin Menghapus  Aset?', mtConfirmation,
      [mbYes, mbNo], 0) of
      mrYes:
        begin
          Items[ItemIndex].Delete;
          // Hitung Jumlah
          RefreshCount2;
        end;
      mrNo:
        ;
    end;
  end;
end;

procedure TForm1.ActHapusFileAsetAktifExecute(Sender: TObject);
begin
  /// Delete File
  case MessageDlg('Apakah anda Yakin ingin menghapus file aset aktif?',
    TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0) of
    mrYes:
      begin
        if FileExists(LPath.Caption + '\' + ListBox1.Items[ListBox1.ItemIndex])
        then
        begin
          DeleteFile(LPath.Caption + '\' + ListBox1.Items[ListBox1.ItemIndex]);
          ActListFileAsetAktifExecute(Sender);
          // Hitung Jumlah
          RefreshCount;
        end;
      end;
    mrNo:
      ;
  end;
end;
procedure TForm1.actHapusFileAsetDijualExecute(Sender: TObject);
begin
  /// Delete File
  case MessageDlg('Apakah anda Yakin ingin menghapus file aset dijual?',
    TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0) of
    mrYes:
      begin
        if FileExists(Label3.Caption + '\' + ListBox2.Items[ListBox2.ItemIndex])
        then
        begin
          DeleteFile(Label3.Caption + '\' + ListBox2.Items[ListBox2.ItemIndex]);
          ActListFileAsetDijualExecute(Sender);
          // Hitung Jumlah
          RefreshCount2;
        end;
      end;
    mrNo:
      ;
  end;
end;

procedure TForm1.actJualAsetExecute(Sender: TObject);
var
  LAValue: array [0 .. 5] of string;
  LocalItem: TListItem;
  fNumber: Integer;
begin
  /// Ubah Data
  with ListView1 do
  begin
  case MessageDlg('Apakah Anda Ingin Menjual Aset?', mtConfirmation,
      [mbYes, mbNo], 0) of
      mrYes:
        begin
          Items.BeginUpdate;
            /// Identification Value
            LAValue[0] := Items[Selected.Index].SubItems[0];
            LAValue[1] := Items[Selected.Index].SubItems[1];

            InputQuery('Input Data', ['Tanggal', 'Detail Aset', 'Nilai Jual(IDR)', 'Untung/Rugi'], LAValue);
            // Masukkan Ke ListView
            fNumber := ListView2.Items.Count + 1;
            LocalItem := ListView2.Items.Add;
            with LocalItem do
            begin
              Caption := IntToStr(fNumber);
              SubItems.Add(LAValue[0]);
              SubItems.Add(LAValue[1]);
              SubItems.Add(LAValue[2]);
              SubItems.Add(LAValue[3]);
              SubItems.Add(LAValue[4]);
            end;
          Items.EndUpdate;
          Items[ItemIndex].Delete;
          // Hitung Jumlah
          RefreshCount;
        end;
      mrNo:

    end;
  end;
end;

procedure TForm1.ActListFileAsetAktifExecute(Sender: TObject);
begin
  ListBox1.Items.Clear;
  FindFilePattern(LPath.Caption + '\', '*.*');
  // Hitung Jumlah
  RefreshCount;
end;
procedure TForm1.ActBukaAsetAktifExecute(Sender: TObject);
var
  LIniFile: TIniFile;
  LStringList: TStringList;
  I: Integer;
  LI: TListItem;
  fFileName: String;
begin
  /// Pilih File
  with OpenDialog1 do
  begin
    Execute;
    /// baca File
    try
      LIniFile := TIniFile.Create(FileName);
      LStringList := TStringList.Create;
      LIniFile.ReadSections(LStringList);
      with LIniFile, ListView1 do
      begin
        if LStringList.Count > 0 then
        begin
          /// Clear
          Items.Clear;
          /// Loop Data From IniFile
          for I := 0 to LStringList.Count - 1 do
          begin
            LI := Items.Add;
            LI.Caption := IntToStr(I);
            LI.SubItems.Add(ReadString(IntToStr(I), 'Tanggal Akuisisi', ''));
            LI.SubItems.Add(ReadString(IntToStr(I), 'Detail Aset', ''));
            LI.SubItems.Add(ReadString(IntToStr(I), 'Akun Aset', ''));
            LI.SubItems.Add(ReadString(IntToStr(I), 'Biaya Akuisisi(IDR)', ''));
            LI.SubItems.Add(ReadString(IntToStr(I), 'Nilai Buku(IDR)', ''));
          end;
        end;
      end;
    finally
      LStringList.Free;
      LIniFile.Free;
    end;
  end;
  fFileName := OpenDialog1.Files[0];
  Delete(fFileName, 1, Length(PathDirectory) + 1);
  FileName.Text := fFileName;
  // Hitung Jumlah
  RefreshCount;
end;
procedure TForm1.actBukaAsetDijualExecute(Sender: TObject);
var
  LIniFile: TIniFile;
  LStringList: TStringList;
  I: Integer;
  LI: TListItem;
  fFileName: String;
begin
  /// Pilih File
  with OpenDialog1 do
  begin
    Execute;
    /// baca File
    try
      LIniFile := TIniFile.Create(FileName);
      LStringList := TStringList.Create;
      LIniFile.ReadSections(LStringList);
      with LIniFile, ListView2 do
      begin
        if LStringList.Count > 0 then
        begin
          /// Clear
          Items.Clear;
          /// Loop Data From IniFile
          for I := 0 to LStringList.Count - 1 do
          begin
            LI := Items.Add;
            LI.Caption := IntToStr(I);
            LI.SubItems.Add(ReadString(IntToStr(I), 'Tanggal', ''));
            LI.SubItems.Add(ReadString(IntToStr(I), 'Detail Aset', ''));
            LI.SubItems.Add(ReadString(IntToStr(I), 'Nilai Jual(IDR)', ''));
            LI.SubItems.Add(ReadString(IntToStr(I), 'Untung/Rugi', ''));
          end;
        end;
      end;
    finally
      LStringList.Free;
      LIniFile.Free;
    end;
  end;
  fFileName := OpenDialog1.Files[0];
  Delete(fFileName, 1, Length(PathDirectory) + 1);
  FileAsetJual.Text := fFileName;
  // Hitung Jumlah
  RefreshCount2;
end;

procedure TForm1.ActTambahAsetAktifExecute(Sender: TObject);
var

  LAValue: array [0 .. 6] of string;
  LocalItem: TListItem;
  fNumber: Integer;
begin
  /// Isi data
  LAValue[0] := FormatDateTime('dd mmmm yyyy', Now);;
  LAValue[1] := '';
  LAValue[2] := '';
  LAValue[3] := '';
  LAValue[4] := '';
  LAValue[5] := '';
  InputQuery('Input Data', ['Tanggal Akuisisi', 'Detail Aset', 'Akun Aset', 'Biaya Akuisisi(IDR)', 'Nilai Buku(IDR)'], LAValue);
  // Masukkan Ke ListView
  fNumber := ListView1.Items.Count + 1;
  LocalItem := ListView1.Items.Add;
  with LocalItem do
  begin
    Caption := IntToStr(fNumber);
    SubItems.Add(LAValue[0]);
    SubItems.Add(LAValue[1]);
    SubItems.Add(LAValue[2]);
    SubItems.Add(LAValue[3]);
    SubItems.Add(LAValue[4]);
    SubItems.Add(LAValue[5]);
  end;
  // Hitung Jumlah
  RefreshCount;
end;
procedure TForm1.ActUbahAsetAktifExecute(Sender: TObject);
var
  LAValue: array [0 .. 6] of string;
begin
  /// Ubah Data
  with ListView1 do
  begin
    Items.BeginUpdate;
    /// Identification Value
    LAValue[0] := Items[Selected.Index].SubItems[0];
    LAValue[1] := Items[Selected.Index].SubItems[1];
    LAValue[2] := Items[Selected.Index].SubItems[2];
    LAValue[3] := Items[Selected.Index].SubItems[3];
    LAValue[4] := Items[Selected.Index].SubItems[4];
    InputQuery('Input Data', ['Tanggal Akuisisi', 'Detail Aset', 'Akun Aset', 'Biaya Akuisisi(IDR)', 'Nilai Buku(IDR)'], LAValue);
    /// Change Value
    Items[Selected.Index].SubItems[0] := LAValue[0];
    Items[Selected.Index].SubItems[1] := LAValue[1];
    Items[Selected.Index].SubItems[2] := LAValue[2];
    Items[Selected.Index].SubItems[3] := LAValue[3];
    Items[Selected.Index].SubItems[4] := LAValue[4];
    Items.EndUpdate;
  end;
end;
procedure TForm1.actUbahAsetDijualExecute(Sender: TObject);
var
  LAValue: array [0 .. 5] of string;
begin
  /// Ubah Data
  with ListView2 do
  begin
    Items.BeginUpdate;
    /// Identification Value
    LAValue[0] := Items[Selected.Index].SubItems[0];
    LAValue[1] := Items[Selected.Index].SubItems[1];
    LAValue[2] := Items[Selected.Index].SubItems[2];
    LAValue[3] := Items[Selected.Index].SubItems[3];
    InputQuery('Input Data', ['Tanggal', 'Detail Aset', 'Nilai Jual(IDR)', 'Untung/Rugi'], LAValue);
    /// Change Value
    Items[Selected.Index].SubItems[0] := LAValue[0];
    Items[Selected.Index].SubItems[1] := LAValue[1];
    Items[Selected.Index].SubItems[2] := LAValue[2];
    Items[Selected.Index].SubItems[3] := LAValue[3];
    Items.EndUpdate;
  end;
end;

procedure TForm1.ActUbahFileAsetAktifExecute(Sender: TObject);
var
  NewFile: String;
begin
  /// Rename File
  NewFile := ReplaceStr(ListBox1.Items[ListBox1.ItemIndex], '.ini', '');
  InputQuery('Ubah Nama Berkas', 'Masukkan Nama File Baru', NewFile);
  RenameFile(PathDirectory + '\' + ListBox1.Items[ListBox1.ItemIndex],
    PathDirectory + '\' + NewFile + '.ini');
  { Refresh ListFile }
  ActListFileAsetAktifExecute(Sender);
end;
procedure TForm1.actUbahFileAsetDijualExecute(Sender: TObject);
var
  NewFile: String;
begin
  /// Rename File
  NewFile := ReplaceStr(ListBox2.Items[ListBox2.ItemIndex], '.ini', '');
  InputQuery('Ubah Nama Berkas', 'Masukkan Nama File Baru', NewFile);
  RenameFile(PathDirectory1 + '\' + ListBox2.Items[ListBox2.ItemIndex],
    PathDirectory1 + '\' + NewFile + '.ini');
  { Refresh ListFile }
  ActListFileAsetDijualExecute(Sender);
end;

procedure TForm1.actListFileAsetDijualExecute(Sender: TObject);
begin
  ListBox2.Items.Clear;
  FindFilePattern2(Label3.Caption + '\', '*.*');
  // Hitung Jumlah
  RefreshCount2;
end;

procedure TForm1.actSimpanAsetDijualExecute(Sender: TObject);
var
  LIniFile: TIniFile;
  I: Integer;
begin
  /// Save Data IniFile Format
  try
    /// Delete File
    if FileExists(PathDirectory1 + '\' + FileAsetJual.Text) then
      DeleteFile(PathDirectory1 + '\' + FileAsetJual.Text);
    LIniFile := TIniFile.Create(PathDirectory1 + '\' + FileAsetJual.Text + '.ini');
    /// Save Record TO File
    with LIniFile, ListView2 do
    begin
      for I := 0 to Items.Count - 1 do
      begin
        WriteString(IntToStr(I), 'Tanggal', Items[I].SubItems[0]);
        WriteString(IntToStr(I), 'Detail Aset', Items[I].SubItems[1]);
        WriteString(IntToStr(I), 'Nilai Jual(IDR)', Items[I].SubItems[2]);
        WriteString(IntToStr(I), 'Untung/Rugi', Items[I].SubItems[3]);
      end;
    end;
    MessageDlg('Data Berhasil diSimpan', mtInformation, [mbOK], 0);
    ActListFileAsetDijualExecute(Sender);
    // Hitung Jumlah
    RefreshCount2;
  finally
    LIniFile.Free;
  end;
end;
procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
var
  I: Integer;
begin
  if Key = #13 then
  begin
    ListBox1.Items.BeginUpdate;
    try
      for I := 0 to ListBox1.Items.Count - 1 do
        ListBox1.Selected[I] := ContainsText(ListBox1.Items[I], Edit1.Text);
    finally
      ListBox1.Items.EndUpdate;
    end;
  end;
end;
procedure TForm1.Edit2KeyPress(Sender: TObject; var Key: Char);
var
  I: Integer;
begin
  if Key = #13 then
  begin
    ListBox2.Items.BeginUpdate;
    try
      for I := 0 to ListBox2.Items.Count - 1 do
        ListBox2.Selected[I] := ContainsText(ListBox2.Items[I], Edit2.Text);
    finally
      ListBox2.Items.EndUpdate;
    end;
  end;
end;

procedure TForm1.FindFilePattern(root, pattern: String);
var
  SR: TSearchRec;
begin
  root := IncludeTrailingPathDelimiter(root);
  if FindFirst(root + '*.*', faAnyFile, SR) = 0 then
    try
      repeat
        Application.ProcessMessages;
        if (SR.Attr and faDirectory) <> 0 then
        begin
          if (SR.Name <> '.') and (SR.Name <> '..') then
            FindFilePattern(root + SR.Name, pattern);
        end
        else
        begin
          if MatchesMask(SR.Name, pattern) then
            Form1.ListBox1.Items.Add(SR.Name);
        end;
      until FindNext(SR) <> 0;
    finally
      FindClose(SR);
    end;
end;

procedure TForm1.FindFilePattern2(root, pattern: String);
var
  SR: TSearchRec;
begin
  root := IncludeTrailingPathDelimiter(root);
  if FindFirst(root + '*.*', faAnyFile, SR) = 0 then
    try
      repeat
        Application.ProcessMessages;
        if (SR.Attr and faDirectory) <> 0 then
        begin
          if (SR.Name <> '.') and (SR.Name <> '..') then
            FindFilePattern2(root + SR.Name, pattern);
        end
        else
        begin
          if MatchesMask(SR.Name, pattern) then
            Form1.ListBox2.Items.Add(SR.Name);
        end;
      until FindNext(SR) <> 0;
    finally
      FindClose(SR);
    end;
end;
procedure TForm1.FormShow(Sender: TObject);
var
  I: Integer;
begin
  /// Path Directory to Save File.
  LPath.Caption := PathDirectory;
  Label3.Caption := PathDirectory1;
  if not DirectoryExists(PathDirectory) then
    ForceDirectories(PathDirectory);
  if not DirectoryExists(PathDirectory1) then
    ForceDirectories(PathDirectory1);
  /// List File To ListBox
  ActListFileAsetAktifExecute(Sender);
  ActListFileAsetDijualExecute(Sender);
end;
procedure TForm1.ListBox1DblClick(Sender: TObject);
var
  LIniFile: TIniFile;
  LStringList: TStringList;
  LI: TListItem;
  I: Integer;
begin
  /// Read Record From File
  /// baca File
  try
    LIniFile := TIniFile.Create(LPath.Caption + '\' + ListBox1.Items
      [ListBox1.ItemIndex]);
    LStringList := TStringList.Create;
    LIniFile.ReadSections(LStringList);
    FileName.Text := ReplaceStr(ListBox1.Items[ListBox1.ItemIndex], '.ini', '');
    with LIniFile, ListView1 do
    begin
      if LStringList.Count > 0 then
      begin
        /// Clear
        Items.Clear;
        /// Loop Data From IniFile
        for I := 0 to LStringList.Count - 1 do
        begin
          LI := Items.Add;
          LI.Caption := IntToStr(I);
          LI.SubItems.Add(ReadString(IntToStr(I), 'Tanggal Akuisisi', ''));
          LI.SubItems.Add(ReadString(IntToStr(I), 'Detail Aset', ''));
          LI.SubItems.Add(ReadString(IntToStr(I), 'Akun Aset', ''));
          LI.SubItems.Add(ReadString(IntToStr(I), 'Biaya Akuisisi(IDR)', ''));
          LI.SubItems.Add(ReadString(IntToStr(I), 'Nilai Buku(IDR)', ''));
        end;
      end;
    end;
    // Hitung Jumlah
    RefreshCount;
  finally
    LStringList.Free;
    LIniFile.Free;
  end;
end;
procedure TForm1.ListBox2DblClick(Sender: TObject);
var
  LIniFile: TIniFile;
  LStringList: TStringList;
  LI: TListItem;
  I: Integer;
begin
  /// Read Record From File
  /// baca File
  try
    LIniFile := TIniFile.Create(Label3.Caption + '\' + ListBox2.Items
      [ListBox2.ItemIndex]);
    LStringList := TStringList.Create;
    LIniFile.ReadSections(LStringList);
    FileAsetJual.Text := ReplaceStr(ListBox2.Items[ListBox2.ItemIndex], '.ini', '');
    with LIniFile, ListView2 do
    begin
      if LStringList.Count > 0 then
      begin
        /// Clear
        Items.Clear;
        /// Loop Data From IniFile
        for I := 0 to LStringList.Count - 1 do
        begin
          LI := Items.Add;
          LI.Caption := IntToStr(I);
          LI.SubItems.Add(ReadString(IntToStr(I), 'Tanggal', ''));
          LI.SubItems.Add(ReadString(IntToStr(I), 'Detail Aset', ''));
          LI.SubItems.Add(ReadString(IntToStr(I), 'NIlai Jual(IDR)', ''));
          LI.SubItems.Add(ReadString(IntToStr(I), 'Untung/Rugi', ''));
        end;
      end;
    end;
    // Hitung Jumlah
    RefreshCount;
  finally
    LStringList.Free;
    LIniFile.Free;
  end;
end;

procedure TForm1.ListView1ColumnClick(Sender: TObject; Column: TListColumn);
begin
  { determine the sort style }
  if Column.Index = Column.Index then
    LvSortStyle := cssAlphaNum
  else
    LvSortStyle := cssNumeric;
  { Call the CustomSort method }
  ListView1.CustomSort(@CustomSortProc, Column.Index - 1);
  { Set the sort order for the column }
  LvSortOrder[Column.Index] := not LvSortOrder[Column.Index];
end;
procedure TForm1.ListView2ColumnClick(Sender: TObject; Column: TListColumn);
begin
  { determine the sort style }
  if Column.Index = Column.Index then
    LvSortStyle := cssAlphaNum
  else
    LvSortStyle := cssNumeric;
  { Call the CustomSort method }
  ListView1.CustomSort(@CustomSortProc, Column.Index - 1);
  { Set the sort order for the column }
  LvSortOrder[Column.Index] := not LvSortOrder[Column.Index];
end;

function TForm1.PathDirectory: string;
begin
  Result := ExtractFileDir(Application.ExeName) + '\Aset Aktif';
end;
function TForm1.PathDirectory1: string;
begin
  Result := ExtractFileDir(Application.ExeName) + '\Aset Terjual';
end;
procedure TForm1.RefreshCount;
begin
  /// Hitung Jumlah File
  StatusBar1.Panels[1].Text := IntToStr(ListBox1.Items.Count);
  /// Jumlah data Inifile
  StatusBar1.Panels[3].Text := IntToStr(ListView1.Items.Count);
end;

procedure TForm1.RefreshCount2;
begin
  /// Hitung Jumlah File
  StatusBar2.Panels[1].Text := IntToStr(ListBox2.Items.Count);
  /// Jumlah data Inifile
  StatusBar2.Panels[3].Text := IntToStr(ListView2.Items.Count);
end;
end.
