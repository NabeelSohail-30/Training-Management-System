<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->

<%
if Session("SUserRoleId") <> 2 then
call OpenDbConn()
Dim RSTimeSlot
Set RSTimeSlot = Server.CreateObject("ADODB.RecordSet")
QryStr = "SELECT * FROM ListTimeSlot"
RSTimeSlot.Open QryStr, conn

if Request.QueryString("QsAction") = "1" then
    Dim mStartTime
    Dim mEndTime
    mStartTime = Request.form("FormStartTime")
    mEndTime = Request.form("FormEndTime")
    Session("sStartTime") = ""
    Session("sEndTime") = ""

    if mStartTime = "" OR Len(mStartTime) = 0 then
        Session("sStartTime") = "Start Time cannot be NULL"
        response.redirect("ListTimeSlot.asp")
    else
        Session("sStartTime") = ""
    end if

    if mEndTime = "" OR Len(mEndTime) = 0 then
        Session("sEndTime") = "End Time cannot be NULL"
        response.redirect("ListTimeSlot.asp")
    else
        Session("sEndTime") = ""
    end if

    QryStr = "INSERT INTO ListTimeSlot(StartTime, EndTime, UserCreatedBy, CreationDateTime)" & _
            " Values('" & mStartTime & "', '" & mEndTime & "'," & Session("SUserId") & ", '" & Now() & "')"
    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListTimeSlot.asp")
end if

if Request.QueryString("QsAction") = "3" then
    'Dim mStartTime
    'Dim mEndTime
    Dim mTimeSlotId
    mStartTime = Request.form("FormStartTime")
    mEndTime = Request.form("FormEndTime")
    mTimeSlotId = Request.Form("FormTimeSlotId")
    Session("sStartTime") = ""
    Session("sEndTime") = ""

    if mStartTime = "" OR Len(mStartTime) = 0 then
        Session("sStartTime") = "Start Time cannot be NULL"
        response.redirect("ListTimeSlot.asp")
    else
        Session("sStartTime") = ""
    end if

    if mEndTime = "" OR Len(mEndTime) = 0 then
        Session("sEndTime") = "End Time cannot be NULL"
        response.redirect("ListTimeSlot.asp")
    else
        Session("sEndTime") = ""
    end if

    QryStr = "UPDATE ListTimeSlot SET StartTime = '" & mStartTime & "', EndTime = '" & mEndTime & "', UserLastUpdatedBy = " & Session("SUserId") & _
            ", LastUpdatedDateTime = '" & Now() & "' WHERE(TimeSlotId = " & mTimeSlotId & ")"

    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListTimeSlot.asp")
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
    <title>Time Slot</title>
</head>

<body>
    <header>
        <!--#include file=Header.asp-->
    </header>

    <div class="wrapper">
        <div class="container-fluid">

            <% 
            if request.QueryString("QsAction") = "2" then 
                Dim RSEditTimeSlot
                Set RSEditTimeSlot = Server.CreateObject("ADODB.RecordSet")
                RSEditTimeSlot.Open "SELECT TimeSlotId, StartTime, EndTime FROM ListTimeSlot WHERE (TimeSlotId = " & Request.QueryString("QsId") & ")", conn
            %>
            <form action="ListTimeSlot.asp?QsAction=3" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Edit Time Slot</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-4">
                                <label for="" class="input-heading">Start Time</label>
                                <input type="time" class="form-control" name="FormStartTime"
                                    value="<% response.write(FormatDateTime(RSEditTimeSlot("StartTime"),4)) %>"></input>
                                <span><% response.write(Session("sStartTime")) %></span>
                            </div>

                            <div class="col-4">
                                <label for="" class="input-heading">End Time</label>
                                <input type="time" class="form-control" name="FormEndTime"
                                    value="<% response.write(FormatDateTime(RSEditTimeSlot("EndTime"),4)) %>"></input>
                                <span><% response.write(Session("sEndTime")) %></span>
                            </div>
                            <input type="hidden" name="FormTimeSlotId"
                                value="<% response.write(RSEditTimeSlot("TimeSlotId")) %>">
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
            RSEditTimeSlot.close
            set RSEditTimeSlot = Nothing
            %>
            <% else %>
            <form action="ListTimeSlot.asp?QsAction=1" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Add New Time Slot</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-4">
                                <label for="" class="input-heading">Start Time</label>
                                <input type="time" class="form-control" name="FormStartTime"></input>
                                <span><% response.write(Session("sStartTime")) %></span>
                            </div>
                            <div class="col-4">
                                <label for="" class="input-heading">End Time</label>
                                <input type="time" class="form-control" name="FormEndTime"></input>
                                <span><% response.write(Session("sEndTime")) %></span>
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
                            <label for="">Time Slot</label>
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <br>
                    <table class="table table-bordered table-hover" style="width: 60%;">
                        <thead>
                            <tr>
                                <th style="width: 3%;">Time Slot Id</th>
                                <th style="width: 5%;">Time Slot</th>
                                <th style="width: 0.5%"></th>
                            </tr>
                        </thead>

                        <tbody>
                            <%
                                do while NOT RSTimeSlot.EOF
                            %>
                            <tr>
                                <td><% response.write(RSTimeSlot("TimeSlotId")) %></td>
                                <td><% response.write(FormatDateTime(RSTimeSlot("StartTime"),3)& " - " & FormatDateTime(RSTimeSlot("EndTime"),3)) %>
                                </td>
                                <td>
                                    <a
                                        href="ListTimeSlot.asp?QsAction=2&QsId=<% response.write(RSTimeSlot("TimeSlotId")) %>">
                                        <img src="Images/edit.png" alt="" width="20px" height="20px">
                                    </a>
                                </td>
                            </tr>
                            <%
                                RSTimeSlot.MoveNext
                                Loop

                                RSTimeSlot.close
                                set RSTimeSlot = Nothing
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