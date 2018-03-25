<%@ Page Language="C#" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Data.OleDb" %>

<script runat="server">
protected void Page_Load(object sender, EventArgs e)
{

string tabadd = Request.Form["tabdest"];

string fileprefix = Request.ServerVariables["HTTP_HOST"];

fileprefix=fileprefix.Replace("www","");
fileprefix=fileprefix.Replace(":","");
fileprefix=fileprefix.Replace("localhost","");
fileprefix=fileprefix.Replace("test.","");
fileprefix=fileprefix.Replace("lavb.","");

DateTime now = DateTime.Now;
string year = now.Year.ToString();
string month = now.Month.ToString();
string day = now.Day.ToString();
string minute = now.Minute.ToString();
string hour = now.Hour.ToString();
string sec = now.Second.ToString();

fileprefix=fileprefix + year + month + day + hour +  minute + sec;

string percorso = Server.MapPath("./");
percorso = percorso.Substring(0,percorso.LastIndexOf('\\'));
percorso = percorso.Substring(0,percorso.LastIndexOf('\\'));
percorso = percorso.Substring(0,percorso.LastIndexOf('\\'));
percorso = percorso + "\\database\\";

string addpath="images\\";

if (tabadd == "fails" || tabadd == "fails_prodotti" || tabadd == "fieldF") { 
addpath = "files\\"; 
} 

if (tabadd == "registeredusers" || tabadd == "p_projects" || tabadd == "p_pictures" || tabadd == "p_description") { 
addpath = "projects\\"; 
} 


percorso = percorso + addpath;

string totfiless="";
string totsizess="";

int totfile=0;

try
        {
            HttpFileCollection hfc = Request.Files;
            for (int i = 0; i < hfc.Count; i++)
            {
                HttpPostedFile hpf = hfc[i];              
                if (hpf.ContentLength > 0)
                {

				string origname = Path.GetFileName(hpf.FileName);
string origext =  origname.Substring(origname.LastIndexOf('.'));
string newname =  fileprefix + "_" + totfile + origext;

int gSize = hpf.ContentLength;


                    hpf.SaveAs(percorso + newname);    
					totfile=totfile+1;
totfiless = "|"+totfiless +  newname + "#"+gSize+"#"+origname;


                }       

            }
			totfiless = totfiless.Substring(1);

string[] totfiles = totfiless.Split('|');

      string getResults =  "";  

	foreach (string namefile in totfiles)
	{
	string filerec=namefile;
	string[] getFile = filerec.Split('#');
	getResults = getResults+"{\"name\":\""+getFile[2]+"\", \"size\":"+getFile[1]+",\"url\":\""+getFile[0]+"\",\"thumbnail_url\":\"\",\"delete_url\":\"\",\"delete_type\":\"DELETE\"},";
	}
int tlength=getResults.Length-1;
getResults=getResults.Substring(0,tlength);
getResults="["+getResults+"]";


Response.Buffer = true;
Response.Clear();
Response.ContentType = "text/plain";
Response.Charset="UTF-8";


Response.Write(getResults);

}
catch (Exception ex)
{
            Response.Write(ex);
        }
}
</script>