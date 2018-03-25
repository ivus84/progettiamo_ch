<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ManageUsers.aspx.vb" Inherits="admin_ManageUsers" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:LoginName ID="LoginName1" runat="server" />
        <asp:LoginStatus ID="LoginStatus1" runat="server" />
    <table style="width: 500px; margin-left:auto; margin-right:auto">
    <tr>
    
    <td>
                <asp:CheckBox ID="adminCheck" runat="server" Text="Administrator" AutoPostBack="false" />
            </td></tr>
        <tr>
            <td>
                <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" LoginCreatedUser="false" ContinueDestinationPageUrl="~/admin/ManageUsers.aspx">
            <WizardSteps>
                <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server" Title="">
                </asp:CreateUserWizardStep>
                <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server">
                </asp:CompleteWizardStep>
            </WizardSteps>
</asp:CreateUserWizard>
</td>
            
            
           
        </tr>
    </table>
    </div>
    </form>
</body>
</html>
