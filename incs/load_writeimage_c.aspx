<%@ Page Language="C#" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Text" %>
<%@ Import Namespace="System.Drawing" %>
<%@ Import Namespace="System.Drawing.Imaging" %>
<%@ Import Namespace="System.Drawing.Text" %>
<%@ Import Namespace="System.Drawing.Drawing2D" %>

<script runat="server">

 
protected void Page_Load(object sender, EventArgs e)
{

string vtext = Request["vtext"];
  
    Bitmap bitmap = null;

    if (vtext != null
        && vtext.Length > 0)

        bitmap = (Bitmap)CreateVerticalTextImage(
            vtext,
            Request["rotate"] == "False",
            Request["size"] == null ? 52.0F
                : (float) Convert.ToDouble(Request["size"]),
            Request["bold"] == "true",
            Request["italic"] == "true");

    if (bitmap != null)
    {
     Response.ContentType = "image/gif";

		bitmap.MakeTransparent(Color.White);
        Response.AddHeader("ContentType", "image/gif");
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        byte[] bytes = (byte[])System.ComponentModel
            .TypeDescriptor.GetConverter(bitmap)
            .ConvertTo(bitmap, typeof(byte[]));

        bitmap.Dispose();
        Response.BinaryWrite(bytes);
        Response.Flush();
    }
}

/// <summary>
/// Generates an image with custom vertical text
/// </summary>
private System.Drawing.Image CreateVerticalTextImage(
    string text, bool rotate, float fsize, bool bold, bool italic)
{
    // set font
    string fontName = "opensans.ttf";
    				PrivateFontCollection privateFontCollection = new PrivateFontCollection();
    				privateFontCollection.AddFontFile(Server.MapPath("./") + fontName);
    				FontFamily fontFamily = privateFontCollection.Families[0];
    FontStyle fstyle = FontStyle.Regular;
    if (bold) fstyle |= FontStyle.Bold;
    if (italic) fstyle |= FontStyle.Italic;
    Font font = new Font(fontFamily, fsize, fstyle);

    StringFormat format = new StringFormat();
	format.Alignment = StringAlignment.Center;
	format.LineAlignment = StringAlignment.Center;

    // creates 1Kx1K image buffer
    System.Drawing.Image imageg
        = (System.Drawing.Image)new Bitmap(140, 40);
    Graphics g = Graphics.FromImage(imageg);
    imageg.Dispose();

    System.Drawing.Image image = (System.Drawing.Image)
new Bitmap(140, 44);
    g = Graphics.FromImage(image);
    g.SmoothingMode = SmoothingMode.AntiAlias;
      
    Rectangle rect = new Rectangle(0, 0, 140, 44);
   
    string fgColor = "#7597b7";
    string fgColor1 = "#95b6cf";
    string bgColor = "#b9d7ee";
    string bgColor1 = "#95b6cf";

    Color fontColor = System.Drawing.ColorTranslator.FromHtml(fgColor);
    Color fontColor1 = System.Drawing.ColorTranslator.FromHtml(fgColor1);
    Color bgColor_1 = System.Drawing.ColorTranslator.FromHtml(bgColor);
    Color bgColor_2 = System.Drawing.ColorTranslator.FromHtml(bgColor1);


    HatchBrush hatchBrush = new HatchBrush(HatchStyle.SmallConfetti, bgColor_2, bgColor_1);
    g.FillRectangle(hatchBrush, rect);    
     
    g.TextRenderingHint = TextRenderingHint.AntiAlias;
  
  SolidBrush fgBrush = new SolidBrush(fontColor);



	SolidBrush wBrush = new SolidBrush(bgColor_1);
	Rectangle rect0 = new Rectangle(0, 0, 140, 44);
    //g.FillRectangle(wBrush, rect0);    

    Rectangle rect1 = new Rectangle(-5, -5, 170, 54);

GraphicsPath graphPath = new GraphicsPath();

int fontStyle = (int)FontStyle.Bold;
graphPath.AddString(text, fontFamily, fontStyle, fsize, rect1, format);
			    
 float v = 4F;
			PointF[] points =
			{
				new PointF(this.random.Next(rect.Width) / v, this.random.Next(rect.Height) / v),
				new PointF(rect.Width - this.random.Next(rect.Width) / v, this.random.Next(rect.Height) / v),
				new PointF(this.random.Next(rect.Width) / v, rect.Height - this.random.Next(rect.Height) / v),
				new PointF(rect.Width - this.random.Next(rect.Width) / v, rect.Height - this.random.Next(rect.Height) / v)
			};
			Matrix matrix = new Matrix();
			matrix.Translate(0F, 0F);
			graphPath.Warp(points, rect, matrix, WarpMode.Perspective, 0F);


hatchBrush = new HatchBrush(HatchStyle.LargeConfetti, fontColor, fontColor1);
g.FillPath(hatchBrush, graphPath);
return image;
font.Dispose();
hatchBrush.Dispose();
g.Dispose();
graphPath.Dispose();
privateFontCollection.Dispose();
fontFamily.Dispose();
}

private Random random = new Random();
</script>