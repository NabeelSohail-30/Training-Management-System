<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->

<%
if Session("SUserRoleId") <> 2 then
call OpenDbConn()
Dim RSOccupation
Set RSOccupation = Server.CreateObject("ADODB.RecordSet")
QryStr = "SELECT * FROM ListOccupation"
RSOccupation.Open QryStr, conn

if Request.QueryString("QsAction") = "1" then
    Dim mOccupation
    mOccupation = Request.form("FormOccupation")
    Session("sOccupation") = ""

    if mOccupation = "" OR Len(mOccupation) = 0 then
        Session("sOccupation") = "Occupation cannot be NULL"
        response.redirect("ListOccupation.asp")
    else
        Session("sOccupation") = ""
    end if

    QryStr = "INSERT INTO ListOccupation(Occupation, UserCreatedBy, CreationDateTime)" & _
            " Values('" & mOccupation & "', " & Session("SUserId") & ", '" & Now() & "')"
    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListOccupation.asp")
end if

if Request.QueryString("QsAction") = "3" then
    'Dim mOccupation
    Dim mOccupationId
    mOccupation = Request.form("FormOccupation")
    mOccupationId = Request.form("FormOccupationId")
    Session("sOccupation") = ""

    if mOccupation = "" OR Len(mOccupation) = 0 then
        Session("sOccupation") = "Occupation cannot be NULL"
        response.redirect("ListOccupation.asp?QsAction=2&QsId=" & mOccupationId)
    else
        Session("sOccupation") = ""
    end if

    QryStr = "UPDATE ListOccupation SET Occupation = '" & mOccupation & "', UserLastUpdatedBy = " & Session("SUserId") & _
                ", LastUpdatedDateTime = '" & Now() & "' WHERE(OccupationId = " & mOccupationId & ")"

    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListOccupation.asp")
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
    <title>Occupation</title>
</head>

<body>
    <header>
        <!--#include file=Header.asp-->
    </header>

    <div class="wrapper">
        <div class="container-fluid">

            <% 
            if request.QueryString("QsAction") = "2" then 
                Dim RSEditOccupation
                Set RSEditOccupation = Server.CreateObject("ADODB.RecordSet")
                RSEditOccupation.Open "SELECT OccupationId, Occupation FROM ListOccupation WHERE (OccupationId = " & Request.QueryString("QsId") & ")", conn
            %>
            <form action="ListOccupation.asp?QsAction=3" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Edit Occupation</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Occupation</label>
                                <input for="" class="form-control" name="FormOccupation"
                                    value="<% response.write(RSEditOccupation("Occupation")) %>"></input>
                                <span><% response.write(Session("sOccupation")) %></span>
                                <input type="hidden" name="FormOccupationId"
                                    value="<% response.write(RSEditOccupation("OccupationId")) %>">
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
            RSEditOccupation.close
            set RSEditOccupation = Nothing
            %>
            <% else %>
            <form action="ListOccupation.asp?QsAction=1" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Add New Occupation</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Occupation</label>
                                <input for="" class="form-control" name="FormOccupation"></input>
                                <span><% response.write(Session("sOccupation")) %></span>
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
                            <label for="">Occupation</label>
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <br>
                    <table class="table table-bordered table-hover" style="width: 60%;">
                        <thead>
                            <tr>
                                <th style="width: 3%;">Occupation Id</th>
                                <th style="width: 5%;">Occupation</th>
                                <th style="width: 0.5%"></th>
                            </tr>
                        </thead>

                        <tbody>
                            <%
                                do while NOT RSOccupation.EOF
                            %>
                            <tr>
                                <td><% response.write(RSOccupation("OccupationId")) %></td>
                                <td><% response.write(RSOccupation("Occupation")) %></td>
                                <td>
                                    <a
                                        href="ListOccupation.asp?QsAction=2&QsId=<% response.write(RSOccupation("OccupationId")) %>">
                                        <img src="Images/edit.png" alt="" width="20px" height="20px">
                                    </a>
                                </td>
                            </tr>
                            <%
                                RSOccupation.MoveNext
                                Loop

                                RSOccupation.close
                                set RSOccupation = Nothing
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