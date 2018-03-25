<%@ Page Language="C#" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Web" %>
<script runat="server">

protected void Page_Load(object sender, EventArgs e)
{
string video = Request.QueryString["nome"];
string ext=video.Substring(video.LastIndexOf(".")+1);

  ext=ext.ToLower();

string cnt="video/mp4";

if (ext=="m4v") { cnt="video/m4v"; }
if (ext=="ogv") { cnt="video/ogg"; }
if (ext=="webm") { cnt="video/webm"; }
if (ext=="mov") { cnt="video/quicktime"; }
if (ext=="flv") { cnt="video/x-flv"; }
if (ext=="mp3") { cnt="audio/mpeg"; }
string percorso = Server.MapPath("./");
string videoPath = "\\database\\files\\";

percorso = percorso.Substring(0,percorso.LastIndexOf('\\'));
percorso = percorso.Substring(0,percorso.LastIndexOf('\\'));
percorso = percorso.Substring(0,percorso.LastIndexOf('\\'));
videoPath= percorso + videoPath + video;


int pos;
int length;

FileStream fs = new FileStream(videoPath, FileMode.Open, FileAccess.Read, FileShare.Read);
            
		
                    pos = 0;
                    length = Convert.ToInt32(fs.Length);

Response.AppendHeader("Content-Type", cnt);
Response.AppendHeader("Content-Length", length.ToString());

const int buffersize = 16384;

byte[] buffer = new byte[buffersize];

int count = fs.Read(buffer, 0, buffersize);

				while (count > 0)
                {
                    if (Response.IsClientConnected)
                    {
                    Response.OutputStream.Write(buffer, 0, count);
					Response.Flush();
		            count = fs.Read(buffer, 0, buffersize);
                    }
                    else
                    {
                    count = -1;
                    }
                    } 
                    
                    
					fs.Close();
					Response.Close();
					Response.End();
                    
}

 public bool IsReusable
    {
        get { return true; }
    }

    private static byte[] HexToByte(string hexString)
    {
        byte[] returnBytes = new byte[hexString.Length / 2];
        for (int i = 0; i < returnBytes.Length; i++)
            returnBytes[i] = Convert.ToByte(hexString.Substring(i * 2, 2), 16);
        return returnBytes;
    }
</script>