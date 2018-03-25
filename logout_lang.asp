<%
lang=request("lang")
langref=request("reflang")
reflang=request("langref")

Session("lang")=lang
Session("reflang")=langref
Session("langref")=reflang
Response.redirect("/")
%>