unit Demo.Main;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.SegmentedProgresBar,
  FMX.Colors,
  FMX.Layouts,
  System.Threading;

type
  TForm4 = class(TForm)
    cmbclrbx1: TComboColorBox;
    lyt1: TLayout;
    lbl1: TLabel;
    lyt2: TLayout;
    cmbclrbx2: TComboColorBox;
    lbl2: TLabel;
    lyt3: TLayout;
    cmbclrbx3: TComboColorBox;
    lbl3: TLabel;
    btn1: TButton;
    Layout1: TLayout;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FTask: iTask;
    FSegmentBar: TSegmentedProgresBar;
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.fmx}

procedure TForm4.btn1Click(Sender: TObject);
begin
  FSegmentBar.DefaultColor := cmbclrbx1.Color;
  FTask := TTask.Run(
    procedure
    begin
      TParallel.For(0, FSegmentBar.SegmentsCount - 1,
        procedure(I: Integer)
        begin
          TThread.Queue(nil,
            procedure
            begin
              FSegmentBar.Segmet[I] := cmbclrbx3.Color;
            end);
          Sleep(Random(3000));
          TThread.Queue(nil,
            procedure
            begin
              FSegmentBar.Segmet[I] := cmbclrbx2.Color;
            end);
        end);
    end);

end;

procedure TForm4.FormCreate(Sender: TObject);
begin
  FSegmentBar := TSegmentedProgresBar.Create(nil);
  FSegmentBar.SegmentsCount := 60;
  FSegmentBar.Align := TAlignLayout.Client;
  FSegmentBar.Parent := Layout1;
  FSegmentBar.Segmet[0] := TAlphaColorRec.Darkkhaki;
  FSegmentBar.Segmet[2] := TAlphaColorRec.Goldenrod;
  FSegmentBar.Segmet[4] := TAlphaColorRec.Red;
end;

procedure TForm4.FormDestroy(Sender: TObject);
begin
  TTask.WaitForAll([FTask]);
  FSegmentBar.Free;
end;

end.
