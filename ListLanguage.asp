<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->

<%
if Session("SUserRoleId") <> 2 then
call OpenDbConn()
Dim RSLanguage
Set RSLanguage = Server.CreateObject("ADODB.RecordSet")
QryStr = "SELECT * FROM ListLanguage"
RSLanguage.Open QryStr, conn

if Request.QueryString("QsAction") = "1" then
    Dim mLanguage
    mLanguage = Request.form("FormLanguage")
    Session("sLanguage") = ""

    if mLanguage = "" OR Len(mLanguage) = 0 then
        Session("sLanguage") = "Language cannot be NULL"
        response.redirect("ListLanguage.asp")
    else
        Session("sLanguage") = ""
    end if

    QryStr = "INSERT INTO ListLanguage(Language, UserCreatedBy, CreationDateTime)" & _
            " Values('" & mLanguage & "', " & Session("SUserId") & ", '" & Now() & "')"
    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListLanguage.asp")
end if

if Request.QueryString("QsAction") = "3" then
    'Dim mLanguage
    Dim mLanguageId
    mLanguage = Request.form("FormLanguage")
    mLanguageId = Request.form("FormLanguageId")
    Session("sLanguage") = ""

    if mLanguage = "" OR Len(mLanguage) = 0 then
        Session("sLanguage") = "Language cannot be NULL"
        response.redirect("ListLanguage.asp?QsAction=2&QsId=" & mLanguageId)
    else
        Session("sLanguage") = ""
    end if

    QryStr = "UPDATE ListLanguage SET Language = '" & mLanguage & "', UserLastUpdatedBy = " & Session("SUserId") & _
                ", LastUpdatedDateTime = '" & Now() & "' WHERE(LanguageId = " & mLanguageId & ")"

    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListLanguage.asp")
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
    <title>Language</title>
</head>

<body>
    <header class="d-print-none">
        <!--#include file=Header.asp-->
    </header>

    <div class="wrapper">
        <div class="container-fluid">

            <% 
            if request.QueryString("QsAction") = "2" then 
                Dim RSEditLanguage
                Set RSEditLanguage = Server.CreateObject("ADODB.RecordSet")
                RSEditLanguage.Open "SELECT LanguageId, Language FROM ListLanguage WHERE (LanguageId = " & Request.QueryString("QsId") & ")", conn
            %>
            <form action="ListLanguage.asp?QsAction=3" method="POST" class="d-print-none">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Edit Language</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Language</label>
                                <input for="" class="form-control" name="FormLanguage"
                                    value="<% response.write(RSEditLanguage("Language")) %>"></input>
                                <span><% response.write(Session("sLanguage")) %></span>
                                <input type="hidden" name="FormLanguageId"
                                    value="<% response.write(RSEditLanguage("LanguageId")) %>">
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
            RSEditLanguage.close
            set RSEditLanguage = Nothing
            %>
            <% else %>
            <form action="ListLanguage.asp?QsAction=1" method="POST" class="d-print-none">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Add New Language</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Language</label>
                                <input for="" class="form-control" name="FormLanguage"></input>
                                <span><% response.write(Session("sLanguage")) %></span>
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

            <div class="div d-none d-print-block">
                <h1>Training Management System</h1>
            </div>

            <div class="panel">
                <br>
                <div class="panel-head">
                    <div class="row">
                        <div class="col">
                            <label for="">Language</label>
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <br>
                    <table class="table table-bordered table-hover" style="width: 60%;">
                        <thead>
                            <tr>
                                <th style="width: 3%;">Language Id</th>
                                <th style="width: 5%;">Language</th>
                                <th style="width: 0.5%" class="d-print-none"></th>
                            </tr>
                        </thead>

                        <tbody>
                            <%
                                do while NOT RSLanguage.EOF
                            %>
                            <tr>
                                <td><% response.write(RSLanguage("LanguageId")) %></td>
                                <td><% response.write(RSLanguage("Language")) %></td>
                                <td class="d-print-none">
                                    <a
                                        href="ListLanguage.asp?QsAction=2&QsId=<% response.write(RSLanguage("LanguageId")) %>">
                                        <img src="Images/edit.png" alt="" width="20px" height="20px">
                                    </a>
                                </td>
                            </tr>
                            <%
                                RSLanguage.MoveNext
                                Loop

                                RSLanguage.close
                                set RSLanguage = Nothing
                            %>
                        </tbody>
                    </table>
                </div>
                <br>
            </div>
        </div>
    </div>

    <footer class="d-print-none">
        <!--#include file=Footer.asp-->
    </footer>

</body>
<% 
else
response.redirect("dashboard.asp")
end if
%>

</html>