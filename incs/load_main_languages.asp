<%	if isnull(Session("lang")) OR len(Session("lang"))=0 then

	SQL1="SELECT * FROM lingue WHERE LO_main=True AND LO_pubblica=True"
	set record=connection.execute(SQL1)

		if not record.eof then
		Session("lang")=record("IN_valore")
		Session("langref")=Lcase(mid(record("TA_nome"),1,2))
		else
		SQL1="SELECT * FROM lingue WHERE LO_attiva=True AND LO_pubblica=True ORDER BY IN_ordine ASC"
		set record=connection.execute(SQL1)

			if not record.eof then
			Session("lang")=record("IN_valore")
			Session("langref")=Lcase(mid(record("TA_nome"),1,2))
			else
			response.redirect("under_construction.asp")
			response.end
			end if
		end If
		
	end if
%>
