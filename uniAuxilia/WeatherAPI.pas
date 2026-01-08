unit WeatherAPI;

interface

uses IdHTTP, IdSSLOpenSSL, System.JSON, System.SysUtils, System.DateUtils;

type
  TDailyWeather = record
    DataTemp: TDate;
    MaxTemperature: Double;
    MinTemperature: Double;
    MeanTemperature: Double;
    PrecipitationSum: Double;
  end;
  TWeatherDataArray = array of TDailyWeather;

  function GetDailyWeather(Latitude,Longitude:Double; StartDate,EndDate:TDate; Forecast:Boolean): TWeatherDataArray;

implementation

{ TDailyWeatherAPI }

function GetDailyWeather(Latitude,Longitude:Double; StartDate,EndDate:TDate; Forecast:Boolean): TWeatherDataArray;
var
   I:Integer;
   tempValue:Double;
   httpClient:TIdHTTP;
   url,response:String;
   jsonObject:TJSONObject;
   jsonArray,dataArrays:TJSONArray;
   jsonValue,dailyData,item:TJSONValue;
   IdSSLIOHandler:TIdSSLIOHandlerSocketOpenSSL;
begin
   httpClient := TIdHTTP.Create(nil);
   IdSSLIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(httpClient);
   IdSSLIOHandler.SSLOptions.SSLVersions := [sslvTLSv1_2];
   httpClient.IOHandler := IdSSLIOHandler;
   try
      if not Forecast then
         url := Format('https://archive-api.open-meteo.com/v1/archive?latitude=%s&longitude=%s&start_date=%s&end_date=%s&daily=temperature_2m_max,temperature_2m_min,temperature_2m_mean,precipitation_sum',
         [StringReplace(Latitude.ToString,',','.',[]),StringReplace(Longitude.ToString,',','.',[]),
         FormatDateTime('yyyy-mm-dd', StartDate),FormatDateTime('yyyy-mm-dd', EndDate)])
      else
         url := Format('https://api.open-meteo.com/v1/forecast?latitude=%s&longitude=%s&daily=temperature_2m_max,temperature_2m_min,precipitation_sum&forecast_days=7',
         [StringReplace(Latitude.ToString,',','.',[]), StringReplace(Longitude.ToString,',','.',[])]);

      response  := '['+httpClient.Get(url)+']';
      jsonValue := TJSONObject.ParseJSONValue(response);
      if not Assigned(jsonValue) then raise Exception.Create('Falha ao analisar a resposta JSON');
      try
         if jsonValue is TJSONArray then
         begin
            jsonArray := jsonValue as TJSONArray;
            for item in jsonArray do
            begin
               jsonObject := item as TJSONObject;
               dailyData  := jsonObject.GetValue<TJSONObject>('daily');
               dataArrays := dailyData.GetValue<TJSONArray>('time');
               SetLength(Result, dataArrays.Count);
               for I := 0 to dataArrays.Count -1 do
               begin
                  Result[I].DataTemp := ISO8601ToDate(dataArrays.Items[I].Value);
                  if TryStrToFloat(StringReplace(dailyData.GetValue<TJSONArray>('temperature_2m_max').Items[I].Value, '.', ',', [rfReplaceAll]), tempValue) then
                     Result[I].MaxTemperature := StrToFloat(StringReplace(dailyData.GetValue<TJSONArray>('temperature_2m_max').Items[I].Value, '.', ',', [rfReplaceAll]));
                  if TryStrToFloat(StringReplace(dailyData.GetValue<TJSONArray>('temperature_2m_min').Items[I].Value, '.', ',', [rfReplaceAll]), tempValue) then
                     Result[I].MinTemperature := StrToFloat(StringReplace(dailyData.GetValue<TJSONArray>('temperature_2m_min').Items[I].Value, '.', ',', [rfReplaceAll]));
                  if not Forecast then
                     if TryStrToFloat(StringReplace(dailyData.GetValue<TJSONArray>('temperature_2m_mean').Items[I].Value, '.', ',', [rfReplaceAll]), tempValue) then
                        Result[I].MeanTemperature  := StrToFloat(StringReplace(dailyData.GetValue<TJSONArray>('temperature_2m_mean').Items[I].Value, '.', ',',[rfReplaceAll]));
                  if TryStrToFloat(StringReplace(dailyData.GetValue<TJSONArray>('precipitation_sum').Items[I].Value, '.', ',', [rfReplaceAll]), tempValue) then
                     Result[I].PrecipitationSum := StrToFloat(StringReplace(dailyData.GetValue<TJSONArray>('precipitation_sum').Items[I].Value, '.', ',',  [rfReplaceAll]));
               end; //for
            end; //for
         end
         else raise Exception.Create('A resposta JSON não é um array');
      finally
         jsonValue.Free;
      end;
   finally
      IdSSLIOHandler.Free;
      httpClient.Free;
   end;
end;

end.

