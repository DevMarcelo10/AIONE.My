object DMServer: TDMServer
  OnCreate = ServerMethodDataModuleCreate
  OnDestroy = ServerMethodDataModuleDestroy
  Encoding = esUtf8
  QueuedRequest = False
  Height = 255
  Width = 462
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
    Left = 44
    Top = 185
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 173
    Top = 103
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 168
    Top = 23
  end
  object FDConnect: TFDConnection
    ConnectionName = 'dbaione'
    Params.Strings = (
      'User_Name=root'
      'Server=localhost'
      'Database=dbaione'
      'Password=f68interdb'
      'Port=3307'
      'DriverID=MySQL'
      'CharacterSet=utf8')
    UpdateOptions.AssignedValues = [uvCountUpdatedRecords]
    UpdateOptions.CountUpdatedRecords = False
    ConnectedStoredUsage = [auDesignTime]
    LoginPrompt = False
    Left = 48
    Top = 24
  end
  object RESTDWDriverFD: TRESTDWDriverFD
    CommitRecords = 100
    Connection = FDConnect
    Left = 48
    Top = 110
  end
  object DWServerEvents: TRESTDWServerEvents
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
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Campo'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Versao'
            Encoded = True
          end>
        DataMode = dmDataware
        Name = 'VersaoApp'
        EventName = 'VersaoApp'
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
            ParamName = 'FILIAL'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Tabela'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'NroDocto'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Modelo'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'CPFnf'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Mailnf'
            Encoded = True
          end>
        DataMode = dmDataware
        Name = 'EmiteNF'
        EventName = 'EmiteNF'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEventsEventsEmiteNFReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        Params = <>
        DataMode = dmDataware
        Name = 'GetDocNF'
        EventName = 'GetDocNF'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        Params = <>
        DataMode = dmDataware
        Name = 'CancelaNF'
        EventName = 'CancelaNF'
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
            ParamName = 'Razao'
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
            ParamName = 'Serie'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Vencimentos'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Certificados'
            Encoded = True
          end>
        DataMode = dmDataware
        Name = 'GetCertificados'
        EventName = 'GetCertificados'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEventsEventsGetCertificadosReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        Params = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Filial'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'ChaveNF'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'ModeloNF'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'arqXML'
            Encoded = True
          end>
        DataMode = dmDataware
        Name = 'GetXML'
        EventName = 'GetXML'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEventsEventsGetXMLReplyEvent
      end>
    Left = 176
    Top = 184
  end
  object spdNFe_base: TspdNFe
    VersaoManual = vm60
    AnexarDanfePDF = True
    DanfeSettings.FraseContingencia = 
      'Danfe em conting'#234'ncia - Impresso em decorr'#234'ncia de problemas t'#233'c' +
      'nicos'
    DanfeSettings.FraseHomologacao = 'SEM VALOR FISCAL'
    DanfeSettings.QtdeCopias = 1
    DanfeSettings.LineDelimiter = '|'
    DanfeSettings.InfCplMaxCol = 68
    DanfeSettings.InfCplMaxRow = 7
    DanfeSettings.ImprimirVolume = False
    DanfeSettings.ImprimirDuplicata = True
    DanfeSettings.MensagemPartilhaAutomatica = False
    DanfeSettings.MensagemFCP = False
    DanfeSettings.ImprimirUnidadeTributada = False
    DanfeSettings.ImprimirObsCont = False
    DanfeSettings.ImprimirFrenteVerso = fvDesabilitado
    DanfeSettings.ImprimirLocalRetiradaEntrega = True
    DanfeSettings.InfCplQuebrarLinhaAut = False
    DanfeSettings.MensagemIcmsDesonerado = False
    DanfeSettings.ImprimirVlrTotalDanfeSimplificado = False
    DanfeSettings.MensagemIcmsMonofasico = False
    DanfeSettings.ExibirAcrescimoEDesconto = False
    Versao = '14.1.6.51'
    CaracteresRemoverAcentos = #225#233#237#243#250#224#232#236#242#249#226#234#238#244#251#228#235#239#246#252#227#245#241#231#193#201#205#211#218#192#200#204#210#217#194#202#206#212#219#196#203#207#214#220#195#213#209#199#186#170
    TipoCertificado = ckMemory
    DiretorioTemplates = 
      'C:\Program Files (x86)\Embarcadero\Studio\22.0\bin\Templatesvm60' +
      'vm60\vm60\'
    IgnoreInvalidCertificates = False
    DiretorioLog = 'C:\Program Files (x86)\Embarcadero\Studio\22.0\bin\Log\'
    Ambiente = akHomologacao
    EmailSettings.Autenticacao = False
    EmailSettings.TimeOut = 0
    EmailSettings.ConteudoHtml = False
    EmailSettings.UseSecureBlackBox = False
    EmailSettings.QtdeTentativas = 0
    EmailSettings.UseTLS = utNoTLSSupport
    EmailSettings.UseOAuth2 = False
    DiretorioEsquemas = 
      'C:\Program Files (x86)\Embarcadero\Studio\22.0\bin\Esquemasvm60v' +
      'm60vm60vm60vm60vm60vm60vm60vm60vm60vm60vm60\vm60\'
    ConexaoSegura = False
    TimeOut = 0
    DiretorioLogErro = 'C:\Program Files (x86)\Embarcadero\Studio\22.0\bin\LogErro\'
    DiretorioTemporario = 'C:\ProgramData\'
    ModoOperacao = moNormal
    EntregaXML = exEmail
    AtualizarArquivoServidores = True
    DiagnosticMode = True
    DiretorioXmlDestinatario = 
      'C:\Program Files (x86)\Embarcadero\Studio\22.0\bin\XmlDestinatar' +
      'io\'
    DiretorioDownloads = 'C:\Program Files (x86)\Embarcadero\Studio\22.0\bin\Downloads\'
    MaxSizeLoteEnvio = 500
    DanfeSimplificado = False
    Left = 312
    Top = 23
  end
  object spdNFeDS: TspdNFeDataSets
    VersaoEsquema = pl_010b
    ValidaRegrasNegocio = False
    ValidaRegrasNegocioTecno = False
    UsarDatasetExportacao = False
    Left = 312
    Top = 103
  end
  object spdNFCe: TspdNFCe
    VersaoManual = vm60
    DanfceSettings.FraseContingencia = 
      'DANFCE em conting'#234'ncia - Impresso em decorr'#234'ncia de problemas t'#233 +
      'cnicos'
    DanfceSettings.FraseHomologacao = 'SEM VALOR FISCAL'
    DanfceSettings.QtdeCopias = 1
    DanfceSettings.LineDelimiter = '|'
    DanfceSettings.InfCplMaxCol = 68
    DanfceSettings.InfCplMaxRow = 7
    DanfceSettings.ModeloDanfce = 
      'C:\Program Files (x86)\Borland\Delphi7\Bin\Templates\Vm60\Danfce' +
      '\retrato.rtm'
    DanfceSettings.ModeloDanfceMensagemEletronica = 
      'C:\Program Files (x86)\Borland\Delphi7\Bin\Templates\Vm60\Danfce' +
      '\retrato.rtm'
    DanfceSettings.FormatoDanfce = fdNormal
    DanfceSettings.ExibirDetalhamento = False
    DanfceSettings.ExibirAcrescimoEDesconto = False
    DanfceSettings.InfCplQuebrarLinhaAut = False
    DanfceSettings.ImprimirFrete = False
    DanfceSettings.ImprimirFreteProduto = False
    DanfceSettings.ImprimirISSQNProduto = False
    DanfceSettings.ImprimecAut = False
    DanfceSettings.MensagemIcmsMonofasico = False
    DanfceSettings.CodigoProduto = cpCodigoProduto
    UF = 'MS'
    Versao = '11.1.7.27'
    CaracteresRemoverAcentos = #225#233#237#243#250#224#232#236#242#249#226#234#238#244#251#228#235#239#246#252#227#245#241#231#193#201#205#211#218#192#200#204#210#217#194#202#206#212#219#196#203#207#214#220#195#213#209#199#186#170
    TipoCertificado = ckMemory
    DiretorioTemplates = 'C:\Program Files (x86)\Borland\Delphi7\Bin\Templates\vm60\'
    IgnoreInvalidCertificates = False
    DiretorioLog = 'C:\Program Files (x86)\Borland\Delphi7\Bin\Log\'
    Ambiente = akHomologacao
    EmailSettings.Autenticacao = False
    EmailSettings.TimeOut = 0
    EmailSettings.AnexarDanfcePDF = True
    EmailSettings.ConteudoHtml = False
    EmailSettings.UseSecureBlackBox = False
    EmailSettings.QtdeTentativas = 0
    EmailSettings.UseTLS = utNoTLSSupport
    EmailSettings.UseOAuth2 = False
    DiretorioEsquemas = 'C:\Program Files (x86)\Borland\Delphi7\Bin\Esquemas\vm60\'
    ConexaoSegura = False
    TimeOut = 0
    SectionINI = 'NFCE'
    DiretorioXmlDestinatario = 'C:\Program Files (x86)\Borland\Delphi7\Bin\XmlDestinatario\'
    MaxSizeLoteEnvio = 500
    DiretorioTemporario = 'C:\Program Files (x86)\Borland\Delphi7\Bin\Temp\'
    EntregaXML = exEmail
    DiagnosticMode = True
    AtualizarArquivoServidores = True
    UtilizarEscPOS = False
    EscPosSettings.ModeloEscPos = 1
    EscPosSettings.ColunasFonteNormalEscPos = 48
    EscPosSettings.EspacoEntreLinhasEscPos = 10
    EscPosSettings.LinhasEntreCuponsEscPos = 3
    EscPosSettings.CortaPapelEscPos = True
    EscPosSettings.PaginaDeCodigoEscPos = 2
    EscPosSettings.QtdeCopiasEscPos = 1
    EscPosSettings.ResumidoEscPos = False
    EscPosSettings.ImprimeDescAcrescItemEscPos = False
    EscPosSettings.ImprimeNomeFantasiaEscPos = False
    CnpjSoftwareHouse = '27124815000139'
    TokenSoftwareHouse = '17ee76f292e5c98566cb6b413c0c8dc6'
    Left = 399
    Top = 23
  end
  object spdNFCeDS: TspdNFCeDataSets
    VersaoEsquema = pl_010b
    ValidaRegrasNegocio = False
    ValidaRegrasNegocioTecno = False
    Left = 398
    Top = 103
  end
  object ACBrNFe: TACBrNFe
    Configuracoes.Geral.SSLLib = libWinCrypt
    Configuracoes.Geral.SSLCryptLib = cryWinCrypt
    Configuracoes.Geral.SSLHttpLib = httpWinHttp
    Configuracoes.Geral.SSLXmlSignLib = xsLibXml2
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.Arquivos.SepararPorMes = True
    Configuracoes.Arquivos.DownloadDFe.PathDownload = 'C:\Fontes\AIONE\Distribuicao'
    Configuracoes.Arquivos.SalvarApenasNFeProcessadas = True
    Configuracoes.WebServices.UF = 'MS'
    Configuracoes.WebServices.Ambiente = taProducao
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Configuracoes.Certificados.ArquivoPFX = 'C:\Fontes\AIONE.My\Certificados\FF SENHA 1205Contabil.pfx'
    Configuracoes.Certificados.Senha = '1205Contabil'
    Configuracoes.RespTec.IdCSRT = 0
    Left = 398
    Top = 180
  end
end
