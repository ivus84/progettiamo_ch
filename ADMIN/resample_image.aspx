<%@ Page Language="C#" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Drawing" %>
<%@ Import Namespace="System.Drawing.Imaging" %>
<%@ Import Namespace="System.Drawing.Drawing2D" %>
<%@ Import Namespace="System.Web" %>
<script runat="server">
protected void Page_Load(object sender, EventArgs e)
{
string immagine = Request.QueryString["filename"];
string gwidth = Request.QueryString["towidth"];
int width = int.Parse(gwidth);
	
string ext=immagine.Substring(immagine.LastIndexOf(".")+1);
ext=ext.ToLower();

string percorso = Server.MapPath("./");
percorso = percorso.Substring(0,percorso.LastIndexOf('\\'));
percorso = percorso.Substring(0,percorso.LastIndexOf('\\'));
percorso = percorso.Substring(0,percorso.LastIndexOf('\\'));

string photoPath = "\\wr\\images\\";
   
photoPath = percorso + photoPath + immagine;

if (width > 0) {
using( System.Drawing.Image photo = System.Drawing.Image.FromFile( photoPath ) )
	{
int newwidth, newheight;

newwidth = width;
int origWidth=photo.Width;
int origHeight=photo.Height;
newheight = origHeight * newwidth / origWidth;
       
Bitmap target = new Bitmap(newwidth, newheight);      
using (Graphics graphics = Graphics.FromImage(target)) {
           graphics.CompositingQuality = CompositingQuality.HighQuality;
           graphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
           graphics.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
		   graphics.CompositingMode = CompositingMode.SourceCopy;
           graphics.DrawImage(photo, 0, 0, newwidth, newheight);

		photo.Dispose();

          if ((ext=="jpg") || (ext=="peg") || (ext=="jpeg"))  { target.Save( photoPath, System.Drawing.Imaging.ImageFormat.Jpeg );	}
		  if ((ext == "gif") || (ext=="png")){ target.Save( photoPath, System.Drawing.Imaging.ImageFormat.Png );		}
		  if ((ext == "tif") || (ext=="tiff") || (ext=="iff")){target.Save( photoPath, System.Drawing.Imaging.ImageFormat.Tiff );		}
		  if (ext == "bmp"){ target.Save( photoPath, System.Drawing.Imaging.ImageFormat.Bmp );  }
	        graphics.Dispose();
			}
        
		target.Dispose();

Response.Write("<body style=\"font-family:arial;background-color:#efefef\"><center><br/>Image resampled to " + width + "x"+newheight+" px</center></body>");
Response.End();

}}
}
</script>