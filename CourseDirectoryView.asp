<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->
<%

call OpenDbConn()
Dim RSCourseDirectory
CourseDirectoryId = Request.QueryString("QsId")
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
                            <a class="nav-link active"
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
                            <a class="nav-link"
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

            <br>

            <div class="panel">
                <br>
                <div class="panel-head">
                    <div class="row">
                        <div class="col">
                            <label for="">View Course Directory</label>
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
                                    class="form-control"><% response.Write(RSCourseDirectory("CourseName")) %></label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Start Date</label>
                                <label class="form-control"><% response.Write(RSCourseDirectory("StartDate")) %></label>
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">End Date</label>
                                <label class="form-control"><% response.Write(RSCourseDirectory("EndDate")) %></label>
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Course Duration</label>
                                <label
                                    class="form-control"><% response.Write(RSCourseDirectory("CourseDuration")) %></label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Time Slot</label>
                                <label
                                    class="form-control"><% response.Write(FormatDateTime(RSCourseDirectory("StartTime"),3)& " - " & FormatDateTime(RSCourseDirectory("EndTime"),3)) %></label>
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Instructor Name</label>
                                <label
                                    class="form-control"><% response.Write(RSCourseDirectory("InstructorName")) %></label>
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Room</label>
                                <label
                                    class="form-control"><% response.Write(RSCourseDirectory("RoomNumber")) %></label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Language</label>
                                <label class="form-control"><% response.Write(RSCourseDirectory("Language")) %></label>
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Minimum Attendance %</label>
                                <label
                                    class="form-control"><% response.Write(RSCourseDirectory("MinAttendancePercentage")) %></label>
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Max Enrollment</label>
                                <label
                                    class="form-control"><% response.Write(RSCourseDirectory("MaxEnrollment")) %></label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Enrollment Closing Date</label>
                                <label
                                    class="form-control"><% response.Write(RSCourseDirectory("EnrollmentClosingDate")) %></label>
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Course Fee</label>
                                <label
                                    class="form-control"><% response.Write(RSCourseDirectory("CourseFee") & " PKR") %></label>
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Course Directory Status</label>
                                <label
                                    class="form-control"><% response.Write(RSCourseDirectory("CourseDirectoryStatus")) %></label>
                            </div>
                        </div>
                    </div>
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