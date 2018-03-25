<% 
Function AddSlashes(input)
    AddSlashes = replace(input,"\","\\")
    AddSlashes = replace(AddSlashes,"'","\'")
    AddSlashes = replace(AddSlashes,chr(34),"\" & chr(34))
End Function

%>