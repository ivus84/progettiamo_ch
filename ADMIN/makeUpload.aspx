<%@ Page Language="C#" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Data.OleDb" %>

<script runat="server">
protected void Page_Load(object sender, EventArgs e)
{
if (Session["lognet"]=="aoiuhf876655djf54Po/zTTr!$")
{
string fieldF = Request.Form["fieldF"];
string tabadd = Request.Form["table"];
string connectTable = Request.Form["connectTable"];
string addFields = Request.Form["addFields"];
string returnurl = Request.Form["returnurl"];
string modeupl = Request.Form["modeupl"];

string fileprefix = Request.ServerVariables["HTTP_HOST"];

fileprefix=fileprefix.Replace("www","");
fileprefix=fileprefix.Replace("preview","");
fileprefix=fileprefix.Replace(":","");
fileprefix=fileprefix.Replace("distanze","");
fileprefix=fileprefix.Replace("localhost","lch_");

DateTime now = DateTime.Now;
string year = now.Year.ToString();
string month = now.Month.ToString();
string day = now.Month.ToString();
string minute = now.Minute.ToString();
string hour = now.Hour.ToString();
string sec = now.Second.ToString();

fileprefix=fileprefix + year + month + day + hour +  minute + sec;

string percorso = Server.MapPath("./");
percorso = percorso.Substring(0,percorso.LastIndexOf('\\'));
percorso = percorso.Substring(0,percorso.LastIndexOf('\\'));
percorso = percorso.Substring(0,percorso.LastIndexOf('\\'));
percorso = percorso + "\\wr\\";

string dbpath = percorso + "dsm_fnstr.mdb";
string addpath="images\\";

if (tabadd == "fails" || tabadd == "fails_prodotti" || tabadd == "fieldF") { 
addpath = "files\\"; 
} 

percorso = percorso + addpath;

string totfiless="";
string totsizess="";

int totfile=0;

try
        {
            // Get the HttpFileCollection
            HttpFileCollection hfc = Request.Files;
            for (int i = 0; i < hfc.Count; i++)
            {
                HttpPostedFile hpf = hfc[i];              
                if (hpf.ContentLength > 0)
                {

				string origname = Path.GetFileName(hpf.FileName);
string origext =  origname.Substring(origname.LastIndexOf('.'));
string newname =  fileprefix + "_" + totfile + origext;

int gSize = hpf.ContentLength/1000;


                    hpf.SaveAs(percorso + newname);    
					totfile=totfile+1;
totfiless = totfiless + "," + newname ;
totsizess = totsizess + "," + gSize;


                }       
				else {
totfiless = totfiless + ",nofile";
totsizess = totsizess + ",0";

				}

            }
			totfiless = totfiless.Substring(1);
			totsizess = totsizess.Substring(1);

string[] totfiles = totfiless.Split(',');
string[] totsizes = totsizess.Split(',');
string filesrefs="";

            string connectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="+dbpath+";";
            OleDbConnection cnn = new OleDbConnection(connectionString);
cnn.Open();
	if (tabadd.Length>0 && fieldF.Length>0 && totfiless.Length>0) {

            

	foreach (string namefile in totfiles)
	{
	//UPD OR INSERT TABLE
	string namefilea=namefile.Replace("'","&#39;");
if (modeupl == null) {modeupl="INSERT";}
					if (modeupl.IndexOf("update") != -1) {


					string[] modeupla = modeupl.Split(',');
					string reffile= modeupla[1];
							

					string SQL="UPDATE " +tabadd+" SET "+fieldF+"='"+namefilea+"' WHERE ID=" + reffile;
	
			OleDbCommand cmd1 = new OleDbCommand(SQL, cnn);
							cmd1.ExecuteNonQuery();
							cmd1.Dispose();
																	


					filesrefs=filesrefs +","+ reffile;
					} else {
					string SQL1="INSERT INTO "+tabadd+" ("+fieldF+") values ('"+namefilea+"')";
							

							OleDbCommand cmd2 = new OleDbCommand(SQL1, cnn);
							cmd2.ExecuteNonQuery();
							cmd2.Dispose();


					string SQL2="SELECT MAX(ID) as ref1 from "+tabadd;
							OleDbCommand  cmd3 = new OleDbCommand(SQL2, cnn);
							OleDbDataReader reader = cmd3.ExecuteReader();
							while (reader.Read())
							{
								filesrefs=filesrefs+","+reader.GetValue(0);
								
							}
										
							reader.Close();
							cmd3.Dispose();
			}

	// END UPD SECTION

	}
	
	filesrefs = filesrefs.Substring(1);
	}


	if (connectTable.Length>0) {
		string[] connectTablee=connectTable.Split(',');
		string cnctTable=connectTablee[0];
		string cnctField=connectTablee[1];
		string cnctValue=connectTablee[2];
		
		string[] uploads = filesrefs.Split(',');

			foreach (string upload in uploads)
	{
			
				string SQL3="INSERT INTO "+cnctTable+" ("+cnctField+",CO_"+tabadd+") values ("+cnctValue+","+upload+")";
				if ( cnctTable == "associa_ogg_files" ) { SQL3="INSERT INTO "+cnctTable+" ("+cnctField+",CO_"+tabadd+",CO_lingue) values ("+cnctValue+","+upload+",0)"; }
						OleDbCommand cmd4 = new OleDbCommand(SQL3, cnn);
						cmd4.ExecuteNonQuery();
						cmd4.Dispose();
			}
	}


	if (addFields.Length>0) {

		string[] addFieldss = addFields.Split(',');
		string[] uploads = filesrefs.Split(',');

		int x=0;
		foreach (string namefield in addFieldss)
	{
		
		for (int i = 0; i < uploads.Length; i++)
        {
			string gref=uploads[i];
			int n = i;
			n=n+1;
			string fieldValue = Request.Form[namefield +"_"+ n];
			if (namefield=="TA_grandezza") { 
			fieldValue=totsizes[i]; 
			}

		if (fieldValue.Length>0) {
				fieldValue=fieldValue.Replace("'","&#39;");

						string SQL4="UPDATE "+tabadd+" SET "+namefield+"='"+fieldValue+"' WHERE ID="+gref;
						OleDbCommand cmd = new OleDbCommand(SQL4, cnn);
						cmd.ExecuteNonQuery();
						cmd.Dispose();
	}
		}
x=x+1;

}}

cnn.Close();
Response.Redirect(returnurl);

}
catch (Exception ex)
{
            Response.Write(ex);
        }
}}
</script>