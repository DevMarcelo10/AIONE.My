unit uConfgIni;

interface

uses
   SysUtils, IniFiles;

type
   TConfigManager = class
   private
      FIniFile: TIniFile;
   public
      constructor Create(const FileName: string);
      destructor Destroy; override;
      procedure SaveConfig(IPRemoto:String; PortaRemoto:Integer);
      procedure LoadConfig(var IPRemoto:String; var PortaRemoto:Integer);
   end;

implementation

uses uDM, uConst, uBusca;

constructor TConfigManager.Create(const FileName: string);
begin
   FIniFile := TIniFile.Create(FileName);
end;

procedure TConfigManager.SaveConfig(IPRemoto:String; PortaRemoto:Integer);
begin
   FIniFile.WriteString ('Config', 'IPRemoto',    IPRemoto);
   FIniFile.WriteInteger('Config', 'PortaRemoto', PortaRemoto);
end;

procedure TConfigManager.LoadConfig(var IPRemoto: string; var PortaRemoto:Integer);
begin
   IPRemoto    := FIniFile.ReadString('Config', 'IPRemoto', '');
   PortaRemoto := FIniFile.ReadInteger('Config', 'PortaRemoto', 0);
end;

destructor TConfigManager.Destroy;
begin
   FIniFile.Free;
   inherited;
end;

end.
