<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->

<%
if Session("SUserRoleId") <> 2 then
call OpenDbConn()
Dim RSRoom
Set RSRoom = Server.CreateObject("ADODB.RecordSet")
QryStr = "SELECT * FROM ListRoom"
RSRoom.Open QryStr, conn

if Request.QueryString("QsAction") = "1" then
    Dim mRoom
    mRoom = Request.form("FormRoom")
    Session("sRoom") = ""

    if mRoom = "" OR Len(mRoom) = 0 then
        Session("sRoom") = "RoomNumber cannot be NULL"
        response.redirect("ListRoom.asp")
    else
        Session("sRoom") = ""
    end if

    QryStr = "INSERT INTO ListRoom(RoomNumber, UserCreatedBy, CreationDateTime)" & _
            " Values('" & mRoom & "', " & Session("SUserId") & ", '" & Now() & "')"
    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListRoom.asp")
end if

if Request.QueryString("QsAction") = "3" then
    'Dim mRoom
    Dim mRoomId
    mRoom = Request.form("FormRoom")
    mRoomId = Request.form("FormRoomId")
    Session("sRoom") = ""

    if mRoom = "" OR Len(mRoom) = 0 then
        Session("sRoom") = "RoomNumber cannot be NULL"
        response.redirect("ListRoom.asp?QsAction=2&QsId=" & mRoomId)
    else
        Session("sRoom") = ""
    end if

    QryStr = "UPDATE ListRoom SET RoomNumber = '" & mRoom & "', UserLastUpdatedBy = " & Session("SUserId") & _
                ", LastUpdatedDateTime = '" & Now() & "' WHERE(RoomId = " & mRoomId & ")"

    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListRoom.asp")
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
    <title>RoomNumber</title>
</head>

<body>
    <header>
        <!--#include file=Header.asp-->
    </header>

    <div class="wrapper">
        <div class="container-fluid">

            <% 
            if request.QueryString("QsAction") = "2" then 
                Dim RSEditRoom
                Set RSEditRoom = Server.CreateObject("ADODB.RecordSet")
                RSEditRoom.Open "SELECT RoomId, RoomNumber FROM ListRoom WHERE (RoomId = " & Request.QueryString("QsId") & ")", conn
            %>
            <form action="ListRoom.asp?QsAction=3" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Edit RoomNumber</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">RoomNumber</label>
                                <input for="" class="form-control" name="FormRoom"
                                    value="<% response.write(RSEditRoom("RoomNumber")) %>"></input>
                                <span><% response.write(Session("sRoom")) %></span>
                                <input type="hidden" name="FormRoomId"
                                    value="<% response.write(RSEditRoom("RoomId")) %>">
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
            RSEditRoom.close
            set RSEditRoom = Nothing
            %>
            <% else %>
            <form action="ListRoom.asp?QsAction=1" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Add New RoomNumber</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">RoomNumber</label>
                                <input for="" class="form-control" name="FormRoom"></input>
                                <span><% response.write(Session("sRoom")) %></span>
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
                            <label for="">RoomNumber</label>
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <br>
                    <table class="table table-bordered table-hover" style="width: 60%;">
                        <thead>
                            <tr>
                                <th style="width: 3%;">RoomNumber Id</th>
                                <th style="width: 5%;">RoomNumber</th>
                                <th style="width: 0.5%"></th>
                            </tr>
                        </thead>

                        <tbody>
                            <%
                                do while NOT RSRoom.EOF
                            %>
                            <tr>
                                <td><% response.write(RSRoom("RoomId")) %></td>
                                <td><% response.write(RSRoom("RoomNumber")) %></td>
                                <td>
                                    <a href="ListRoom.asp?QsAction=2&QsId=<% response.write(RSRoom("RoomId")) %>">
                                        <img src="Images/edit.png" alt="" width="20px" height="20px">
                                    </a>
                                </td>
                            </tr>
                            <%
                                RSRoom.MoveNext
                                Loop

                                RSRoom.close
                                set RSRoom = Nothing
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