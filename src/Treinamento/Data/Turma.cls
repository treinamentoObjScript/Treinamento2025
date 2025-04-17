Class Treinamento.Data.Turma Extends (%Persistent, %XML.Adaptor)
{

Property Instrutor As Treinamento.Data.Instrutor [ SqlColumnNumber = 2 ];

Property DataInicio As %Date [ SqlColumnNumber = 3 ];

Property Status As %String [ SqlColumnNumber = 4 ];

Property Alunos As list Of Treinamento.Data.Aluno [ SqlColumnNumber = 5 ];

Property Curso As Treinamento.Data.Curso [ SqlColumnNumber = 6 ];

/// VerificaStatus
Method VerificaStatus(curso As %String) As %String [ Language = objectscript ]
{
    Set tSC = $$$OK
    Set core = ##class(Treinamento.Data.LogMensagem).%New()
    Try 
    {
        #; Processo de criação de Log
        Set StatusProcesso = "Metodo VerificaStatus executado com sucesso"
        Set pStatus = 1
        Set init = core.CriarEntrada("VerificaStatus", "Treinamento.Data.Turma")
        Set IdLog = init.%Id()

        Set statusTurma = ""	
        Set sql = "Select * from Treinamento_Data.Turma where Curso->Nome = '"_curso_"'"	
        Set resultSet = ##class(%ResultSet).%New()
        Set status = resultSet.Prepare(sql)
        Set status = resultSet.Execute()
        
        If resultSet.Next(){
            
            Set statusTurma = resultSet.Get("Status")
        }
    }
    Catch(exception)
    {
        Set tSC            = exception.AsStatus()
        Set pStatus        = 0
        Set erroMensagem  = $SYSTEM.Status.GetOneErrorText(tSC)
        Set erro           = "IdLog :"_IdLog_ " - ErroLog : "_erroMensagem
        Set Fim            = core.Finalizar(IdLog, erro,  pStatus)  
        Throw exception           

    }
	Set fim = core.Finalizar(IdLog, StatusProcesso, pStatus)
	Return statusTurma
}

/// Imprime Turma
ClassMethod ImprimeTurma(curso As %String) As %String [ Language = objectscript ]
{
     Set tSC = $$$OK
     Set core = ##class(Treinamento.Data.LogMensagem).%New()
      Try 
        {
            Set StatusProcesso = "Metodo ImprimeTurma executado com sucesso"
            Set pStatus = 1
            Set init = core.CriarEntrada("ImprimeTurma", "Treinamento.Data.Turma")
            Set IdLog = init.%Id()

            Set Status = $$$OK    
            Set SQL = "Select * from Treinamento_Data.Turma where Curso->Nome = '"_curso_"'"    
            Set resultSet = ##class(%ResultSet).%New()

            Set status = resultSet.Prepare(SQL)
            if $SYSTEM.Status.IsError(Status) return Status
            
            Set status = resultSet.Execute()
            if $SYSTEM.Status.IsError(Status) return Status

            If resultSet.Next()
            {
                Set idTurma = resultSet.Get("ID")
                Set turma = ##class(Treinamento.Data.Turma).%OpenId(idTurma)
            }
            For x= 1:1: turma.Alunos.Count()
            {
                Set aluno = turma.Alunos.GetAt(x)
            // W "Nome : "_aluno.Nome, " Matricula : "_aluno.Matricula, " Idade :"_aluno.Idade, !
            }
        }
        Catch(exception)
        {
            Set tSC            = exception.AsStatus()
            Set pStatus        = 0
            Set erroMensagem  = $SYSTEM.Status.GetOneErrorText(tSC)
            Set erro           = "IdLog :"_IdLog_ " - ErroLog : "_erroMensagem
            Set Fim            = core.Finalizar(IdLog, erro,  pStatus)  
            Throw exception          

        }
     Set Fim = core.Finalizar(IdLog, StatusProcesso,  pStatus)  
    
    return
}

Storage Default
{
<Data name="TurmaDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Instrutor</Value>
</Value>
<Value name="3">
<Value>DataInicio</Value>
</Value>
<Value name="4">
<Value>Status</Value>
</Value>
<Value name="5">
<Value>Alunos</Value>
</Value>
<Value name="6">
<Value>Curso</Value>
</Value>
</Data>
<DataLocation>^Treinamento.Data.TurmaD</DataLocation>
<DefaultData>TurmaDefaultData</DefaultData>
<ExtentSize>1</ExtentSize>
<IdLocation>^Treinamento.Data.TurmaD</IdLocation>
<IndexLocation>^Treinamento.Data.TurmaI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="Alunos">
<AverageFieldSize>17</AverageFieldSize>
<OutlierSelectivity>.999999:$lb($lb("1"),$lb("2"),$lb("3"))</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="Curso">
<AverageFieldSize>3</AverageFieldSize>
<OutlierSelectivity>.999999:1</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="DataInicio">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="Instrutor">
<AverageFieldSize>3</AverageFieldSize>
<OutlierSelectivity>.999999:1</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="Status">
<AverageFieldSize>12</AverageFieldSize>
<OutlierSelectivity>.999999:"Imcompleto"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^Treinamento.Data.TurmaS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
