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
  FMX.StdCtrls, FMX.SegmentedProgresBar, FMX.Colors, FMX.Layouts;

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
    sgmntdprgrsbr1: TSegmentedProgresBar;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses
  System.Threading;
{$R *.fmx}

procedure TForm4.btn1Click(Sender: TObject);
begin
  sgmntdprgrsbr1.Clear;
  sgmntdprgrsbr1.DefaultColor := cmbclrbx1.Color;
  sgmntdprgrsbr1.SegmentsCount := 60;

  TTask.Run(
    procedure
    begin
      TParallel.For(0, sgmntdprgrsbr1.SegmentsCount - 1,
        procedure(I: Integer)
        begin
          TThread.Queue(nil,
            procedure
            begin
              sgmntdprgrsbr1.Segmet[I] := cmbclrbx3.Color;
            end);
          Sleep(1000);
          TThread.Queue(nil,
            procedure
            begin
              sgmntdprgrsbr1.Segmet[I] := cmbclrbx2.Color;
            end);
        end);
    end);

end;

procedure TForm4.FormCreate(Sender: TObject);
begin
  sgmntdprgrsbr1.Segmet[0] := TAlphaColorRec.Darkkhaki;
  sgmntdprgrsbr1.Segmet[2] := TAlphaColorRec.Goldenrod;
  sgmntdprgrsbr1.Segmet[4] := TAlphaColorRec.Red;
end;

end.
