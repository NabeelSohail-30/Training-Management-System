<!--#include file=../OpenDbConn.asp-->
<!--#include file=../ReValidateLogin.asp-->

<%
call OpenDbConn()
Dim RSCourseDirectory
Set RSCourseDirectory = Server.CreateObject("ADODB.RecordSet")
Dim Counter
Dim TotalRecords
TotalRecords = 0

Dim Filter
Dim CourseDirectoryId
Dim CourseName
Dim StartDate
Dim EndDate
Dim CategoryId
Dim SubCategoryId
Dim InstructorId
Dim TimeSlotId
Dim RoomId
Dim StatusId

CourseDirectoryId = Request.Form("FormCourseDirectoryId")
CourseName = Request.Form("FormCourseName")
StartDate = Request.Form("FormStartDate")
EndDate = Request.Form("FormEndDate")
CategoryId = Request.Form("FormCourseCategoryId")
SubCategoryId = Request.Form("FormCourseSubCategoryId")
InstructorId = Request.Form("FormInstructorId")
TimeSlotId = Request.Form("FormTimeSlotId")
RoomId = Request.Form("FormRoomId")
StatusId = Request.Form("FormCourseDirectoryStatus")

if CourseDirectoryId <> "" or len(CourseDirectoryId) <> 0 then
    if IsNumeric(CourseDirectoryId) = False then
        CourseDirectoryId = 0
    end if
end if

Filter = " WHERE (1=1) "

if CourseDirectoryId <> "" or len(CourseDirectoryId) <> 0 then
    Filter = Filter & " AND (CourseDirectoryId = " & cint(CourseDirectoryId) & ")"
end if

if CourseName <> "" or len(CourseName) <> 0 then
    Filter = Filter & " AND (CourseName LIKE '%" & CourseName & "%')"
end if

if (StartDate <> "" or len(StartDate) <> 0) AND (EndDate <> "" or len(EndDate) <> 0) then
    Filter = Filter & " AND (StartDate <= '" & EndDate & "')"
    Filter = Filter & " AND (EndDate >= '" & StartDate & "')"
end if

if (StartDate <> "" or len(StartDate) <> 0) AND (EndDate = "" or len(EndDate) = 0) then
    Filter = Filter & " AND (StartDate >= '" & StartDate & "')"
end if

if (EndDate <> "" or len(EndDate) <> 0) AND (StartDate = "" or len(StartDate) = 0) then
    Filter = Filter & " AND (EndDate <= '" & EndDate & "')"
end if

if cint(CategoryId) <> -1 then
    Filter = Filter & " AND (CategoryId = " & cint(CategoryId) & ")"
end if

if cint(SubCategoryId) <> -1 then
    Filter = Filter & " AND (SubCategoryId = " & cint(SubCategoryId) & ")"
end if

if cint(InstructorId) <> -1 then
    Filter = Filter & " AND (InstructorId = " & cint(InstructorId) & ")"
end if

if cint(TimeSlotId) <> -1 then
    Filter = Filter & " AND (TimeSlotId = " & cint(TimeSlotId) & ")"
end if

if cint(RoomId) <> -1 then
    Filter = Filter & " AND (RoomId = " & cint(RoomId) & ")"
end if

if cint(StatusId) <> -1 then
    Filter = Filter & " AND (CourseDirectoryStatusId = " & cint(StatusId) & ")"
end if

QryStr = "SELECT * FROM Rep_CourseDirectory " & Filter & " Order by RoomNumber"
RSCourseDirectory.Open QryStr, conn
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../CSS/bootstrap.css">
    <link rel="stylesheet" href="../CSS/StyleReports.css">
    <title>Course Directory By Room Number</title>
</head>

<body>
    <header>
        <h1 class="text-center">Training Management System</h1>
        <h3 class="text-center">Course Directory by Room Number</h3>
    </header>

    <%
        dim mRoom
        do while NOT RSCourseDirectory.EOF
            mRoom = RSCourseDirectory("RoomNumber")
            if mRoom = "" then 
                exit do
            end if
    %>
    <main>
        <table class="table table-bordered" style="width: 95%;">
            <h4 class="text-center mt-2">Room : <% response.write(mRoom) %></h4>
            <thead>
                <tr>
                    <th class="text-center">S.No.</th>
                    <th class="text-center">Course Directory Id</th>
                    <th class="text-center">Course Name</th>
                    <th class="text-center">Category</th>
                    <th class="text-center">Sub Category</th>
                    <th class="text-center">Start Date</th>
                    <th class="text-center">End Date</th>
                    <th class="text-center">Time Slot</th>
                    <th class="text-center">Instructor</th>
                    <!--<th class="text-center">Room</th>-->
                    <th class="text-center">Course Directory Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                            
                Counter = 1
                do while RSCourseDirectory("RoomNumber") = (mRoom)
                %>
                <tr>
                    <td class="text-center"><% response.Write(Counter) %></td>
                    <td class="text-center"><% response.Write(RSCourseDirectory("CourseDirectoryId")) %></td>
                    <td><% response.Write(RSCourseDirectory("CourseName")) %></td>
                    <td><% response.Write(RSCourseDirectory("Category")) %></td>
                    <td><% response.Write(RSCourseDirectory("SubCategory")) %></td>
                    <td class="text-center"><% response.Write(RSCourseDirectory("StartDate")) %></td>
                    <td class="text-center"><% response.Write(RSCourseDirectory("EndDate")) %></td>
                    <td class="text-center">
                        <% response.Write(FormatDateTime(RSCourseDirectory("StartTime"),3)& " - " & FormatDateTime(RSCourseDirectory("EndTime"),3)) %>
                    </td>
                    <td><% response.Write(RSCourseDirectory("InstructorName")) %></td>
                    <!--<td class="text-center"><% response.Write(RSCourseDirectory("RoomNumber")) %></td>-->
                    <td><% response.Write(RSCourseDirectory("CourseDirectoryStatus")) %></td>
                </tr>
                <%
                                RSCourseDirectory.MoveNext
                                Counter = Counter + 1
                                TotalRecords = TotalRecords + 1
                                if RSCourseDirectory.EOF then
                                    exit do
                                end if
                            loop

                        'RSCourseDirectory.MoveNext
                        %>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="11">
                        <h5>Total Course Directories for Room (<% response.Write(mRoom) %>) :
                            <% response.write(Counter - 1) %></h5>
                    </td>
                </tr>
            </tfoot>
        </table>
        <hr>
    </main>
    <%
    loop

    RSCourseDirectory.close
    set RSCourseDirectory = Nothing
    %>

    <footer>
        <div class="row" style="padding-bottom: 12px;">
            <div class="col text-center" style="font-size: small;">
                Copyright &copy; 2020 - <% response.write(Year(Date()))%>, Training Management System. All
                Rights
                Reserved
            </div>
        </div>
    </footer>
</body>

</html>