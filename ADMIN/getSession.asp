<%
returntxt = session("openedStructure")

If Len(returntxt)>0 then

set regEx = New RegExp
regEx.IgnoreCase = True
regEx.Global = True
regEx.Pattern = ",,"
returntxt = regEx.Replace(returntxt, ",")
set regEx=nothing

set regEx = New RegExp
regEx.IgnoreCase = True
regEx.Global = True
regEx.Pattern = ",#,"
returntxt = regEx.Replace(returntxt, ",")
set regEx=nothing

set regEx = New RegExp
regEx.IgnoreCase = True
regEx.Global = True
regEx.Pattern = ",,"
returntxt = regEx.Replace(returntxt, ",")
set regEx=nothing

returntxt=Replace(returntxt,",#,",",")
returntxt=Replace(returntxt,",#,",",")
returntxt=Replace(returntxt,",#,",",")
returntxt=Replace(returntxt,",#,",",")
returntxt=Replace(returntxt,",,",",")

'If Mid(returntxt,1,1)="," Then returntxt=Mid(returntxt,2)
'If Right(returntxt,1)="," Then returntxt=Mid(returntxt,1,Len(returntxt)-1)

session("openedStructure")=returntxt
response.write returntxt
End if
%>