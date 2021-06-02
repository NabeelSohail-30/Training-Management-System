<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->
<%

'Opening Db
call OpenDbConn()

'Variables Declaration
    Dim CourseDirectoryId

    Dim mStartDate
    Dim mEndDate
    Dim mStartTime
    Dim mEndTime
    Dim TimeSlotMinutes
    Dim CourseDuration
    Dim mAttendanceDate
    Dim mCourseDirectoryStatus
    Dim mTotalTSMinutes
    Dim mMinAttendancePercentage

    Dim RSCourseDirectory
    Dim RSAttendanceList
    Dim RSCourseDuration
    Dim RSDuplicateAttendance
    Dim RSAttendancePercentage

    Dim AttendanceCount
    Dim iCounter
    Dim iTotalRecords
    Dim IsError
    Dim IsDuplicate

    Dim TotalPresentMin
    Dim StdAttendancePercentage

    Dim eDuplicateAttendance
    Dim eAttendanceDate
    Dim eDurationError

    Session("sShortMinutes") = ""
'End

'Get CD id From QueryString
CourseDirectoryId = Request.QueryString("QsId")

if CourseDirectoryId <> "" then 

'Open RS For Course Directory View
Set RSCourseDirectory = Server.CreateObject("ADODB.RecordSet")
QryStr = "SELECT * FROM V_CourseDirectoryView WHERE(CourseDirectoryId = " & CourseDirectoryId & ")"
RSCourseDirectory.Open QryStr, conn
'End

'Check weather course is scheduled

'Variables Initialization
    mStartDate = RSCourseDirectory("StartDate")
    mEndDate = RSCourseDirectory("EndDate")
    mStartTime = RSCourseDirectory("StartTime")
    mEndTime = RSCourseDirectory("EndTime")
    CourseDuration = RSCourseDirectory("CourseDuration")
    mCourseDirectoryStatus = RSCourseDirectory("CourseDirectoryStatusId")
    mMinAttendancePercentage = RSCourseDirectory("MinAttendancePercentage")
    
    TimeSlotMinutes = (DateDiff("n", mStartTime, mEndTime))
    'mStartMinutes = (Hour(mStartTime)*60) + Minute(mStartTime)
    'mEndMinutes = (Hour(mEndTime)*60) + Minute(mEndTime)
    'TotMinutes = mEndMinutes - mStartMinutes
    mTotalTSMinutes = cint(TimeSlotMinutes)*cint(CourseDuration)

    IsError = 0
    IsDuplicate = 0
    eDuplicateAttendance = ""

    mAttendanceDate = request.form("FormAttendanceDate")
    eAttendanceDate = ""
    eDuplicateAttendance = ""
    eDurationError = ""
'End 

'response.write(DateDiff("n", mStartTime, mEndTime))
'response.write(mStartMinutes)
'response.write("<br>")
'response.write(mEndMinutes)

'Open RS For Enrolled Student List for Attendance
Set RSAttendanceList = Server.CreateObject("ADODB.RecordSet")
QryStr = "SELECT * FROM V_AttendanceListView WHERE(CourseDirectoryId = " & CourseDirectoryId & ") AND (EnrollmentStatusId = 1)"
RSAttendanceList.Open QryStr, conn
'End

'response.write("CD Id = " & request.form("FormCourseDirectoryId"))

'Validating Course duration
    Set RSCourseDuration = Server.CreateObject("ADODB.RecordSet")
    QryStr = "SELECT Count(CourseDirectoryId) AS TotalAttendance FROM V_AttendanceGroup WHERE(CourseDirectoryId = " & CourseDirectoryId & ")"
    RSCourseDuration.Open QryStr, conn

    if NOT RSCourseDuration.Eof then
        AttendanceCount = RSCourseDuration("TotalAttendance")
    else
        AttendanceCount = 0
    end if

    RSCourseDuration.close
    set RSCourseDuration = Nothing

    'response.write(AttendanceCount)
'End

