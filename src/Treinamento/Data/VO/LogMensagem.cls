Class Treinamento.Data.VO.LogMensagem Extends (%SerialObject, %XML.Adaptor)
{

Property Metodo As %String;

Property Classe As %String;

Property Inicio As %String;

Property Fim As %String;

Property Status As %Boolean;

Property StatusProcesso As %String;

Storage Default
{
<Data name="LogMensagemState">
<Value name="1">
<Value>Metodo</Value>
</Value>
<Value name="2">
<Value>Classe</Value>
</Value>
<Value name="3">
<Value>Inicio</Value>
</Value>
<Value name="4">
<Value>Fim</Value>
</Value>
<Value name="5">
<Value>Status</Value>
</Value>
<Value name="6">
<Value>StatusProcesso</Value>
</Value>
</Data>
<State>LogMensagemState</State>
<StreamLocation>^Treinamento.Da2C80.LogMensagemS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
