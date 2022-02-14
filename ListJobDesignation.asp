<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->

<%
if Session("SUserRoleId") <> 2 then
call OpenDbConn()
Dim RSJob
Set RSJob = Server.CreateObject("ADODB.RecordSet")
QryStr = "SELECT * FROM ListJobDesignation"
RSJob.Open QryStr, conn

if Request.QueryString("QsAction") = "1" then
    Dim mJobDesignation
    mJobDesignation = Request.form("FormJobDesignation")
    Session("sJob") = ""

    if mJobDesignation = "" OR Len(mJobDesignation) = 0 then
        Session("sJob") = "Job Designation cannot be NULL"
        response.redirect("ListJobDesignation.asp")
    else
        Session("sJob") = ""
    end if

    QryStr = "INSERT INTO ListJobDesignation(JobDesignation, UserCreatedBy, CreationDateTime)" & _
            " Values('" & mJobDesignation & "', " & Session("SUserId") & ", '" & Now() & "')"
    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListJobDesignation.asp")
end if

if Request.QueryString("QsAction") = "3" then
    'Dim mJobDesignation
    Dim mJobDesignationId
    mJobDesignation = Request.form("FormJobDesignation")
    mJobDesignationId = Request.form("FormJobDesignationId")
    Session("sJob") = ""

    if mJobDesignation = "" OR Len(mJobDesignation) = 0 then
        Session("sJob") = "Job Designation cannot be NULL"
        response.redirect("ListJobDesignation.asp?QsAction=2&QsId=" & mJobDesignationId)
    else
        Session("sJob") = ""
    end if

    QryStr = "UPDATE ListJobDesignation SET JobDesignation = '" & mJobDesignation & "', UserLastUpdatedBy = " & Session("SUserId") & _
                ", LastUpdatedDateTime = '" & Now() & "' WHERE(JobDesignationId = " & mJobDesignationId & ")"

    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListJobDesignation.asp")
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
    <title>Job Designation</title>
</head>

<body>
    <header>
        <!--#include file=Header.asp-->
    </header>

    <div class="wrapper">
        <div class="container-fluid">

            <% 
            if request.QueryString("QsAction") = "2" then 
                Dim RSEditJob
                Set RSEditJob = Server.CreateObject("ADODB.RecordSet")
                RSEditJob.Open "SELECT JobDesignationId, JobDesignation FROM ListJobDesignation WHERE (JobDesignationId = " & Request.QueryString("QsId") & ")", conn
            %>
            <form action="ListJobDesignation.asp?QsAction=3" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Edit Job Designation</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Job Designation</label>
                                <input for="" class="form-control" name="FormJobDesignation"
                                    value="<% response.write(RSEditJob("JobDesignation")) %>"></input>
                                <span><% response.write(Session("sJob")) %></span>
                                <input type="hidden" name="FormJobDesignationId"
                                    value="<% response.write(RSEditJob("JobDesignationId")) %>">
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
            RSEditJob.close
            set RSEditJob = Nothing
            %>
            <% else %>
            <form action="ListJobDesignation.asp?QsAction=1" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Add New Job Designation</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Job Designation</label>
                                <input for="" class="form-control" name="FormJobDesignation"></input>
                                <span><% response.write(Session("sJob")) %></span>
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
                            <label for="">Job Designation</label>
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <br>
                    <table class="table table-bordered table-hover" style="width: 60%;">
                        <thead>
                            <tr>
                                <th style="width: 3%;">Job Designation Id</th>
                                <th style="width: 5%;">Job Designation</th>
                                <th style="width: 0.5%"></th>
                            </tr>
                        </thead>

                        <tbody>
                            <%
                                do while NOT RSJob.EOF
                            %>
                            <tr>
                                <td><% response.write(RSJob("JobDesignationId")) %></td>
                                <td><% response.write(RSJob("JobDesignation")) %></td>
                                <td>
                                    <a
                                        href="ListJobDesignation.asp?QsAction=2&QsId=<% response.write(RSJob("JobDesignationId")) %>">
                                        <img src="Images/edit.png" alt="" width="20px" height="20px">
                                    </a>
                                </td>
                            </tr>
                            <%
                                RSJob.MoveNext
                                Loop

                                RSJob.close
                                set RSJob = Nothing
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