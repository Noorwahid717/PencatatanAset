object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Pencatatan Aset'
  ClientHeight = 603
  ClientWidth = 877
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 877
    Height = 603
    ActivePage = TabSheet1
    Align = alClient
    PopupMenu = PM01
    TabHeight = 25
    TabOrder = 0
    ExplicitHeight = 604
    object TabSheet1: TTabSheet
      Caption = 'Aset Aktif'
      object GroupBox1: TGroupBox
        Left = 0
        Top = 73
        Width = 145
        Height = 476
        Align = alLeft
        Caption = 'Options'
        TabOrder = 0
        ExplicitHeight = 477
        object Button1: TButton
          Left = 2
          Top = 15
          Width = 141
          Height = 26
          Action = AcSimpanAsetAktif
          Align = alTop
          TabOrder = 0
        end
        object ListBox1: TListBox
          Left = 2
          Top = 87
          Width = 141
          Height = 387
          Align = alClient
          ItemHeight = 13
          TabOrder = 1
          OnDblClick = ListBox1DblClick
          ExplicitHeight = 388
        end
        object Button2: TButton
          Left = 2
          Top = 41
          Width = 141
          Height = 25
          Action = ActHapusFileAsetAktif
          Align = alTop
          TabOrder = 2
        end
        object Edit1: TEdit
          Left = 2
          Top = 66
          Width = 141
          Height = 21
          Align = alTop
          TabOrder = 3
          TextHint = 'Cari Nama File'
          OnKeyPress = Edit1KeyPress
        end
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 869
        Height = 73
        Align = alTop
        Caption = 'Judul Dokumen'
        TabOrder = 1
        object Label1: TLabel
          Left = 16
          Top = 20
          Width = 29
          Height = 13
          Caption = 'Path :'
        end
        object LPath: TLabel
          Left = 51
          Top = 20
          Width = 59
          Height = 13
          Caption = 'Location File'
        end
        object FileName: TLabeledEdit
          Left = 64
          Top = 39
          Width = 661
          Height = 21
          EditLabel.Width = 46
          EditLabel.Height = 13
          EditLabel.BiDiMode = bdLeftToRight
          EditLabel.Caption = 'File Name'
          EditLabel.ParentBiDiMode = False
          LabelPosition = lpLeft
          TabOrder = 0
        end
      end
      object ListView1: TListView
        Left = 145
        Top = 73
        Width = 724
        Height = 476
        Align = alClient
        Columns = <
          item
            Caption = 'No'
            Width = 25
          end
          item
            Caption = 'Tanggal Akuisisi'
            Width = 150
          end
          item
            Caption = 'Detail Aset'
            Width = 150
          end
          item
            Caption = 'Akun Aset'
            Width = 150
          end
          item
            Caption = 'Biaya Akuisisi(IDR)'
            Width = 110
          end
          item
            Caption = 'Nilai Buku(IDR)'
            Width = 100
          end>
        TabOrder = 2
        ViewStyle = vsReport
        OnColumnClick = ListView1ColumnClick
      end
      object StatusBar1: TStatusBar
        Left = 0
        Top = 549
        Width = 869
        Height = 19
        Panels = <
          item
            Text = 'Jumlah File :'
            Width = 70
          end
          item
            Width = 75
          end
          item
            Text = 'Jumlah Data :'
            Width = 80
          end
          item
            Width = 80
          end>
        ExplicitTop = 550
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Aset Dijual'
      ImageIndex = 1
      object StatusBar2: TStatusBar
        Left = 0
        Top = 549
        Width = 869
        Height = 19
        Panels = <
          item
            Text = 'Jumlah File :'
            Width = 70
          end
          item
            Width = 75
          end
          item
            Text = 'Jumlah Data :'
            Width = 80
          end
          item
            Width = 80
          end>
        ExplicitTop = 550
      end
      object ListView2: TListView
        Left = 145
        Top = 73
        Width = 724
        Height = 476
        Align = alClient
        Columns = <
          item
            Caption = 'No Transaksi'
            Width = 75
          end
          item
            Caption = 'Tanggal'
            Width = 100
          end
          item
            Caption = 'Detail Aset'
            Width = 150
          end
          item
            Caption = 'Harga Jual(IDR)'
            Width = 200
          end
          item
            Caption = 'Untung/Rugi'
            Width = 150
          end>
        TabOrder = 1
        ViewStyle = vsReport
        OnColumnClick = ListView2ColumnClick
        ExplicitHeight = 477
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 0
        Width = 869
        Height = 73
        Align = alTop
        Caption = 'Judul Dokumen'
        TabOrder = 2
        object Label2: TLabel
          Left = 16
          Top = 20
          Width = 29
          Height = 13
          Caption = 'Path :'
        end
        object Label3: TLabel
          Left = 51
          Top = 20
          Width = 59
          Height = 13
          Caption = 'Location File'
        end
        object FileAsetJual: TLabeledEdit
          Left = 64
          Top = 39
          Width = 661
          Height = 21
          EditLabel.Width = 46
          EditLabel.Height = 13
          EditLabel.BiDiMode = bdLeftToRight
          EditLabel.Caption = 'File Name'
          EditLabel.ParentBiDiMode = False
          LabelPosition = lpLeft
          TabOrder = 0
        end
      end
      object GroupBox4: TGroupBox
        Left = 0
        Top = 73
        Width = 145
        Height = 476
        Align = alLeft
        Caption = 'Options'
        TabOrder = 3
        ExplicitHeight = 477
        object Button3: TButton
          Left = 2
          Top = 15
          Width = 141
          Height = 26
          Action = actSimpanAsetDijual
          Align = alTop
          TabOrder = 0
        end
        object ListBox2: TListBox
          Left = 2
          Top = 87
          Width = 141
          Height = 387
          Align = alClient
          ItemHeight = 13
          TabOrder = 1
          OnDblClick = ListBox2DblClick
          ExplicitHeight = 388
        end
        object Button4: TButton
          Left = 2
          Top = 41
          Width = 141
          Height = 25
          Action = actHapusFileAsetDijual
          Align = alTop
          TabOrder = 2
        end
        object Edit2: TEdit
          Left = 2
          Top = 66
          Width = 141
          Height = 21
          Align = alTop
          TabOrder = 3
          TextHint = 'Cari Nama File'
          OnKeyPress = Edit2KeyPress
        end
      end
    end
  end
  object AL01: TActionList
    Left = 492
    Top = 39
    object AcSimpanAsetAktif: TAction
      Caption = 'Simpan Aset Aktif'
      ShortCut = 16467
      OnExecute = AcSimpanAsetAktifExecute
    end
    object ActHapusAsetAktif: TAction
      Caption = 'Hapus Aset Aktif'
      ShortCut = 46
      OnExecute = ActHapusAsetAktifExecute
    end
    object ActTambahAsetAktif: TAction
      Caption = 'Tambah Aset Aktif'
      ShortCut = 16457
      OnExecute = ActTambahAsetAktifExecute
    end
    object ActUbahAsetAktif: TAction
      Caption = 'Ubah Aset Aktif'
      ShortCut = 113
      OnExecute = ActUbahAsetAktifExecute
    end
    object ActBukaAsetAktif: TAction
      Caption = 'Buka Aset Aktif'
      ShortCut = 16463
      OnExecute = ActBukaAsetAktifExecute
    end
    object ActListFileAsetAktif: TAction
      Caption = 'Daftar Berkas Aset Aktif'
      ShortCut = 16460
      OnExecute = ActListFileAsetAktifExecute
    end
    object ActHapusFileAsetAktif: TAction
      Caption = 'Hapus File Aset Aktif'
      ShortCut = 16430
      OnExecute = ActHapusFileAsetAktifExecute
    end
    object ActUbahFileAsetAktif: TAction
      Caption = 'Ubah File Aset Aktif'
      ShortCut = 16497
      OnExecute = ActUbahFileAsetAktifExecute
    end
    object actJualAset: TAction
      Caption = 'Jual Aset'
      ShortCut = 16458
      OnExecute = actJualAsetExecute
    end
    object actSimpanAsetDijual: TAction
      Caption = 'Simpan Aset Dijual'
      ShortCut = 49235
      OnExecute = actSimpanAsetDijualExecute
    end
    object actHapusFileAsetDijual: TAction
      Caption = 'Hapus File Aset Dijual'
      ShortCut = 8238
      OnExecute = actHapusFileAsetDijualExecute
    end
    object actUbahAsetDijual: TAction
      Caption = 'Ubah Aset Dijual'
      ShortCut = 8305
      OnExecute = actUbahAsetDijualExecute
    end
    object actHapusAsetDijual: TAction
      Caption = 'Hapus Aset Dijual'
      ShortCut = 32814
      OnExecute = actHapusAsetDijualExecute
    end
    object actListFileAsetDijual: TAction
      Caption = 'Daftar Berkas Aset Dijual'
      ShortCut = 24652
      OnExecute = actListFileAsetDijualExecute
    end
    object actBukaAsetDijual: TAction
      Caption = 'Buka Aset Dijual'
      ShortCut = 49231
      OnExecute = actBukaAsetDijualExecute
    end
    object actUbahFileAsetDijual: TAction
      Caption = 'Ubah File Aset Dijual'
      ShortCut = 24689
      OnExecute = actUbahFileAsetDijualExecute
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 600
    Top = 40
  end
  object PM01: TPopupMenu
    Left = 548
    Top = 39
    object Open1: TMenuItem
      Action = ActBukaAsetAktif
    end
    object actBukaAsetDijual1: TMenuItem
      Action = actBukaAsetDijual
    end
    object AcSimpan1: TMenuItem
      Action = AcSimpanAsetAktif
    end
    object SimpanAsetDijual1: TMenuItem
      Action = actSimpanAsetDijual
    end
    object UbahFile1: TMenuItem
      Action = ActUbahFileAsetAktif
    end
    object UbahFileAsetDijual1: TMenuItem
      Action = actUbahFileAsetDijual
    end
    object HapusFile1: TMenuItem
      Action = ActHapusFileAsetAktif
    end
    object HapusFile2: TMenuItem
      Action = actHapusFileAsetDijual
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object ActTambah1: TMenuItem
      Action = ActTambahAsetAktif
    end
    object ActHapus1: TMenuItem
      Action = ActHapusAsetAktif
    end
    object ActUbah1: TMenuItem
      Action = ActUbahAsetAktif
    end
    object JualAset1: TMenuItem
      Action = actJualAset
    end
    object UbahAsetDijual1: TMenuItem
      Action = actUbahAsetDijual
    end
    object HapusAsetDijual1: TMenuItem
      Action = actHapusAsetDijual
    end
    object DaftarFileAsetAktif1: TMenuItem
      Action = ActListFileAsetAktif
    end
    object DaftarBerkasAsetDijual1: TMenuItem
      Action = actListFileAsetDijual
    end
  end
end
