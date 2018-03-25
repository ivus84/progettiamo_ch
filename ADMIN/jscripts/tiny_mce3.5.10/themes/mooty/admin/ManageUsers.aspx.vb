
Partial Class admin_ManageUsers
    Inherits System.Web.UI.Page
    Protected Sub CreateUserWizard1_CreatedUser(sender As Object, e As System.EventArgs) Handles CreateUserWizard1.CreatedUser
        Dim userName As String = CreateUserWizard1.UserName
        Dim uid = Membership.GetUser(CreateUserWizard1.UserName).ProviderUserKey
        If (adminCheck.Checked) Then
            Roles.AddUserToRole(userName, "administrator")
        Else
            Roles.AddUserToRole(userName, "auth_user")
        End If
    End Sub
End Class
