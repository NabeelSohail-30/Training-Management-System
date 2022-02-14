<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->

<%
call OpenDbConn()
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <link rel="stylesheet" href="CSS/GlobalStyle.css">
    <link rel="stylesheet" href="CSS/StyleAddCourseDir.css">
    <title>Reports</title>
    <style>
        a.button {
            width: 90%;
            font-weight: bold;
            text-align: center;
            vertical-align: middle;
        }
    </style>
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
                    Report Filter
                </div>

                <div class="panel-body">
                    <section class="action">
                        <div>
                            <form class="search" action="" method="POST" id="FilterForm" target="_blank">
                                <div class="row">
                                    <div>
                                        <input type="search" class="search-bar" placeholder="Course Directory Id"
                                            name="FormCourseDirectoryId">
                                    </div>
                                    <div>
                                        <input type="search" class="search-bar" placeholder="Search By Course Name"
                                            name="FormCourseName">
                                    </div>
                                    <div>
                                        <input type="date" class="search-bar" placeholder="Search By Start Date"
                                            name="FormStartDate">
                                    </div>
                                    <div>
                                        <input type="date" class="search-bar" placeholder="Search By End Date"
                                            name="FormEndDate">
                                    </div>
                                </div>

                                <div class="row">
                                    <div>
                                        <select name="FormCourseCategoryId" id="" class="search-bar"
                                            style="width: auto;">
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
                                        Set RSNationality = Nothing
                                    %>
                                        </select>
                                    </div>
                                    <div>
                                        <select name="FormCourseSubCategoryId" id="" class="search-bar"
                                            style="width: auto;">
                                            <option value="-1">Select Sub Category</option>
                                            <%
                                        Dim RSSubCategory
                                        Set RSSubCategory = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSSubCategory.Open "SELECT SubCategoryId, SubCategory FROM ListCourseSubCategory",Conn
            
                                        do while NOT RSSubCategory.EOF
                                            if mCourseSubCategoryId = RSSubCategory("SubCategoryId") then
                                    %>
                                            <option value="<% response.write(RSSubCategory("SubCategoryId")) %>"
                                                selected>
                                                <% response.write(RSSubCategory("SubCategory")) %></option>
                                            <% else %>
                                            <option value="<% response.write(RSSubCategory("SubCategoryId")) %>">
                                                <% response.write(RSSubCategory("SubCategory")) %></option>
                                            <%
                                            end if
                                        RSSubCategory.MoveNext
                                        Loop
                
                                        RSSubCategory.Close
                                        Set RSNationality = Nothing
                                    %>
                                        </select>
                                    </div>
                                    <div>
                                        <select name="FormInstructorId" id="" class="search-bar" style="width: auto;">
                                            <option value="-1">Select Instructor</option>
                                            <%
                                        Dim RSInstructor
                                        Set RSInstructor = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSInstructor.Open "SELECT InstructorId, InstructorName FROM ListInstructor",Conn
            
                                        do while NOT RSInstructor.EOF
                                    %>
                                            <option value="<% response.write(RSInstructor("InstructorId")) %>">
                                                <% response.write(RSInstructor("InstructorName")) %></option>
                                            <%
                                        RSInstructor.MoveNext
                                        Loop
                
                                        RSInstructor.Close
                                        Set RSNationality = Nothing
                                    %>
                                        </select>
                                    </div>
                                    <div>
                                        <select name="FormTimeSlotId" id="" class="search-bar" style="width: auto;">
                                            <option value="-1">Select Time Slot</option>
                                            <%
                                        Dim RSTimeSlot
                                        Set RSTimeSlot = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSTimeSlot.Open "SELECT TimeSlotId, StartTime, EndTime FROM ListTimeSlot",Conn
            
                                        do while NOT RSTimeSlot.EOF
                                    %>
                                            <option value="<% response.write(RSTimeSlot("TimeSlotId")) %>">
                                                <% response.write(FormatDateTime(RSTimeSlot("StartTime"),3)& " - " & FormatDateTime(RSTimeSlot("EndTime"),3)) %>
                                            </option>
                                            <%    
                                        RSTimeSlot.MoveNext
                                        Loop
                
                                        RSTimeSlot.Close
                                        Set RSNationality = Nothing
                                    %>
                                        </select>
                                    </div>
                                </div>

                                <div class="row">
                                    <div>
                                        <select name="FormRoomId" id="" class="search-bar" style="width: auto;">
                                            <option value="-1">Select Room Number</option>
                                            <%
                                        Dim RSRoom
                                        Set RSRoom = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSRoom.Open "SELECT RoomId, RoomNumber FROM ListRoom",Conn
            
                                        do while NOT RSRoom.EOF
                                            if mRoomId = RSRoom("RoomId") then
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

                                    <div>
                                        <select name="FormCourseDirectoryStatus" id="" class="search-bar"
                                            style="width: auto;">
                                            <option value="-1">Select Course Directory Status</option>
                                            <%
                                        Dim RSStatus
                                        Set RSStatus = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSStatus.Open "SELECT CourseDirectoryStatusId, CourseDirectoryStatus FROM ListCourseDirectoryStatus",Conn
            
                                        do while NOT RSStatus.EOF
                                            if mStatusId = RSStatus("CourseDirectoryStatusId") then
                                    %>
                                            <option value="<% response.write(RSStatus("CourseDirectoryStatusId")) %>"
                                                selected>
                                                <% response.write(RSStatus("CourseDirectoryStatus")) %></option>
                                            <% else %>
                                            <option value="<% response.write(RSStatus("CourseDirectoryStatusId")) %>">
                                                <% response.write(RSStatus("CourseDirectoryStatus")) %></option>
                                            <%
                                            end if
                                        RSStatus.MoveNext
                                        Loop
                
                                        RSStatus.Close
                                        Set RSStatus = Nothing
                                    %>
                                        </select>
                                    </div>

                                    <div>
                                        <select name="FormEnrollmentStatus" id="" class="search-bar"
                                            style="width: auto;">
                                            <option value="-1">Select Enrollment Status</option>
                                            <%
                                        Dim RSeStatus
                                        Set RSeStatus = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSeStatus.Open "SELECT EnrollmentStatusId, EnrollmentStatus FROM ListEnrollmentStatus",Conn
            
                                        do while NOT RSeStatus.EOF
                                    %>
                                            <option value="<% response.write(RSeStatus("EnrollmentStatusId")) %>">
                                                <% response.write(RSeStatus("EnrollmentStatus")) %></option>
                                            <%
                                        RSeStatus.MoveNext
                                        Loop
                
                                        RSeStatus.Close
                                        Set RSeStatus = Nothing
                                    %>
                                        </select>
                                    </div>

                                    <div>
                                        <select name="FormIsFeePaid" id="" class="search-bar" style="width: auto;">
                                            <option value="-1">Select Fee Status</option>
                                            <option value="1">Fee Paid</option>
                                            <option value="0">Fee Not Paid</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col d-flex justify-content-center">
                                        <a class="button">Clear Filter</a>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </section>
                </div>
            </div>

            <div class="panel">
                <br>
                <div class="panel-head">
                    Course Directory Reports
                </div>

                <div class="panel-body">
                    <br>
                    <div class="row">
                        <div class="col-3 d-flex justify-content-center">
                            <a class="button" onclick="FormSubmit('Reports/RepCourseDirectory.asp');">Course
                                Directory</a>
                        </div>
                        <div class="col-3 d-flex justify-content-center">
                            <a href="#" class="button"
                                onclick="FormSubmit('Reports/RepCourseDirectoryDetailed.asp');">Detailed
                                Course Directory</a>
                        </div>
                        <div class="col-3 d-flex justify-content-center">
                            <a href="#" class="button"
                                onclick="FormSubmit('Reports/RepCourseDirectoryByCategory.asp');">Course
                                Directory by Category</a>
                        </div>
                        <div class="col-3 d-flex justify-content-center">
                            <a href="#" class="button"
                                onclick="FormSubmit('Reports/RepCourseDirectoryBySubCatg.asp');">Course
                                Directory by Sub Category</a>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-3 d-flex justify-content-center">
                            <a href="#" class="button"
                                onclick="FormSubmit('Reports/RepCourseDirectoryByTS.asp');">Course
                                Directory by Time Slot</a>
                        </div>
                        <div class="col-3 d-flex justify-content-center">
                            <a href="#" class="button"
                                onclick="FormSubmit('Reports/RepCourseDirectoryByInstructor.asp');">Course
                                Directory by Instructor</a>
                        </div>
                        <div class="col-3 d-flex justify-content-center">
                            <a href="#" class="button"
                                onclick="FormSubmit('Reports/RepCourseDirectoryByRoom.asp');">Course
                                Directory by Room</a>
                        </div>
                        <div class="col-3 d-flex justify-content-center">
                            <a href="#" class="button"
                                onclick="FormSubmit('Reports/RepCourseDirectoryByStatus.asp');">Course
                                Directory by Status</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="panel">
                <br>
                <div class="panel-head">
                    Enrollment Detail Reports
                </div>

                <div class="panel-body">
                    <br>
                    <div class="row">
                        <div class="col-3 d-flex justify-content-center">
                            <a class="button"
                                onclick="FormSubmit('Reports/RepEnrollmentPerCourseDirectory.asp');">Enrollment Detail
                                Per Course Directory</a>
                        </div>
                        <div class="col-3 d-flex justify-content-center">
                            <a href="#" class="button"
                                onclick="FormSubmit('Reports/RepEnrollmentByCourseDirectory.asp');">Enrollment Detail
                                By Course Directory</a>
                        </div>
                        <div class="col-3 d-flex justify-content-center">
                            <a href="#" class="button"
                                onclick="FormSubmit('Reports/RepEnrollmentByEnrollmentStatus.asp');">Enrollment Detail
                                By Enrollment Status</a>
                        </div>
                        <div class="col-3 d-flex justify-content-center">
                            <a href="#" class="button"
                                onclick="FormSubmit('Reports/RepEnrollmentByIsFeePaid.asp');">Enrollment Detail
                                By Is Fee Paid</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer>
        <!--#include file=Footer.asp-->
    </footer>

</body>
<script>
    function FormSubmit(SubmitUrl) {
        var FilterForm = document.getElementById('FilterForm');
        FilterForm.setAttribute("action", SubmitUrl);
        //console.log(SubmitUrl);
        FilterForm.submit();
    }
</script>

</html>