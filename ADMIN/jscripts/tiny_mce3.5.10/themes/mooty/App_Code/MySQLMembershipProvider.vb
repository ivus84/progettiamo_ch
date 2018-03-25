Imports System.Web.Security
Imports System.Configuration.Provider
Imports System.Collections.Specialized
Imports System.Data
Imports MySql.Data.MySqlClient
Imports System.Configuration
Imports System.Diagnostics
Imports System.Web
Imports System.Globalization
Imports System.Security.Cryptography
Imports System.Text
Imports System.Web.Configuration


'
'
'-- Please, send me an email (andriniaina@gmail.com) if you have done some improvements or bug corrections to this file
'
'You will have to change MySqlMembershipProvider::encryptionKey to a random hexadecimal value of your choice
'
'CREATE TABLE `users` (
'  `PKID` varchar(36) collate latin1_general_ci NOT NULL default '',
'  `Username` varchar(255) collate latin1_general_ci NOT NULL default '',
'  `ApplicationName` varchar(100) collate latin1_general_ci NOT NULL default '',
'  `Email` varchar(100) collate latin1_general_ci NOT NULL default '',
'  `Comment` varchar(255) collate latin1_general_ci default NULL,
'  `Password` varchar(128) collate latin1_general_ci NOT NULL default '',
'  `PasswordQuestion` varchar(255) collate latin1_general_ci default NULL,
'  `PasswordAnswer` varchar(255) collate latin1_general_ci default NULL,
'  `IsApproved` tinyint(1) default NULL,
'  `LastActivityDate` datetime default NULL,
'  `LastLoginDate` datetime default NULL,
'  `LastPasswordChangedDate` datetime default NULL,
'  `CreationDate` datetime default NULL,
'  `IsOnLine` tinyint(1) default NULL,
'  `IsLockedOut` tinyint(1) default NULL,
'  `LastLockedOutDate` datetime default NULL,
'  `FailedPasswordAttemptCount` int(11) default NULL,
'  `FailedPasswordAttemptWindowStart` datetime default NULL,
'  `FailedPasswordAnswerAttemptCount` int(11) default NULL,
'  `FailedPasswordAnswerAttemptWindowStart` datetime default NULL,
'  PRIMARY KEY  (`PKID`)
') ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci; 
'
'
'



