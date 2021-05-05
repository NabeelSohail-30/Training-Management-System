<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->
<%
    call OpenDbConn()

    Dim RSCourseDirectory
    Dim IsError

    CourseDirectoryId = Request.QueryString("QsId")
    IsError = request.QueryString("QsIsError")

    Set RSCourseDirectory = Server.CreateObject("ADODB.RecordSet")
    
    QryStr = "SELECT * FROM V_CourseDirectoryView WHERE(CourseDirectoryId = " & CourseDirectoryId & ")"
    
    RSCourseDirectory.Open QryStr, conn
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <link rel="stylesheet" href="CSS/GlobalStyle.css">
    <link rel="stylesheet" href="CSS/StyleAddCourseDir.css">
    <title>Edit Course Directory</title>
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
                            <a class="nav-link active"
                                href="CourseDirectoryEdit.asp?QsId=<% response.Write(RSCourseDirectory("CourseDirectoryId")) %>">Edit
                                Course Directory</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link"
                                href="EnrollCourse.asp?QsId=<% response.Write(RSCourseDirectory("CourseDirectoryId")) %>">Enroll
                                Course</a>
                        </li>
                    </ul>
                </div>
            </div>

            <br>

            <div class="panel">
                <br>
                <div class="panel-head">
                    <div class="row">
                        <div class="col">
                            <label for="">Edit Course Directory</label>
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <br>
                    <form action="CourseDirectoryUpdate.asp" method="POST">
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <input type="hidden" value="<% response.write(CourseDirectoryId) %>"
                                        name="FormCourseDirectoryId">
                                    <label for="" class="input-heading">Course Name</label>
                                    <% if IsError = "1" then %>
                                    <select name="FormCourseId" id="" class="form-control">
                                        <option value="-1">Select Course</option>
                                        <%
                                        Dim RSCourseName
                                        Set RSCourseName = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSCourseName.Open "SELECT CourseId, CourseName FROM CourseContent" & ConditionSubCatg,Conn
    
                                        do while NOT RSCourseName.EOF
                                            if RSCourseDirectory("CourseId") = Session("smCourseId") then
                                    %>
                                        <option value="<% response.write(RSCourseName("CourseId")) %>" selected>
                                            <% response.write(RSCourseName("CourseName")) %></option>
                                        <% else %>
                                        <option value="<% response.write(RSCourseName("CourseId")) %>">
                                            <% response.write(RSCourseName("CourseName")) %></option>
                                        <%
                                            end if
                                        RSCourseName.MoveNext
                                        Loop
                
                                        RSCourseName.Close
                                        Set RSCourseName = Nothing
                                    %>
                                    </select>
                                    <% else %>
                                    <select name="FormCourseId" id="" class="form-control">
                                        <option value="-1">Select Course</option>
                                        <%
                                        'Dim RSCourseName
                                        Set RSCourseName = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSCourseName.Open "SELECT CourseId, CourseName FROM CourseContent" & ConditionSubCatg,Conn
    
                                        do while NOT RSCourseName.EOF
                                            if RSCourseDirectory("CourseId") = RSCourseName("CourseId") then
                                    %>
                                        <option value="<% response.write(RSCourseName("CourseId")) %>" selected>
                                            <% response.write(RSCourseName("CourseName")) %></option>
                                        <% else %>
                                        <option value="<% response.write(RSCourseName("CourseId")) %>">
                                            <% response.write(RSCourseName("CourseName")) %></option>
                                        <%
                                            end if
                                        RSCourseName.MoveNext
                                        Loop
                
                                        RSCourseName.Close
                                        Set RSCourseName = Nothing
                                    %>
                                    </select>
                                    <% end if %>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col">
                                <span><% response.write(Session("sCourseId")) %></span>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-4">
                                <div class="form-group">
                                    <label for="" class="input-heading">Start Date</label>
                                    <% if IsError = "1" then %>
                                    <input type="date" name="FormStartDate" id="" class="form-control"
                                        value="<% response.write(Session("smStartDate")) %>">
                                    <% else %>
                                    <input type="date" name="FormStartDate" id="" class="form-control"
                                        value="<% response.write(RSCourseDirectory("StartDate")) %>">
                                    <% end if %>
                                </div>
                            </div>

                            <div class="col-4">
                                <div class="form-group">
                                    <label for="" class="input-heading">End Date</label>
                                    <% if IsError = "1" then %>
                                    <input type="date" name="FormEndDate" id="" class="form-control"
                                        value="<% response.write(Session("smEndDate")) %>">
                                    <% else %>
                                    <input type="date" name="FormEndDate" id="" class="form-control"
                                        value="<% response.write(RSCourseDirectory("EndDate")) %>">
                                    <% end if %>
                                </div>
                            </div>

                            <div class="col-4">
                                <div class="form-group">
                                    <label for="" class="input-heading">Course Duration</label>
                                    <% if IsError = "1" then %>
                                    <input type="text" name="FormCourseDuration" id="" class="form-control"
                                        value="<% response.write(Session("smDuration")) %>">
                                    <% else %>
                                    <input type="text" name="FormCourseDuration" id="" class="form-control"
                                        value="<% response.write(RSCourseDirectory("CourseDuration")) %>">
                                    <% end if %>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-4">
                                <span><% response.write(Session("sStartDate")) %></span>
                            </div>
                            <div class="col-4">
                                <span><% response.write(Session("sEndDate")) %></span>
                            </div>
                            <div class="col-4">
                                <span><% response.write(Session("sDuration")) %></span>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-4">
                                <div class="form-group">
                                    <label for="" class="input-heading">Time Slot</label>
                                    <% if IsError = "1" then %>
                                    <select name="FormTimeSlotId" id="" class="form-control">
                                        <option value="-1">Select Time Slot</option>
                                        <%
                                        Dim RSTimeSlot
                                        Set RSTimeSlot = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSTimeSlot.Open "SELECT TimeSlotId, StartTime, EndTime FROM ListTimeSlot",Conn
    
                                        do while NOT RSTimeSlot.EOF
                                            if RSTimeSlot("TimeSlotId") = Session("smTimeSlotId") then
                                    %>
                                        <option value="<% response.write(RSTimeSlot("TimeSlotId")) %>" Selected>
                                            <% response.write(FormatDateTime(RSTimeSlot("StartTime"),3) & " - " & FormatDateTime(RSTimeSlot("EndTime"),3)) %>
                                        </option>
                                        <% else %>
                                        <option value="<% response.write(RSTimeSlot("TimeSlotId")) %>">
                                            <% response.write(FormatDateTime(RSTimeSlot("StartTime"),3) & " - " & FormatDateTime(RSTimeSlot("EndTime"),3)) %>
                                        </option>
                                        <%
                                            end if
                                        RSTimeSlot.MoveNext
                                        Loop
                
                                        RSTimeSlot.Close
                                        Set RSTimeSlot = Nothing
                                    %>
                                    </select>
                                    <% else %>
                                    <select name="FormTimeSlotId" id="" class="form-control">
                                        <option value="-1">Select Time Slot</option>
                                        <%
                                        'Dim RSTimeSlot
                                        Set RSTimeSlot = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSTimeSlot.Open "SELECT TimeSlotId, StartTime, EndTime FROM ListTimeSlot",Conn
    
                                        do while NOT RSTimeSlot.EOF
                                            if RSCourseDirectory("TimeSlotId") = RSTimeSlot("TimeSlotId") then
                                    %>
                                        <option value="<% response.write(RSTimeSlot("TimeSlotId")) %>" selected>
                                            <% response.write(FormatDateTime(RSTimeSlot("StartTime"),3) & " - " & FormatDateTime(RSTimeSlot("EndTime"),3)) %>
                                        </option>
                                        <% else %>
                                        <option value="<% response.write(RSTimeSlot("TimeSlotId")) %>">
                                            <% response.write(FormatDateTime(RSTimeSlot("StartTime"),3) & " - " & FormatDateTime(RSTimeSlot("EndTime"),3)) %>
                                        </option>
                                        <%
                                            end if
                                        RSTimeSlot.MoveNext
                                        Loop
                
                                        RSTimeSlot.Close
                                        Set RSTimeSlot = Nothing
                                    %>
                                    </select>
                                    <% end if %>
                                </div>
                            </div>

                            <div class="col-4">
                                <div class="form-group">
                                    <label for="" class="input-heading">Instructor Name</label>
                                    <% if IsError = "1" then %>
                                    <select name="FormInstructorId" id="" class="form-control">
                                        <option value="-1">Select Instructor</option>
                                        <%
                                        Dim RSInstructor
                                        Set RSInstructor = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSInstructor.Open "SELECT InstructorId, InstructorName FROM ListInstructor",Conn
    
                                        do while NOT RSInstructor.EOF
                                            if RSInstructor("InstructorId") = Session("smInstructorId") then
                                    %>
                                        <option value="<% response.write(RSInstructor("InstructorId")) %>" selected>
                                            <% response.write(RSInstructor("InstructorName")) %></option>
                                        <% else %>
                                        <option value="<% response.write(RSInstructor("InstructorId")) %>">
                                            <% response.write(RSInstructor("InstructorName")) %></option>
                                        <%
                                            end if
                                        RSInstructor.MoveNext
                                        Loop
                
                                        RSInstructor.Close
                                        Set RSInstructor = Nothing
                                    %>
                                    </select>
                                    <% else %>
                                    <select name="FormInstructorId" id="" class="form-control">
                                        <option value="-1">Select Instructor</option>
                                        <%
                                        'Dim RSInstructor
                                        Set RSInstructor = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSInstructor.Open "SELECT InstructorId, InstructorName FROM ListInstructor",Conn
    
                                        do while NOT RSInstructor.EOF
                                            if RSCourseDirectory("InstructorId") = RSInstructor("InstructorId") then
                                    %>
                                        <option value="<% response.write(RSInstructor("InstructorId")) %>" selected>
                                            <% response.write(RSInstructor("InstructorName")) %></option>
                                        <% else %>
                                        <option value="<% response.write(RSInstructor("InstructorId")) %>">
                                            <% response.write(RSInstructor("InstructorName")) %></option>
                                        <%
                                            end if
                                        RSInstructor.MoveNext
                                        Loop
                
                                        RSInstructor.Close
                                        Set RSInstructor = Nothing
                                    %>
                                    </select>
                                    <% end if %>
                                </div>
                            </div>

                            <div class="col-4">
                                <div class="form-group">
                                    <label for="" class="input-heading">Room</label>
                                    <% if IsError = "1" then %>
                                    <select name="FormRoomId" id="" class="form-control">
                                        <option value="-1">Select Room</option>
                                        <%
                                        Dim RSRoom
                                        Set RSRoom = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSRoom.Open "SELECT RoomId, RoomNumber FROM ListRoom",Conn
    
                                        do while NOT RSRoom.EOF
                                            if RSRoom("RoomId") = Session("smRoomId") then
                                    %>
                                        <option value="<% response.write(RSRoom("RoomId")) %>" selected>
                                            <% response.write(RSRoom("RoomNumber")) %></option>
                                        <% else %>
                                        <option value="<% response.write(RSRoom("RoomId")) %>">
                                            <% response.write(RSRoom("RoomNumber")) %></option>
                                        <%
                                            end if
                                        RSRoom.MoveNext
                                        Loop
                
                                        RSRoom.Close
                                        Set RSRoom = Nothing
                                    %>
                                    </select>
                                    <% else %>
                                    <select name="FormRoomId" id="" class="form-control">
                                        <option value="-1">Select Room</option>
                                        <%
                                        'Dim RSRoom
                                        Set RSRoom = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSRoom.Open "SELECT RoomId, RoomNumber FROM ListRoom",Conn
    
                                        do while NOT RSRoom.EOF
                                            if RSCourseDirectory("RoomId") = RSRoom("RoomId") then
                                    %>
                                        <option value="<% response.write(RSRoom("RoomId")) %>" selected>
                                            <% response.write(RSRoom("RoomNumber")) %></option>
                                        <% else %>
                                        <option value="<% response.write(RSRoom("RoomId")) %>">
                                            <% response.write(RSRoom("RoomNumber")) %></option>
                                        <%
                                            end if
                                        RSRoom.MoveNext
                                        Loop
                
                                        RSRoom.Close
                                        Set RSRoom = Nothing
                                    %>
                                    </select>
                                    <% end if %>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-4">
                                <span><% response.write(Session("sTimeSlotId")) %></span>
                            </div>
                            <div class="col-4">
                                <span><% response.write(Session("sConflictedInstructor")) %></span>
                            </div>
                            <div class="col-4">
                                <span><% response.write(Session("sConflictedRoom")) %></span>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-4">
                                <div class="form-group">
                                    <label for="" class="input-heading">Language</label>
                                    <% if IsError = "1" then %>
                                    <select name="FormLanguageId" id="" class="form-control">
                                        <option value="-1">Select Language</option>
                                        <%
                                        Dim RSLanguage
                                        Set RSLanguage = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSLanguage.Open "SELECT LanguageId, Language FROM ListLanguage",Conn
    
                                        do while NOT RSLanguage.EOF
                                            if RSLanguage("LanguageId") = Session("LanguageId") then
                                        %>
                                        <option value="<% response.write(RSLanguage("LanguageId")) %>" selected>
                                            <% response.write(RSLanguage("Language")) %></option>
                                        <% else %>
                                        <option value="<% response.write(RSLanguage("LanguageId")) %>">
                                            <% response.write(RSLanguage("Language")) %></option>
                                        <%
                                            end if
                                        RSLanguage.MoveNext
                                        Loop
                
                                        RSLanguage.Close
                                        Set RSLanguage = Nothing
                                        %>
                                    </select>
                                    <% else %>
                                    <select name="FormLanguageId" id="" class="form-control">
                                        <option value="-1">Select Language</option>
                                        <%
                                        'Dim RSLanguage
                                        Set RSLanguage = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSLanguage.Open "SELECT LanguageId, Language FROM ListLanguage",Conn
    
                                        do while NOT RSLanguage.EOF
                                            if RSCourseDirectory("LanguageId") = RSLanguage("LanguageId") then
                                    %>
                                        <option value="<% response.write(RSLanguage("LanguageId")) %>" selected>
                                            <% response.write(RSLanguage("Language")) %></option>
                                        <% else %>
                                        <option value="<% response.write(RSLanguage("LanguageId")) %>">
                                            <% response.write(RSLanguage("Language")) %></option>
                                        <%
                                            end if
                                        RSLanguage.MoveNext
                                        Loop
                
                                        RSLanguage.Close
                                        Set RSLanguage = Nothing
                                    %>
                                    </select>
                                    <% end if %>
                                </div>
                            </div>

                            <div class="col-4">
                                <div class="form-group">
                                    <label for="" class="input-heading">Minimum Attendance %</label>
                                    <% if IsError = "1" then %>
                                    <input type="text" class="form-control" name="FormMinAttendance"
                                        value="<% response.write(Session("smAttendance")) %>">
                                    <% else %>
                                    <input type="text" class="form-control" name="FormMinAttendance"
                                        value="<% response.write(RSCourseDirectory("MinAttendancePercentage")) %>">
                                    <% end if %>
                                </div>
                            </div>

                            <div class="col-4">
                                <div class="form-group">
                                    <label for="" class="input-heading">Max Enrollment</label>
                                    <% if IsError = "1" then %>
                                    <input type="text" class="form-control" name="FormMaxEnrollment"
                                        value="<% response.write(Session("smMaxEnrollment")) %>">
                                    <% else %>
                                    <input type="text" class="form-control" name="FormMaxEnrollment"
                                        value="<% response.write(RSCourseDirectory("MaxEnrollment")) %>">
                                    <% end if %>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-4">
                                <span><% response.write(Session("sLanguageId")) %></span>
                            </div>
                            <div class="col-4">
                                <span><% response.write(Session("sAttendance")) %></span>
                            </div>
                            <div class="col-4">
                                <span><% response.write(Session("sMaxEnrollment")) %></span>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-4">
                                <div class="form-group">
                                    <label for="" class="input-heading">Enrollment Closing Date</label>
                                    <% if IsError = "1" then %>
                                    <input type="date" class="form-control" name="FormEnrollmentClosingDate"
                                        value="<% response.write(Session("smClosingDate")) %>">
                                    <% else %>
                                    <input type="date" class="form-control" name="FormEnrollmentClosingDate"
                                        value="<% response.write(RSCourseDirectory("EnrollmentClosingDate")) %>">
                                    <% end if %>
                                </div>
                            </div>

                            <div class="col-4">
                                <div class="form-group">
                                    <label for="" class="input-heading">Course Fee</label>
                                    <% if IsError = "1" then %>
                                    <input type="text" class="form-control" name="FormCourseFee"
                                        value="<% response.write(Session("smCourseFee")) %>">
                                    <% else %>
                                    <input type="text" class="form-control" name="FormCourseFee"
                                        value="<% response.write(RSCourseDirectory("CourseFee")) %>">
                                    <% end if %>
                                </div>
                            </div>

                            <div class="col-4">
                                <div class="form-group">
                                    <label for="" class="input-heading">Course Directory Status</label>
                                    <% if IsError = "1" then %>
                                    <select name="FormCourseDirectoryStatus" id="" class="form-control">
                                        <option value="-1">Select Course Status</option>
                                        <%
                                        Dim RSCourseStatus
                                        Set RSCourseStatus = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSCourseStatus.Open "SELECT CourseDirectoryStatusId, CourseDirectoryStatus FROM ListCourseDirectoryStatus",Conn
    
                                        do while NOT RSCourseStatus.EOF
                                            if RSCourseStatus("CourseDirectoryStatusId") = Session("smCourseDirectoryStatusId") then
                                        %>
                                        <option value="<% response.write(RSCourseStatus("CourseDirectoryStatusId")) %>"
                                            selected>
                                            <% response.write(RSCourseStatus("CourseDirectoryStatus")) %></option>
                                        <% else %>
                                        <option value="<% response.write(RSCourseStatus("CourseDirectoryStatusId")) %>">
                                            <% response.write(RSCourseStatus("CourseDirectoryStatus")) %></option>
                                        <%
                                            end if
                                        RSCourseStatus.MoveNext
                                        Loop
                
                                        RSCourseStatus.Close
                                        Set RSCourseStatus = Nothing
                                        %>
                                    </select>
                                    <% else %>
                                    <select name="FormCourseDirectoryStatus" id="" class="form-control">
                                        <option value="-1">Select Course Status</option>
                                        <%
                                        Set RSCourseStatus = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSCourseStatus.Open "SELECT CourseDirectoryStatusId, CourseDirectoryStatus FROM ListCourseDirectoryStatus",Conn
    
                                        do while NOT RSCourseStatus.EOF
                                            if RSCourseStatus("CourseDirectoryStatusId") = RSCourseDirectory("CourseDirectoryStatusId") then
                                        %>
                                        <option value="<% response.write(RSCourseStatus("CourseDirectoryStatusId")) %>"
                                            selected>
                                            <% response.write(RSCourseStatus("CourseDirectoryStatus")) %></option>
                                        <% else %>
                                        <option value="<% response.write(RSCourseStatus("CourseDirectoryStatusId")) %>">
                                            <% response.write(RSCourseStatus("CourseDirectoryStatus")) %></option>
                                        <%
                                            end if
                                        RSCourseStatus.MoveNext
                                        Loop
                
                                        RSCourseStatus.Close
                                        Set RSCourseStatus = Nothing
                                        %>
                                    </select>
                                    <% end if %>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-4">
                                <span><% response.write(Session("sClosingDate")) %></span>
                            </div>
                            <div class="col-4">
                                <span><% response.write(Session("sCourseFee")) %></span>
                            </div>
                            <div class="col-4">
                                <span><% response.write(Session("")) %></span>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg d-flex justify-content-center">
                                <input type="submit" value="Update" class="button">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <br>
        </div>
    </div>

    <footer>
        <!--#include file=Footer.asp-->
    </footer>
</body>

</html>