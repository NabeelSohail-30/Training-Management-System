<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->

<%
if Session("SUserRoleId") <> 2 then
call OpenDbConn()
Dim RSTechnical
Set RSTechnical = Server.CreateObject("ADODB.RecordSet")
QryStr = "SELECT * FROM ListTechnicalQualifications"
RSTechnical.Open QryStr, conn

if Request.QueryString("QsAction") = "1" then
    Dim mTQualification
    mTQualification = Request.form("FormTQualification")
    Session("sTQualification") = ""

    if mTQualification = "" OR Len(mTQualification) = 0 then
        Session("sTQualification") = "Technical Qualification cannot be NULL"
        response.redirect("ListTechnicalQualification.asp")
    else
        Session("sTQualification") = ""
    end if

    QryStr = "INSERT INTO ListTechnicalQualifications(TechnicalQualifications, UserCreatedBy, CreationDateTime)" & _
            " Values('" & mTQualification & "', " & Session("SUserId") & ", '" & Now() & "')"
    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListTechnicalQualification.asp")
end if

if Request.QueryString("QsAction") = "3" then
    'Dim mTQualification
    Dim mTQualificationId
    mTQualification = Request.form("FormTQualification")
    mTQualificationId = Request.form("FormTQualificationId")
    Session("sTQualification") = ""

    if mTQualification = "" OR Len(mTQualification) = 0 then
        Session("sTQualification") = "Technical Qualification cannot be NULL"
        response.redirect("ListTechnicalQualification.asp?QsAction=2&QsId=" & mTQualificationId)
    else
        Session("sTQualification") = ""
    end if

    QryStr = "UPDATE ListTechnicalQualifications SET TechnicalQualifications = '" & mTQualification & "', UserLastUpdatedBy = " & Session("SUserId") & _
                ", LastUpdatedDateTime = '" & Now() & "' WHERE(TQualificationId = " & mTQualificationId & ")"

    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListTechnicalQualification.asp")
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
    <title>Religion</title>
</head>

<body>
    <header>
        <!--#include file=Header.asp-->
    </header>

    <div class="wrapper">
        <div class="container-fluid">

            <% 
            if request.QueryString("QsAction") = "2" then 
                Dim RSEditTQualification
                Set RSEditTQualification = Server.CreateObject("ADODB.RecordSet")
                RSEditTQualification.Open "SELECT TQualificationId, TechnicalQualifications FROM ListTechnicalQualifications WHERE (TQualificationId = " & Request.QueryString("QsId") & ")", conn
            %>
            <form action="ListTechnicalQualification.asp?QsAction=3" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Edit Technical Qualification</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Technical Qualification</label>
                                <input for="" class="form-control" name="FormTQualification"
                                    value="<% response.write(RSEditTQualification("TechnicalQualifications")) %>"></input>
                                <span><% response.write(Session("sTQualification")) %></span>
                                <input type="hidden" name="FormTQualificationId"
                                    value="<% response.write(RSEditTQualification("TQualificationId")) %>">
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
            RSEditTQualification.close
            set RSEditTQualification = Nothing
            %>
            <% else %>
            <form action="ListTechnicalQualification.asp?QsAction=1" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Add New Technical Qualification</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Technical Qualification</label>
                                <input for="" class="form-control" name="FormTQualification"></input>
                                <span><% response.write(Session("sTQualification")) %></span>
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
                            <label for="">Religion</label>
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <br>
                    <table class="table table-bordered table-hover" style="width: 60%;">
                        <thead>
                            <tr>
                                <th style="width: 3%;">Religion Id</th>
                                <th style="width: 5%;">Religion</th>
                                <th style="width: 0.5%"></th>
                            </tr>
                        </thead>

                        <tbody>
                            <%
                                do while NOT RSTechnical.EOF
                            %>
                            <tr>
                                <td><% response.write(RSTechnical("TQualificationId")) %></td>
                                <td><% response.write(RSTechnical("TechnicalQualifications")) %></td>
                                <td>
                                    <a
                                        href="ListTechnicalQualification.asp?QsAction=2&QsId=<% response.write(RSTechnical("TQualificationId")) %>">
                                        <img src="Images/edit.png" alt="" width="20px" height="20px">
                                    </a>
                                </td>
                            </tr>
                            <%
                                RSTechnical.MoveNext
                                Loop

                                RSTechnical.close
                                set RSTechnical = Nothing
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