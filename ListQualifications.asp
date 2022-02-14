<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->

<%
if Session("SUserRoleId") <> 2 then
call OpenDbConn()
Dim RSQualifications
Set RSQualifications = Server.CreateObject("ADODB.RecordSet")
QryStr = "SELECT * FROM ListQualifications"
RSQualifications.Open QryStr, conn

if Request.QueryString("QsAction") = "1" then
    Dim mQualifications
    mQualifications = Request.form("FormQualifications")
    Session("sQualifications") = ""

    if mQualifications = "" OR Len(mQualifications) = 0 then
        Session("sQualifications") = "Qualifications cannot be NULL"
        response.redirect("ListQualifications.asp")
    else
        Session("sQualifications") = ""
    end if

    QryStr = "INSERT INTO ListQualifications(Qualifications, UserCreatedBy, CreationDateTime)" & _
            " Values('" & mQualifications & "', " & Session("SUserId") & ", '" & Now() & "')"
    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListQualifications.asp")
end if

if Request.QueryString("QsAction") = "3" then
    'Dim mQualifications
    Dim mQualificationId
    mQualifications = Request.form("FormQualifications")
    mQualificationId = Request.form("FormQualificationId")
    Session("sQualifications") = ""

    if mQualifications = "" OR Len(mQualifications) = 0 then
        Session("sQualifications") = "Qualifications cannot be NULL"
        response.redirect("ListQualifications.asp?QsAction=2&QsId=" & mQualificationId)
    else
        Session("sQualifications") = ""
    end if

    QryStr = "UPDATE ListQualifications SET Qualifications = '" & mQualifications & "', UserLastUpdatedBy = " & Session("SUserId") & _
                ", LastUpdatedDateTime = '" & Now() & "' WHERE(QualificationId = " & mQualificationId & ")"

    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListQualifications.asp")
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
    <title>Qualifications</title>
</head>

<body>
    <header>
        <!--#include file=Header.asp-->
    </header>

    <div class="wrapper">
        <div class="container-fluid">

            <% 
            if request.QueryString("QsAction") = "2" then 
                Dim RSEditQualification
                Set RSEditQualification = Server.CreateObject("ADODB.RecordSet")
                RSEditQualification.Open "SELECT QualificationId, Qualifications FROM ListQualifications WHERE (QualificationId = " & Request.QueryString("QsId") & ")", conn
            %>
            <form action="ListQualifications.asp?QsAction=3" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Edit Qualifications</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Qualifications</label>
                                <input for="" class="form-control" name="FormQualifications"
                                    value="<% response.write(RSEditQualification("Qualifications")) %>"></input>
                                <span><% response.write(Session("sQualifications")) %></span>
                                <input type="hidden" name="FormQualificationId"
                                    value="<% response.write(RSEditQualification("QualificationId")) %>">
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
            RSEditQualification.close
            set RSEditQualification = Nothing
            %>
            <% else %>
            <form action="ListQualifications.asp?QsAction=1" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Add New Qualifications</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Qualifications</label>
                                <input for="" class="form-control" name="FormQualifications"></input>
                                <span><% response.write(Session("sQualifications")) %></span>
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
                            <label for="">Qualifications</label>
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <br>
                    <table class="table table-bordered table-hover" style="width: 60%;">
                        <thead>
                            <tr>
                                <th style="width: 3%;">Qualifications Id</th>
                                <th style="width: 5%;">Qualifications</th>
                                <th style="width: 0.5%"></th>
                            </tr>
                        </thead>

                        <tbody>
                            <%
                                do while NOT RSQualifications.EOF
                            %>
                            <tr>
                                <td><% response.write(RSQualifications("QualificationId")) %></td>
                                <td><% response.write(RSQualifications("Qualifications")) %></td>
                                <td>
                                    <a
                                        href="ListQualifications.asp?QsAction=2&QsId=<% response.write(RSQualifications("QualificationId")) %>">
                                        <img src="Images/edit.png" alt="" width="20px" height="20px">
                                    </a>
                                </td>
                            </tr>
                            <%
                                RSQualifications.MoveNext
                                Loop

                                RSQualifications.close
                                set RSQualifications = Nothing
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