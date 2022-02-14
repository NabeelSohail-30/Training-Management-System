<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->

<%
if Session("SUserRoleId") <> 2 then
call OpenDbConn()
Dim RSReligion
Set RSReligion = Server.CreateObject("ADODB.RecordSet")
QryStr = "SELECT * FROM ListReligion"
RSReligion.Open QryStr, conn

if Request.QueryString("QsAction") = "1" then
    Dim mReligion
    mReligion = Request.form("FormReligion")
    Session("sReligion") = ""

    if mReligion = "" OR Len(mReligion) = 0 then
        Session("sReligion") = "Religion cannot be NULL"
        response.redirect("ListReligion.asp")
    else
        Session("sReligion") = ""
    end if

    QryStr = "INSERT INTO ListReligion(Religion, UserCreatedBy, CreationDateTime)" & _
            " Values('" & mReligion & "', " & Session("SUserId") & ", '" & Now() & "')"
    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListReligion.asp")
end if

if Request.QueryString("QsAction") = "3" then
    'Dim mReligion
    Dim mReligionId
    mReligion = Request.form("FormReligion")
    mReligionId = Request.form("FormReligionId")
    Session("sReligion") = ""

    if mReligion = "" OR Len(mReligion) = 0 then
        Session("sReligion") = "Religion cannot be NULL"
        response.redirect("ListReligion.asp?QsAction=2&QsId=" & mReligionId)
    else
        Session("sReligion") = ""
    end if

    QryStr = "UPDATE ListReligion SET Religion = '" & mReligion & "', UserLastUpdatedBy = " & Session("SUserId") & _
                ", LastUpdatedDateTime = '" & Now() & "' WHERE(ReligionId = " & mReligionId & ")"

    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListReligion.asp")
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
                Dim RSEditReligion
                Set RSEditReligion = Server.CreateObject("ADODB.RecordSet")
                RSEditReligion.Open "SELECT ReligionId, Religion FROM ListReligion WHERE (ReligionId = " & Request.QueryString("QsId") & ")", conn
            %>
            <form action="ListReligion.asp?QsAction=3" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Edit Religion</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Religion</label>
                                <input for="" class="form-control" name="FormReligion"
                                    value="<% response.write(RSEditReligion("Religion")) %>"></input>
                                <span><% response.write(Session("sReligion")) %></span>
                                <input type="hidden" name="FormReligionId"
                                    value="<% response.write(RSEditReligion("ReligionId")) %>">
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
            RSEditReligion.close
            set RSEditReligion = Nothing
            %>
            <% else %>
            <form action="ListReligion.asp?QsAction=1" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Add New Religion</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Religion</label>
                                <input for="" class="form-control" name="FormReligion"></input>
                                <span><% response.write(Session("sReligion")) %></span>
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
                                do while NOT RSReligion.EOF
                            %>
                            <tr>
                                <td><% response.write(RSReligion("ReligionId")) %></td>
                                <td><% response.write(RSReligion("Religion")) %></td>
                                <td>
                                    <a
                                        href="ListReligion.asp?QsAction=2&QsId=<% response.write(RSReligion("ReligionId")) %>">
                                        <img src="Images/edit.png" alt="" width="20px" height="20px">
                                    </a>
                                </td>
                            </tr>
                            <%
                                RSReligion.MoveNext
                                Loop

                                RSReligion.close
                                set RSReligion = Nothing
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