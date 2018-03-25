using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PayPal.Api;
using System.Net;

public partial class actions_PayPal_SDK : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Get a reference to the config
        Dictionary<string,string> config = ConfigManager.Instance.GetProperties();

        // Use OAuthTokenCredential to request an access token from PayPal
        String accessToken = new OAuthTokenCredential(config).GetAccessToken();
        ServicePointManager.Expect100Continue = true;
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls;
        ServicePointManager.DefaultConnectionLimit = 9999;

        APIContext apiContext = new APIContext(accessToken);
        // Initialize the apiContext's configuration with the default configuration for this application.
        apiContext.Config = ConfigManager.Instance.GetProperties();

        // Define any custom configuration settings for calls that will use this object.
        apiContext.Config["connectionTimeout"] = "1000"; // Quick timeout for testing purposes

        // Define any HTTP headers to be used in HTTP requests made with this APIContext object
        if (apiContext.HTTPHeaders == null)
        {
            apiContext.HTTPHeaders = new Dictionary<string, string>();
        }
        apiContext.HTTPHeaders["some-header-name"] = "some-value";
    }
}