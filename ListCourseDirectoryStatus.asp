<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->

<%
if Session("SUserRoleId") <> 2 then
call OpenDbConn()
Dim RSCourseStatus
Set RSCourseStatus = Server.CreateObject("ADODB.RecordSet")
QryStr = "SELECT * FROM ListCourseDirectoryStatus"
RSCourseStatus.Open QryStr, conn

if Request.QueryString("QsAction") = "1" then
    Dim mCourseStatus
    mCourseStatus = Request.form("FormCourseStatus")
    Session("sStatus") = ""

    if mCourseStatus = "" OR Len(mCourseStatus) = 0 then
        Session("sStatus") = "Course Status cannot be NULL"
        response.redirect("ListCourseDirectoryStatus.asp")
    else
        Session("sStatus") = ""
    end if

    QryStr = "INSERT INTO ListCourseDirectoryStatus(CourseDirectoryStatus, UserCreatedBy, CreationDateTime)" & _
            " Values('" & mCourseStatus & "', " & Session("SUserId") & ", '" & Now() & "')"
    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListCourseDirectoryStatus.asp")
end if

if Request.QueryString("QsAction") = "3" then
    'Dim mCourseStatus
    Dim mCourseStatusId
    mCourseStatus = Request.form("FormCourseStatus")
    mCourseStatusId = Request.form("FormCourseStatusId")
    Session("sStatus") = ""

    if mCourseStatus = "" OR Len(mCourseStatus) = 0 then
        Session("sStatus") = "Course Directory Status cannot be NULL"
        response.redirect("ListCourseDirectoryStatus.asp?QsAction=2&QsId=" & mCourseStatusId)
    else
        Session("sStatus") = ""
    end if

    QryStr = "UPDATE ListCourseDirectoryStatus SET CourseDirectoryStatus = '" & mCourseStatus & "', UserLastUpdatedBy = " & Session("SUserId") & _
                ", LastUpdatedDateTime = '" & Now() & "' WHERE(CourseDirectoryStatusId = " & mCourseStatusId & ")"

    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListCourseDirectoryStatus.asp")
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
    <title>Course Directory Status</title>
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
                RSEditStatus.Open "SELECT CourseDirectoryStatusId, CourseDirectoryStatus FROM ListCourseDirectoryStatus WHERE (CourseDirectoryStatusId = " & Request.QueryString("QsId") & ")", conn
            %>
            <form action="ListCourseDirectoryStatus.asp?QsAction=3" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Edit Course Directory Status</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Course Directory Status</label>
                                <input for="" class="form-control" name="FormCourseStatus"
                                    value="<% response.write(RSEditStatus("CourseDirectoryStatus")) %>"></input>
                                <span><% response.write(Session("sStatus")) %></span>
                                <input type="hidden" name="FormCourseStatusId"
                                    value="<% response.write(RSEditStatus("CourseDirectoryStatusId")) %>">
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
            <form action="ListCourseDirectoryStatus.asp?QsAction=1" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Add New Course Directory Status</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Course Directory Status</label>
                                <input for="" class="form-control" name="FormCourseStatus"></input>
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
                            <label for="">Course Directory Status</label>
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <br>
                    <table class="table table-bordered table-hover" style="width: 60%;">
                        <thead>
                            <tr>
                                <th style="width: 3%;">Course Directory Status Id</th>
                                <th style="width: 5%;">Course Directory Status</th>
                                <th style="width: 0.5%"></th>
                            </tr>
                        </thead>

                        <tbody>
                            <%
                                do while NOT RSCourseStatus.EOF
                            %>
                            <tr>
                                <td><% response.write(RSCourseStatus("CourseDirectoryStatusId")) %></td>
                                <td><% response.write(RSCourseStatus("CourseDirectoryStatus")) %></td>
                                <td>
                                    <a
                                        href="ListCourseDirectoryStatus.asp?QsAction=2&QsId=<% response.write(RSCourseStatus("CourseDirectoryStatusId")) %>">
                                        <img src="Images/edit.png" alt="" width="20px" height="20px">
                                    </a>
                                </td>
                            </tr>
                            <%
                                RSCourseStatus.MoveNext
                                Loop

                                RSCourseStatus.close
                                set RSCourseStatus = Nothing
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