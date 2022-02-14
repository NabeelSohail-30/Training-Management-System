<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->
<%
if Session("SUserRoleId") <> 2 then
    dim mCourseCategoryId
    dim mCourseSubCategoryId
    dim ConditionCatg
    dim ConditionSubCatg

    mCourseCategoryId = cint(request.Form("FormCourseCategoryId"))
    mCourseSubCategoryId = cint(request.Form("FormCourseSubCategoryId"))
    ConditionCatg = " WHERE(1=1) "
    ConditionSubCatg = " WHERE(1=1) "

    if mCourseCategoryId > 0 then
        ConditionCatg = ConditionCatg & " AND (CategoryId = " & mCourseCategoryId & ") "
    else
        ConditionCatg = ConditionCatg & " AND (CategoryId = -1 ) "
    end if

    if mCourseSubCategoryId > 0 then
        ConditionSubCatg = ConditionCatg & " AND (SubCategoryId = " & mCourseSubCategoryId & ") "
    else
        ConditionSubCatg = ConditionCatg & " AND (SubCategoryId = -1 ) "
    end if

    'response.write(ConditionCatg)
    'response.write("<br>")
    'response.write(ConditionSubCatg)


%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <link rel="stylesheet" href="CSS/GlobalStyle.css">
    <link rel="stylesheet" href="CSS/StyleAddCourseDir.css">
    <title>Add Course Directory</title>
</head>

