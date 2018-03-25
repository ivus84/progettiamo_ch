using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NPOI;
using System.Data;
using System.Data.OleDb;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using NPOI.HSSF.UserModel;
using System.IO;

using main;
using System.Text;


public partial class ADMIN_ProjectPromotersExcelDownload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        String load = Request["load"];
        String mode = Request["mode"];
        string connectionString = "";
        string dbpath = Server.MapPath("/");
        //dbpath=Mid(dbpath,1,Instrrev(dbpath,"\")-1)
        //checklast=Mid(dbpath,Instrrev(dbpath,"\")+1)

        //If checklast="admin" Then 
        //dbpath=Mid(dbpath,1,Instrrev(dbpath,"\")-1)
        //checklast=Mid(dbpath,Instrrev(dbpath,"\")+1)
        //End if

        //If checklast="web" Or checklast="public_html" Or checklast="admin" Then dbpath=Mid(dbpath,1,Instrrev(dbpath,"\")-1)
        //'If checklast="web" Or checklast="public_html" Or checklast="progettiamo" Or checklast="admin" Then dbpath=Mid(dbpath,1,Instrrev(dbpath,"\")-1)
        dbpath = dbpath.Substring(0, dbpath.LastIndexOf("\\"));
        dbpath = dbpath.Substring(0, dbpath.LastIndexOf("\\"));
        dbpath = dbpath + "\\database\\";
        string dbname = "dsm_progettiamo.v1.mdb";

        

        main.rc4encrypt rc4 = new rc4encrypt();
        rc4.Password = "prgttmc";
        
       
        dbpath = dbpath + dbname;
        DataTable dt = null;
        String SQL = "SELECT * FROM p_projects WHERE ID=" + load;
        string filename = "";
        int adm_area = Session["adm_area"] == null ? 0 : (int)Session["adm_area"];
        if (adm_area > 0)
        {
            SQL = "SELECT * FROM p_projects WHERE ID=" + load + " AND CO_p_area=" + Session["adm_area"];
        }
        try
        {
            connectionString = @"PROVIDER=Microsoft.Jet.OLEDB.4.0;" + "Data Source='" + dbpath + "';";
            

            using (OleDbConnection con = new OleDbConnection(connectionString))
            {
                
                con.Open();
               
                using (OleDbCommand command = new OleDbCommand(SQL, con))
                using (OleDbDataReader reader = command.ExecuteReader())
                {
                    dt = new DataTable();
                    dt.Columns.Add("Ente/Società", typeof(String));
                    dt.Columns.Add("Cognome", typeof(String));
                    dt.Columns.Add("Nome", typeof(String));
                    dt.Columns.Add("Fr.", typeof(String));
                    dt.Columns.Add("Email", typeof(String));
                    dt.Columns.Add("Tel.", typeof(String));
                    dt.Columns.Add("Cap", typeof(String));
                    dt.Columns.Add("Luogo", typeof(String));
                    dt.Columns.Add("Indirizzo", typeof(String));
                    dt.Columns.Add("Data", typeof(String));

                    while (reader.Read())
                    {
                        filename = reader["TA_nome"].ToString();
                        SQL = "SELECT DISTINCT ID FROM (SELECT ID FROM QU_projects_promises WHERE CO_p_projects=" + load + " ORDER BY DT_data)";


                        using (OleDbCommand com2 = new OleDbCommand(SQL, con))
                        {
                            using (OleDbDataReader rec1 = com2.ExecuteReader())
                            {
                                string refu = "";
                                while (rec1.Read())
                                {
                                    refu = rec1["ID"].ToString();

                                    SQL = "SELECT SUM(IN_promessa) as promesso,MAX(DT_data) as lastdata FROM QU_projects_promises WHERE CO_p_projects=" + load + " AND ID=" + refu;

                                    using (OleDbCommand com3 = new OleDbCommand(SQL, con))
                                    {
                                        using (OleDbDataReader rec2 = com3.ExecuteReader())
                                        {
                                            while (rec2.Read())
                                            {
                                                string promesso = rec2["promesso"].ToString();
                                                string lastdata = rec2["lastdata"].ToString();
                                                SQL = "SELECT * FROM registeredusers WHERE ID=" + refu;
                                                using (OleDbCommand com4 = new OleDbCommand(SQL, con))
                                                using (OleDbDataReader rec3 = com4.ExecuteReader())
                                                {
                                                    while (rec3.Read())
                                                    {

                                                        string email = rec3["TA_email"].ToString();
                                                        
                                                        //EnDecrypt.CryptedText = email;
                                                        //EnDecrypt.Decrypt();
                                                        //email = System.Web.HttpUtility.UrlDecode(email);
                                                        //rc4.URLDecode(email);
                                                        //throw new Exception(rc4.URLDecode(email));
                                                        if (!String.IsNullOrEmpty(email)){
                                                        rc4.PlainText = email;
                                                        
                                                        email = rc4.EnDeCrypt(2);
                                                        }
                                                        
                                                        string telefono = rec3["TA_telefono"].ToString();
                                                        //EnDecrypt.CryptedText = telefono;
                                                        //EnDecrypt.Decrypt();
                                                        if (!String.IsNullOrEmpty(telefono))
                                                        {
                                                            rc4.PlainText = telefono;
                                                            telefono = rc4.EnDeCrypt(2);
                                                        }
                                                        dt.Rows.Add(rec3["TA_ente"], DecodeFromUtf8((String)rec3["TA_cognome"]), DecodeFromUtf8((String)rec3["TA_nome"]), promesso, email, telefono, rec3["TA_cap"], rec3["TA_citta"], rec3["TA_indirizzo"], lastdata);
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        catch (Exception ex)
        {

            Response.Write(dbpath + "<br/>" + ex.Message + "<br/>" + ex.StackTrace);
                Response.End();
            return;
        }


        downloadExcel(filename, dt, mode);
    }
    public static string HexStrToStr(string hexStr)
    {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < hexStr.Length; i += 2)
        {
            int n = Convert.ToInt32(hexStr.Substring(i, 2), 16);
            sb.Append(Convert.ToChar(n));
        }
        return sb.ToString();
    }

    private static string ConvertFromUTF8(string s)
    {
        if (String.IsNullOrEmpty(s)) return s;
        Encoding iso = Encoding.GetEncoding("ISO-8859-1");
        Encoding utf8 = Encoding.UTF8;
        byte[] utfBytes = utf8.GetBytes(s);
        byte[] isoBytes = Encoding.Convert(utf8, iso, utfBytes);
        return iso.GetString(isoBytes);

    }
    private static string DecodeFromUtf8(string s)
    {
        string utf8_String = s;
        byte[] bytes = Encoding.Default.GetBytes(utf8_String);
        return Encoding.UTF8.GetString(bytes);
    }
    public void downloadExcel(String filename, DataTable dt, String extension)
    {
        filename = HttpUtility.UrlEncode(filename);
        IWorkbook workbook;
        ICellStyle headerCellStyle;
        if (extension == "xlsx")
        {
            workbook = new XSSFWorkbook();
            
        }
        else if (extension == "xls")
        {
            workbook = new HSSFWorkbook();
        }
        else
        {
            throw new Exception("This format is not supported");
        }

        ISheet sheet1 = workbook.CreateSheet("Sostenitori");

        //make a header row
        IRow row1 = sheet1.CreateRow(0);
        IFont boldFont = (IFont)workbook.CreateFont();
        boldFont.Boldweight = (short)NPOI.SS.UserModel.FontBoldWeight.Bold;
        headerCellStyle = workbook.CreateCellStyle();
        headerCellStyle.SetFont(boldFont);
        for (int j = 0; j < dt.Columns.Count; j++)
        {

            ICell cell = row1.CreateCell(j);
            cell.CellStyle = headerCellStyle;
            String columnName = dt.Columns[j].ToString();
            cell.SetCellValue(columnName);
        }

        

        //loops through data
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            IRow row = sheet1.CreateRow(i + 1);
            for (int j = 0; j < dt.Columns.Count; j++)
            {

                ICell cell = row.CreateCell(j);
                String columnName = dt.Columns[j].ToString();
                cell.SetCellValue(dt.Rows[i][columnName].ToString());
            }
        }

        using (MemoryStream exportData = new MemoryStream())
        {
            Response.Clear();
            workbook.Write(exportData);
            filename  = string.Format("attachment;filename=sostenitori_{0}_{1}", filename, DateTime.Now.Day.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Year.ToString());
            if (extension == "xlsx") //xlsx file format
            {
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("Content-Disposition", filename + ".xlsx" );
                Response.BinaryWrite(exportData.ToArray());
            }
            else if (extension == "xls")  //xls file format
            {
                Response.ContentType = "application/vnd.ms-excel";
                Response.AddHeader("Content-Disposition", filename + ".xls");
                Response.BinaryWrite(exportData.GetBuffer());
            }
            Response.End();
        }
    }

  

}

