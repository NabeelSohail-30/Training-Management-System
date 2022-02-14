<!--#include file=../OpenDbConn.asp-->
<!--#include file=../ReValidateLogin.asp-->

<%
call OpenDbConn()
Dim RSEnrollmentDetail
Set RSEnrollmentDetail = Server.CreateObject("ADODB.RecordSet")

Dim CourseDirectoryId
Dim Filter
CourseDirectoryId = Request.Form("FormCourseDirectoryId")

if CourseDirectoryId <> "" or len(CourseDirectoryId) <> 0 then
    if IsNumeric(CourseDirectoryId) = False then
        response.write("<h1>Please Enter Valid Course Directory Id to View Report</h1>")
        response.end
    end if
end if

Filter = " WHERE (1=1) "

if CourseDirectoryId <> "" or len(CourseDirectoryId) <> 0 then
    Filter = Filter & " AND (CourseDirectoryId = " & cint(CourseDirectoryId) & ")"
else
    response.write("<h1>Please Enter Course Directory Id to View Report</h1>")
    response.end
end if

QryStr = "SELECT * FROM Rep_EnrollmentPerCourseDirectory " & Filter
RSEnrollmentDetail.Open QryStr, conn

%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../CSS/bootstrap.css">
    <link rel="stylesheet" href="../CSS/StyleReports.css">
    <title>Enrollment Detail Per Course Directory Report</title>
</head>

<body>
    <header>
        <h1 class="text-center">Training Management System</h1>
        <h3 class="text-center">Enrollment Detail Per Course Directory Report</h3>
    </header>

    <main>
        <div class="container-fluid">
            <div class="panel">

                <div class="panel-body">
                    <div class="row">
                        <div class="col-3">
                            <div class="form-group">
                                <label for="" class="input-heading">Corse Directory Id</label>
                                <label
                                    class="form-control label-data"><% response.Write(RSEnrollmentDetail("CourseDirectoryId")) %></label>
                            </div>
                        </div>

                        <div class="col-3">
                            <div class="form-group">
                                <label for="" class="input-heading">Course Code</label>
                                <label
                                    class="form-control label-data"><% response.Write(RSEnrollmentDetail("CourseCode")) %></label>
                            </div>
                        </div>

                        <div class="col-6">
                            <div class="form-group">
                                <label for="" class="input-heading">Course Name</label>
                                <label
                                    class="form-control label-data"><% response.Write(RSEnrollmentDetail("CourseName")) %></label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-3">
                            <div class="form-group">
                                <label for="" class="input-heading">Category</label>
                                <label
                                    class="form-control label-data"><% response.Write(RSEnrollmentDetail("Category")) %></label>
                            </div>
                        </div>

                        <div class="col-3">
                            <div class="form-group">
                                <label for="" class="input-heading">Sub Category</label>
                                <label
                                    class="form-control label-data"><% response.Write(RSEnrollmentDetail("SubCategory")) %></label>
                            </div>
                        </div>

                        <div class="col-3">
                            <div class="form-group">
                                <label for="" class="input-heading">Start Date</label>
                                <label
                                    class="form-control label-data"><% response.Write(RSEnrollmentDetail("StartDate")) %></label>
                            </div>
                        </div>

                        <div class="col-3">
                            <div class="form-group">
                                <label for="" class="input-heading">End Date</label>
                                <label
                                    class="form-control label-data"><% response.Write(RSEnrollmentDetail("EndDate")) %></label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-3">
                            <div class="form-group">
                                <label for="" class="input-heading">Time Slot</label>
                                <label
                                    class="form-control label-data"><% response.Write(FormatDateTime(RSEnrollmentDetail("StartTime"),3)& " - " & FormatDateTime(RSEnrollmentDetail("EndTime"),3)) %></label>
                            </div>
                        </div>

                        <div class="col-3">
                            <div class="form-group">
                                <label for="" class="input-heading">Instructor Name</label>
                                <label
                                    class="form-control label-data"><% response.Write(RSEnrollmentDetail("InstructorName")) %></label>
                            </div>
                        </div>

                        <div class="col-2">
                            <div class="form-group">
                                <label for="" class="input-heading">Room</label>
                                <label
                                    class="form-control label-data"><% response.Write(RSEnrollmentDetail("RoomNumber")) %></label>
                            </div>
                        </div>

                        <div class="col-2">
                            <div class="form-group">
                                <label for="" class="input-heading">Course Fee</label>
                                <label
                                    class="form-control label-data"><% response.Write(RSEnrollmentDetail("CourseFee") & " PKR") %></label>
                            </div>
                        </div>

                        <div class="col-2">
                            <div class="form-group">
                                <label for="" class="input-heading">Course Directory Status</label>
                                <label
                                    class="form-control label-data"><% response.Write(RSEnrollmentDetail("CourseDirectoryStatus")) %></label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <br>

            <div class="panel">


                <div class="panel-body">
                    <table class="table table-bordered" style="width: 98%;">
                        <thead>
                            <tr>
                                <th class="text-center">S.No.</th>
                                <th class="text-center">Gr Number</th>
                                <th class="text-center">First Name</th>
                                <th class="text-center">Last Name</th>
                                <th class="text-center">Father Name</th>
                                <th class="text-center">NIC Number</th>
                                <th class="text-center">Mobile Number</th>
                                <th class="text-center">Email Address</th>
                                <th class="text-center">Fee Paid</th>
                                <th class="text-center">Balance Fee</th>
                                <th class="text-center">Enrollment Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                Dim Counter
                                Dim TotBalanceFee
                                Dim TotPaidFee
                                TotBalanceFee = 0
                                TotPaidFee = 0

                                Counter = 1
                                do while NOT RSEnrollmentDetail.EOF
                                    TotBalanceFee = TotBalanceFee + cint(RSEnrollmentDetail("BalanceFee"))
                                    TotPaidFee = TotPaidFee + cint(RSEnrollmentDetail("PaidFee"))
                            %>
                            <tr>
                                <td><% response.write(Counter) %></td>
                                <td><% response.write(RSEnrollmentDetail("StdGrNumber")) %></td>
                                <td><% response.write(RSEnrollmentDetail("StdFirstName")) %></td>
                                <td><% response.write(RSEnrollmentDetail("StdLastName")) %></td>
                                <td><% response.write(RSEnrollmentDetail("FatherName")) %></td>
                                <td><% response.write(RSEnrollmentDetail("StdNICNumber")) %></td>
                                <td><% response.write(RSEnrollmentDetail("StdMobileNumber")) %></td>
                                <td><% response.write(RSEnrollmentDetail("StdEmailAddress")) %></td>
                                <td><% response.write(RSEnrollmentDetail("PaidFee")) %></td>
                                <td><% response.write(RSEnrollmentDetail("BalanceFee")) %></td>
                                <td><% response.write(RSEnrollmentDetail("EnrollmentStatus")) %></td>
                            </tr>
                            <%
                                    RSEnrollmentDetail.MoveNext
                                    Counter = Counter + 1
                                loop
            
                                RSEnrollmentDetail.close
                                set RSEnrollmentDetail = Nothing
                            %>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="5">
                                    <h5>Total Students Enrolled : <% response.write(Counter - 1) %></h5>
                                </td>
                                <td colspan="4" class="text-right">
                                    <h5>Total Paid Fee : PKR <% response.write(TotPaidFee) %></h5>
                                </td>
                                <td colspan="5">
                                    <h5>Total Balance Fee : PKR <% response.write(TotBalanceFee) %></h5>
                                </td>
                            </tr>
                        </tfoot>
                    </table>
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