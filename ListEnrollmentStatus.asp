<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->

<%
if Session("SUserRoleId") <> 2 then
call OpenDbConn()
Dim RSEnrollmentStatus
Set RSEnrollmentStatus = Server.CreateObject("ADODB.RecordSet")
QryStr = "SELECT * FROM ListEnrollmentStatus"
RSEnrollmentStatus.Open QryStr, conn

if Request.QueryString("QsAction") = "1" then
    Dim mEnrollmentStatus
    mEnrollmentStatus = Request.form("FormEnrollmentStatus")
    Session("sStatus") = ""

    if mEnrollmentStatus = "" OR Len(mEnrollmentStatus) = 0 then
        Session("sStatus") = "Enrollment Status cannot be NULL"
        response.redirect("ListEnrollmentStatus.asp")
    else
        Session("sStatus") = ""
    end if

    QryStr = "INSERT INTO ListEnrollmentStatus(EnrollmentStatus, UserCreatedBy, CreationDateTime)" & _
            " Values('" & mEnrollmentStatus & "', " & Session("SUserId") & ", '" & Now() & "')"
    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListEnrollmentStatus.asp")
end if

if Request.QueryString("QsAction") = "3" then
    'Dim mEnrollmentStatus
    Dim mEnrollmentStatusId
    mEnrollmentStatus = Request.form("FormEnrollmentStatus")
    mEnrollmentStatusId = Request.form("FormEnrollmentStatusId")
    Session("sStatus") = ""

    if mEnrollmentStatus = "" OR Len(mEnrollmentStatus) = 0 then
        Session("sStatus") = "Enrollment Status cannot be NULL"
        response.redirect("ListEnrollmentStatus.asp?QsAction=2&QsId=" & mEnrollmentStatusId)
    else
        Session("sStatus") = ""
    end if

    QryStr = "UPDATE ListEnrollmentStatus SET EnrollmentStatus = '" & mEnrollmentStatus & "', UserLastUpdatedBy = " & Session("SUserId") & _
                ", LastUpdatedDateTime = '" & Now() & "' WHERE(EnrollmentStatusId = " & mEnrollmentStatusId & ")"

    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListEnrollmentStatus.asp")
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
    <title>Enrollment Status</title>
</head>

<body>
    <header>
        <!--#include file=Header.asp-->
    </header>

    <div class="wrapper">
        <div class="container-fluid">

            <% 
            if request.QueryString("QsAction") = "2" then 
                Dim RSEditStatus
                Set RSEditStatus = Server.CreateObject("ADODB.RecordSet")
                RSEditStatus.Open "SELECT EnrollmentStatusId, EnrollmentStatus FROM ListEnrollmentStatus WHERE (EnrollmentStatusId = " & Request.QueryString("QsId") & ")", conn
            %>
            <form action="ListEnrollmentStatus.asp?QsAction=3" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Edit Enrollment Status</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Enrollment Status</label>
                                <input for="" class="form-control" name="FormEnrollmentStatus"
                                    value="<% response.write(RSEditStatus("EnrollmentStatus")) %>"></input>
                                <span><% response.write(Session("sStatus")) %></span>
                                <input type="hidden" name="FormEnrollmentStatusId"
                                    value="<% response.write(RSEditStatus("EnrollmentStatusId")) %>">
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
            RSEditStatus.close
            set RSEditStatus = Nothing
            %>
            <% else %>
            <form action="ListEnrollmentStatus.asp?QsAction=1" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Add New Enrollment Status</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Enrollment Status</label>
                                <input for="" class="form-control" name="FormEnrollmentStatus"></input>
                                <span><% response.write(Session("sStatus")) %></span>
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
                            <label for="">Enrollment Status</label>
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <br>
                    <table class="table table-bordered table-hover" style="width: 60%;">
                        <thead>
                            <tr>
                                <th style="width: 3%;">Enrollment Status Id</th>
                                <th style="width: 5%;">Enrollment Status</th>
                                <th style="width: 0.5%"></th>
                            </tr>
                        </thead>

                        <tbody>
                            <%
                                do while NOT RSEnrollmentStatus.EOF
                            %>
                            <tr>
                                <td><% response.write(RSEnrollmentStatus("EnrollmentStatusId")) %></td>
                                <td><% response.write(RSEnrollmentStatus("EnrollmentStatus")) %></td>
                                <td>
                                    <a
                                        href="ListEnrollmentStatus.asp?QsAction=2&QsId=<% response.write(RSEnrollmentStatus("EnrollmentStatusId")) %>">
                                        <img src="Images/edit.png" alt="" width="20px" height="20px">
                                    </a>
                                </td>
                            </tr>
                            <%
                                RSEnrollmentStatus.MoveNext
                                Loop

                                RSEnrollmentStatus.close
                                set RSEnrollmentStatus = Nothing
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