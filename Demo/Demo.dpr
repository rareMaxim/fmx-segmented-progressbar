program Demo;

uses
  System.StartUpCopy,
  FMX.Forms,
  Demo.Main in 'Demo.Main.pas' {Form4};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
