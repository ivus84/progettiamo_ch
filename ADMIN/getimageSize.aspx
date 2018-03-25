<%@ Import Namespace="System.IO"%>
<%@ Import Namespace="System.Drawing"%>
<%@ Import Namespace="System.Drawing.Imaging"%>
<%@ Import Namespace="System.Drawing.Drawing2D"%>
<SCRIPT RUNAT="SERVER">
Sub Page_Load()

  Dim immagine as String
  Dim percorso as String
  Dim width as Integer = 0
  Dim height as Integer = 0

  immagine = Request("filename")
  percorso = MapPath("./")
  percorso = Mid(percorso,1,InstrRev(percorso,"\")-1)
  percorso = Mid(percorso,1,InstrRev(percorso,"\")-1)
  percorso = Mid(percorso,1,InstrRev(percorso,"\"))
  percorso = percorso &"wr\images\"
  percorso = percorso & immagine
  immagine = percorso

Dim bmp as System.Drawing.Bitmap = CType(System.Drawing.Image.FromFile(immagine, False), System.Drawing.Bitmap)
width = Convert.ToInt32(bmp.Width)
height = Convert.ToInt32(bmp.Height)
response.write(width & "x" & height)
bmp.Dispose()
Response.End()
End Sub
</SCRIPT>