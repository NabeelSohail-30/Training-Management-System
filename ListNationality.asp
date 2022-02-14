<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->

<%
if Session("SUserRoleId") <> 2 then
call OpenDbConn()
Dim RSNationality
Set RSNationality = Server.CreateObject("ADODB.RecordSet")
QryStr = "SELECT * FROM ListNationality"
RSNationality.Open QryStr, conn

if Request.QueryString("QsAction") = "1" then
    Dim mNationality
    mNationality = Request.form("FormNationality")
    Session("sNationality") = ""

    if mNationality = "" OR Len(mNationality) = 0 then
        Session("sNationality") = "Nationality cannot be NULL"
        response.redirect("ListNationality.asp")
    else
        Session("sNationality") = ""
    end if

    QryStr = "INSERT INTO ListNationality(Nationality, UserCreatedBy, CreationDateTime)" & _
            " Values('" & mNationality & "', " & Session("SUserId") & ", '" & Now() & "')"
    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListNationality.asp")
end if

if Request.QueryString("QsAction") = "3" then
    'Dim mNationality
    Dim mNationalityId
    mNationality = Request.form("FormNationality")
    mNationalityId = Request.form("FormNationalityId")
    Session("sNationality") = ""

    if mNationality = "" OR Len(mNationality) = 0 then
        Session("sNationality") = "Nationality cannot be NULL"
        response.redirect("ListNationality.asp?QsAction=2&QsId=" & mNationalityId)
    else
        Session("sNationality") = ""
    end if

    QryStr = "UPDATE ListNationality SET Nationality = '" & mNationality & "', UserLastUpdatedBy = " & Session("SUserId") & _
                ", LastUpdatedDateTime = '" & Now() & "' WHERE(NationalityId = " & mNationalityId & ")"

    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListNationality.asp")
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
    <title>Nationality</title>
</head>

<body>
    <header>
        <!--#include file=Header.asp-->
    </header>

    <div class="wrapper">
        <div class="container-fluid">

            <% 
            if request.QueryString("QsAction") = "2" then 
                Dim RSEditNationality
                Set RSEditNationality = Server.CreateObject("ADODB.RecordSet")
                RSEditNationality.Open "SELECT NationalityId, Nationality FROM ListNationality WHERE (NationalityId = " & Request.QueryString("QsId") & ")", conn
            %>
            <form action="ListNationality.asp?QsAction=3" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Edit Nationality</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Nationality</label>
                                <input for="" class="form-control" name="FormNationality"
                                    value="<% response.write(RSEditNationality("Nationality")) %>"></input>
                                <span><% response.write(Session("sNationality")) %></span>
                                <input type="hidden" name="FormNationalityId"
                                    value="<% response.write(RSEditNationality("NationalityId")) %>">
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
            RSEditNationality.close
            set RSEditNationality = Nothing
            %>
            <% else %>
            <form action="ListNationality.asp?QsAction=1" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Add New Nationality</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Nationality</label>
                                <input for="" class="form-control" name="FormNationality"></input>
                                <span><% response.write(Session("sNationality")) %></span>
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
                            <label for="">Nationality</label>
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <br>
                    <table class="table table-bordered table-hover" style="width: 60%;">
                        <thead>
                            <tr>
                                <th style="width: 3%;">Nationality Id</th>
                                <th style="width: 5%;">Nationality</th>
                                <th style="width: 0.5%"></th>
                            </tr>
                        </thead>

                        <tbody>
                            <%
                                do while NOT RSNationality.EOF
                            %>
                            <tr>
                                <td><% response.write(RSNationality("NationalityId")) %></td>
                                <td><% response.write(RSNationality("Nationality")) %></td>
                                <td>
                                    <a
                                        href="ListNationality.asp?QsAction=2&QsId=<% response.write(RSNationality("NationalityId")) %>">
                                        <img src="Images/edit.png" alt="" width="20px" height="20px">
                                    </a>
                                </td>
                            </tr>
                            <%
                                RSNationality.MoveNext
                                Loop

                                RSNationality.close
                                set RSNationality = Nothing
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