object DMServer: TDMServer
  OnCreate = ServerMethodDataModuleCreate
  OnDestroy = ServerMethodDataModuleDestroy
  Encoding = esUtf8
  QueuedRequest = False
  Height = 280
  Width = 340
  PixelsPerInch = 115
  object RESTDWPoolerDB: TRESTDWPoolerDB
    RESTDriver = RESTDWDriverFD
    Compression = True
    Encoding = esUtf8
    StrsTrim = False
    StrsEmpty2Null = False
    StrsTrim2Len = True
    Active = False
    PoolerOffMessage = 'RESTPooler not active.'
    ParamCreate = True
    Left = 53
    Top = 193
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 217
    Top = 107
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 211
    Top = 20
  end
  object FDConnect: TFDConnection
    ConnectionName = 'dbaiserver'
    Params.Strings = (
      'User_Name=root'
      'Server=localhost'
      'Database=dbaiserver'
      'Password=f68interdb'
      'Port=3307'
      'DriverID=MySQL')
    UpdateOptions.AssignedValues = [uvCountUpdatedRecords]
    UpdateOptions.CountUpdatedRecords = False
    LoginPrompt = False
    Left = 58
    Top = 29
  end
  object RESTDWDriverFD: TRESTDWDriverFD
    CommitRecords = 100
    Connection = FDConnect
    Left = 58
    Top = 105
  end
  object DWServerEvents1: TRESTDWServerEvents
    IgnoreInvalidParams = False
    Events = <
      item
        Routes = [crAll]
        NeedAuthorization = True
        Params = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'usuario'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'senha'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'IDUsuario'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odINOUT
            ObjectValue = ovBoolean
            ParamName = 'IndMaster'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovBoolean
            ParamName = 'result'
            Encoded = True
          end>
        DataMode = dmDataware
        Name = 'Login'
        EventName = 'Login'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        Params = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Arquivo'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovBlob
            ParamName = 'Result'
            Encoded = True
          end>
        DataMode = dmDataware
        Name = 'DownloadFile'
        EventName = 'DownloadFile'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEventsEventsDownloadFileReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        Params = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'arquivo'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'diretorio'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovBlob
            ParamName = 'filesend'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odINOUT
            ObjectValue = ovBoolean
            ParamName = 'result'
            Encoded = True
          end>
        DataMode = dmDataware
        Name = 'UpLoadFile'
        EventName = 'UpLoadFile'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        Params = <
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovDateTime
            ParamName = 'DataNow'
            Encoded = True
          end>
        DataMode = dmDataware
        Name = 'DataServer'
        EventName = 'DataServer'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        Params = <
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Versao'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'VersaoDB'
            Encoded = True
          end>
        DataMode = dmDataware
        Name = 'VersaoApp'
        EventName = 'VersaoApp'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEventsEventsVersaoAppReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        Params = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Etapa'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovInteger
            ParamName = 'IndSub'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovWideString
            ParamName = 'Frase'
            Encoded = True
          end>
        DataMode = dmDataware
        Name = 'FraseIA'
        EventName = 'FraseIA'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEventsEventsFraseIAReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        Params = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'recSQL'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end>
        DataMode = dmDataware
        Name = 'SincroConv'
        EventName = 'SincroConv'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        Params = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Farmacia'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Filial'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Empresa'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'CNPJ'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end>
        DataMode = dmDataware
        Name = 'ValidaKey'
        EventName = 'ValidaKey'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEventsEventsValidaKeyReplyEvent
      end>
    Left = 219
    Top = 191
  end
end
