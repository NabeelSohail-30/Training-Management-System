<!--#include file=../OpenDbConn.asp-->
<!--#include file=../ReValidateLogin.asp-->

<%
call OpenDbConn()
Dim RSEnrollmentDetail
Set RSEnrollmentDetail = Server.CreateObject("ADODB.RecordSet")

Dim Filter

QryStr = "SELECT * FROM Rep_EnrollmentPerCourseDirectory ORDER BY IsFeePaid"
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
    <title>Enrollment Detail By Is Fee Paid</title>
</head>

<body>
    <header>
        <h1 class="text-center">Training Management System</h1>
        <h3 class="text-center">Enrollment Detail By Is Fee Paid</h3>
    </header>

    <main>
        <div class="container-fluid">
            <%
                dim mIsFeePaid
                do while NOT RSEnrollmentDetail.EOF
                    mIsFeePaid = RSEnrollmentDetail("IsFeePaid")
            %>
            <br>
            <div class="panel">
                <div class="panel-head">
                    Fee Paid : <% response.write(mIsFeePaid) %>
                </div>

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
                                do while RSEnrollmentDetail("IsFeePaid") = mIsFeePaid
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
                                    if RSEnrollmentDetail.EOF then
                                        exit do
                                    end if
                                loop
                            %>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="5">
                                    <%
                                        if mIsFeePaid then 
                                    %>
                                    <h5>Total Students for (Fee Paid) :
                                        <% response.write(Counter - 1) %></h5>
                                    <% else %>
                                    <h5>Total Students for (Fee Not Paid) :
                                        <% response.write(Counter - 1) %></h5>
                                    <% end if %>
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
            <hr>
            <%
                loop

                RSEnrollmentDetail.close
                set RSEnrollmentDetail = Nothing
            %>
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