<body>
    <header>
        <!--#include file=Header.asp-->
    </header>

    <div class="wrapper">
        <div class="container-fluid">
            <div class="panel">
                <br>
                <div class="panel-head">
                    <div class="row">
                        <div class="col">
                            <label for="">Add New Course Directory</label>
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <section class="action">
                        <div>
                            <form class="search" action="CourseDirectoryAdd.asp" method="POST" id="FormCatg">
                                <div>
                                    <select name="FormCourseCategoryId" id="" class="search-bar"
                                        onchange="document.getElementById('FormCatg').submit()">
                                        <option value="-1">Select Category</option>
                                        <%
                                        Dim RSCategory
                                        Set RSCategory = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSCategory.Open "SELECT CategoryId, Category FROM ListCourseCategory",Conn
            
                                        do while NOT RSCategory.EOF
                                            if mCourseCategoryId = RSCategory("CategoryId") then
                                    %>
                                        <option value="<% response.write(RSCategory("CategoryId")) %>" selected>
                                            <% response.write(RSCategory("Category")) %></option>
                                        <% else %>
                                        <option value="<% response.write(RSCategory("CategoryId")) %>">
                                            <% response.write(RSCategory("Category")) %></option>
                                        <%
                                        end if
                                        RSCategory.MoveNext
                                        Loop
                
                                        RSCategory.Close
                                        Set RSCategory = Nothing
                                    %>
                                    </select>
                                </div>
                                <input type="submit" name="" id="" class="search-btn" value="Filter">
                            </form>

                            <form class="search" action="CourseDirectoryAdd.asp" method="POST" id="FormSubCatg">

                                <input type="hidden" value="<% response.write(mCourseCategoryId) %>"
                                    name="FormCourseCategoryId">

                                <div>
                                    <select name="FormCourseSubCategoryId" id="" class="search-bar"
                                        onchange="document.getElementById('FormSubCatg').submit()">
                                        <option value="-1">Select Sub Category</option>
                                        <%
                                        Dim RSSubCategory
                                        Set RSSubCategory = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSSubCategory.Open "SELECT SubCategoryId, SubCategory FROM ListCourseSubCategory" & ConditionCatg,Conn
            
                                        do while NOT RSSubCategory.EOF
                                        if mCourseSubCategoryId = RSSubCategory("SubCategoryId") then
                                        %>
                                        <option value="<% response.write(RSSubCategory("SubCategoryId")) %>" selected>
                                            <% response.write(RSSubCategory("SubCategory")) %></option>
                                        <% else %>
                                        <option value="<% response.write(RSSubCategory("SubCategoryId")) %>">
                                            <% response.write(RSSubCategory("SubCategory")) %></option>
                                        <%
                                        end if
                                        RSSubCategory.MoveNext
                                        Loop
                
                                        RSSubCategory.Close
                                        Set RSSubCategory = Nothing
                                        %>
                                    </select>
                                </div>
                                <input type="submit" name="" id="" class="search-btn" value="Filter">
                            </form>
                        </div>
                    </section>

                    <form action="CourseDirectorySave.asp" method="POST">
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label for="" class="input-heading">Course Name</label>
                                    <select name="FormCourseId" id="" class="form-control">
                                        <option value="-1">Select Course</option>
                                        <%
                                        Dim RSCourseName
                                        Set RSCourseName = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSCourseName.Open "SELECT CourseId, CourseName FROM CourseContent" & ConditionSubCatg,Conn
    
                                        do while NOT RSCourseName.EOF
                                    %>
                                        <option value="<% response.write(RSCourseName("CourseId")) %>">
                                            <% response.write(RSCourseName("CourseName")) %></option>
                                        <%
                                        RSCourseName.MoveNext
                                        Loop
                
                                        RSCourseName.Close
                                        Set RSCourseName = Nothing
                                    %>
                                    </select>
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
                                    <input type="date" name="FormStartDate" id="" class="form-control"
                                        value="<% response.write(Session("smStartDate")) %>">
                                </div>
                            </div>

                            <div class="col-4">
                                <div class="form-group">
                                    <label for="" class="input-heading">End Date</label>
                                    <input type="date" name="FormEndDate" id="" class="form-control"
                                        value="<% response.write(Session("smEndDate")) %>">
                                </div>
                            </div>

                            <div class="col-4">
                                <div class="form-group">
                                    <label for="" class="input-heading">Course Duration</label>
                                    <input type="text" name="FormCourseDuration" id="" class="form-control"
                                        value="<% response.write(Session("smDuration")) %>">
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
                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Time Slot</label>
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
                                </div>
                            </div>

                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Instructor Name</label>
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
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-6">
                                <span><% response.write(Session("sTimeSlotId")) %></span>
                            </div>
                            <div class="col-6">
                                <span><% response.write(Session("sConflictedInstructor")) %></span>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-4">
                                <div class="form-group">
                                    <label for="" class="input-heading">Room</label>
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
                                </div>
                            </div>

                            <div class="col-4">
                                <div class="form-group">
                                    <label for="" class="input-heading">Language</label>
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
                                </div>
                            </div>

                            <div class="col-4">
                                <div class="form-group">
                                    <label for="" class="input-heading">Max Enrollment</label>
                                    <input type="text" class="form-control" name="FormMaxEnrollment"
                                        value="<% response.write(Session("smMaxEnrollment")) %>">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-4">
                                <span><% response.write(Session("sConflictedRoom")) %></span>
                            </div>
                            <div class="col-4">
                                <span><% response.write(Session("sLanguageId")) %></span>
                            </div>
                            <div class="col-4">
                                <span><% response.write(Session("sMaxEnrollment")) %></span>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-4">
                                <div class="form-group">
                                    <label for="" class="input-heading">Enrollment Closing Date</label>
                                    <input type="date" class="form-control" name="FormEnrollmentClosingDate"
                                        value="<% response.write(Session("smClosingDate")) %>">
                                </div>
                            </div>

                            <div class="col-4">
                                <div class="form-group">
                                    <label for="" class="input-heading">Minimum Attendance %</label>
                                    <input type="text" class="form-control" name="FormMinAttendance"
                                        value="<% response.write(Session("smAttendance")) %>">
                                </div>
                            </div>

                            <div class="col-4">
                                <div class="form-group">
                                    <label for="" class="input-heading">Course Fee</label>
                                    <input type="text" class="form-control" name="FormCourseFee"
                                        value="<% response.write(Session("smCourseFee")) %>">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-4">
                                <span><% response.write(Session("sClosingDate")) %></span>
                            </div>
                            <div class="col-4">
                                <span><% response.write(Session("smAttendance")) %></span>
                            </div>
                            <div class="col-4">
                                <span><% response.write(Session("sCourseFee")) %></span>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg d-flex justify-content-center">
                                <input type="submit" value="Save" class="button">
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
<%
else
response.redirect("dashboard.asp")
end if
%>

</html>