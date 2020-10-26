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
    FSegmentsCount: Integer;
    FDefaultColor: TAlphaColor;
    FColors: TArray<TAlphaColor>;
    procedure SetSegmentsCount(const Value: Integer);
    function GetRectBySegIndex(const Index: Integer): TRectF;
    function GetSegmetColor(Index: Integer): TAlphaColor;
    procedure SetSegmetColor(Index: Integer; const Value: TAlphaColor);
    procedure InitBrush(Index: Integer);
    procedure SetDefaultColor(const Value: TAlphaColor);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure AfterConstruction; override;
    procedure Clear;
    property Segmet[Index: Integer]: TAlphaColor read GetSegmetColor write SetSegmetColor; default;
  published
    property Align;
    property Height;
    property Width;
    property Size;
    property Position;
    property SegmentsCount: Integer read FSegmentsCount write SetSegmentsCount;
    property DefaultColor: TAlphaColor read FDefaultColor write SetDefaultColor;
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
  DefaultColor := TAlphaColorRec.Bisque;
end;

procedure TSegmentedProgresBar.Clear;
begin
  FColors := nil;
end;

function TSegmentedProgresBar.GetRectBySegIndex(const Index: Integer): TRectF;
var
  L, R, T, B: Single;
  Width: Single;
begin
  Width := ClipRect.Width / SegmentsCount;
  L := Width * Index;
  T := ClipRect.Top;
  B := ClipRect.Bottom;
  R := L + Width;
  Result.Create(L, T, R, B);
end;

function TSegmentedProgresBar.GetSegmetColor(Index: Integer): TAlphaColor;
begin
  if Index >= FSegmentsCount then
    raise ERangeError.Create('Index >= SegmentsCount');
  InitBrush(Index);
  Result := FColors[Index];
  Repaint;
end;

procedure TSegmentedProgresBar.InitBrush(Index: Integer);
begin
  if FColors[Index] <= 0 then
    FColors[Index] := FDefaultColor;
end;

procedure TSegmentedProgresBar.Paint;
var
  I: Integer;
begin
  inherited;
  for I := Low(FColors) to High(FColors) do
  begin
    Canvas.Fill.Color := (GetSegmetColor(I));
    Canvas.FillRect(GetRectBySegIndex(I), 1, 1, [], 1);
  end;
end;

procedure TSegmentedProgresBar.SetDefaultColor(const Value: TAlphaColor);
begin
  FDefaultColor := Value;
  Repaint;
end;

procedure TSegmentedProgresBar.SetSegmentsCount(const Value: Integer);
begin
  SetLength(FColors, Value);
  FSegmentsCount := Value;
end;

procedure TSegmentedProgresBar.SetSegmetColor(Index: Integer; const Value: TAlphaColor);
begin
  if Index >= FSegmentsCount then
    raise ERangeError.Create('Index >= SegmentsCount');
  InitBrush(Index);
  FColors[Index] := Value;
  // RepaintRect(GetRectBySegIndex(Index));
  Repaint;
end;

end.
