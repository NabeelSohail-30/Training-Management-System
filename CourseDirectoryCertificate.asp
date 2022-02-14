<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->
<%

call OpenDbConn()
Dim RSCourseDirectory
CourseDirectoryId = Request.QueryString("QsId")
Set RSCourseDirectory = Server.CreateObject("ADODB.RecordSet")
QryStr = "SELECT * FROM V_CourseDirectoryView WHERE(CourseDirectoryId = " & CourseDirectoryId & ")"
RSCourseDirectory.Open QryStr, conn


Dim RSEnroll
Set RSEnroll = Server.CreateObject("ADODB.RecordSet")
RSEnroll.open "SELECT * FROM V_StdEnrollmentView WHERE(CourseDirectoryId = " & CourseDirectoryId & ") AND (EnrollmentStatusId = 5)", conn

if Session("SUserRoleId") <> 2 then
if Request.QueryString("QsIssue") = 1 then
    Dim StdEnrollmentId
    StdEnrollmentId = Request.QueryString("QsStdEnrollmentId")

    QryStr = "UPDATE StudentEnrollment SET IsCertificateIssued = 1, CertificateIssueDate = '" & Now() & "', UserLastUpdatedBy = " & Session("SUserId") &_
                ", LastUpdatedDateTime = '" & Now() & "' WHERE (StdEnrollmentId = " & StdEnrollmentId & ") AND (CourseDirectoryId = " & CourseDirectoryId & ")"
    'response.write(QryStr)
    Conn.execute QryStr
    Response.Redirect("CourseDirectoryCertificate.asp?QsId=" & CourseDirectoryId)
end if

if Request.QueryString("QsIssue") = 2 then

    'Update All - Method 01
    QryStr = "UPDATE StudentEnrollment SET IsCertificateIssued = 1, CertificateIssueDate = '" & Now() & "', UserLastUpdatedBy = " & Session("SUserId") &_
            ", LastUpdatedDateTime = '" & Now() & "' WHERE(CourseDirectoryId = " & CourseDirectoryId & ") AND (EnrollmentStatusId = 5) AND (IsCertificateIssued = 'False')"
        
    conn.execute QryStr

    'Dim RSIssueCertificate
    'Set RSIssueCertificate = Server.CreateObject("ADODB.RecordSet")
    'RSIssueCertificate.open "SELECT StdEnrollmentId FROM V_StdEnrollmentView WHERE(CourseDirectoryId = " & CourseDirectoryId & ") AND (EnrollmentStatusId = 5) AND (IsCertificateIssued = 'False')", conn


    'do while NOT RSIssueCertificate.EOF
    '    QryStr = "UPDATE StudentEnrollment SET IsCertificateIssued = 1, CertificateIssueDate = '" & Now() & "', UserLastUpdatedBy = " & Session("SUserId") &_
    '    ", LastUpdatedDateTime = '" & Now() & "' WHERE (StdEnrollmentId = " & RSIssueCertificate("StdEnrollmentId") & ") AND (CourseDirectoryId = " & CourseDirectoryId & ")"
        'response.write("<br>")
        'response.write(QryStr)
    '    conn.execute QryStr
    '    RSIssueCertificate.MoveNext
    'loop

    Response.Redirect("CourseDirectoryCertificate.asp?QsId=" & CourseDirectoryId)
end if
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
    <title>Course Directory Certificate</title>
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
                            <a class="nav-link"
                                href="CourseDirectoryAttendance.asp?QsId=<% response.Write(RSCourseDirectory("CourseDirectoryId")) %>">Attendance</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link active"
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

            <div class="panel">
                <br>
                <div class="panel-head">
                    <div class="row">
                        <div class="col">
                            <label for="">Course Enrolled Students</label>
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <br>

                    <% if Session("SUserRoleId") <> 2 then %>
                    <div class="row">
                        <div class="col-lg d-flex justify-content-center text-center">
                            <a href="CourseDirectoryCertificate.asp?QsIssue=2&QsId=<% response.write(CourseDirectoryId) %>"
                                class="button" style="width: 20%;">Issue Certificate to All</a>
                        </div>
                    </div>
                    <% end if %>

                    <table class="table table-bordered table-hover" style="width: 100%;">
                        <thead class="thead-light">
                            <tr>
                                <th style="width: 2%;">GR Number</th>
                                <th style="width: 5%;">First Name</th>
                                <th style="width: 5%;">Last Name</th>
                                <th style="width: 6%;">NIC</th>
                                <th style="width: 5%;">Father Name</th>
                                <th style="width: 2%;">Is Fee Paid</th>
                                <th style="width: 2%;">Is Certificate Issued</th>
                                <th style="width: 2%;">Status</th>
                                <th style="width: 3%;"></th>
                            </tr>
                        </thead>

                        <tbody>
                            <% 
                            do while NOT RSEnroll.EOF
                            %>
                            <tr>
                                <td><% response.Write(RSEnroll("StdGrNumber")) %></td>
                                <td><% response.Write(RSEnroll("StdFirstName")) %></td>
                                <td><% response.Write(RSEnroll("StdLastName")) %></td>
                                <td><% response.Write(RSEnroll("StdNICNumber")) %></td>
                                <td><% response.Write(RSEnroll("FatherName")) %></td>
                                <td><% response.Write(RSEnroll("IsFeePaid")) %></td>
                                <td><% response.Write(RSEnroll("IsCertificateIssued")) %></td>
                                <td><% response.Write(RSEnroll("EnrollmentStatus")) %></td>
                                <td>
                                    <% if Session("SUserRoleId") <> 2 then %>
                                    <% if (RSEnroll("IsFeePaid") = "True") AND (RSEnroll("IsCertificateIssued") = "False") then %>
                                    <a
                                        href="CourseDirectoryCertificate.asp?QsIssue=1&QsId=<% response.write(CourseDirectoryId) %>&QsStdEnrollmentId=<% response.write(RSEnroll("StdEnrollmentId")) %>">Issue
                                        Certificate</a>
                                    <% end if %>
                                    <% end if %>
                                </td>
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
        </div>
    </div>

    <footer>
        <!--#include file=Footer.asp-->
    </footer>
</body>

</html>