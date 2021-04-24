<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->
<%

call OpenDbConn()

Dim mStdEnrollmentId
Dim RSCourseDetail

mStdEnrollmentId = Request.QueryString("StdEnrollId")

Set RSCourseDetail = Server.CreateObject("ADODB.RecordSet")
QryStr = "SELECT * FROM V_StudentCourseDetailView WHERE(StdEnrollmentId = " & mStdEnrollmentId & ")"
RSCourseDetail.Open QryStr, conn

Dim mStudentId
Dim mCourseCode
Dim mCourseName
Dim mCourseCategory
Dim mCourseSubcategory
Dim mStartDate
Dim mEndDate
Dim mCourseDuration
Dim mStartTime
Dim mEndTime
Dim mCourseFee
Dim mCourseDirectoryStatus
Dim mFeeDiscount
Dim mActualFee
Dim mPaidFee
Dim mBalanceFee
Dim mIsFeePaid
Dim mEnrollmentStatus

mStudentId = RSCourseDetail("StudentId")
mCourseCode = RSCourseDetail("CourseCode")
mCourseName = RSCourseDetail("CourseName")
mCourseCategory = RSCourseDetail("Category")
mCourseSubcategory = RSCourseDetail("SubCategory")
mStartDate = RSCourseDetail("StartDate")
mEndDate = RSCourseDetail("EndDate")
mCourseDuration = RSCourseDetail("CourseDuration")
mStartTime = RSCourseDetail("StartTime")
mEndTime = RSCourseDetail("EndTime")
mCourseFee = RSCourseDetail("CourseFee")
mCourseDirectoryStatus = RSCourseDetail("CourseDirectoryStatus")
mFeeDiscount = RSCourseDetail("FeeDiscount")
mActualFee = RSCourseDetail("ActualFee")
mPaidFee = RSCourseDetail("PaidFee")
mBalanceFee = RSCourseDetail("BalanceFee")
mIsFeePaid = RSCourseDetail("IsFeePaid")
mEnrollmentStatus = RSCourseDetail("EnrollmentStatus")

%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Training Course Detail</title>
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <link rel="stylesheet" href="CSS/GlobalStyle.css">
    <link rel="stylesheet" href="CSS/StyleStdCourseDetail.css">
</head>

<body>
    <header>
        <!--#include file=Header.asp-->
    </header>

    <div class="wrapper">
        <div class="container-fluid">
            <div class="panel">
                <div class="panel-head">
                    <div class="row">
                        <div class="col">
                            <label for="">View Student Course Detail</label>
                        </div>
                    </div>
                </div>

                <div class="panel-body">

                    <div class="row mt-3">
                        <div class="col-3">
                            <div class="form-group">
                                <label for="" class="input-heading">Course Code</label>
                                <label for="" class="form-control"><% response.Write(mCourseCode) %></label>
                            </div>
                        </div>

                        <div class="col-9">
                            <div class="form-group">
                                <label for="" class="input-heading">Course Name</label>
                                <label for="" class="form-control"><% response.Write(mCourseName) %></label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-6">
                            <div class="form-group">
                                <label for="" class="input-heading">Course Category</label>
                                <label for="" class="form-control"><% response.Write(mCourseCategory) %></label>
                            </div>
                        </div>

                        <div class="col-6">
                            <div class="form-group">
                                <label for="" class="input-heading">Sub Category</label>
                                <label for="" class="form-control"><% response.Write(mCourseSubcategory) %></label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Start Date</label>
                                <label class="form-control"><% response.Write(mStartDate) %></label>
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">End Date</label>
                                <label class="form-control"><% response.Write(mEndDate) %></label>
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Course Duration</label>
                                <label class="form-control"><% response.Write(mCourseDuration) %></label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Time Slot</label>
                                <label for=""
                                    class="form-control"><% response.Write(FormatDateTime(mStartTime, 3) & " - " & FormatDateTime(mEndTime, 3)) %></label>
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Course Fee</label>
                                <label for="" class="form-control"><% response.Write(mCourseFee) %></label>
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Course Directory Status</label>
                                <label for="" class="form-control"><% response.Write(mCourseDirectoryStatus) %></label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Fee Discount</label>
                                <label for="" class="form-control"><% response.Write(mFeeDiscount) %></label>
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Actual Fee</label>
                                <label for="" class="form-control"><% response.Write(mActualFee) %></label>
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Paid Fee</label>
                                <label for="" class="form-control"><% response.Write(mPaidFee) %></label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Balance Fee</label>
                                <label for="" class="form-control"><% response.Write(mBalanceFee) %></label>
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Is Fee Paid</label>
                                <label for="" class="form-control"><% response.Write(mIsFeePaid) %></label>
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Enrollment Status</label>
                                <label for="" class="form-control"><% response.Write(mEnrollmentStatus) %></label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg d-flex justify-content-center text-center">
                            <a href="StudentCourse.asp?QsStdId=<% response.Write(mStudentId) %>" class="button">Back to
                                Grid</a>
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

</html>