'Insert Attendance Module Start
if request.form("FormCourseDirectoryId") <> "" then
    CourseDirectoryId = request.form("FormCourseDirectoryId")

    if cint(AttendanceCount) < cint(CourseDuration) then
        
        'Validating Duplicate Attendance
            Set RSDuplicateAttendance = Server.CreateObject("ADODB.RecordSet")
            QryStr = "SELECT * FROM V_AttendanceGroup WHERE(CourseDirectoryId = " & CourseDirectoryId & ") AND (AttendanceDate = '" & mAttendanceDate & "')"
            'response.write(QryStr)
            RSDuplicateAttendance.Open QryStr, conn

            if NOT RSDuplicateAttendance.Eof then
                eDuplicateAttendance = "Duplicate Attendance Found, Attendance has already been entered for date = " & mAttendanceDate
                IsDuplicate = 1
            else
                eDuplicateAttendance = ""
            end if

            RSDuplicateAttendance.close
            set RSDuplicateAttendance = Nothing
        'End

        if IsDuplicate = 0 then
            'Validating Attendance Date
                eAttendanceDate = ""

                'response.write(NOT(cdate(mAttendanceDate) >= cdate(mStartDate) AND cdate(mAttendanceDate) <= cdate(mEndDate)))

                if len(mAttendanceDate) <= 0 then
                    eAttendanceDate = "Attendance Date cannot be NULL"
                    IsError = 1
                elseif cdate(mAttendanceDate) > cdate(Now()) then
                    eAttendanceDate = "Attendance Date cannot be Greater than Current Date"
                    IsError = 1
                elseif NOT (cdate(mAttendanceDate) >= cdate(mStartDate) AND cdate(mAttendanceDate) <= cdate(mEndDate)) then
                    eAttendanceDate = "Attendance Date must be between Course Date"
                    IsError = 1
                end if
            'End

            'Validating Short Minutes
                iTotalRecords = Request.Form("FormCounter")

                for iCounter = 1 to iTotalRecords
                    Session("sShortMinutes" & iCounter) = ""
                Next

                for iCounter = 1 to iTotalRecords
                    if len(request.form("FormShortMin" & iCounter)) = 0 then
                        Session("sShortMinutes" & iCounter) = "Short Minutes cannot be NULL"
                        IsError = 1
                    elseif cint(request.form("FormShortMin" & iCounter)) < 0 then
                        Session("sShortMinutes" & iCounter) = "Short Minutes cannot be less than Zero"
                        IsError = 1
                    elseif cint(request.form("FormShortMin" & iCounter)) > cint(TimeSlotMinutes) then
                        Session("sShortMinutes" & iCounter) = "Short Minutes must be between Time Slot Minutes (0 - " & TimeSlotMinutes & ")"
                        IsError = 1
                    end if
                    Session("sMin" & iCounter) = request.form("FormShortMin" & iCounter)
                Next
                eDurationError = ""
            'End
        end if
    else
        eDurationError = "You cannot enter Attendance for the date " & request.form("FormAttendanceDate") & " because Attendance has been completed."
        IsError = 1
    end if

    'Inserting Records in Db
        if IsError = 0 then
            for iCounter = 1 to iTotalRecords
                QryStr = "INSERT INTO StudentAttendance (StdEnrollmentId, AttendanceDate, ShortMin, UserCreatedBy) " & _
                "VALUES (" & request.form("FormStdEnrollmentId" & iCounter) & ", '" & mAttendanceDate & "', " & request.form("FormShortMin" & iCounter) & ", " & Session("SUserId") & ")"
                'response.write("<br>")
                'response.write(QryStr)
                conn.execute QryStr
            Next
        End if
    'End

end if
'End of Module