Namespace Andri.Web

    Public NotInheritable Class MySqlMembershipProvider
        Inherits MembershipProvider

        '
        ' Global connection string, generated password length, generic exception message, event log info.
        '

        Private newPasswordLength As Integer = 8
        Private eventSource As String = "MySqlMembershipProvider"
        Private eventLog As String = "Application"
        Private exceptionMessage As String = "An exception occurred. Please check the Event Log."
        Private tableName As String = "users"
        Private connectionString As String

        Private Const encryptionKey As String = "AE09F72B007CAAB5"

        '
        ' If false, exceptions are thrown to the caller. If true,
        ' exceptions are written to the event log.
        '

        Private pWriteExceptionsToEventLog As Boolean

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
                name = "MySqlMembershipProvider"
            End If

            If [String].IsNullOrEmpty(config("description")) Then
                config.Remove("description")
                config.Add("description", "Sample MySql Membership provider")
            End If

            ' Initialize the abstract base class.
            MyBase.Initialize(name, config)

            pApplicationName = GetConfigValue(config("applicationName"), System.Web.Hosting.HostingEnvironment.ApplicationVirtualPath)
            pMaxInvalidPasswordAttempts = Convert.ToInt32(GetConfigValue(config("maxInvalidPasswordAttempts"), "5"))
            pPasswordAttemptWindow = Convert.ToInt32(GetConfigValue(config("passwordAttemptWindow"), "10"))
            pMinRequiredNonAlphanumericCharacters = Convert.ToInt32(GetConfigValue(config("minRequiredNonAlphanumericCharacters"), "1"))
            pMinRequiredPasswordLength = Convert.ToInt32(GetConfigValue(config("minRequiredPasswordLength"), "7"))
            pPasswordStrengthRegularExpression = Convert.ToString(GetConfigValue(config("passwordStrengthRegularExpression"), ""))
            pEnablePasswordReset = Convert.ToBoolean(GetConfigValue(config("enablePasswordReset"), "true"))
            pEnablePasswordRetrieval = Convert.ToBoolean(GetConfigValue(config("enablePasswordRetrieval"), "true"))
            pRequiresQuestionAndAnswer = Convert.ToBoolean(GetConfigValue(config("requiresQuestionAndAnswer"), "false"))
            pRequiresUniqueEmail = Convert.ToBoolean(GetConfigValue(config("requiresUniqueEmail"), "true"))
            pWriteExceptionsToEventLog = Convert.ToBoolean(GetConfigValue(config("writeExceptionsToEventLog"), "true"))

            Dim temp_format As String = config("passwordFormat")
            If temp_format Is Nothing Then
                temp_format = "Hashed"
            End If

            Select Case temp_format
                Case "Hashed"
                    pPasswordFormat = MembershipPasswordFormat.Hashed
                    Exit Select
                Case "Encrypted"
                    pPasswordFormat = MembershipPasswordFormat.Encrypted
                    Exit Select
                Case "Clear"
                    pPasswordFormat = MembershipPasswordFormat.Clear
                    Exit Select
                Case Else
                    Throw New ProviderException("Password format not supported.")
            End Select

            '
            ' Initialize MySqlConnection.
            '

            Dim ConnectionStringSettings As ConnectionStringSettings = ConfigurationManager.ConnectionStrings(config("connectionStringName"))

            If ConnectionStringSettings Is Nothing OrElse ConnectionStringSettings.ConnectionString.Trim() = "" Then
                Throw New ProviderException("Connection string cannot be blank.")
            End If

            connectionString = ConnectionStringSettings.ConnectionString


        End Sub


        '
        ' A helper function to retrieve config values from the configuration file.
        '

        Private Function GetConfigValue(configValue As String, defaultValue As String) As String
            If [String].IsNullOrEmpty(configValue) Then
                Return defaultValue
            End If

            Return configValue
        End Function


        '
        ' System.Web.Security.MembershipProvider properties.
        '


        Private pApplicationName As String
        Private pEnablePasswordReset As Boolean
        Private pEnablePasswordRetrieval As Boolean
        Private pRequiresQuestionAndAnswer As Boolean
        Private pRequiresUniqueEmail As Boolean
        Private pMaxInvalidPasswordAttempts As Integer
        Private pPasswordAttemptWindow As Integer
        Private pPasswordFormat As MembershipPasswordFormat

        Public Overrides Property ApplicationName() As String
            Get
                Return pApplicationName
            End Get
            Set(value As String)
                pApplicationName = value
            End Set
        End Property

        Public Overrides ReadOnly Property EnablePasswordReset() As Boolean
            Get
                Return pEnablePasswordReset
            End Get
        End Property


        Public Overrides ReadOnly Property EnablePasswordRetrieval() As Boolean
            Get
                Return pEnablePasswordRetrieval
            End Get
        End Property


        Public Overrides ReadOnly Property RequiresQuestionAndAnswer() As Boolean
            Get
                Return pRequiresQuestionAndAnswer
            End Get
        End Property


        Public Overrides ReadOnly Property RequiresUniqueEmail() As Boolean
            Get
                Return pRequiresUniqueEmail
            End Get
        End Property


        Public Overrides ReadOnly Property MaxInvalidPasswordAttempts() As Integer
            Get
                Return pMaxInvalidPasswordAttempts
            End Get
        End Property


        Public Overrides ReadOnly Property PasswordAttemptWindow() As Integer
            Get
                Return pPasswordAttemptWindow
            End Get
        End Property


        Public Overrides ReadOnly Property PasswordFormat() As MembershipPasswordFormat
            Get
                Return pPasswordFormat
            End Get
        End Property

        Private pMinRequiredNonAlphanumericCharacters As Integer

        Public Overrides ReadOnly Property MinRequiredNonAlphanumericCharacters() As Integer
            Get
                Return pMinRequiredNonAlphanumericCharacters
            End Get
        End Property

        Private pMinRequiredPasswordLength As Integer

        Public Overrides ReadOnly Property MinRequiredPasswordLength() As Integer
            Get
                Return pMinRequiredPasswordLength
            End Get
        End Property

        Private pPasswordStrengthRegularExpression As String

        Public Overrides ReadOnly Property PasswordStrengthRegularExpression() As String
            Get
                Return pPasswordStrengthRegularExpression
            End Get
        End Property

        '
        ' System.Web.Security.MembershipProvider methods.
        '

        '
        ' MembershipProvider.ChangePassword
        '

        Public Overrides Function ChangePassword(username As String, oldPwd As String, newPwd As String) As Boolean
            If Not ValidateUser(username, oldPwd) Then
                Return False
            End If


            Dim args As New ValidatePasswordEventArgs(username, newPwd, True)

            OnValidatingPassword(args)

            If args.Cancel Then
                If args.FailureInformation IsNot Nothing Then
                    Throw args.FailureInformation
                Else
                    Throw New MembershipPasswordException("Change password canceled due to new password validation failure.")
                End If
            End If


            Dim conn As New MySqlConnection(connectionString)

            Dim cmd As New MySqlCommand("UPDATE `" & tableName & "`" & " SET Password = ?Password, LastPasswordChangedDate = ?LastPasswordChangedDate " & " WHERE Username = ?Username AND ApplicationName = ?ApplicationName", conn)

            cmd.Parameters.Add("?Password", MySqlDbType.VarChar, 255).Value = EncodePassword(newPwd)
            cmd.Parameters.Add("?LastPasswordChangedDate", MySqlDbType.Datetime).Value = DateTime.Now
            cmd.Parameters.Add("?Username", MySqlDbType.VarChar, 255).Value = username
            cmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = pApplicationName


            Dim rowsAffected As Integer = 0

            Try
                conn.Open()

                rowsAffected = cmd.ExecuteNonQuery()
            Catch e As MySqlException
                If WriteExceptionsToEventLog Then
                    WriteToEventLog(e, "ChangePassword")

                    Throw New ProviderException(exceptionMessage)
                Else
                    Throw e
                End If
            Finally
                conn.Close()
            End Try

            If rowsAffected > 0 Then
                Return True
            End If

            Return False
        End Function



        '
        ' MembershipProvider.ChangePasswordQuestionAndAnswer
        '

        Public Overrides Function ChangePasswordQuestionAndAnswer(username As String, password As String, newPwdQuestion As String, newPwdAnswer As String) As Boolean
            If Not ValidateUser(username, password) Then
                Return False
            End If

            Dim conn As New MySqlConnection(connectionString)
            Dim cmd As New MySqlCommand("UPDATE `" & tableName & "`" & " SET PasswordQuestion = ?Question, PasswordAnswer = ?Answer" & " WHERE Username = ?Username AND ApplicationName = ?ApplicationName", conn)

            cmd.Parameters.Add("?Question", MySqlDbType.VarChar, 255).Value = newPwdQuestion
            cmd.Parameters.Add("?Answer", MySqlDbType.VarChar, 255).Value = EncodePassword(newPwdAnswer)
            cmd.Parameters.Add("?Username", MySqlDbType.VarChar, 255).Value = username
            cmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = pApplicationName


            Dim rowsAffected As Integer = 0

            Try
                conn.Open()

                rowsAffected = cmd.ExecuteNonQuery()
            Catch e As MySqlException
                If WriteExceptionsToEventLog Then
                    WriteToEventLog(e, "ChangePasswordQuestionAndAnswer")

                    Throw New ProviderException(exceptionMessage)
                Else
                    Throw e
                End If
            Finally
                conn.Close()
            End Try

            If rowsAffected > 0 Then
                Return True
            End If

            Return False
        End Function



        '
        ' MembershipProvider.CreateUser
        '

        Public Overrides Function CreateUser(username As String, password As String, email As String, passwordQuestion As String, passwordAnswer As String, isApproved As Boolean, _
         providerUserKey As Object, ByRef status As MembershipCreateStatus) As MembershipUser
            Dim args As New ValidatePasswordEventArgs(username, password, True)

            OnValidatingPassword(args)

            If args.Cancel Then
                status = MembershipCreateStatus.InvalidPassword
                Return Nothing
            End If



            If RequiresUniqueEmail AndAlso GetUserNameByEmail(email) <> "" Then
                status = MembershipCreateStatus.DuplicateEmail
                Return Nothing
            End If

            Dim u As MembershipUser = GetUser(username, False)

            If u Is Nothing Then
                Dim createDate As DateTime = DateTime.Now

                If providerUserKey Is Nothing Then
                    providerUserKey = Guid.NewGuid()
                Else
                    If Not (TypeOf providerUserKey Is Guid) Then
                        status = MembershipCreateStatus.InvalidProviderUserKey
                        Return Nothing
                    End If
                End If

                Dim conn As New MySqlConnection(connectionString)
                Dim cmd As New MySqlCommand("INSERT INTO `" & tableName & "`" & " (PKID, Username, Password, Email, PasswordQuestion, " & " PasswordAnswer, IsApproved," & " Comment, CreationDate, LastPasswordChangedDate, LastActivityDate," & " ApplicationName, IsLockedOut, LastLockedOutDate," & " FailedPasswordAttemptCount, FailedPasswordAttemptWindowStart, " & " FailedPasswordAnswerAttemptCount, FailedPasswordAnswerAttemptWindowStart)" & " Values(?PKID, ?Username, ?Password, ?Email, ?PasswordQuestion, " & " ?PasswordAnswer, ?IsApproved, ?Comment, ?CreationDate, ?LastPasswordChangedDate, " & " ?LastActivityDate, ?ApplicationName, ?IsLockedOut, ?LastLockedOutDate, " & " ?FailedPasswordAttemptCount, ?FailedPasswordAttemptWindowStart, " & " ?FailedPasswordAnswerAttemptCount, ?FailedPasswordAnswerAttemptWindowStart)", conn)

                cmd.Parameters.Add("?PKID", MySqlDbType.VarChar).Value = providerUserKey.ToString()
                cmd.Parameters.Add("?Username", MySqlDbType.VarChar, 255).Value = username
                cmd.Parameters.Add("?Password", MySqlDbType.VarChar, 255).Value = EncodePassword(password)
                cmd.Parameters.Add("?Email", MySqlDbType.VarChar, 128).Value = email
                cmd.Parameters.Add("?PasswordQuestion", MySqlDbType.VarChar, 255).Value = passwordQuestion
                cmd.Parameters.Add("?PasswordAnswer", MySqlDbType.VarChar, 255).Value = If(passwordAnswer Is Nothing, Nothing, EncodePassword(passwordAnswer))
                cmd.Parameters.Add("?IsApproved", MySqlDbType.Bit).Value = isApproved
                cmd.Parameters.Add("?Comment", MySqlDbType.VarChar, 255).Value = ""
                cmd.Parameters.Add("?CreationDate", MySqlDbType.Datetime).Value = createDate
                cmd.Parameters.Add("?LastPasswordChangedDate", MySqlDbType.Datetime).Value = createDate
                cmd.Parameters.Add("?LastActivityDate", MySqlDbType.Datetime).Value = createDate
                cmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = pApplicationName
                cmd.Parameters.Add("?IsLockedOut", MySqlDbType.Bit).Value = 0
                'false
                cmd.Parameters.Add("?LastLockedOutDate", MySqlDbType.Datetime).Value = createDate
                cmd.Parameters.Add("?FailedPasswordAttemptCount", MySqlDbType.Int32).Value = 0
                cmd.Parameters.Add("?FailedPasswordAttemptWindowStart", MySqlDbType.Datetime).Value = createDate
                cmd.Parameters.Add("?FailedPasswordAnswerAttemptCount", MySqlDbType.Int32).Value = 0
                cmd.Parameters.Add("?FailedPasswordAnswerAttemptWindowStart", MySqlDbType.Datetime).Value = createDate

                Try
                    conn.Open()

                    Dim recAdded As Integer = cmd.ExecuteNonQuery()

                    If recAdded > 0 Then
                        status = MembershipCreateStatus.Success
                    Else
                        status = MembershipCreateStatus.UserRejected
                    End If
                Catch e As MySqlException
                    If WriteExceptionsToEventLog Then
                        WriteToEventLog(e, "CreateUser")
                    End If

                    status = MembershipCreateStatus.ProviderError
                Finally
                    conn.Close()
                End Try


                Return GetUser(username, False)
            Else
                status = MembershipCreateStatus.DuplicateUserName
            End If


            Return Nothing
        End Function



        '
        ' MembershipProvider.DeleteUser
        '

        Public Overrides Function DeleteUser(username As String, deleteAllRelatedData As Boolean) As Boolean
            Dim conn As New MySqlConnection(connectionString)
            Dim cmd As New MySqlCommand("DELETE FROM `" & tableName & "`" & " WHERE Username = ?Username AND ApplicationName = ?ApplicationName", conn)

            cmd.Parameters.Add("?Username", MySqlDbType.VarChar, 255).Value = username
            cmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = pApplicationName

            Dim rowsAffected As Integer = 0

            Try
                conn.Open()

                rowsAffected = cmd.ExecuteNonQuery()

                ' Process commands to delete all data for the user in the database.
                If deleteAllRelatedData Then
                End If
            Catch e As MySqlException
                If WriteExceptionsToEventLog Then
                    WriteToEventLog(e, "DeleteUser")

                    Throw New ProviderException(exceptionMessage)
                Else
                    Throw e
                End If
            Finally
                conn.Close()
            End Try

            If rowsAffected > 0 Then
                Return True
            End If

            Return False
        End Function



        '
        ' MembershipProvider.GetAllUsers
        '

        Public Overrides Function GetAllUsers(pageIndex As Integer, pageSize As Integer, ByRef totalRecords As Integer) As MembershipUserCollection
            Dim conn As New MySqlConnection(connectionString)
            Dim cmd As New MySqlCommand("SELECT Count(*) FROM `" & tableName & "` " & "WHERE ApplicationName = ?ApplicationName", conn)
            cmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = ApplicationName

            Dim users As New MembershipUserCollection()

            Dim reader As MySqlDataReader = Nothing
            totalRecords = 0

            Try
                conn.Open()
                totalRecords = Convert.ToInt32(cmd.ExecuteScalar())

                If totalRecords <= 0 Then
                    Return users
                End If

                cmd.CommandText = "SELECT PKID, Username, Email, PasswordQuestion," & " Comment, IsApproved, IsLockedOut, CreationDate, LastLoginDate," & " LastActivityDate, LastPasswordChangedDate, LastLockedOutDate " & " FROM `" & tableName & "` " & " WHERE ApplicationName = ?ApplicationName " & " ORDER BY Username Asc"

                reader = cmd.ExecuteReader()
                Dim counter As Integer = 0
                Dim startIndex As Integer = pageSize * pageIndex
                Dim endIndex As Integer = startIndex + pageSize - 1

                While reader.Read()
                    If counter >= startIndex Then
                        Dim u As MembershipUser = GetUserFromReader(reader)
                        users.Add(u)
                    End If

                    If counter >= endIndex Then
                        cmd.Cancel()
                    End If

                    counter += 1
                End While
                reader.Close()

            Catch e As MySqlException
                If WriteExceptionsToEventLog Then
                    WriteToEventLog(e, "GetAllUsers")

                    Throw New ProviderException(exceptionMessage)
                Else
                    Throw e
                End If
            Finally
                If reader IsNot Nothing Then
                    reader.Close()
                End If
                conn.Close()
            End Try

            Return users
        End Function


        '
        ' MembershipProvider.GetNumberOfUsersOnline
        '

        Public Overrides Function GetNumberOfUsersOnline() As Integer

            Dim onlineSpan As New TimeSpan(0, System.Web.Security.Membership.UserIsOnlineTimeWindow, 0)
            Dim compareTime As DateTime = DateTime.Now.Subtract(onlineSpan)

            Dim conn As New MySqlConnection(connectionString)
            Dim cmd As New MySqlCommand("SELECT Count(*) FROM `" & tableName & "`" & " WHERE LastActivityDate > ?CompareDate AND ApplicationName = ?ApplicationName", conn)

            cmd.Parameters.Add("?CompareDate", MySqlDbType.Datetime).Value = compareTime
            cmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = pApplicationName

            Dim numOnline As Integer = 0

            Try
                conn.Open()

                numOnline = Convert.ToInt32(cmd.ExecuteScalar())
            Catch e As MySqlException
                If WriteExceptionsToEventLog Then
                    WriteToEventLog(e, "GetNumberOfUsersOnline")

                    Throw New ProviderException(exceptionMessage)
                Else
                    Throw e
                End If
            Finally
                conn.Close()
            End Try

            Return numOnline
        End Function



        '
        ' MembershipProvider.GetPassword
        '

        Public Overrides Function GetPassword(username As String, answer As String) As String
            If Not EnablePasswordRetrieval Then
                Throw New ProviderException("Password Retrieval Not Enabled.")
            End If

            If PasswordFormat = MembershipPasswordFormat.Hashed Then
                Throw New ProviderException("Cannot retrieve Hashed passwords.")
            End If

            Dim conn As New MySqlConnection(connectionString)
            Dim cmd As New MySqlCommand("SELECT Password, PasswordAnswer, IsLockedOut FROM `" & tableName & "`" & " WHERE Username = ?Username AND ApplicationName = ?ApplicationName", conn)

            cmd.Parameters.Add("?Username", MySqlDbType.VarChar, 255).Value = username
            cmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = pApplicationName

            Dim password As String = ""
            Dim passwordAnswer As String = ""
            Dim reader As MySqlDataReader = Nothing

            Try
                conn.Open()

                reader = cmd.ExecuteReader(CommandBehavior.SingleRow)
                If reader.HasRows Then
                    reader.Read()

                    If reader.GetBoolean(2) Then
                        Throw New MembershipPasswordException("The supplied user is locked out.")
                    End If

                    password = reader.GetString(0)
                    passwordAnswer = reader.GetString(1)
                Else
                    Throw New MembershipPasswordException("The supplied user name is not found.")
                End If
                reader.Close()

            Catch e As MySqlException
                If WriteExceptionsToEventLog Then
                    WriteToEventLog(e, "GetPassword")

                    Throw New ProviderException(exceptionMessage)
                Else
                    Throw e
                End If
            Finally
                If reader IsNot Nothing Then
                    reader.Close()
                End If
                conn.Close()
            End Try


            If RequiresQuestionAndAnswer AndAlso Not CheckPassword(answer, passwordAnswer) Then
                UpdateFailureCount(username, "passwordAnswer")

                Throw New MembershipPasswordException("Incorrect password answer.")
            End If


            If PasswordFormat = MembershipPasswordFormat.Encrypted Then
                password = UnEncodePassword(password)
            End If

            Return password
        End Function



        '
        ' MembershipProvider.GetUser(string, bool)
        '

        Public Overrides Function GetUser(username As String, userIsOnline As Boolean) As MembershipUser
            Dim conn As New MySqlConnection(connectionString)
            Dim cmd As New MySqlCommand("SELECT PKID, Username, Email, PasswordQuestion," & " Comment, IsApproved, IsLockedOut, CreationDate, LastLoginDate," & " LastActivityDate, LastPasswordChangedDate, LastLockedOutDate" & " FROM `" & tableName & "` WHERE Username = ?Username AND ApplicationName = ?ApplicationName", conn)

            cmd.Parameters.Add("?Username", MySqlDbType.VarChar, 255).Value = username
            cmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = pApplicationName

            Dim u As MembershipUser = Nothing
            Dim reader As MySqlDataReader = Nothing

            Try
                conn.Open()

                reader = cmd.ExecuteReader()
                If reader.HasRows Then
                    reader.Read()
                    u = GetUserFromReader(reader)
                    reader.Close()

                    If userIsOnline Then
                        Dim updateCmd As New MySqlCommand("UPDATE `" & tableName & "` " & "SET LastActivityDate = ?LastActivityDate " & "WHERE Username = ?Username AND ApplicationName = ?ApplicationName", conn)

                        updateCmd.Parameters.Add("?LastActivityDate", MySqlDbType.VarChar).Value = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss")
                        updateCmd.Parameters.Add("?Username", MySqlDbType.VarChar, 255).Value = username
                        updateCmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = pApplicationName

                        updateCmd.ExecuteNonQuery()
                    End If
                End If
                reader.Close()

            Catch e As MySqlException
                If WriteExceptionsToEventLog Then
                    WriteToEventLog(e, "GetUser(String, Boolean)")

                    Throw New ProviderException(exceptionMessage)
                Else
                    Throw e
                End If
            Finally
                If reader IsNot Nothing Then
                    reader.Close()
                End If

                conn.Close()
            End Try

            Return u
        End Function


        '
        ' MembershipProvider.GetUser(object, bool)
        '

        Public Overrides Function GetUser(providerUserKey As Object, userIsOnline As Boolean) As MembershipUser
            Dim conn As New MySqlConnection(connectionString)
            Dim cmd As New MySqlCommand("SELECT PKID, Username, Email, PasswordQuestion," & " Comment, IsApproved, IsLockedOut, CreationDate, LastLoginDate," & " LastActivityDate, LastPasswordChangedDate, LastLockedOutDate" & " FROM `" & tableName & "` WHERE PKID = ?PKID", conn)

            cmd.Parameters.Add("?PKID", MySqlDbType.VarChar).Value = providerUserKey

            Dim u As MembershipUser = Nothing
            Dim reader As MySqlDataReader = Nothing

            Try
                conn.Open()

                reader = cmd.ExecuteReader()
                If reader.HasRows Then
                    reader.Read()
                    u = GetUserFromReader(reader)

                    reader.Close()

                    If userIsOnline Then
                        Dim updateCmd As New MySqlCommand("UPDATE `" & tableName & "` " & "SET LastActivityDate = ?LastActivityDate " & "WHERE PKID = ?PKID", conn)

                        updateCmd.Parameters.Add("?LastActivityDate", MySqlDbType.VarChar).Value = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss")
                        updateCmd.Parameters.Add("?PKID", MySqlDbType.VarChar).Value = providerUserKey

                        updateCmd.ExecuteNonQuery()
                    End If
                End If
                reader.Close()

            Catch e As MySqlException
                If WriteExceptionsToEventLog Then
                    WriteToEventLog(e, "GetUser(Object, Boolean)")

                    Throw New ProviderException(exceptionMessage)
                Else
                    Throw e
                End If
            Finally
                If reader IsNot Nothing Then
                    reader.Close()
                End If

                conn.Close()
            End Try

            Return u
        End Function


        '
        ' GetUserFromReader
        '    A helper function that takes the current row from the MySqlDataReader
        ' and hydrates a MembershiUser from the values. Called by the 
        ' MembershipUser.GetUser implementation.
        '

        Private Function GetUserFromReader(reader As MySqlDataReader) As MembershipUser
            Dim providerUserKey As Object = New Guid(reader.GetValue(0).ToString())
            Dim username As String = If(reader.IsDBNull(1), "", reader.GetString(1))
            Dim email As String = If(reader.IsDBNull(2), "", reader.GetString(2))
            Dim passwordQuestion As String = If(reader.IsDBNull(3), "", reader.GetString(3))
            Dim comment As String = If(reader.IsDBNull(4), "", reader.GetString(4))
            Dim isApproved As Boolean = If(reader.IsDBNull(5), False, reader.GetBoolean(5))
            Dim isLockedOut As Boolean = If(reader.IsDBNull(6), False, reader.GetBoolean(6))
            Dim creationDate As DateTime = If(reader.IsDBNull(7), DateTime.Now, reader.GetDateTime(7))
            Dim lastLoginDate As DateTime = If(reader.IsDBNull(8), DateTime.Now, reader.GetDateTime(8))
            Dim lastActivityDate As DateTime = If(reader.IsDBNull(9), DateTime.Now, reader.GetDateTime(9))
            Dim lastPasswordChangedDate As DateTime = If(reader.IsDBNull(10), DateTime.Now, reader.GetDateTime(10))
            Dim lastLockedOutDate As DateTime = If(reader.IsDBNull(11), DateTime.Now, reader.GetDateTime(11))

            Dim u As New MembershipUser(Me.Name, username, providerUserKey, email, passwordQuestion, comment, _
             isApproved, isLockedOut, creationDate, lastLoginDate, lastActivityDate, lastPasswordChangedDate, _
             lastLockedOutDate)

            Return u
        End Function


        '
        ' MembershipProvider.UnlockUser
        '

        Public Overrides Function UnlockUser(username As String) As Boolean
            Dim conn As New MySqlConnection(connectionString)
            Dim cmd As New MySqlCommand("UPDATE `" & tableName & "` " & " SET IsLockedOut = 0, LastLockedOutDate = ?LastLockedOutDate " & " WHERE Username = ?Username AND ApplicationName = ?ApplicationName", conn)

            cmd.Parameters.Add("?LastLockedOutDate", MySqlDbType.Datetime).Value = DateTime.Now
            cmd.Parameters.Add("?Username", MySqlDbType.VarChar, 255).Value = username
            cmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = pApplicationName

            Dim rowsAffected As Integer = 0

            Try
                conn.Open()

                rowsAffected = cmd.ExecuteNonQuery()
            Catch e As MySqlException
                If WriteExceptionsToEventLog Then
                    WriteToEventLog(e, "UnlockUser")

                    Throw New ProviderException(exceptionMessage)
                Else
                    Throw e
                End If
            Finally
                conn.Close()
            End Try

            If rowsAffected > 0 Then
                Return True
            End If

            Return False
        End Function


        '
        ' MembershipProvider.GetUserNameByEmail
        '

        Public Overrides Function GetUserNameByEmail(email As String) As String
            Dim conn As New MySqlConnection(connectionString)
            Dim cmd As New MySqlCommand("SELECT Username" & " FROM `" & tableName & "` WHERE Email = ?Email AND ApplicationName = ?ApplicationName", conn)

            cmd.Parameters.Add("?Email", MySqlDbType.VarChar, 128).Value = email
            cmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = pApplicationName

            Dim username As String = ""

            Try
                conn.Open()

                username = DirectCast(cmd.ExecuteScalar(), String)
            Catch e As MySqlException
                If WriteExceptionsToEventLog Then
                    WriteToEventLog(e, "GetUserNameByEmail")

                    Throw New ProviderException(exceptionMessage)
                Else
                    Throw e
                End If
            Finally
                conn.Close()
            End Try

            If username Is Nothing Then
                username = ""
            End If

            Return username
        End Function




        '
        ' MembershipProvider.ResetPassword
        '

        Public Overrides Function ResetPassword(username As String, answer As String) As String
            If Not EnablePasswordReset Then
                Throw New NotSupportedException("Password reset is not enabled.")
            End If

            If answer Is Nothing AndAlso RequiresQuestionAndAnswer Then
                UpdateFailureCount(username, "passwordAnswer")

                Throw New ProviderException("Password answer required for password reset.")
            End If

            Dim newPassword As String = System.Web.Security.Membership.GeneratePassword(newPasswordLength, MinRequiredNonAlphanumericCharacters)


            Dim args As New ValidatePasswordEventArgs(username, newPassword, True)

            OnValidatingPassword(args)

            If args.Cancel Then
                If args.FailureInformation IsNot Nothing Then
                    Throw args.FailureInformation
                Else
                    Throw New MembershipPasswordException("Reset password canceled due to password validation failure.")
                End If
            End If


            Dim conn As New MySqlConnection(connectionString)
            Dim cmd As New MySqlCommand("SELECT PasswordAnswer, IsLockedOut FROM `" & tableName & "`" & " WHERE Username = ?Username AND ApplicationName = ?ApplicationName", conn)

            cmd.Parameters.Add("?Username", MySqlDbType.VarChar, 255).Value = username
            cmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = pApplicationName

            Dim rowsAffected As Integer = 0
            Dim passwordAnswer As String = ""
            Dim reader As MySqlDataReader = Nothing

            Try
                conn.Open()

                reader = cmd.ExecuteReader(CommandBehavior.SingleRow)
                If reader.HasRows Then
                    reader.Read()

                    If reader.GetBoolean(1) Then
                        Throw New MembershipPasswordException("The supplied user is locked out.")
                    End If

                    passwordAnswer = reader.GetString(0)
                Else
                    Throw New MembershipPasswordException("The supplied user name is not found.")
                End If
                reader.Close()


                If RequiresQuestionAndAnswer AndAlso Not CheckPassword(answer, passwordAnswer) Then
                    UpdateFailureCount(username, "passwordAnswer")

                    Throw New MembershipPasswordException("Incorrect password answer.")
                End If

                Dim updateCmd As New MySqlCommand("UPDATE `" & tableName & "`" & " SET Password = ?Password, LastPasswordChangedDate = ?LastPasswordChangedDate" & " WHERE Username = ?Username AND ApplicationName = ?ApplicationName AND IsLockedOut = 0", conn)

                updateCmd.Parameters.Add("?Password", MySqlDbType.VarChar, 255).Value = EncodePassword(newPassword)
                updateCmd.Parameters.Add("?LastPasswordChangedDate", MySqlDbType.DateTime).Value = DateTime.Now
                updateCmd.Parameters.Add("?Username", MySqlDbType.VarChar, 255).Value = username
                updateCmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = pApplicationName

                rowsAffected = updateCmd.ExecuteNonQuery()
            Catch e As MySqlException
                If WriteExceptionsToEventLog Then
                    WriteToEventLog(e, "ResetPassword")

                    Throw New ProviderException(exceptionMessage)
                Else
                    Throw e
                End If
            Finally
                If reader IsNot Nothing Then
                    reader.Close()
                End If
                conn.Close()
            End Try

            If rowsAffected > 0 Then
                Return newPassword
            Else
                Throw New MembershipPasswordException("User not found, or user is locked out. Password not Reset.")
            End If
        End Function


        '
        ' MembershipProvider.UpdateUser
        '

        Public Overrides Sub UpdateUser(user As MembershipUser)
            Dim conn As New MySqlConnection(connectionString)
            Dim cmd As New MySqlCommand("UPDATE `" & tableName & "`" & " SET Email = ?Email, Comment = ?Comment," & " IsApproved = ?IsApproved" & " WHERE Username = ?Username AND ApplicationName = ?ApplicationName", conn)

            cmd.Parameters.Add("?Email", MySqlDbType.VarChar, 128).Value = user.Email
            cmd.Parameters.Add("?Comment", MySqlDbType.VarChar, 255).Value = user.Comment
            cmd.Parameters.Add("?IsApproved", MySqlDbType.Bit).Value = user.IsApproved
            cmd.Parameters.Add("?Username", MySqlDbType.VarChar, 255).Value = user.UserName
            cmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = pApplicationName


            Try
                conn.Open()

                cmd.ExecuteNonQuery()
            Catch e As MySqlException
                If WriteExceptionsToEventLog Then
                    WriteToEventLog(e, "UpdateUser")

                    Throw New ProviderException(exceptionMessage)
                Else
                    Throw e
                End If
            Finally
                conn.Close()
            End Try
        End Sub


        '
        ' MembershipProvider.ValidateUser
        '

        Public Overrides Function ValidateUser(username As String, password As String) As Boolean
            Dim isValid As Boolean = False

            Dim conn As New MySqlConnection(connectionString)
            Dim cmd As New MySqlCommand("SELECT Password, IsApproved FROM `" & tableName & "`" & " WHERE Username = ?Username AND ApplicationName = ?ApplicationName AND IsLockedOut = 0", conn)

            cmd.Parameters.Add("?Username", MySqlDbType.VarChar, 255).Value = username
            cmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = pApplicationName

            Dim reader As MySqlDataReader = Nothing
            Dim isApproved As Boolean = False
            Dim pwd As String = ""

            Try
                conn.Open()

                reader = cmd.ExecuteReader(CommandBehavior.SingleRow)
                If reader.HasRows Then
                    reader.Read()
                    pwd = reader.GetString(0)
                    isApproved = reader.GetBoolean(1)
                Else
                    Return False
                End If
                reader.Close()


                If CheckPassword(password, pwd) Then
                    If isApproved Then
                        isValid = True

                        Dim updateCmd As New MySqlCommand("UPDATE `" & tableName & "` SET LastLoginDate = ?LastLoginDate, LastActivityDate = ?LastActivityDate" & " WHERE Username = ?Username AND ApplicationName = ?ApplicationName", conn)

                        updateCmd.Parameters.Add("?LastLoginDate", MySqlDbType.DateTime).Value = DateTime.Now
                        updateCmd.Parameters.Add("?LastActivityDate", MySqlDbType.DateTime).Value = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss")
                        updateCmd.Parameters.Add("?Username", MySqlDbType.VarChar, 255).Value = username
                        updateCmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = pApplicationName

                        updateCmd.ExecuteNonQuery()
                    End If
                Else
                    conn.Close()

                    UpdateFailureCount(username, "password")
                End If
            Catch e As MySqlException
                If WriteExceptionsToEventLog Then
                    WriteToEventLog(e, "ValidateUser")

                    Throw New ProviderException(exceptionMessage)
                Else
                    Throw e
                End If
            Finally
                If reader IsNot Nothing Then
                    reader.Close()
                End If
                conn.Close()
            End Try

            Return isValid
        End Function


        '
        ' UpdateFailureCount
        '   A helper method that performs the checks and updates associated with
        ' password failure tracking.
        '

        Private Sub UpdateFailureCount(username As String, failureType As String)
            Dim conn As New MySqlConnection(connectionString)
            Dim cmd As New MySqlCommand("SELECT FailedPasswordAttemptCount, " & "  FailedPasswordAttemptWindowStart, " & "  FailedPasswordAnswerAttemptCount, " & "  FailedPasswordAnswerAttemptWindowStart " & "  FROM `" & tableName & "` " & "  WHERE Username = ?Username AND ApplicationName = ?ApplicationName", conn)

            cmd.Parameters.Add("?Username", MySqlDbType.VarChar, 255).Value = username
            cmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = pApplicationName

            Dim reader As MySqlDataReader = Nothing
            Dim windowStart As New DateTime()
            Dim failureCount As Integer = 0

            Try
                conn.Open()

                reader = cmd.ExecuteReader(CommandBehavior.SingleRow)
                If reader.HasRows Then
                    reader.Read()

                    If failureType = "password" Then
                        failureCount = reader.GetInt32(0)
                        windowStart = reader.GetDateTime(1)
                    End If

                    If failureType = "passwordAnswer" Then
                        failureCount = reader.GetInt32(2)
                        windowStart = reader.GetDateTime(3)
                    End If
                End If
                reader.Close()


                Dim windowEnd As DateTime = windowStart.AddMinutes(PasswordAttemptWindow)

                If failureCount = 0 OrElse DateTime.Now > windowEnd Then
                    ' First password failure or outside of PasswordAttemptWindow. 
                    ' Start a new password failure count from 1 and a new window starting now.

                    If failureType = "password" Then
                        cmd.CommandText = "UPDATE `" & tableName & "` " & "  SET FailedPasswordAttemptCount = ?Count, " & "      FailedPasswordAttemptWindowStart = ?WindowStart " & "  WHERE Username = ?Username AND ApplicationName = ?ApplicationName"
                    End If

                    If failureType = "passwordAnswer" Then
                        cmd.CommandText = "UPDATE `" & tableName & "` " & "  SET FailedPasswordAnswerAttemptCount = ?Count, " & "      FailedPasswordAnswerAttemptWindowStart = ?WindowStart " & "  WHERE Username = ?Username AND ApplicationName = ?ApplicationName"
                    End If

                    cmd.Parameters.Clear()

                    cmd.Parameters.Add("?Count", MySqlDbType.Int32).Value = 1
                    cmd.Parameters.Add("?WindowStart", MySqlDbType.DateTime).Value = DateTime.Now
                    cmd.Parameters.Add("?Username", MySqlDbType.VarChar, 255).Value = username
                    cmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = pApplicationName

                    If cmd.ExecuteNonQuery() < 0 Then
                        Throw New ProviderException("Unable to update failure count and window start.")
                    End If
                Else
                    If System.Math.Max(System.Threading.Interlocked.Increment(failureCount), failureCount - 1) >= MaxInvalidPasswordAttempts Then
                        ' Password attempts have exceeded the failure threshold. Lock out
                        ' the user.

                        cmd.CommandText = "UPDATE `" & tableName & "` " & "  SET IsLockedOut = ?IsLockedOut, LastLockedOutDate = ?LastLockedOutDate " & "  WHERE Username = ?Username AND ApplicationName = ?ApplicationName"

                        cmd.Parameters.Clear()

                        cmd.Parameters.Add("?IsLockedOut", MySqlDbType.Bit).Value = True
                        cmd.Parameters.Add("?LastLockedOutDate", MySqlDbType.DateTime).Value = DateTime.Now
                        cmd.Parameters.Add("?Username", MySqlDbType.VarChar, 255).Value = username
                        cmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = pApplicationName

                        If cmd.ExecuteNonQuery() < 0 Then
                            Throw New ProviderException("Unable to lock out user.")
                        End If
                    Else
                        ' Password attempts have not exceeded the failure threshold. Update
                        ' the failure counts. Leave the window the same.

                        If failureType = "password" Then
                            cmd.CommandText = "UPDATE `" & tableName & "` " & "  SET FailedPasswordAttemptCount = ?Count" & "  WHERE Username = ?Username AND ApplicationName = ?ApplicationName"
                        End If

                        If failureType = "passwordAnswer" Then
                            cmd.CommandText = "UPDATE `" & tableName & "` " & "  SET FailedPasswordAnswerAttemptCount = ?Count" & "  WHERE Username = ?Username AND ApplicationName = ?ApplicationName"
                        End If

                        cmd.Parameters.Clear()

                        cmd.Parameters.Add("?Count", MySqlDbType.Int32).Value = failureCount
                        cmd.Parameters.Add("?Username", MySqlDbType.VarChar, 255).Value = username
                        cmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = pApplicationName

                        If cmd.ExecuteNonQuery() < 0 Then
                            Throw New ProviderException("Unable to update failure count.")
                        End If
                    End If
                End If
            Catch e As MySqlException
                If WriteExceptionsToEventLog Then
                    WriteToEventLog(e, "UpdateFailureCount")

                    Throw New ProviderException(exceptionMessage)
                Else
                    Throw e
                End If
            Finally
                If reader IsNot Nothing Then
                    reader.Close()
                End If
                conn.Close()
            End Try
        End Sub


        '
        ' CheckPassword
        '   Compares password values based on the MembershipPasswordFormat.
        '

        Private Function CheckPassword(password As String, dbpassword As String) As Boolean
            Dim pass1 As String = password
            Dim pass2 As String = dbpassword

            Select Case PasswordFormat
                Case MembershipPasswordFormat.Encrypted
                    pass2 = UnEncodePassword(dbpassword)
                    Exit Select
                Case MembershipPasswordFormat.Hashed
                    pass1 = EncodePassword(password)
                    Exit Select
                Case Else
                    Exit Select
            End Select

            If pass1 = pass2 Then
                Return True
            End If

            Return False
        End Function


        '
        ' EncodePassword
        '   Encrypts, Hashes, or leaves the password clear based on the PasswordFormat.
        '

        Private Function EncodePassword(password As String) As String
            Dim encodedPassword As String = password

            Select Case PasswordFormat
                Case MembershipPasswordFormat.Clear
                    Exit Select
                Case MembershipPasswordFormat.Encrypted
                    encodedPassword = Convert.ToBase64String(EncryptPassword(Encoding.Unicode.GetBytes(password)))
                    Exit Select
                Case MembershipPasswordFormat.Hashed
                    Dim hash As New HMACSHA1()
                    hash.Key = HexToByte(encryptionKey)
                    encodedPassword = Convert.ToBase64String(hash.ComputeHash(Encoding.Unicode.GetBytes(password)))
                    Exit Select
                Case Else
                    Throw New ProviderException("Unsupported password format.")
            End Select

            Return encodedPassword
        End Function


        '
        ' UnEncodePassword
        '   Decrypts or leaves the password clear based on the PasswordFormat.
        '

        Private Function UnEncodePassword(encodedPassword As String) As String
            Dim password As String = encodedPassword

            Select Case PasswordFormat
                Case MembershipPasswordFormat.Clear
                    Exit Select
                Case MembershipPasswordFormat.Encrypted
                    password = Encoding.Unicode.GetString(DecryptPassword(Convert.FromBase64String(password)))
                    Exit Select
                Case MembershipPasswordFormat.Hashed
                    Throw New ProviderException("Cannot unencode a hashed password.")
                Case Else
                    Throw New ProviderException("Unsupported password format.")
            End Select

            Return password
        End Function

        '
        ' HexToByte
        '   Converts a hexadecimal string to a byte array. Used to convert encryption
        ' key values from the configuration.
        '

        Private Function HexToByte(hexString As String) As Byte()
            Dim returnBytes As Byte() = New Byte(hexString.Length \ 2 - 1) {}
            For i As Integer = 0 To returnBytes.Length - 1
                returnBytes(i) = Convert.ToByte(hexString.Substring(i * 2, 2), 16)
            Next
            Return returnBytes
        End Function


        '
        ' MembershipProvider.FindUsersByName
        '

        Public Overrides Function FindUsersByName(usernameToMatch As String, pageIndex As Integer, pageSize As Integer, ByRef totalRecords As Integer) As MembershipUserCollection

            Dim conn As New MySqlConnection(connectionString)
            Dim cmd As New MySqlCommand("SELECT Count(*) FROM `" & tableName & "` " & "WHERE Username LIKE ?UsernameSearch AND ApplicationName = ?ApplicationName", conn)
            cmd.Parameters.Add("?UsernameSearch", MySqlDbType.VarChar, 255).Value = usernameToMatch
            cmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = pApplicationName

            Dim users As New MembershipUserCollection()

            Dim reader As MySqlDataReader = Nothing

            Try
                conn.Open()
                totalRecords = Convert.ToInt32(cmd.ExecuteScalar())

                If totalRecords <= 0 Then
                    Return users
                End If

                cmd.CommandText = "SELECT PKID, Username, Email, PasswordQuestion," & " Comment, IsApproved, IsLockedOut, CreationDate, LastLoginDate," & " LastActivityDate, LastPasswordChangedDate, LastLockedOutDate " & " FROM `" & tableName & "` " & " WHERE Username LIKE ?UsernameSearch AND ApplicationName = ?ApplicationName " & " ORDER BY Username Asc"

                reader = cmd.ExecuteReader()
                Dim counter As Integer = 0
                Dim startIndex As Integer = pageSize * pageIndex
                Dim endIndex As Integer = startIndex + pageSize - 1

                While reader.Read()
                    If counter >= startIndex Then
                        Dim u As MembershipUser = GetUserFromReader(reader)
                        users.Add(u)
                    End If

                    If counter >= endIndex Then
                        cmd.Cancel()
                    End If

                    counter += 1
                End While
                reader.Close()

            Catch e As MySqlException
                If WriteExceptionsToEventLog Then
                    WriteToEventLog(e, "FindUsersByName")

                    Throw New ProviderException(exceptionMessage)
                Else
                    Throw e
                End If
            Finally
                If reader IsNot Nothing Then
                    reader.Close()
                End If

                conn.Close()
            End Try

            Return users
        End Function

        '
        ' MembershipProvider.FindUsersByEmail
        '

        Public Overrides Function FindUsersByEmail(emailToMatch As String, pageIndex As Integer, pageSize As Integer, ByRef totalRecords As Integer) As MembershipUserCollection
            Dim conn As New MySqlConnection(connectionString)
            Dim cmd As New MySqlCommand("SELECT Count(*) FROM `" & tableName & "` " & "WHERE Email LIKE ?EmailSearch AND ApplicationName = ?ApplicationName", conn)
            cmd.Parameters.Add("?EmailSearch", MySqlDbType.VarChar, 255).Value = emailToMatch
            cmd.Parameters.Add("?ApplicationName", MySqlDbType.VarChar, 255).Value = ApplicationName

            Dim users As New MembershipUserCollection()

            Dim reader As MySqlDataReader = Nothing
            totalRecords = 0

            Try
                conn.Open()
                totalRecords = Convert.ToInt32(cmd.ExecuteScalar())

                If totalRecords <= 0 Then
                    Return users
                End If

                cmd.CommandText = "SELECT PKID, Username, Email, PasswordQuestion," & " Comment, IsApproved, IsLockedOut, CreationDate, LastLoginDate," & " LastActivityDate, LastPasswordChangedDate, LastLockedOutDate " & " FROM `" & tableName & "` " & " WHERE Email LIKE ?Username AND ApplicationName = ?ApplicationName " & " ORDER BY Username Asc"

                reader = cmd.ExecuteReader()
                Dim counter As Integer = 0
                Dim startIndex As Integer = pageSize * pageIndex
                Dim endIndex As Integer = startIndex + pageSize - 1

                While reader.Read()
                    If counter >= startIndex Then
                        Dim u As MembershipUser = GetUserFromReader(reader)
                        users.Add(u)
                    End If

                    If counter >= endIndex Then
                        cmd.Cancel()
                    End If

                    counter += 1
                End While
                reader.Close()

            Catch e As MySqlException
                If WriteExceptionsToEventLog Then
                    WriteToEventLog(e, "FindUsersByEmail")

                    Throw New ProviderException(exceptionMessage)
                Else
                    Throw e
                End If
            Finally
                If reader IsNot Nothing Then
                    reader.Close()
                End If

                conn.Close()
            End Try

            Return users
        End Function

        '
        ' WriteToEventLog
        '   A helper function that writes exception detail to the event log. Exceptions
        ' are written to the event log as a security measure to avoid private database
        ' details from being returned to the browser. If a method does not return a status
        ' or boolean indicating the action succeeded or failed, a generic exception is also 
        ' thrown by the caller.
        '

        Private Sub WriteToEventLog(e As Exception, action As String)
            Return
            Dim log As New EventLog()
            log.Source = eventSource
            log.Log = eventLog

            Dim message As String = "An exception occurred communicating with the data source." & vbLf & vbLf
            message += "Action: " & action & vbLf & vbLf
            message += "Exception: " & e.ToString()

            log.WriteEntry(message)
        End Sub
    End Class
End Namespace