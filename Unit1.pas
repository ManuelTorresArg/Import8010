unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, StrUtils, EncdDecd, xmldom, DB, DBClient, Provider,
  Xmlxform, DBGrids;

type
  TForm1 = class(TForm)
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    Memo1: TMemo;
    Memo2: TMemo;
    DBGrid1: TDBGrid;
    XMLTransformProvider1: TXMLTransformProvider;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    function DepreStream(Stm : TMemoryStream; origen, fin: string):TMemoryStream;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  lineasPEM_encode,
  lineasPEM_decode,
  lineasPEM_final: TMemoryStream;
  nombre_archivo_detalle, ruta, archivo: string;
  searchResult : TSearchRec;
  ini, fin : Integer;
begin

  if OpenDialog1.Execute then
  begin

    Memo1.Lines.LoadFromFile(OpenDialog1.FileName);
    lineasPEM_encode := TMemoryStream.Create;
    lineasPEM_decode := TMemoryStream.Create;
    lineasPEM_final := TMemoryStream.Create;
    lineasPEM_encode.Position := 0;
    Memo1.Text := AnsiMidStr(Memo1.Text, 21, Pos('-----END', Memo1.text)-21);
    Memo1.lines.SaveToStream(lineasPEM_encode);
    lineasPEM_encode.Position := 0;
    lineasPEM_decode.Position := 0;
    DecodeStream(lineasPEM_encode, lineasPEM_decode);
    lineasPEM_decode.Position := 0;
    lineasPEM_final := DepreStream(lineasPEM_decode, '<tns', '/tns');
    lineasPEM_final.Position := 0;
    lineasPEM_final.SaveToFile(ExtractFilePath(ParamStr(0)) + '-pem_decoded.xml');
    lineasPEM_encode.free;
    lineasPEM_decode.free;
    lineasPEM_final.free;



  end;


end;


function TForm1.DepreStream(Stm : TMemoryStream; origen, fin: string):TMemoryStream;
var
  sTemp : String;
  oStrStm : tStringStream;
  i, ancho_corte: integer;
begin
  oStrStm := tStringStream.create('');
  try
    Stm.Seek(0,soFromBeginning);
    oStrStm.copyfrom(Stm,Stm.Size);
    sTemp := oStrStm.DataString;

     if (Pos('cintaTestigoDigital',sTemp) > 0) then
       ancho_corte := 25
     else
       ancho_corte := 15;

    sTemp := ReplaceStr(sTemp, Chr($0D) +Chr($0A),  Chr($0A)); //cambia los saltos de linea que algunas impresoras generan mal, es 0A no 0D0A
    sTemp := ReplaceStr(sTemp, Chr($04)+chr($82)+chr($04)+chr($00), '');
    sTemp := ReplaceStr(sTemp, Chr($04)+chr($82)+chr($10)+chr($00), '');
    sTemp := ReplaceStr(sTemp, Chr($04)+chr($82)+chr($0C)+chr($00), '');
    sTemp := ReplaceStr(sTemp, Chr($04)+chr($82)+chr($0E)+chr($2A), '');
    sTemp := ReplaceStr(sTemp, Chr($04)+chr($82)+chr($0E)+chr($2B), '');
    sTemp := ReplaceStr(sTemp, Chr($04)+chr($82)+chr($0E)+chr($2C), '');
    sTemp := ReplaceStr(sTemp, Chr($04)+chr($82)+chr($0E)+chr($2D), '');
    sTemp := ReplaceStr(sTemp, Chr($04)+chr($82)+chr($0E)+chr($2E), '');
    sTemp := ReplaceStr(sTemp, Chr($04)+chr($82)+chr($0d), '');
    sTemp := ReplaceStr(sTemp, Chr($04)+chr($82)+chr($04)+chr($00), '');
    sTemp := ReplaceStr(sTemp, Chr($04)+chr($82)+chr($0e)+chr($8f), '');//
    sTemp := ReplaceStr(sTemp, Chr($04)+chr($82)+chr($0e)+chr($44), '');
    sTemp := ReplaceStr(sTemp, Chr($04)+chr($2D), '');

    sTemp := ReplaceStr(sTemp, Chr($04)+chr($2D), '');


    sTemp := ReplaceStr(sTemp, Chr($04)+chr($82)+chr($0e)+chr($33), '');//

    sTemp := ReplaceStr(sTemp, Chr($04)+chr($15), '');
    sTemp := ReplaceStr(sTemp, Chr($04)+chr($19), '');
    sTemp := ReplaceStr(sTemp, Chr($c5), '');
    sTemp := ReplaceStr(sTemp, 'ÿ', '');
    sTemp := ReplaceStr(sTemp, 'Nu/mero', 'Numero');

    // limpia todos los que empiezan con  Chr($04)+chr($82 + 2 mas
    while pos( Chr($04)+chr($82) , stemp) > 0 do begin
      delete(stemp, pos( Chr($04)+chr($82), stemp), 4);
    end;

    if (Pos(origen,sTemp) > 0) and (Pos(fin,sTemp) > 0) then
      begin
        sTemp := copy( sTemp, Pos(origen,sTemp), Pos(fin,sTemp)+ancho_corte - Pos(origen,sTemp));
      end;

    oStrStm.free;
    oStrStm := tStringStream.Create(sTemp);
    Result := tMemoryStream.create;
    oStrStm.Seek(0,soFromBeginning);
    Result.CopyFrom(oStrStm,oStrStm.Size);
    Result.Seek(0,soFromBeginning);
  finally
    oStrStm.free;
  end;
end;




end.