'Updating Attendance Module Start
if request.QueryString("QsUpdate")= "2" then
Dim EditAttendanceDate
    CourseDirectoryId = request.form("EditFormCDId")
    EditAttendanceDate = request.form("EditFormDate")

    'Validating Short Minutes
        iTotalRecords = Request.Form("EditFormCounter")

        for iCounter = 1 to iTotalRecords
            Session("sEditShortMinutes" & iCounter) = ""
        Next

        for iCounter = 1 to iTotalRecords
            if len(request.form("EditFormShortMin" & iCounter)) = 0 then
                Session("sEditShortMinutes" & iCounter) = "Short Minutes cannot be NULL"
                IsError = 1
            elseif cint(request.form("EditFormShortMin" & iCounter)) < 0 then
                Session("sEditShortMinutes" & iCounter) = "Short Minutes cannot be less than Zero"
                IsError = 1
            elseif cint(request.form("EditFormShortMin" & iCounter)) > cint(TimeSlotMinutes) then
                Session("sEditShortMinutes" & iCounter) = "Short Minutes must be between Time Slot Minutes (0 - " & TimeSlotMinutes & ")"
                IsError = 1
            end if
            Session("sEditMin" & iCounter) = request.form("EditFormShortMin" & iCounter)
        Next
    'End

    'Updating Records in Db
        if IsError = 0 then
            for iCounter = 1 to iTotalRecords
                QryStr = "UPDATE StudentAttendance SET ShortMin = " & request.form("EditFormShortMin" & iCounter) & " , UserLastUpdatedBy = " & Session("SUserId") & ", LastUpdatedDateTime = '" & Now() &_
                        "' WHERE(AttendanceId = " & Request.Form("FormAttendanceId" & iCounter) & ")"
                'response.write("<br>")
                'response.write(QryStr)
                Session("sEditMin" & iCounter) = ""
                conn.execute QryStr
            Next
        else
            Response.Redirect("CourseDirectoryAttendance.asp?QsEdit=1&QsId=" & CourseDirectoryId & "&QsDate=" & EditAttendanceDate)
        End if
    'End

end if
'End of Module

'Deleting Attendance Module Start
if request.QueryString("QsDelete")= "1" then
    'Deleting Records in Db
        QryStr = "DELETE StdAtt " &_
                "FROM dbo.StudentEnrollment INNER JOIN dbo.StudentAttendance StdAtt ON " &_
                "dbo.StudentEnrollment.StdEnrollmentId = StdAtt.StdEnrollmentId " &_
                "WHERE (((dbo.StudentEnrollment.CourseDirectoryId)=" & Request.QueryString("QsId") & ") AND ((StdAtt.AttendanceDate)='" & Request.QueryString("QsDate") & "'))"

        'response.write(QryStr)
        conn.execute QryStr
    'End
end if
'End of Module

'Change CD Status to Completed - Start
if request.QueryString("QsUpdate")= "1" then
    Dim EnrollmentStatus
    CourseDirectoryId = Request.Form("FormCourseDirectoryIdUpdate")

    if AttendanceCount < CourseDuration then
        eDurationError = "This Course Directory Attendance is not Completed."
    end if

    
    'Change Student Enrollment Status
    Set RSAttendancePercentage = Server.CreateObject("ADODB.RecordSet")
    QryStr = "SELECT * FROM V_StdTotalShortMinView WHERE(CourseDirectoryId = " & CourseDirectoryId & ")"
    RSAttendancePercentage.open QryStr, conn
    
    do while NOT RSAttendancePercentage.EOF
    'Response.write("<br>")
    'response.write(RSAttendancePercentage("TotalShortMin"))
    TotalPresentMin = cint(mTotalTSMinutes) - cint(RSAttendancePercentage("TotalShortMin"))
    StdAttendancePercentage = (cint(TotalPresentMin)/cint(mTotalTSMinutes))*100
    'Response.write("<br>")
    'response.write(RSAttendancePercentage("StdEnrollmentId") & " - " & StdAttendancePercentage & " - ")
    
    'Response.write("<br> Std Total Short Min:")
    'response.write(cint(RSAttendancePercentage("TotalShortMin")))
    'Response.write("<br> Total TS Min:")
    'response.write(cint(mTotalTSMinutes))
    'Response.write("<br> Std Total Present Min:")
    'response.write(cint(TotalPresentMin))
    'Response.write("<br> Std Attendance Percentage:")
    'response.write(StdAttendancePercentage)
    'Response.write("<br> Min Attendance Percentage:")
    'response.write(mMinAttendancePercentage)
    
    if StdAttendancePercentage >= cdbl(mMinAttendancePercentage) then
    EnrollmentStatus = 5
    elseif StdAttendancePercentage <= 0 then
    EnrollmentStatus = 7
    elseif StdAttendancePercentage < cdbl(mMinAttendancePercentage) then
    EnrollmentStatus = 9
    end if
    
    QryStr = "UPDATE StudentEnrollment SET EnrollmentStatusId = " & EnrollmentStatus & ", UserLastUpdatedBy = " & Session("SUserId") &_ 
    ", LastUpdatedDateTime = '" & Now() & "' WHERE(CourseDirectoryId = " & CourseDirectoryId & ") AND (StdEnrollmentId = " & RSAttendancePercentage("StdEnrollmentId") & ")"
    'Response.write("<br>")
    'Response.write(QryStr)
    Conn.execute QryStr
    
    RSAttendancePercentage.MoveNext
    loop
    'end

    'Change CD Status to Completed
        QryStr = "UPDATE CourseDirectory Set CourseDirectoryStatusId = 2 , UserLastUpdatedBy = " & Session("SUserId") &_ 
        ", LastUpdatedDateTime = '" & Now() & "' WHERE(CourseDirectoryId = " & CourseDirectoryId & ")"
        'response.write(QryStr)
        Conn.execute QryStr
    'end

    response.redirect("CourseDirectoryAttendance.asp?QsId=" & CourseDirectoryId)

