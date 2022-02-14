<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->

<%
if Session("SUserRoleId") <> 2 then

call OpenDbConn()
Dim RSGender
Set RSGender = Server.CreateObject("ADODB.RecordSet")
QryStr = "SELECT * FROM ListGender"
RSGender.Open QryStr, conn

if Request.QueryString("QsAction") = "1" then
    Dim mGender
    mGender = Request.form("FormGender")
    Session("sGender") = ""

    if mGender = "" OR Len(mGender) = 0 then
        Session("sGender") = "Gender cannot be NULL"
        response.redirect("ListGender.asp")
    else
        Session("sGender") = ""
    end if

    QryStr = "INSERT INTO ListGender(Gender, UserCreatedBy, CreationDateTime)" & _
            " Values('" & mGender & "', " & Session("SUserId") & ", '" & Now() & "')"
    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListGender.asp")
end if

if Request.QueryString("QsAction") = "3" then
    'Dim mGender
    Dim mGenderId
    mGender = Request.form("FormGender")
    mGenderId = Request.form("FormGenderId")
    Session("sGender") = ""

    if mGender = "" OR Len(mGender) = 0 then
        Session("sGender") = "Gender cannot be NULL"
        response.redirect("ListGender.asp?QsAction=2&QsId=" & mGenderId)
    else
        Session("sGender") = ""
    end if

    QryStr = "UPDATE ListGender SET Gender = '" & mGender & "', UserLastUpdatedBy = " & Session("SUserId") & _
                ", LastUpdatedDateTime = '" & Now() & "' WHERE(GenderId = " & mGenderId & ")"

    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListGender.asp")
end if

%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <link rel="stylesheet" href="CSS/GlobalStyle.css">
    <link rel="stylesheet" href="CSS/StyleAddCourseDir.css">
    <title>Gender</title>
</head>

<body>
    <header>
        <!--#include file=Header.asp-->
    </header>

    <div class="wrapper">
        <div class="container-fluid">

            <% 
            if request.QueryString("QsAction") = "2" then 
                Dim RSEditGender
                Set RSEditGender = Server.CreateObject("ADODB.RecordSet")
                RSEditGender.Open "SELECT GenderId, Gender FROM ListGender WHERE (GenderId = " & Request.QueryString("QsId") & ")", conn
            %>
            <form action="ListGender.asp?QsAction=3" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Edit Gender</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Gender</label>
                                <input for="" class="form-control" name="FormGender"
                                    value="<% response.write(RSEditGender("Gender")) %>"></input>
                                <span><% response.write(Session("sGender")) %></span>
                                <input type="hidden" name="FormGenderId"
                                    value="<% response.write(RSEditGender("GenderId")) %>">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg d-flex justify-content-center">
                                <input type="submit" value="Update" class="button" style="width: 20%">
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <%
            RSEditGender.close
            set RSEditGender = Nothing
            %>
            <% else %>
            <form action="ListGender.asp?QsAction=1" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Add New Gender</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Gender</label>
                                <input for="" class="form-control" name="FormGender"></input>
                                <span><% response.write(Session("sGender")) %></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg d-flex justify-content-center">
                                <input type="submit" value="Add" class="button" style="width: 20%">
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <% end if %>

            <div class="panel">
                <br>
                <div class="panel-head">
                    <div class="row">
                        <div class="col">
                            <label for="">Gender</label>
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <br>
                    <table class="table table-bordered table-hover" style="width: 60%;">
                        <thead>
                            <tr>
                                <th style="width: 3%;">Gender Id</th>
                                <th style="width: 5%;">Gender</th>
                                <th style="width: 0.5%"></th>
                            </tr>
                        </thead>

                        <tbody>
                            <%
                                do while NOT RSGender.EOF
                            %>
                            <tr>
                                <td><% response.write(RSGender("GenderId")) %></td>
                                <td><% response.write(RSGender("Gender")) %></td>
                                <td>
                                    <a href="ListGender.asp?QsAction=2&QsId=<% response.write(RSGender("GenderId")) %>">
                                        <img src="Images/edit.png" alt="" width="20px" height="20px">
                                    </a>
                                </td>
                            </tr>
                            <%
                                RSGender.MoveNext
                                Loop

                                RSGender.close
                                set RSGender = Nothing
                            %>
                        </tbody>
                    </table>
                </div>
                <br>
            </div>
        </div>
    </div>

    <footer>
        <!--#include file=Footer.asp-->
    </footer>

</body>
<% 
else
response.redirect("dashboard.asp")
end if
%>

</html>