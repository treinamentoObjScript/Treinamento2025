Class Treinamento.Data.LogMensagem Extends (%Persistent, %XML.Adaptor)
{

Property Metodo As %String(MAXLEN = 200) [ SqlColumnNumber = 2 ];

Property Classe As %String [ SqlColumnNumber = 3 ];

Property Inicio As %String [ SqlColumnNumber = 4 ];

Property Fim As %String(MAXLEN = 200) [ SqlColumnNumber = 5 ];

Property Status As %Boolean [ SqlColumnNumber = 6 ];

Property StatusProcesso As %String [ SqlColumnNumber = 7 ];

Property ListaLog As list Of Treinamento.Data.VO.LogMensagem;

ClassMethod CriarEntrada(pMetodo As %String, pClasse As %String) As Treinamento.Data.LogMensagem
{
    Set tSC = $$$OK
    try 
    {
        #Dim exception    As %Exception.General = ""
        #Dim statusCode    AS %Status           = $SYSTEM.Status.OK()
        #Dim entry        AS LogMensagem        = ..%New()

        Set entry.Metodo = pMetodo
        Set entry.Classe = pClasse
        Set entry.Inicio = $ZDateTime($HOROLOG,4)
        Set entry.Fim    = ""
        Set entry.Status = statusCode
        Set statusCode = entry.%Save()        

    }
    Catch(exception)
    {
        Set tSC           = exception.AsStatus()
        Set erroMensagem  = $SYSTEM.Status.GetOneErrorText(tSC)
        Throw exception
        
    }
    return entry
}

ClassMethod Finalizar(pIdLog As %Integer, pStatusProcesso As %String, pstatusCode As %String) As Treinamento.Data.LogMensagem
{
    Set tSC = $$$OK
    try 
    {
        #Dim exception    As %Exception.General = ""
        #Dim statusCode    AS %Status           = $SYSTEM.Status.OK()
        #Dim entry        AS LogMensagem        = ..%OpenId(pIdLog)

        Set entry.Fim            = $ZDateTime($HOROLOG,4)
        Set entry.StatusProcesso = pStatusProcesso
        Set entry.Status         = pstatusCode
        Set statusLog            = entry.%Save()       
        

    }
    Catch(exception)
    {
        Set tSC           = exception.AsStatus()
        Set erroMensagem  = $SYSTEM.Status.GetOneErrorText(tSC)
        Throw exception
        
    }
    return entry
}

ClassMethod ConsultaLog(pStatus As %Boolean, pDataInicio As %String = "", pDataFim As %String) As Treinamento.Data.VO.LogMensagem
{
   
    try 
    {   
        #Dim StatusCode   As %Status            = $SYSTEM.Status.OK()
        #Dim exception    As %Exception.General = ""
        #Dim SQL          As %String
        #Dim resultSet    As %ResultSet 
        #Dim entry        AS LogMensagem        = ..%New()

        Set SQL = "SELECT * FROM Treinamento_Data.LogMensagem WHERE Status =  "_pStatus
        Set SQL = SQL_ " AND FIM <= '"_pDataFim_"'"
        Set resultSet = ##class(%ResultSet).%New()
        Set statusCode = resultSet.Prepare(SQL)
        set statusCode = resultSet.Execute()
        if $System.Status.Error(statusCode) return statusCode

        While (resultSet.Next())
        {
            Set pItem = ##class(Treinamento.Data.VO.LogMensagem).%New()
            Set pItem.Metodo          = resultSet.%Get("Metodo")     
            Set pItem.Classe          = resultSet.%Get("Classe")
            Set pItem.Inicio          = resultSet.%Get("Inicio")     
            Set pItem.Fim             = resultSet.%Get("Fim")
            Set pItem.Status          = resultSet.%Get("Status")     
            Set pItem.StatusProcesso  = resultSet.%Get("StatusProcesso")
            Do entry.ListaLog.Insert(pItem)
        }
      

    }
    Catch(exception)
    {
        Set tSC           = exception.AsStatus()
        Set erroMensagem  = $SYSTEM.Status.GetOneErrorText(tSC)
        Throw exception
        
    }
    return entry
}

Storage Default
{
<Data name="LogMensagemDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Metodo</Value>
</Value>
<Value name="3">
<Value>Classe</Value>
</Value>
<Value name="4">
<Value>Inicio</Value>
</Value>
<Value name="5">
<Value>Fim</Value>
</Value>
<Value name="6">
<Value>Status</Value>
</Value>
<Value name="7">
<Value>StatusProcesso</Value>
</Value>
<Value name="8">
<Value>ListaLog</Value>
</Value>
</Data>
<DataLocation>^Treinamento.Data.LogMensagemD</DataLocation>
<DefaultData>LogMensagemDefaultData</DefaultData>
<IdLocation>^Treinamento.Data.LogMensagemD</IdLocation>
<IndexLocation>^Treinamento.Data.LogMensagemI</IndexLocation>
<StreamLocation>^Treinamento.Data.LogMensagemS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
