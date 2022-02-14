<!--#include file=../OpenDbConn.asp-->
<!--#include file=../ReValidateLogin.asp-->

<%
call OpenDbConn()
Dim RSCourseDirectory
Set RSCourseDirectory = Server.CreateObject("ADODB.RecordSet")

Dim CourseDirectoryId
Dim Filter
CourseDirectoryId = Request.Form("FormCourseDirectoryId")

if CourseDirectoryId <> "" or len(CourseDirectoryId) <> 0 then
    if IsNumeric(CourseDirectoryId) = False then
        response.write("<h1>Please Enter Valid Course Directory Id to View Detailed Course Directory Report</h1>")
        response.end
    end if
end if

Filter = " WHERE (1=1) "

if CourseDirectoryId <> "" or len(CourseDirectoryId) <> 0 then
    Filter = Filter & " AND (CourseDirectoryId = " & cint(CourseDirectoryId) & ")"
else
    response.write("<h1>Please Enter Course Directory Id to View Detailed Course Directory Report</h1>")
    response.end
end if

QryStr = "SELECT * FROM Rep_CourseDirectoryDetailed" & Filter
RSCourseDirectory.Open QryStr, conn

Dim RSTotalEnrollment
Set RSTotalEnrollment = Server.CreateObject("ADODB.RecordSet")

QryStr = "SELECT Count(StudentId) AS TotalEnrollment FROM V_StdEnrollmentView WHERE(CourseDirectoryId = " & CourseDirectoryId & ")"
RSTotalEnrollment.Open QryStr, conn

Dim TotEnrollment
Dim EnrollmentAvailable
TotEnrollment = RSTotalEnrollment("TotalEnrollment")
EnrollmentAvailable = cint(RSCourseDirectory("MaxEnrollment")) - cint(TotEnrollment)

%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../CSS/bootstrap.css">
    <link rel="stylesheet" href="../CSS/StyleReports.css">
    <title>Course Directory Detailed Report</title>
</head>

<body>
    <header>
        <h1 class="text-center">Training Management System</h1>
        <h3 class="text-center">Course Directory Detailed Report</h3>
    </header>

    <main>
        <div class="container">
            <div class="panel-body">
                <div class="row">
                    <div class="col-4">
                        <div class="form-group">
                            <label for="" class="input-heading">Corse Directory Id</label>
                            <label
                                class="form-control label-data"><% response.Write(RSCourseDirectory("CourseDirectoryId")) %></label>
                        </div>
                    </div>

                    <div class="col-4">
                        <div class="form-group">
                            <label for="" class="input-heading">Course Id</label>
                            <label
                                class="form-control label-data"><% response.Write(RSCourseDirectory("CourseId")) %></label>
                        </div>
                    </div>

                    <div class="col-4">
                        <div class="form-group">
                            <label for="" class="input-heading">Course Code</label>
                            <label
                                class="form-control label-data"><% response.Write(RSCourseDirectory("CourseCode")) %></label>
                        </div>
                    </div>
                </div>

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
                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Category</label>
                            <label
                                class="form-control label-data"><% response.Write(RSCourseDirectory("Category")) %></label>
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Sub Category</label>
                            <label
                                class="form-control label-data"><% response.Write(RSCourseDirectory("SubCategory")) %></label>
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
                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Time Slot</label>
                            <label
                                class="form-control label-data"><% response.Write(FormatDateTime(RSCourseDirectory("StartTime"),3)& " - " & FormatDateTime(RSCourseDirectory("EndTime"),3)) %></label>
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Instructor Name</label>
                            <label
                                class="form-control label-data"><% response.Write(RSCourseDirectory("InstructorName")) %></label>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-4">
                        <div class="form-group">
                            <label for="" class="input-heading">Room</label>
                            <label
                                class="form-control label-data"><% response.Write(RSCourseDirectory("RoomNumber")) %></label>
                        </div>
                    </div>

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

                <div class="row">
                    <div class="col-4">
                        <div class="form-group">
                            <label for="" class="input-heading">Max Enrollment</label>
                            <label
                                class="form-control label-data"><% response.Write(RSCourseDirectory("MaxEnrollment")) %></label>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="form-group">
                            <label for="" class="input-heading">Total Enrollment</label>
                            <label class="form-control label-data"><% response.Write(TotEnrollment) %></label>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="form-group">
                            <label for="" class="input-heading">Enrollments Available</label>
                            <label class="form-control label-data"><% response.Write(EnrollmentAvailable) %></label>
                        </div>
                    </div>
                </div>


                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">User Created By</label>
                            <label
                                class="form-control label-data"><% response.Write(RSCourseDirectory("UserFullName")) %></label>
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Creation Date Time</label>
                            <label
                                class="form-control label-data"><% response.Write(RSCourseDirectory("CreationDateTime")) %></label>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">User Last Updated By</label>
                            <label
                                class="form-control label-data"><% response.Write(RSCourseDirectory("UpdatedUserFullName")) %></label>
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Last Updated Date Time</label>
                            <label
                                class="form-control label-data"><% response.Write(RSCourseDirectory("LastUpdatedDateTime")) %></label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

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