<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->
<!--#include file=AppSetting.asp-->
<%
    Dim RSEnroll
    dim StdId

    StdId = request.QueryString("QsStdId")

    Set RSEnroll = Server.CreateObject("ADODB.RecordSet")
    RSEnroll.open "SELECT * FROM V_StudentCoursesView WHERE(StudentId = " & StdId & ")", conn
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <link rel="stylesheet" href="CSS/GlobalStyle.css">
    <link rel="stylesheet" href="CSS/StyleEditStudent.css">
    <title>Training Courses</title>
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
                            <a class="nav-link" href="ViewStudentDetail.asp?QsStdId=<% response.Write(StdId) %>">View
                                Student Detail</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="EditStudentDetail.asp?QsStdId=<% response.Write(StdId) %>">Edit
                                Student Detail</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link"
                                href="AcademicQualification.asp?QsStdId=<% response.Write(StdId) %>">Academic
                                Qualification</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link"
                                href="TechnicalQualification.asp?QsStdId=<% response.Write(StdId) %>">Technical
                                Qualification</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="WorkExperience.asp?QsStdId=<% response.Write(StdId) %>">Work
                                Experience</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active"
                                href="StudentCourse.asp?QsStdId=<% response.Write(StdId) %>">Training Courses</a>
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
                            <label for="">Courses Enrolled</label>
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <br>
                    <table class="table table-bordered table-hover" style="width: 100%;">
                        <thead class="thead-light">
                            <tr>
                                <th style="width: 0.5%;">Enrollment Id</th>
                                <th style="width: 10%;">Course Name</th>
                                <th style="width: 4%;">Start Date</th>
                                <th style="width: 4%;">End Date</th>
                                <th style="width: 4%;">Time Slot</th>
                                <th style="width: 2%;">Enrollment Status</th>
                            </tr>
                        </thead>

                        <tbody>
                            <% 
                                do while NOT RSEnroll.EOF
                            %>
                            <tr>
                                <td><a
                                        href="StudentCourseDetail.asp?StdEnrollId=<% response.write(RSEnroll("StdEnrollmentId")) %>"><% response.Write(RSEnroll("StdEnrollmentId")) %></a>
                                </td>
                                <td><% response.Write(RSEnroll("CourseName")) %></td>
                                <td><% response.Write(RSEnroll("StartDate")) %></td>
                                <td><% response.Write(RSEnroll("EndDate")) %></td>
                                <td><% response.Write(FormatDateTime(RSEnroll("StartTime"),3)& " - " & FormatDateTime(RSEnroll("EndTime"),3)) %>
                                </td>
                                <td><% response.Write(RSEnroll("EnrollmentStatus")) %></td>
                            </tr>
                            <%
                                RSEnroll.MoveNext
                                loop

                                RSEnroll.close
                                set RSEnroll = Nothing
                            %>
                        </tbody>
                    </table>
                </div>
            </div>

            <br>

        </div>
    </div>

    <footer>
        <!--#include file=Footer.asp-->
    </footer>
</body>
<script src="Scripts/AddNewStd.js"></script>
<script src="Scripts/Global.js"></script>

</html>