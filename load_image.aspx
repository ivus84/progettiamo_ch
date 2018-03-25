<%@ Page Language="C#" Debug="true" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Drawing" %>
<%@ Import Namespace="System.Drawing.Drawing2D" %>
<%@ Import Namespace="System.Drawing.Imaging" %>

 
<script runat="server">

protected void Page_Load(object sender, EventArgs e)
{
string immagine = Request.QueryString["path"];

string gwidth=immagine.Substring(immagine.LastIndexOf("$")+1);
int bw = immagine.IndexOf('@');
if (bw>0) {
immagine=immagine.Replace("@","");
bw=1;
}


int width = int.Parse(gwidth);
if (width<=2000) {	
immagine=immagine.Substring(0,immagine.LastIndexOf("$"));
string ext=immagine.Substring(immagine.LastIndexOf(".")+1);
ext=ext.ToLower();

string cnt="image/"+ext;
if (ext == "jpg") {  cnt="image/jpeg"; }  
if (ext == "peg") {  cnt="image/jpeg"; }  
if (ext == "tif") {  cnt="image/tiff"; }  
if (ext == "iif") {  cnt="image/tiff"; }  

string percorso = Server.MapPath("./");
percorso = percorso.Substring(0,percorso.LastIndexOf('\\'));
percorso = percorso.Substring(0,percorso.LastIndexOf('\\'));

string photoPath = "\\database\\images\\";
string projectsPath = "\\database\\projects\\";
string filesPath = "\\database\\files\\";
string thumbPath = photoPath + "thumbs\\";
   
photoPath = percorso + photoPath + immagine;
if (!File.Exists(photoPath)) { photoPath = percorso + projectsPath + immagine; }
if (!File.Exists(photoPath)) { photoPath = percorso + filesPath + immagine; }

thumbPath = percorso + thumbPath + width + "_" + bw + "_" +immagine;

if (File.Exists(thumbPath)) {
Response.Clear();
DateTime lastModified = File.GetLastWriteTime(thumbPath);
HttpCachePolicy cachePolicy = Response.Cache;
cachePolicy.SetCacheability(HttpCacheability.Public);
cachePolicy.SetOmitVaryStar(true);
cachePolicy.SetExpires(DateTime.Now + TimeSpan.FromDays(60));
cachePolicy.VaryByParams["path"] = true;
cachePolicy.SetValidUntilExpires(true);
cachePolicy.SetLastModified(lastModified);

FileStream fs = new FileStream(thumbPath, FileMode.Open, FileAccess.Read, FileShare.Read);
const int buffersize = 1024*2;
byte[] buffer = new byte[buffersize];
int length = (int)fs.Length;
int count = fs.Read(buffer, 0, buffersize);
Response.ContentType = cnt;
Response.AddHeader("Content-Disposition", "inline; filename=" + width + "_" + immagine);
Response.AppendHeader("Content-Length", length.ToString());

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
fs.Dispose();
Response.Close();
Response.End();
return;
}


if (width > 0) {
//Response.Write(photoPath);
//Response.End();
using( System.Drawing.Image photo = System.Drawing.Image.FromFile( photoPath ) )
	{
int newwidth, newheight;

newwidth = width;
int origWidth=photo.Width;
int origHeight=photo.Height;
newheight = origHeight * newwidth / origWidth;
    
Response.ContentType = cnt;
Bitmap target = new Bitmap(newwidth, newheight);      
using (Graphics graphics = Graphics.FromImage(target)) {
   
		   graphics.CompositingQuality = CompositingQuality.HighQuality;
           graphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
           graphics.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
		   graphics.CompositingMode = CompositingMode.SourceCopy;
        
		if (bw==1) {
    ColorMatrix colorMatrix = new ColorMatrix(
       new float[][] 
      {
          new float[] {.3f, .3f, .3f, 0, 0},
          new float[] {.59f, .59f, .59f, 0, 0},
          new float[] {.11f, .11f, .11f, 0, 0},
          new float[] {0, 0, 0, 1, 0},
          new float[] {0, 0, 0, 0, 1}
       });

    ImageAttributes attributes = new ImageAttributes();
    attributes.SetColorMatrix(colorMatrix);

    graphics.DrawImage(photo, new Rectangle(0, 0, newwidth, newheight),
       0, 0, origWidth, origHeight, GraphicsUnit.Pixel, attributes);

} else {
graphics.DrawImage(photo, 0, 0, newwidth, newheight);
}



          if ((ext=="jpg") || (ext=="peg") || (ext=="jpeg"))  { target.Save( thumbPath, System.Drawing.Imaging.ImageFormat.Jpeg );	}
		  if ((ext == "gif") || (ext=="png")){ target.Save( thumbPath, System.Drawing.Imaging.ImageFormat.Png );		}
		  if ((ext == "tif") || (ext=="tiff") || (ext=="iff")){target.Save( thumbPath, System.Drawing.Imaging.ImageFormat.Tiff );		}
		  if (ext == "bmp"){ target.Save( thumbPath, System.Drawing.Imaging.ImageFormat.Bmp );  }
	        graphics.Dispose();
			}
        
		target.Dispose();
		if (origWidth>1980 || origHeight>1620) {
		newwidth = 1980;
		if (origHeight>origWidth && origHeight>162) { newwidth = 1280; }
		newheight = origHeight * newwidth / origWidth;
		Bitmap target1 = new Bitmap(newwidth, newheight);      
			using (Graphics graphics = Graphics.FromImage(target1)) {
			   graphics.CompositingQuality = CompositingQuality.HighQuality;
			   graphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
			   graphics.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
			   graphics.CompositingMode = CompositingMode.SourceCopy;
			   graphics.DrawImage(photo, 0, 0, newwidth, newheight);
          photo.Dispose();
		  if ((ext=="jpg") || (ext=="peg") || (ext=="jpeg"))  { target1.Save( photoPath, System.Drawing.Imaging.ImageFormat.Jpeg );	}
		  if ((ext == "gif") || (ext=="png")){ target1.Save( photoPath, System.Drawing.Imaging.ImageFormat.Png );		}
		  if ((ext == "tif") || (ext=="tiff") || (ext=="iff")){target1.Save( photoPath, System.Drawing.Imaging.ImageFormat.Tiff );		}
		  if (ext == "bmp"){ target1.Save( photoPath, System.Drawing.Imaging.ImageFormat.Bmp );  }
	        graphics.Dispose();
			}
		target1.Dispose();
		} else {
		photo.Dispose();
		}

//Response.Write(thumbPath);
//Response.End();

Response.Clear();
FileStream fs = new FileStream(thumbPath, FileMode.Open, FileAccess.Read, FileShare.Read);
const int buffersize = 1024*4;
byte[] buffer = new byte[buffersize];
int length = (int)fs.Length;
int count = fs.Read(buffer, 0, buffersize);
Response.ContentType = cnt;
Response.AddHeader("Content-Disposition", "inline; filename=" + width + "_" + immagine);
Response.AppendHeader("Content-Length", length.ToString());
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
                    }} 
fs.Close();
fs.Dispose();
Response.Close();
Response.End();

}}}}
</script>