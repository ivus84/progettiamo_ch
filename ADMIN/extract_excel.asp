<!--METADATA TYPE="TypeLib" UUID="00000200-0000-0010-8000-00AA006D2EA4" -->
<!--#INCLUDE VIRTUAL="./admin/load_connection_msdasql.asp"-->
<%

table=request("table")

Response.Buffer = true

ContentType = "application/vnd.ms-excel"

tabellat=table
tabella=table

If tabellat="registeredusers" Then tabellat="Utenti registrati"
Response.Charset = "UTF-8"
Response.AddHeader "Content-Disposition", "attachment; filename="&tabellat&"_"&Day(Now())&Month(Now())&Year(Now())&".xls"
Response.ContentType = ContentType

%><!--#INCLUDE VIRTUAL="./admin/load_allowed_columns.asp"-->
<?xml version="1.0" encoding="UTF-8" ?>
<?mso-application progid="Excel.Sheet"?>
<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
xmlns:html="http://www.w3.org/TR/REC-html40">
<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
<Author>distanze</Author>
<LastAuthor>distanze</LastAuthor>
<Created><%=now()%></Created>
<LastSaved><%=now()%></LastSaved>
<Company>distanze.ch</Company>
<Version>11.4920</Version>
</DocumentProperties>
<OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">
<DownloadComponents/>
<LocationOfComponents HRef="file:///C:\MSOCache\All%20Users\20000409-6000-11D3-8CFE-0150048383C9\"/>
</OfficeDocumentSettings>
<ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">
<WindowHeight>8955</WindowHeight>
<WindowWidth>11355</WindowWidth>
<WindowTopX>360</WindowTopX>
<WindowTopY>120</WindowTopY>
<ProtectStructure>False</ProtectStructure>
<ProtectWindows>False</ProtectWindows>
</ExcelWorkbook>
<Styles>
<Style ss:ID="Default" ss:Name="Normal">
<Alignment ss:Vertical="Top"/>
   <Font ss:FontName="Arial" ss:Size="9"  x:Family="Swiss" ss:Bold="0"/>
   <Interior/>
<NumberFormat/>
<Protection/>
</Style>
<Style ss:ID="sNormal">
   <Font ss:FontName="Arial" ss:Size="9"  x:Family="Swiss" ss:Bold="0"/>
      <Alignment ss:Vertical="Top"/>
<Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="#000000"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="#000000"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="#000000"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="#000000"/>
   </Borders>
</Style>
<Style ss:ID="sNormal1">
     <Alignment ss:Vertical="Top"/>
        <Borders>
         <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
         <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
         <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
         <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
        </Borders>
        <Font x:Family="Swiss" ss:Size="9"/>
     <Interior ss:Color="#CCFFCC" ss:Pattern="Solid"/>
</Style>
<Style ss:ID="sTop1">
<Alignment ss:Horizontal="Left" ss:Vertical="Center" ss:WrapText="1"/>
	<Interior ss:Color="#CCCCCC" ss:Pattern="Solid"/>
   <Font ss:FontName="Arial" ss:Size="9" x:Family="Swiss" ss:Bold="1" ss:Color="#333333"/>
   <Borders>
       <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"
        ss:Color="#000000"/>
       <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"
        ss:Color="#000000"/>
       <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"
        ss:Color="#000000"/>
       <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"
        ss:Color="#000000"/>
   </Borders>
  </Style>

<Style ss:ID="sTop1int">
<Alignment ss:Horizontal="Left" ss:Vertical="Center" ss:WrapText="1"/>
	<Interior ss:Color="#FFFF99" ss:Pattern="Solid"/>

   <Font ss:FontName="Arial" ss:Size="9" x:Family="Swiss" ss:Bold="1" ss:Color="#333333"/>
   <Borders>
       <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"
        ss:Color="#000000"/>
       <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"
        ss:Color="#000000"/>
       <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"
        ss:Color="#000000"/>
       <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"
        ss:Color="#000000"/>
   </Borders>
  </Style>
</Styles>
<%
Set rstSchema = connection.OpenSchema(adSchemaColumns,Array(Empty, Empty, ""&table&""))

i=0
columns1=""
do Until rstSchema.EOF
if rstSchema("COLUMN_NAME")<>"ID" And InStr(allowed_columns," "&rstSchema("COLUMN_NAME")&" ")>0 then
columns1=columns1&rstSchema("COLUMN_NAME")&","
i=i+1
end if
rstSchema.movenext
loop

columns1=Mid(columns1,1,len(columns1)-1)

columns1=Split(columns1,",")
totfields=UBound(columns1)
%>
<Worksheet ss:Name="<%=tabellat%>">
<Table ss:ExpandedColumnCount="<%=totfields+1%>">
<%
i=0
do while i<=totfields%>
<Column ss:AutoFitWidth="0" ss:Width="89.5"/>
<%i=i+1
loop
%>

<Row ss:Height="23.25">
<Cell ss:StyleID="sTop1int" ss:MergeAcross="<%=totfields%>" >
<ss:Data ss:Type="String"
      xmlns="http://www.w3.org/TR/REC-html40"><B><%=tabellat%></B></ss:Data></Cell>
</Row>
<Row>
<%For x = LBound(columns1) TO UBound(columns1)
scrivi=columns1(x)
scrivi=REplace(scrivi,"TA_","")
scrivi=REplace(scrivi,"TX_","")
scrivi=REplace(scrivi,"DT_","")
scrivi=REplace(scrivi,"LO_","")
'scrivi=replace(scrivi,"nome","Name")
'scrivi=replace(scrivi,"data","Datum")
%>
<Cell ss:StyleID="sTop1"><Data ss:Type="String"><%=scrivi%></Data></Cell>
<%
response.write chr(10)
Next%>
</Row>
<%SQL="SELECT * FROM "&table&" "&session("defsql")
set record=connection.execute(SQL)

classchange="1"
do while not record.eof
%><Row><%
if classchange="1" then
classchange=""
else
classchange="1"
end if

xx=0
do while xx<=totfields
scrivi=record(""&columns1(xx))
if len(scrivi)>0 then scrivi=Replace(scrivi,"<br>",""&CHR(10)&"")
if len(scrivi)>0 then scrivi=Replace(scrivi,"<BR>",""&CHR(10)&"")
if len(scrivi)>0 then scrivi=Replace(scrivi,"<br/>",""&CHR(10)&"")
if len(scrivi)>0 then scrivi=Replace(scrivi,"�","")

if len(scrivi)>0 then scrivi=Replace(scrivi,"-"," ")
%><Cell ss:StyleID="sNormal<%=classchange%>"><Data ss:Type="String"><%=scrivi%></Data></Cell>
<%
xx=xx+1
loop%>
</Row>
<%
record.movenext
loop
%>
</Table>

<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
<PageSetup>
    <Layout x:Orientation="Landscape"/>
<Footer x:Margin="0" x:Data="<%=tabellat%>&amp;R1"/>
    <PageMargins x:Bottom="0.25" x:Left="0.20" x:Right="0.20"
     x:Top="0.25"/>
   </PageSetup>
<Print>
<ValidPrinterInfo/>
<Scale>80</Scale>
<HorizontalResolution>600</HorizontalResolution>
<VerticalResolution>600</VerticalResolution>
</Print>
<Selected/>
<Panes>
<Pane>
<Number>3</Number>
<ActiveRow>1</ActiveRow>
<ActiveCol>1</ActiveCol>
</Pane>
</Panes>
<ProtectObjects>False</ProtectObjects>
<ProtectScenarios>False</ProtectScenarios>
</WorksheetOptions>
</Worksheet>
</Workbook>