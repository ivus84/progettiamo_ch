Imports System.Web.Security
Imports System.Configuration.Provider
Imports System.Collections.Specialized
Imports MySql.Data.MySqlClient
Imports System.Configuration
Imports System.Diagnostics
Imports System.Web
Imports System.Globalization

'
'
'-- Please, send me an email (andriniaina@gmail.com) if you have done some improvements or bug corrections to this file
'
'
'CREATE TABLE Roles
'(
'  Rolename Varchar (255) NOT NULL,
'  ApplicationName varchar (255) NOT NULL
')
'
'CREATE TABLE UsersInRoles
'(
'  Username Varchar (255) NOT NULL,
'  Rolename Varchar (255) NOT NULL,
'  ApplicationName Text (255) NOT NULL
')
'ALTER TABLE `usersinroles` ADD INDEX ( `Username` , `Rolename` , `ApplicationName` ) ;
'ALTER TABLE `roles` ADD INDEX ( `Rolename` , `ApplicationName` ) ;
'
'



Namespace Andri.Web

    Public NotInheritable Class MySqlRoleProvider
        Inherits RoleProvider

        '
        ' Global connection string, generic exception message, event log info.
        '

        Private rolesTable As String = "roles"
        Private usersInRolesTable As String = "usersinroles"

        Private eventSource As String = "MySqlRoleProvider"
        Private eventLog As String = "Application"
        Private exceptionMessage As String = "An exception occurred. Please check the Event Log."

        Private pConnectionStringSettings As ConnectionStringSettings
        Private connectionString As String


        '
        ' If false, exceptions are thrown to the caller. If true,
        ' exceptions are written to the event log.
        '

        Private pWriteExceptionsToEventLog As Boolean = False

        Public Property WriteExceptionsToEventLog() As Boolean
            Get
                Return pWriteExceptionsToEventLog
            End Get
            Set(value As Boolean)
                pWriteExceptionsToEventLog = value
            End Set
        End Property



        '
        ' System.Configuration.Provider.ProviderBase.Initialize Method
        '

        Public Overrides Sub Initialize(name As String, config As NameValueCollection)

            '
            ' Initialize values from web.config.
            '

            If config Is Nothing Then
                Throw New ArgumentNullException("config")
            End If

            If name Is Nothing OrElse name.Length = 0 Then
                name = "MySqlRoleProvider"
            End If

            If [String].IsNullOrEmpty(config("description")) Then
                config.Remove("description")
                config.Add("description", "Sample MySql Role provider")
            End If

            ' Initialize the abstract base class.
            MyBase.Initialize(name, config)


            If config("applicationName") Is Nothing OrElse config("applicationName").Trim() = "" Then
                pApplicationName = System.Web.Hosting.HostingEnvironment.ApplicationVirtualPath
            Else
                pApplicationName = config("applicationName")
            End If


            If config("writeExceptionsToEventLog") IsNot Nothing Then
                If config("writeExceptionsToEventLog").ToUpper() = "TRUE" Then
                    pWriteExceptionsToEventLog = True
                End If
            End If


            '
            ' Initialize MySqlConnection.
            '

            pConnectionStringSettings = ConfigurationManager.ConnectionStrings(config("connectionStringName"))

            If pConnectionStringSettings Is Nothing OrElse pConnectionStringSettings.ConnectionString.Trim() = "" Then
                Throw New ProviderException("Connection string cannot be blank.")
            End If

            connectionString = pConnectionStringSettings.ConnectionString
        End Sub



        '
        ' System.Web.Security.RoleProvider properties.
        '


        Private pApplicationName As String


        Public Overrides Property ApplicationName() As String
            Get
                Return pApplicationName
            End Get
            Set(value As String)
                pApplicationName = value
            End Set
        End Property

        '
        ' System.Web.Security.RoleProvider methods.
        '

        '
        ' RoleProvider.AddUsersToRoles
        '

        Public Overrides Sub AddUsersToRoles(usernames As String(), rolenames As String())
            For Each rolename As String In rolenames
                If Not RoleExists(rolename) Then
                    Throw New ProviderException("Role name not found.")
                End If
            Next

            For Each username As String In usernames
                If username.IndexOf(","c) > 0 Then
                    Throw New ArgumentException("User names cannot contain commas.")
                End If

                For Each rolename As String In rolenames
                    If IsUserInRole(username, rolename) Then
                        Throw New ProviderException("User is already in role.")
                    End If
                Next
            Next


            Dim conn As New MySqlConnection(connectionString)
            Dim cmd As New MySqlCommand("INSERT INTO `" & usersInRolesTable & "`" & " (Username, Rolename, ApplicationName) " & " Values(?Username, ?Rolename, ?ApplicationName)", conn)

            Dim userParm As MySqlParameter = cmd.Parameters.Add("?Username", MySqlDbType.VarChar, 255)
            Dim roleParm As MySqlParameter = cmd.Parameters.Add("?Rolename", MySqlDbType.VarChar, 255)
            cmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = ApplicationName

            Dim tran As MySqlTransaction = Nothing

            Try
                conn.Open()
                tran = conn.BeginTransaction()
                cmd.Transaction = tran

                For Each username As String In usernames
                    For Each rolename As String In rolenames
                        userParm.Value = username
                        roleParm.Value = rolename
                        cmd.ExecuteNonQuery()
                    Next
                Next

                tran.Commit()
            Catch e As MySqlException
                Try
                    tran.Rollback()
                Catch
                End Try


                If WriteExceptionsToEventLog Then
                    WriteToEventLog(e, "AddUsersToRoles")
                Else
                    Throw e
                End If
            Finally
                conn.Close()
            End Try
        End Sub


        '
        ' RoleProvider.CreateRole
        '

        Public Overrides Sub CreateRole(rolename As String)
            If rolename.IndexOf(","c) > 0 Then
                Throw New ArgumentException("Role names cannot contain commas.")
            End If

            If RoleExists(rolename) Then
                Throw New ProviderException("Role name already exists.")
            End If

            Dim conn As New MySqlConnection(connectionString)
            Dim cmd As New MySqlCommand("INSERT INTO `" & rolesTable & "`" & " (Rolename, ApplicationName) " & " Values(?Rolename, ?ApplicationName)", conn)

            cmd.Parameters.Add("?Rolename", MySqlDbType.VarChar, 255).Value = rolename
            cmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = ApplicationName

            Try
                conn.Open()

                cmd.ExecuteNonQuery()
            Catch e As MySqlException
                If WriteExceptionsToEventLog Then
                    WriteToEventLog(e, "CreateRole")
                Else
                    Throw e
                End If
            Finally
                conn.Close()
            End Try
        End Sub


        '
        ' RoleProvider.DeleteRole
        '

        Public Overrides Function DeleteRole(rolename As String, throwOnPopulatedRole As Boolean) As Boolean
            If Not RoleExists(rolename) Then
                Throw New ProviderException("Role does not exist.")
            End If

            If throwOnPopulatedRole AndAlso GetUsersInRole(rolename).Length > 0 Then
                Throw New ProviderException("Cannot delete a populated role.")
            End If

            Dim conn As New MySqlConnection(connectionString)
            Dim cmd As New MySqlCommand("DELETE FROM `" & rolesTable & "`" & " WHERE Rolename = ?Rolename AND ApplicationName = ?ApplicationName", conn)

            cmd.Parameters.Add("?Rolename", MySqlDbType.VarChar, 255).Value = rolename
            cmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = ApplicationName


            Dim cmd2 As New MySqlCommand("DELETE FROM `" & usersInRolesTable & "`" & " WHERE Rolename = ?Rolename AND ApplicationName = ?ApplicationName", conn)

            cmd2.Parameters.Add("?Rolename", MySqlDbType.VarChar, 255).Value = rolename
            cmd2.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = ApplicationName

            Dim tran As MySqlTransaction = Nothing

            Try
                conn.Open()
                tran = conn.BeginTransaction()
                cmd.Transaction = tran
                cmd2.Transaction = tran

                cmd2.ExecuteNonQuery()
                cmd.ExecuteNonQuery()

                tran.Commit()
            Catch e As MySqlException
                Try
                    tran.Rollback()
                Catch
                End Try


                If WriteExceptionsToEventLog Then
                    WriteToEventLog(e, "DeleteRole")

                    Return False
                Else
                    Throw e
                End If
            Finally
                conn.Close()
            End Try

            Return True
        End Function


        '
        ' RoleProvider.GetAllRoles
        '

        Public Overrides Function GetAllRoles() As String()
            Dim tmpRoleNames As String = ""

            Dim conn As New MySqlConnection(connectionString)
            Dim cmd As New MySqlCommand("SELECT Rolename FROM `" & rolesTable & "`" & " WHERE ApplicationName = ?ApplicationName", conn)

            cmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = ApplicationName

            Dim reader As MySqlDataReader = Nothing

            Try
                conn.Open()

                reader = cmd.ExecuteReader()
                While reader.Read()
                    tmpRoleNames += reader.GetString(0) & ","
                End While
                reader.Close()

            Catch e As MySqlException
                If WriteExceptionsToEventLog Then
                    WriteToEventLog(e, "GetAllRoles")
                Else
                    Throw e
                End If
            Finally
                If reader IsNot Nothing Then
                    reader.Close()
                End If
                conn.Close()
            End Try

            If tmpRoleNames.Length > 0 Then
                ' Remove trailing comma.
                tmpRoleNames = tmpRoleNames.Substring(0, tmpRoleNames.Length - 1)
                Return tmpRoleNames.Split(","c)
            End If

            Return New String(-1) {}
        End Function


        '
        ' RoleProvider.GetRolesForUser
        '

        Public Overrides Function GetRolesForUser(username As String) As String()
            Dim tmpRoleNames As String = ""

            Dim conn As New MySqlConnection(connectionString)
            Dim cmd As New MySqlCommand("SELECT Rolename FROM `" & usersInRolesTable & "`" & " WHERE Username = ?Username AND ApplicationName = ?ApplicationName", conn)

            cmd.Parameters.Add("?Username", MySqlDbType.VarChar, 255).Value = username
            cmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = ApplicationName

            Dim reader As MySqlDataReader = Nothing

            Try
                conn.Open()

                reader = cmd.ExecuteReader()
                While reader.Read()
                    tmpRoleNames += reader.GetString(0) & ","
                End While
                reader.Close()

            Catch e As MySqlException
                If WriteExceptionsToEventLog Then
                    WriteToEventLog(e, "GetRolesForUser")
                Else
                    Throw e
                End If
            Finally
                If reader IsNot Nothing Then
                    reader.Close()
                End If
                conn.Close()
            End Try

            If tmpRoleNames.Length > 0 Then
                ' Remove trailing comma.
                tmpRoleNames = tmpRoleNames.Substring(0, tmpRoleNames.Length - 1)
                Return tmpRoleNames.Split(","c)
            End If

            Return New String(-1) {}
        End Function


        '
        ' RoleProvider.GetUsersInRole
        '

        Public Overrides Function GetUsersInRole(rolename As String) As String()
            Dim tmpUserNames As String = ""

            Dim conn As New MySqlConnection(connectionString)
            Dim cmd As New MySqlCommand("SELECT Username FROM `" & usersInRolesTable & "`" & " WHERE Rolename = ?Rolename AND ApplicationName = ?ApplicationName", conn)

            cmd.Parameters.Add("?Rolename", MySqlDbType.VarChar, 255).Value = rolename
            cmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = ApplicationName

            Dim reader As MySqlDataReader = Nothing

            Try
                conn.Open()

                reader = cmd.ExecuteReader()
                While reader.Read()
                    tmpUserNames += reader.GetString(0) & ","
                End While
                reader.Close()

            Catch e As MySqlException
                If WriteExceptionsToEventLog Then
                    WriteToEventLog(e, "GetUsersInRole")
                Else
                    Throw e
                End If
            Finally
                If reader IsNot Nothing Then
                    reader.Close()
                End If
                conn.Close()
            End Try

            If tmpUserNames.Length > 0 Then
                ' Remove trailing comma.
                tmpUserNames = tmpUserNames.Substring(0, tmpUserNames.Length - 1)
                Return tmpUserNames.Split(","c)
            End If

            Return New String(-1) {}
        End Function


        '
        ' RoleProvider.IsUserInRole
        '

        Public Overrides Function IsUserInRole(username As String, rolename As String) As Boolean
            Dim userIsInRole As Boolean = False

            Dim conn As New MySqlConnection(connectionString)
            Dim cmd As New MySqlCommand("SELECT COUNT(*) FROM `" & usersInRolesTable & "`" & " WHERE Username = ?Username AND Rolename = ?Rolename AND ApplicationName = ?ApplicationName", conn)

            cmd.Parameters.Add("?Username", MySqlDbType.VarChar, 255).Value = username
            cmd.Parameters.Add("?Rolename", MySqlDbType.VarChar, 255).Value = rolename
            cmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = ApplicationName

            Try
                conn.Open()

                Dim numRecs As Long = Convert.ToInt64(cmd.ExecuteScalar())

                If numRecs > 0 Then
                    userIsInRole = True
                End If
            Catch e As MySqlException
                If WriteExceptionsToEventLog Then
                    WriteToEventLog(e, "IsUserInRole")
                Else
                    Throw e
                End If
            Finally
                conn.Close()
            End Try

            Return userIsInRole
        End Function


        '
        ' RoleProvider.RemoveUsersFromRoles
        '

        Public Overrides Sub RemoveUsersFromRoles(usernames As String(), rolenames As String())
            For Each rolename As String In rolenames
                If Not RoleExists(rolename) Then
                    Throw New ProviderException("Role name not found.")
                End If
            Next

            For Each username As String In usernames
                For Each rolename As String In rolenames
                    If Not IsUserInRole(username, rolename) Then
                        Throw New ProviderException("User is not in role.")
                    End If
                Next
            Next


            Dim conn As New MySqlConnection(connectionString)
            Dim cmd As New MySqlCommand("DELETE FROM `" & usersInRolesTable & "`" & " WHERE Username = ?Username AND Rolename = ?Rolename AND ApplicationName = ?ApplicationName", conn)

            Dim userParm As MySqlParameter = cmd.Parameters.Add("?Username", MySqlDbType.VarChar, 255)
            Dim roleParm As MySqlParameter = cmd.Parameters.Add("?Rolename", MySqlDbType.VarChar, 255)
            cmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = ApplicationName

            Dim tran As MySqlTransaction = Nothing

            Try
                conn.Open()
                tran = conn.BeginTransaction()
                cmd.Transaction = tran

                For Each username As String In usernames
                    For Each rolename As String In rolenames
                        userParm.Value = username
                        roleParm.Value = rolename
                        cmd.ExecuteNonQuery()
                    Next
                Next

                tran.Commit()
            Catch e As MySqlException
                Try
                    tran.Rollback()
                Catch
                End Try


                If WriteExceptionsToEventLog Then
                    WriteToEventLog(e, "RemoveUsersFromRoles")
                Else
                    Throw e
                End If
            Finally
                conn.Close()
            End Try
        End Sub


        '
        ' RoleProvider.RoleExists
        '

        Public Overrides Function RoleExists(rolename As String) As Boolean
            Dim exists As Boolean = False

            Dim conn As New MySqlConnection(connectionString)
            Dim cmd As New MySqlCommand("SELECT COUNT(*) FROM `" & rolesTable & "`" & " WHERE Rolename = ?Rolename AND ApplicationName = ?ApplicationName", conn)

            cmd.Parameters.Add("?Rolename", MySqlDbType.VarChar, 255).Value = rolename
            cmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = ApplicationName

            Try
                conn.Open()

                Dim numRecs As Long = Convert.ToInt64(cmd.ExecuteScalar())

                If numRecs > 0 Then
                    exists = True
                End If
            Catch e As MySqlException
                If WriteExceptionsToEventLog Then
                    WriteToEventLog(e, "RoleExists")
                Else
                    Throw e
                End If
            Finally
                conn.Close()
            End Try

            Return exists
        End Function

        '
        ' RoleProvider.FindUsersInRole
        '

        Public Overrides Function FindUsersInRole(rolename As String, usernameToMatch As String) As String()
            Dim conn As New MySqlConnection(connectionString)
            Dim cmd As New MySqlCommand("SELECT Username FROM `" & usersInRolesTable & "` " & "WHERE Username LIKE ?UsernameSearch AND Rolename = ?Rolename AND ApplicationName = ?ApplicationName", conn)
            cmd.Parameters.Add("?UsernameSearch", MySqlDbType.VarChar, 255).Value = usernameToMatch
            cmd.Parameters.Add("?RoleName", MySqlDbType.VarChar, 255).Value = rolename
            cmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = pApplicationName

            Dim tmpUserNames As String = ""
            Dim reader As MySqlDataReader = Nothing

            Try
                conn.Open()

                reader = cmd.ExecuteReader()
                While reader.Read()
                    tmpUserNames += reader.GetString(0) & ","
                End While
                reader.Close()

            Catch e As MySqlException
                If WriteExceptionsToEventLog Then
                    WriteToEventLog(e, "FindUsersInRole")
                Else
                    Throw e
                End If
            Finally
                If reader IsNot Nothing Then
                    reader.Close()
                End If

                conn.Close()
            End Try

            If tmpUserNames.Length > 0 Then
                ' Remove trailing comma.
                tmpUserNames = tmpUserNames.Substring(0, tmpUserNames.Length - 1)
                Return tmpUserNames.Split(","c)
            End If

            Return New String(-1) {}
        End Function

        '
        ' WriteToEventLog
        '   A helper function that writes exception detail to the event log. Exceptions
        ' are written to the event log as a security measure to avoid private database
        ' details from being returned to the browser. If a method does not return a status
        ' or boolean indicating the action succeeded or failed, a generic exception is also 
        ' thrown by the caller.
        '

        Private Sub WriteToEventLog(e As MySqlException, action As String)
            Dim log As New EventLog()
            log.Source = eventSource
            log.Log = eventLog

            Dim message As String = exceptionMessage & vbLf & vbLf
            message += "Action: " & action & vbLf & vbLf
            message += "Exception: " & e.ToString()

            log.WriteEntry(message)
        End Sub

    End Class
End Namespace