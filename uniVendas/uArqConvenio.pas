unit uArqConvenio;

interface

uses
  System.SysUtils;

type
  TArqConvenio = class
  private
    FIDConv: Integer;
    FNomcon: String;
  public
    property IDConv: Integer read FIDConv write FIDConv;
    property Nomcon: String read FNomcon write FNomcon;

    constructor Create(AIDConv: Integer; ANomcon: String);
    destructor Destroy; override;
  end;

implementation

constructor TArqConvenio.Create(AIDConv: Integer; ANomcon: String);
begin
  FIDConv:= AIDConv;
  FNomcon:= ANomcon;
end;

destructor TArqConvenio.Destroy;
begin
  inherited;
end;

end.
