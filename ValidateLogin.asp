<%
    'Variables Declaration
        Dim UserEmail
        Dim UserPass
        Dim ErrorFound
        Dim RSLogin
        Dim QryStr
    'End

    'UserEmail and Password can be stored from Form or Session Variables
    '1. Whenever User will Login from Login Page Values will be stored from Form Object
    '2. After Login on Every Page Login Values will be stored from Session Variables to revalidate Login Details

    'Initializing Variables from Form Object

        if Session("SUserEmail")="" OR Session("SUserPass") ="" then    'If Session is Null, It means values are coming from Form Obj
            UserEmail = request.Form("TxtUserEmail")
            UserPass = request.Form("TxtUserPass")
            Session("SLoggedDateTime")=""   'LoggedDateTime Session Variable set to Null to Store Logged in Date Time
        else    'If Session is not Null, It means values are coming from Session Obj
            UserEmail = Session("SUserEmail")
            UserPass = Session("SUserPass")
        end if
    'End

    'response.Write(UserEmail)
    'response.Write(UserPass)

    'Session Variables
        Session("SErrorEmail")=""
        Session("SErrorPass")=""
        Session("SErrorInvalid")=""

        Session("SUserEmail")=""
        Session("SUserId")=""
        Session("SUserPass")=""
        Session("SUserName")=""
        Session("SUserRoleId")=""
        Session("SUserRole")=""
    'End

    'Checking Null, Redirecting back to Login Page if Null
        if UserEmail="" or isnull(UserEmail)=true then
            Session("SErrorEmail")="Please Enter Login Email"
            ErrorFound=true
        end if

        if UserPass="" or isnull(UserPass)=true then
            Session("SErrorPass")="Please Enter Login Password"
            Session("SUserEmail")=UserEmail
            ErrorFound=true
        end if

        if ErrorFound=true then
            response.Redirect("Login.asp")
        end if
    'End

    'Setting, Opening Db and RS
        Set Conn = Server.CreateObject("ADODB.Connection")
        Set RSLogin = Server.CreateObject("ADODB.RecordSet")

        CS = "Driver={SQL Server};Server=NABEELS-WORK;Database=TrainingManagementSystem;User Id=TMS;Password=Nabeel30;"
        Conn.Open CS

QryStr = "SELECT LoginUsersDetail.LoginId, LoginUsersDetail.LoginEmail, LoginUsersDetail.UserFullName, LoginUsersDetail.LoginPassword, LoginUsersDetail.UserRoleId, LoginUserRole.Role, LoginUsersDetail.IsActive" & _ 
        " FROM LoginUserRole INNER JOIN " & _
        "LoginUsersDetail ON LoginUserRole.LoginId = LoginUsersDetail.LoginId" & _
        " WHERE (LoginEmail = '" & UserEmail & "') AND (LoginPassword = '" & UserPass & "') AND (IsActive <> 0)" 

        'response.Write(QryStr)

        RSLogin.Open QryStr,Conn

        'Check if Any Record Found or Not, If No then Redirect to Login Page with Invalid Error
        if rslogin.EOF=true then
            Session("SErrorInvalid")=("Invalid UserName or Password")
            Session("SUserEmail")=UserEmail

            response.Redirect("Login.asp")
        else    'Storing RS Values and Looged Date Time in Session Variables
            Session("SUserEmail")= RSLogin("LoginEmail")
            Session("SUserId")= RSLogin("LoginId")
            Session("SUserPass")= RSLogin("LoginPassword")
            Session("SUserName")= RSLogin("UserFullName")
            Session("SUserRoleId")= RSLogin("UserRoleId")
            Session("SUserRole")= RSLogin("Role")

            'If LoggedDateTime is Null, It Means User is trying to Login in Using Login Page
            if Session("SLoggedDateTime") = "" then
                Session("SLoggedDateTime")=Now()
                response.Redirect("Dashboard.asp")     'Redirecting to Dashboard Page
            end if

            'response.Write(RSLogin("LoginEmail"))
            'response.Write(RSLogin("LoginPassword"))
            'response.Write(RSLogin("UserFullName"))
            'response.Write(RSLogin("UserRoleId"))
            'response.Write(RSLogin("Role"))
            'response.Write(Now())
        end if
    'End
%>