end if
'End

%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <link rel="stylesheet" href="CSS/GlobalStyle.css">
    <link rel="stylesheet" href="CSS/StyleAddCourseDir.css">
    <title>View Course Directory</title>
</head>

<body>
    <header>
        <!--#include file=Header.asp-->
    </header>

    <div class="wrapper">
        <div class="container-fluid">
            <div class="row justify-content-center">
                <div class="col">
                    <ul class="nav nav-tabs">
                        <li class="nav-item">
                            <a class="nav-link"
                                href="CourseDirectoryView.asp?QsId=<% response.Write(RSCourseDirectory("CourseDirectoryId")) %>">View
                                Course Directory</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link"
                                href="CourseDirectoryEdit.asp?QsId=<% response.Write(RSCourseDirectory("CourseDirectoryId")) %>">Edit
                                Course Directory</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link"
                                href="EnrollCourse.asp?QsId=<% response.Write(RSCourseDirectory("CourseDirectoryId")) %>">Enroll
                                Course</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link active"
                                href="CourseDirectoryAttendance.asp?QsId=<% response.Write(RSCourseDirectory("CourseDirectoryId")) %>">Attendance</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link"
                                href="CourseDirectoryCertificate.asp?QsId=<% response.Write(RSCourseDirectory("CourseDirectoryId")) %>">Certificate
                                Issuance</a>
                        </li>
                    </ul>
                </div>
            </div>

            <% if AttendanceCount >= CourseDuration AND mCourseDirectoryStatus = 1 then %>
            <div>
                <form action="CourseDirectoryAttendance.asp?QsUpdate=1&QsId=<% response.Write(CourseDirectoryId) %>"
                    method="POST">
                    <div class="panel">
                        <br>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg d-flex justify-content-center">
                                    <input type="submit" value="Click Here to Close Attendance" class="button">
                                    <input type="hidden" name="FormCourseDirectoryIdUpdate" id="" class="form-control"
                                        value="<% response.Write(CourseDirectoryId) %>">
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <% end if %>

            <div class="panel">
                <br>
                <div class="panel-head">
                    <div class="row">
                        <div class="col">
                            <label for="">Course Directory</label>
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <br>
                    <div class="row">
                        <div class="col">
                            <div class="form-group">
                                <label for="" class="input-heading">Course Name</label>
                                <label
                                    class="form-control label-data"><% response.Write(RSCourseDirectory("CourseName")) %></label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Start Date</label>
                                <label
                                    class="form-control label-data"><% response.Write(RSCourseDirectory("StartDate")) %></label>
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">End Date</label>
                                <label
                                    class="form-control label-data"><% response.Write(RSCourseDirectory("EndDate")) %></label>
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Course Duration</label>
                                <label
                                    class="form-control label-data"><% response.Write(RSCourseDirectory("CourseDuration")) %></label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Time Slot</label>
                                <label
                                    class="form-control label-data"><% response.Write(FormatDateTime(RSCourseDirectory("StartTime"),3)& " - " & FormatDateTime(RSCourseDirectory("EndTime"),3)) %></label>
                                <input type="hidden" value="<% =(TimeSlotMinutes) %>" id="TSMinutes">
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Instructor Name</label>
                                <label
                                    class="form-control label-data"><% response.Write(RSCourseDirectory("InstructorName")) %></label>
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Room</label>
                                <label
                                    class="form-control label-data"><% response.Write(RSCourseDirectory("RoomNumber")) %></label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Language</label>
                                <label
                                    class="form-control label-data"><% response.Write(RSCourseDirectory("Language")) %></label>
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Min Attendance Percentage</label>
                                <label
                                    class="form-control label-data"><% response.Write(RSCourseDirectory("MinAttendancePercentage")) %></label>
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Max Enrollment</label>
                                <label
                                    class="form-control label-data"><% response.Write(RSCourseDirectory("MaxEnrollment")) %></label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Enrollment Closing Date</label>
                                <label
                                    class="form-control label-data"><% response.Write(RSCourseDirectory("EnrollmentClosingDate")) %></label>
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Course Fee</label>
                                <label
                                    class="form-control label-data"><% response.Write(RSCourseDirectory("CourseFee") & " PKR") %></label>
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Course Directory Status</label>
                                <label
                                    class="form-control label-data"><% response.Write(RSCourseDirectory("CourseDirectoryStatus")) %></label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <% if Now() >= cdate(mStartDate) then %>
            <% if cint(mCourseDirectoryStatus) = 1 then %>
            <% if AttendanceCount < CourseDuration then %>
            <form action="CourseDirectoryAttendance.asp?QsId=<% response.Write(CourseDirectoryId) %>" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Attendance Date</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row justify-content-center">
                            <div class="col-4">
                                <div class="form-group">
                                    <label for="" class="input-heading">Attendance Date</label>
                                    <input type="date" name="FormAttendanceDate" id="AttendanceDate"
                                        class="form-control" onblur="ValidateAttendanceDate(this);">
                                    <input type="hidden" name="FormCourseDirectoryId" id="" class="form-control"
                                        value="<% response.Write(CourseDirectoryId) %>">
                                    <input type="hidden" name="" id="StartDate" class="form-control"
                                        value="<% response.Write(mStartDate) %>">
                                    <input type="hidden" name="" id="EndDate" class="form-control"
                                        value="<% response.Write(mEndDate) %>">
                                </div>
                            </div>
                        </div>

                        <div class="row justify-content-center">
                            <div class="col-4 text-center">
                                <span class="text-center" id="DateError"><% response.Write(eAttendanceDate) %></span>
                            </div>
                        </div>

                        <div class="row justify-content-center">
                            <div class="col text-center">
                                <span class="text-center"><% response.Write(eDurationError) %></span>
                            </div>
                        </div>

                        <div class="row justify-content-center">
                            <div class="col text-center">
                                <span class="text-center"><% response.Write(eDuplicateAttendance) %></span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Attendance List</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>

                        <table class="table table-bordered table-hover" style="width: 90%;">
                            <thead class="thead-light">
                                <tr>
                                    <th style="width: 3%;">GR-Number</th>
                                    <th style="width: 5%;">First Name</th>
                                    <th style="width: 5%;">Last Name</th>
                                    <th style="width: 5%;">Father Name</th>
                                    <th style="width: 5%;">Short Minutes</th>
                                    <th style="width: .5%;"></th>
                                    <th style="width: .5%;"></th>
                                </tr>
                            </thead>

                            <tbody>
                                <%
                                    Dim Counter
                                    Counter = 1

                                    do while NOT RSAttendanceList.EOF
                                    %>

                                <tr>
                                    <td><% response.Write(RSAttendanceList("StdGrNumber")) %></td>
                                    <td><% response.Write(RSAttendanceList("StdFirstName")) %></td>
                                    <td><% response.Write(RSAttendanceList("StdLastName")) %></td>
                                    <td><% response.Write(RSAttendanceList("FatherName")) %></td>
                                    <td><input type=" text" id="InputShortMin<% response.write(Counter) %>"
                                            class="form-control" name="FormShortMin<% response.write(Counter) %>"
                                            onblur="ValidateShortMin(this);"
                                            value="<% response.Write(Session("sMin" & Counter)) %>">
                                        <span class="Error"
                                            id="ErrorMin"><% response.Write(Session("sShortMinutes" & Counter)) %></span>
                                    </td>
                                    <td>
                                        <span
                                            onclick="MarkAbsent(document.getElementById('InputShortMin<% response.write(Counter) %>'));"><img
                                                src="Images/Absent.png" alt="Click to Mark Absent" width="30px"
                                                height="30px" title="Click to Mark Absent"></span>
                                    </td>
                                    <td>
                                        <span
                                            onclick="MarkPresent(document.getElementById('InputShortMin<% response.write(Counter) %>'));"><img
                                                src="Images/present.png" alt="Click to Mark Present" width="30px"
                                                height="30px" title="Click to Mark Present"></span>
                                    </td>
                                    <input type="hidden" name="FormStdEnrollmentId<% response.write(Counter) %>" id=""
                                        value="<% response.Write(RSAttendanceList("StdEnrollmentId")) %>">
                                </tr>

                                <%
                                                        Counter = Counter + 1
                                                        RSAttendanceList.MoveNext
                                                        loop

                                                        RSAttendanceList.close
                                                        set RSAttendanceList = Nothing
                                                        %>
                            </tbody>
                        </table>
                        <input type="hidden" value="<% response.Write(Counter - 1) %>" name="FormCounter">
                    </div>
                </div>
                <div class=" row">
                    <div class="col-lg d-flex justify-content-center">
                        <input type="submit" value="Submit" class="button">
                    </div>
                </div>
            </form>
            <% else %>
            <div class="row mt-4">
                <div class="col text-center">
                    <h2>This Course Directory Attendance is Completed</h2>
                </div>
            </div>
            <% end if %>
            <% elseif cint(mCourseDirectoryStatus) = 2 then %>
            <div class="row mt-4">
                <div class="col text-center">
                    <h2>This Course Directory is Completed</h2>
                </div>
            </div>
            <% elseif cint(mCourseDirectoryStatus) = 3 then %>
            <div class="row mt-4">
                <div class="col text-center">
                    <h2>This Course Directory is Cancelled</h2>
                </div>
            </div>
            <% end if %>
            <% else %>
            <div class="row mt-4">
                <div class="col text-center">
                    <h2>This Course Directory is not Started Yet</h2>
                </div>
            </div>
            <% end if %>

            <div class="panel">
                <br>
                <div class="panel-head">
                    <div class="row">
                        <div class="col">
                            <label for="">Student's Attendance</label>
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <br>

                    <table class="table table-bordered table-hover" style="width: 70%;">
                        <thead class="thead-light">
                            <tr>
                                <th style="width: 3%;">Course Directory Id</th>
                                <th style="width: 5%;">Attendance Date</th>
                                <th style="width: 5%;">Attendance Count</th>
                                <th style="width: 1%;"></th>
                                <th style="width: 1%;"></th>
                            </tr>
                        </thead>

                        <tbody>
                            <%
                                Dim RSAttendance
                                Set RSAttendance = Server.CreateObject("ADODB.RecordSet")
                                QryStr = "SELECT * FROM V_AttendanceGroup WHERE(CourseDirectoryId = " & CourseDirectoryId & ")"
                                RSAttendance.Open QryStr, conn

                                do while NOT RSAttendance.EOF
                                %>

                            <tr>
                                <td><% response.Write(RSAttendance("CourseDirectoryId")) %></td>
                                <td><% response.Write(RSAttendance("AttendanceDate")) %></td>
                                <td><% response.Write(RSAttendance("AttendanceCount")) %></td>
                                <td>
                                    <a
                                        href="CourseDirectoryAttendance.asp?QsEdit=1&QsId=<% response.write(CourseDirectoryId) %>&QsDate=<% response.write(RSAttendance("AttendanceDate")) %>"><img
                                            src="Images/edit.png" alt="" style="width: 18px; height: 18px;"
                                            title="Edit Attendance"></a>
                                </td>
                                <td>
                                    <a
                                        href="CourseDirectoryAttendance.asp?QsDelete=1&QsId=<% response.write(CourseDirectoryId) %>&QsDate=<% response.write(RSAttendance("AttendanceDate")) %>"><img
                                            src="Images/cancel.png" alt="" style="width: 18px; height: 18px;"
                                            title="Delete Attendance"
                                            onclick="return (confirm('Do you want to Delete this Attendance?'));"></a>
                                </td>
                            </tr>

                            <%
                                RSAttendance.MoveNext
                                loop

                                RSAttendance.close
                                set RSAttendance = Nothing
                                %>
                        </tbody>
                    </table>
                </div>
            </div>

            <% if Request.QueryString("QsEdit")="1" AND Request.QueryString("QsId")<>"" AND Request.QueryString("QsDate")<>"" then %>
            <form action="CourseDirectoryAttendance.asp?QsUpdate=2&QsId=<% response.Write(CourseDirectoryId) %>"
                method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Edit Attendance</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>

                        <table class="table table-bordered table-hover" style="width: 90%;">
                            <thead class="thead-light">
                                <tr>
                                    <th style="width: 3%;">GR-Number</th>
                                    <th style="width: 5%;">First Name</th>
                                    <th style="width: 5%;">Last Name</th>
                                    <th style="width: 5%;">Father Name</th>
                                    <th style="width: 5%;">Short Minutes</th>
                                    <th style="width: .5%;"></th>
                                    <th style="width: .5%;"></th>
                                </tr>
                            </thead>

                            <tbody>
                                <%
                                    Counter = 1

                                    Set RSAttendanceList = Server.CreateObject("ADODB.RecordSet")
                                    QryStr = "SELECT * FROM V_AttendanceListEdit WHERE(CourseDirectoryId = " & CourseDirectoryId & ") AND (EnrollmentStatusId = 1) AND (AttendanceDate = '" & cdate(Request.QueryString("QsDate")) & "')"
                                    RSAttendanceList.Open QryStr, conn
                                %>

                                <input type="hidden" name="EditFormCDId" id=""
                                    value="<% response.Write(RSAttendanceList("CourseDirectoryId")) %>">
                                <input type="hidden" name="EditFormDate" id=""
                                    value="<% response.Write(RSAttendanceList("AttendanceDate")) %>">

                                <%
                                    do while NOT RSAttendanceList.EOF
                                %>

                                <tr>
                                    <td><% response.Write(RSAttendanceList("StdGrNumber")) %></td>
                                    <td><% response.Write(RSAttendanceList("StdFirstName")) %></td>
                                    <td><% response.Write(RSAttendanceList("StdLastName")) %></td>
                                    <td><% response.Write(RSAttendanceList("FatherName")) %></td>
                                    <td>
                                        <% if Session("sEditMin" & Counter) = "" then %>
                                        <input type=" text" id="EditShortMin<% response.write(Counter) %>"
                                            class="form-control" name="EditFormShortMin<% response.write(Counter) %>"
                                            onblur="ValidateShortMin(this);"
                                            value="<% response.Write(RSAttendanceList("ShortMin")) %>">
                                        <% else %>
                                        <input type=" text" id="EditShortMin<% response.write(Counter) %>"
                                            class="form-control" name="EditFormShortMin<% response.write(Counter) %>"
                                            onblur="ValidateShortMin(this);"
                                            value="<% response.Write(Session("sEditMin" & Counter)) %>">
                                        <% end if %>
                                        <span class="Error"
                                            id="EditErrorMin"><% response.Write(Session("sEditShortMinutes" & Counter)) %></span>
                                    </td>
                                    <td>
                                        <span
                                            onclick="MarkAbsent(document.getElementById('EditShortMin<% response.write(Counter) %>'));"><img
                                                src="Images/Absent.png" alt="Click to Mark Absent" width="30px"
                                                height="30px" title="Click to Mark Absent"></span>
                                    </td>
                                    <td>
                                        <span
                                            onclick="MarkPresent(document.getElementById('EditShortMin<% response.write(Counter) %>'));"><img
                                                src="Images/present.png" alt="Click to Mark Present" width="30px"
                                                height="30px" title="Click to Mark Present"></span>
                                    </td>
                                    <input type="hidden" name="FormAttendanceId<% response.write(Counter) %>" id=""
                                        value="<% response.Write(RSAttendanceList("AttendanceId")) %>">
                                </tr>

                                <%
                                    Counter = Counter + 1
                                    RSAttendanceList.MoveNext
                                    loop

                                    RSAttendanceList.close
                                    set RSAttendanceList = Nothing
                                    %>
                            </tbody>
                        </table>
                        <input type="hidden" value="<% response.Write(Counter - 1) %>" name="EditFormCounter">
                    </div>
                </div>
                <div class=" row">
                    <div class="col-lg d-flex justify-content-center">
                        <input type="submit" value="Update" class="button">
                    </div>
                </div>
            </form>
            <% end if %>
        </div>
    </div>

    <footer>
        <!--#include file=Footer.asp-->
    </footer>
</body>

<script src="Scripts/Attendance.js  "></script>

</html>
<%
else
    response.write("<h3>Page cannot be loaded, Please Contact System Administrator</h3>")
end if  
%>