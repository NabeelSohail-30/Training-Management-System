<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->

<%
if Session("SUserRoleId") <> 2 then
call OpenDbConn()
Dim RSMaritalStatus
Set RSMaritalStatus = Server.CreateObject("ADODB.RecordSet")
QryStr = "SELECT * FROM ListMaritalStatus"
RSMaritalStatus.Open QryStr, conn

if Request.QueryString("QsAction") = "1" then
    Dim mMaritalStatus
    mMaritalStatus = Request.form("FormMaritalStatus")
    Session("sMaritalStatus") = ""

    if mMaritalStatus = "" OR Len(mMaritalStatus) = 0 then
        Session("sMaritalStatus") = "Marital Status cannot be NULL"
        response.redirect("ListMaritalStatus.asp")
    else
        Session("sMaritalStatus") = ""
    end if

    QryStr = "INSERT INTO ListMaritalStatus(MaritalStatus, UserCreatedBy, CreationDateTime)" & _
            " Values('" & mMaritalStatus & "', " & Session("SUserId") & ", '" & Now() & "')"
    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListMaritalStatus.asp")
end if

if Request.QueryString("QsAction") = "3" then
    'Dim mMaritalStatus
    Dim mMaritalStatusId
    mMaritalStatus = Request.form("FormMaritalStatus")
    mMaritalStatusId = Request.form("FormMaritalStatusId")
    Session("sMaritalStatus") = ""

    if mMaritalStatus = "" OR Len(mMaritalStatus) = 0 then
        Session("sMaritalStatus") = "Marital Status cannot be NULL"
        response.redirect("ListMaritalStatus.asp?QsAction=2&QsId=" & mMaritalStatusId)
    else
        Session("sMaritalStatus") = ""
    end if

    QryStr = "UPDATE ListMaritalStatus SET MaritalStatus = '" & mMaritalStatus & "', UserLastUpdatedBy = " & Session("SUserId") & _
                ", LastUpdatedDateTime = '" & Now() & "' WHERE(MaritalStatusId = " & mMaritalStatusId & ")"

    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListMaritalStatus.asp")
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
    <title>Marital Status</title>
</head>

<body>
    <header>
        <!--#include file=Header.asp-->
    </header>

    <div class="wrapper">
        <div class="container-fluid">

            <% 
            if request.QueryString("QsAction") = "2" then 
                Dim RSEditMaritalStatus
                Set RSEditMaritalStatus = Server.CreateObject("ADODB.RecordSet")
                RSEditMaritalStatus.Open "SELECT MaritalStatusId, MaritalStatus FROM ListMaritalStatus WHERE (MaritalStatusId = " & Request.QueryString("QsId") & ")", conn
            %>
            <form action="ListMaritalStatus.asp?QsAction=3" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Edit Marital Status</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Marital Status</label>
                                <input for="" class="form-control" name="FormMaritalStatus"
                                    value="<% response.write(RSEditMaritalStatus("MaritalStatus")) %>"></input>
                                <span><% response.write(Session("sMaritalStatus")) %></span>
                                <input type="hidden" name="FormMaritalStatusId"
                                    value="<% response.write(RSEditMaritalStatus("MaritalStatusId")) %>">
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
            RSEditMaritalStatus.close
            set RSEditMaritalStatus = Nothing
            %>
            <% else %>
            <form action="ListMaritalStatus.asp?QsAction=1" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Add New Marital Status</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Marital Status</label>
                                <input for="" class="form-control" name="FormMaritalStatus"></input>
                                <span><% response.write(Session("sMaritalStatus")) %></span>
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
                            <label for="">Marital Status</label>
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <br>
                    <table class="table table-bordered table-hover" style="width: 60%;">
                        <thead>
                            <tr>
                                <th style="width: 3%;">Marital Status Id</th>
                                <th style="width: 5%;">Marital Status</th>
                                <th style="width: 0.5%"></th>
                            </tr>
                        </thead>

                        <tbody>
                            <%
                                do while NOT RSMaritalStatus.EOF
                            %>
                            <tr>
                                <td><% response.write(RSMaritalStatus("MaritalStatusId")) %></td>
                                <td><% response.write(RSMaritalStatus("MaritalStatus")) %></td>
                                <td>
                                    <a
                                        href="ListMaritalStatus.asp?QsAction=2&QsId=<% response.write(RSMaritalStatus("MaritalStatusId")) %>">
                                        <img src="Images/edit.png" alt="" width="20px" height="20px">
                                    </a>
                                </td>
                            </tr>
                            <%
                                RSMaritalStatus.MoveNext
                                Loop

                                RSMaritalStatus.close
                                set RSMaritalStatus = Nothing
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