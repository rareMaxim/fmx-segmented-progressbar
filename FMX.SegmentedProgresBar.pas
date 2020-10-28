unit FMX.SegmentedProgresBar;

interface

uses
  FMX.Controls.Presentation,
  System.Classes,
  FMX.Graphics,
  System.Types,
  System.UITypes;

type
  TSegmentedProgresBar = class(TPresentedControl)
  private
    fSegmentsCount: Integer;
    fDefaultColor: TAlphaColor;
    fColors: TArray<TAlphaColor>;
    fBackgroundColor: TAlphaColor;
    procedure SetSegmentsCount(const Value: Integer);
    function GetRectBySegIndex(const Index: Integer): TRect;
    function GetSegmetColor(Index: Integer): TAlphaColor;
    procedure SetSegmetColor(Index: Integer; const Value: TAlphaColor);
    procedure InitBrush(Index: Integer);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure AfterConstruction; override;
    procedure Clear;
    property Segmet[Index: Integer]: TAlphaColor read GetSegmetColor write SetSegmetColor; default;
  published
    property Align;
    property DefaultColor: TAlphaColor read fDefaultColor write fDefaultColor;
    property BackgroundColor: TAlphaColor read fBackgroundColor write fBackgroundColor;
    property Height;
    property Position;
    property Width;
    property SegmentsCount: Integer read fSegmentsCount write SetSegmentsCount;
    property Size;
  end;

procedure register;

implementation

uses
  FMX.Types,
  FMX.Controls,
  System.SysUtils;

procedure register;
begin
  RegisterComponents('Additional', [TSegmentedProgresBar]);
end;
{ TSegmentedProgresBar }

procedure TSegmentedProgresBar.AfterConstruction;
begin
  inherited;
  Height := 20;
  Width := 100;
end;

constructor TSegmentedProgresBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fDefaultColor := TAlphaColorRec.Bisque;
  fBackgroundColor := TAlphaColorRec.Beige;
end;

procedure TSegmentedProgresBar.Clear;
begin
  fColors := nil;
end;

function TSegmentedProgresBar.GetRectBySegIndex(const Index: Integer): TRect;
var
  lWidth: Integer;
begin
  lWidth := Round(ClipRect.Width / SegmentsCount);
  Result.Left := lWidth * Index;
  Result.Top := Round(ClipRect.Top);
  Result.Bottom := Round(ClipRect.Bottom);
  Result.Right := Result.Left + lWidth;
end;

function TSegmentedProgresBar.GetSegmetColor(Index: Integer): TAlphaColor;
begin
  if Index >= fSegmentsCount then
    raise ERangeError.Create('Index >= SegmentsCount');
  InitBrush(Index);
  Result := fColors[Index];
  Repaint;
end;

procedure TSegmentedProgresBar.InitBrush(Index: Integer);
begin
  if fColors[Index] <= 0 then
    fColors[Index] := fDefaultColor;
end;

procedure TSegmentedProgresBar.Paint;
var
  I: Integer;
begin
  inherited;
  Canvas.Fill.Color := fBackgroundColor;
  Canvas.FillRect(ClipRect, 0, 0, [], 1);
  for I := Low(fColors) to High(fColors) do
  begin
    Canvas.Fill.Color := (GetSegmetColor(I));
    Canvas.FillRect(GetRectBySegIndex(I), 0, 0, [], 1);
  end;
end;

procedure TSegmentedProgresBar.SetSegmentsCount(const Value: Integer);
begin
  SetLength(fColors, Value);
  fSegmentsCount := Value;
end;

procedure TSegmentedProgresBar.SetSegmetColor(Index: Integer; const Value: TAlphaColor);
begin
  if Index >= fSegmentsCount then
    raise ERangeError.Create('Index >= SegmentsCount');
  InitBrush(Index);
  fColors[Index] := Value;
  // RepaintRect(GetRectBySegIndex(Index));
  Repaint;
end;

end.
