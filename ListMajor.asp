<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->

<%
if Session("SUserRoleId") <> 2 then
call OpenDbConn()
Dim RSMajor
Set RSMajor = Server.CreateObject("ADODB.RecordSet")
QryStr = "SELECT * FROM ListMajor"
RSMajor.Open QryStr, conn

if Request.QueryString("QsAction") = "1" then
    Dim mMajor
    mMajor = Request.form("FormMajor")
    Session("sMajor") = ""

    if mMajor = "" OR Len(mMajor) = 0 then
        Session("sMajor") = "Major cannot be NULL"
        response.redirect("ListMajor.asp")
    else
        Session("sMajor") = ""
    end if

    QryStr = "INSERT INTO ListMajor(Major, UserCreatedBy, CreationDateTime)" & _
            " Values('" & mMajor & "', " & Session("SUserId") & ", '" & Now() & "')"
    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListMajor.asp")
end if

if Request.QueryString("QsAction") = "3" then
    'Dim mMajor
    Dim mMajorId
    mMajor = Request.form("FormMajor")
    mMajorId = Request.form("FormMajorId")
    Session("sMajor") = ""

    if mMajor = "" OR Len(mMajor) = 0 then
        Session("sMajor") = "Major cannot be NULL"
        response.redirect("ListMajor.asp?QsAction=2&QsId=" & mMajorId)
    else
        Session("sMajor") = ""
    end if

    QryStr = "UPDATE ListMajor SET Major = '" & mMajor & "', UserLastUpdatedBy = " & Session("SUserId") & _
                ", LastUpdatedDateTime = '" & Now() & "' WHERE(MajorId = " & mMajorId & ")"

    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListMajor.asp")
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
    <title>Major</title>
</head>

<body>
    <header>
        <!--#include file=Header.asp-->
    </header>

    <div class="wrapper">
        <div class="container-fluid">

            <% 
            if request.QueryString("QsAction") = "2" then 
                Dim RSEditMajor
                Set RSEditMajor = Server.CreateObject("ADODB.RecordSet")
                RSEditMajor.Open "SELECT MajorId, Major FROM ListMajor WHERE (MajorId = " & Request.QueryString("QsId") & ")", conn
            %>
            <form action="ListMajor.asp?QsAction=3" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Edit Major</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Major</label>
                                <input for="" class="form-control" name="FormMajor"
                                    value="<% response.write(RSEditMajor("Major")) %>"></input>
                                <span><% response.write(Session("sMajor")) %></span>
                                <input type="hidden" name="FormMajorId"
                                    value="<% response.write(RSEditMajor("MajorId")) %>">
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
            RSEditMajor.close
            set RSEditMajor = Nothing
            %>
            <% else %>
            <form action="ListMajor.asp?QsAction=1" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Add New Major</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Major</label>
                                <input for="" class="form-control" name="FormMajor"></input>
                                <span><% response.write(Session("sMajor")) %></span>
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
                            <label for="">Major</label>
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <br>
                    <table class="table table-bordered table-hover" style="width: 60%;">
                        <thead>
                            <tr>
                                <th style="width: 3%;">Major Id</th>
                                <th style="width: 5%;">Major</th>
                                <th style="width: 0.5%"></th>
                            </tr>
                        </thead>

                        <tbody>
                            <%
                                do while NOT RSMajor.EOF
                            %>
                            <tr>
                                <td><% response.write(RSMajor("MajorId")) %></td>
                                <td><% response.write(RSMajor("Major")) %></td>
                                <td>
                                    <a href="ListMajor.asp?QsAction=2&QsId=<% response.write(RSMajor("MajorId")) %>">
                                        <img src="Images/edit.png" alt="" width="20px" height="20px">
                                    </a>
                                </td>
                            </tr>
                            <%
                                RSMajor.MoveNext
                                Loop

                                RSMajor.close
                                set RSMajor = Nothing
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