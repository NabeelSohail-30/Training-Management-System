<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->
<%

call OpenDbConn()
Dim RSCourseDirectory
CourseDirectoryId = Request.QueryString("QsId")
Set RSCourseDirectory = Server.CreateObject("ADODB.RecordSet")
QryStr = "SELECT * FROM V_CourseDirectoryView WHERE(CourseDirectoryId = " & CourseDirectoryId & ")"
RSCourseDirectory.Open QryStr, conn

Dim LastEnrollmentDate
Dim MaxEnrollment
Dim cStartDate
Dim cEndDate
Dim EnrollmentStatus

Set RSTotalEnrollment = Server.CreateObject("ADODB.RecordSet")
QryStr = "SELECT Count(StudentId) AS TotalEnrollment FROM V_StdEnrollmentView WHERE(CourseDirectoryId = " & CourseDirectoryId & ")"
RSTotalEnrollment.Open QryStr, conn
Dim TotEnrollment
Dim EnrollmentAvailable


LastEnrollmentDate = RSCourseDirectory("EnrollmentClosingDate")
MaxEnrollment = RSCourseDirectory("MaxEnrollment")
TotEnrollment = RSTotalEnrollment("TotalEnrollment")
EnrollmentAvailable = cint(RSCourseDirectory("MaxEnrollment")) - cint(TotEnrollment)

'response.write(cdate(LastEnrollmentDate))
'response.write("<br>")
'response.write(cdate(Date()))
'response.write(cdate(Date()) < cdate(LastEnrollmentDate))

Dim RSEnroll
Set RSEnroll = Server.CreateObject("ADODB.RecordSet")
RSEnroll.open "SELECT * FROM V_StdEnrollmentView WHERE(CourseDirectoryId = " & CourseDirectoryId & ")", conn

dim CourseFee
CourseFee = RSCourseDirectory("CourseFee")

'Declaring Variables of Student Filtration
    dim mStudentId
    dim StdGrNumber
    dim StdFirstName
    dim StdNICNumber
    dim StdLastName
    dim StdEmailAddress
    dim StdFatherName

    dim StdNotFound
    StdNotFound = ""
'end

'Start Student Filtration for Enrollment
if Request.QueryString("Filter")= "1" AND (Request("FormGrNumber") <> "" or Request("FormStdNIC") <> "" or Request("FormStdEmail") <> "") then
    FilterStudent()
end if
'End Student Filtration for Enrollment

if Request.QueryString("Enroll")= "1" AND (Request.Form("FormStudentId") <> "") then
    'Variables Declaration
        dim eStudentId
        dim eStdGrNumber
        dim eStdNicNumber
        dim eStdEmailAddress
        dim mCourseDirectoryId
        dim mCourseFee
        dim mFeeDiscountPercent
        dim mFeeDiscount
        dim mActualFee
        dim mPaidFee
        dim mBalanceFee
        dim mIsFeePaid
        dim mEnrollmentStatusId
        dim mUserCreatedBy
        dim EnrollmentErrorFound
        dim mLastEnrollmentDate
        
        Session("sFeeDiscountPercentage") = ""
        Session("sFeeDiscount") = ""
        Session("sPaidFee") = ""
    'end

    'Variables Initialization
        eStudentId = request.form("FormStudentId")
        eStdGrNumber = request.form("eFormGrNumber")
        eStdNicNumber = request.form("eFormStdNic")
        eStdEmailAddress = request.form("eFormStdEmail")
        mCourseDirectoryId = request.form("FormCourseDirectoryId")
        mCourseFee = cdbl(request.form("FormCourseFee"))
        mFeeDiscountPercent = request.form("FormFeeDiscountPercentage")
        mFeeDiscount = request.form("FormFeeDiscount")
        mPaidFee = request.form("FormFeePaid")
        mLastEnrollmentDate = request.form("FormLastEnrollmentDate")
        mEnrollmentStatusId = 1
        EnrollmentErrorFound = 0
        mUserCreatedBy = Session("SUserId")
    'end

    'Validating Maximum Enrollment
        Dim RSMaxEnrollment
        Dim TotalEnrollment
        Session("sDuplicateEnrollment") = ""

        Set RSMaxEnrollment = Server.CreateObject("ADODB.RecordSet")
        RSMaxEnrollment.open "SELECT COUNT(CourseDirectoryId) AS TotalEnrollment FROM StudentEnrollment WHERE(CourseDirectoryId = " & mCourseDirectoryId & ") AND (EnrollmentStatusId = 1)", conn

        if NOT RSMaxEnrollment.EOF then
            TotalEnrollment = RSMaxEnrollment("TotalEnrollment")
        else
            TotalEnrollment = 0
        end if

        if TotalEnrollment >= MaxEnrollment then
            Session("sDuplicateEnrollment") = "No Seats Available! <br> Enrollment is Closed due to Insufficient Enrollment Seats. Please Try Next Time"
            response.Redirect("EnrollCourse.asp?Filter=1&QsId=" & mCourseDirectoryId & "&FormGrNumber=" & eStdGrNumber & "&FormStdNic=" & eStdNicNumber & "&FormStdEmail=" & eStdEmailAddress)
        else
            Session("sDuplicateEnrollment") = ""
        end if

        'response.write(MaxEnrollment)
        'response.write("<br>" & TotalEnrollment)
        'response.end
    'End

    'Validating Enrollment Closing Date
        Dim CurrentDate
        CurrentDate = Now()
        Session("sDuplicateEnrollment") = ""

        'response.write(cdate(CurrentDate))
        'response.write("<br>")
        'response.write(cdate(mLastEnrollmentDate))
        'response.end

        if cdate(CurrentDate) > cdate(mLastEnrollmentDate) then
            'response.write(cdate(mLastEnrollmentDate))
            'response.end
            Session("sDuplicateEnrollment") = "Enrollment Closed! <br> Enrollment is Closed due to Enrollment Closing Date. Please Try Next Time"
            response.Redirect("EnrollCourse.asp?Filter=1&QsId=" & mCourseDirectoryId & "&FormGrNumber=" & eStdGrNumber & "&FormStdNic=" & eStdNicNumber & "&FormStdEmail=" & eStdEmailAddress)
        end if
    'End

    'Validating Duplicate Enrollment
        Dim RSDuplicateRec
        Session("sDuplicateEnrollment") = ""

        Set RSDuplicateRec = Server.CreateObject("ADODB.RecordSet")
        RSDuplicateRec.open "SELECT StudentId FROM StudentEnrollment WHERE(StudentId = " & eStudentId & ") AND (CourseDirectoryId = " & mCourseDirectoryId & ") AND (EnrollmentStatusId = 1)", conn
        
        if NOT RSDuplicateRec.EOF then
            Session("sDuplicateEnrollment") = "Student has already been enrolled in this Course"
            response.Redirect("EnrollCourse.asp?Filter=1&QsId=" & mCourseDirectoryId & "&FormGrNumber=" & eStdGrNumber & "&FormStdNic=" & eStdNicNumber & "&FormStdEmail=" & eStdEmailAddress)
        end if

        RSDuplicateRec.close
        Set RSDuplicateRec = Nothing
    'End

    'Calculating Actual Fee
        '1. If FeeDiscount% and FeeDiscount = NULL then Error
        '2. If FeeDiscount% and FeeDiscount <> NULL then Error
        '3. If FeeDiscount% <> Null then calculate FeeDiscount AND ActualFee
        '4. If FeeDiscount <> Null then calculate FeeDiscount% AND ActualFee

        'response.write("<br>% Not NULL - double quote ")
        'response.write(mFeeDiscountPercent <> "")
        'response.write("<br>% NOT ISNULL " & len(mFeeDiscountPercent))
        'response.write("<br>")
        'response.write("<br>Discount Not NULL - double quote ")
        'response.write(mFeeDiscount <> "")
        'response.write("<br>Discount NOT ISNULL " & len(mFeeDiscount))
        'response.write("<br>")

        if (mFeeDiscountPercent = "" OR len(mFeeDiscountPercent) <= 0) AND (mFeeDiscount = "" OR len(mFeeDiscount) <= 0) then
            Session("sFeeDiscountPercentage") = "Fee Discount Percentage and Fee Discount Amount Both cannot be NULL"
            Session("sFeeDiscount") = "Fee Discount Percentage and Fee Discount Amount Both cannot be NULL"
            EnrollmentErrorFound = 1
            'response.write("1st condition")
        elseif (mFeeDiscountPercent <> "" OR len(mFeeDiscountPercent) > 0) AND (mFeeDiscount <> "" OR len(mFeeDiscount) > 0) then
            Session("sFeeDiscountPercentage") = "Fee Discount Percentage and Fee Discount Amount cannot be filled together"
            Session("sFeeDiscount") = "Fee Discount Percentage and Fee Discount Amount cannot be filled together"
            EnrollmentErrorFound = 1
            'response.write("2nd condition")
        elseif (mFeeDiscountPercent <> "" OR len(mFeeDiscountPercent) > 0) AND (mFeeDiscount = "" OR len(mFeeDiscount) <= 0) then
            if cdbl(mFeeDiscountPercent) < 0 OR cdbl(mFeeDiscountPercent) > 100 then
                Session("sFeeDiscountPercentage") = "Fee Discount Percentage cannot be less than Zero or Greater than 100"
                EnrollmentErrorFound = 1
            else
                mFeeDiscount = (mCourseFee * cdbl(mFeeDiscountPercent))/100
                mActualFee = (cdbl(mCourseFee) - cdbl(mFeeDiscount))
            end if
            'response.write("3rd condition = % Not Null AND Discount IS NULL")
        elseif (mFeeDiscountPercent = "" OR len(mFeeDiscountPercent) <= 0) AND (mFeeDiscount <> "" OR len(mFeeDiscount) > 0) then
            if cdbl(mFeeDiscount) < 0 OR cdbl(mFeeDiscount) > cdbl(mCourseFee) then
                Session("sFeeDiscount") = "Fee Discount Amount cannot be less than Zero OR greater than Course Fee"
                EnrollmentErrorFound = 1
            else
                mFeeDiscountPercent = (cdbl(mFeeDiscount)/mCourseFee)*100
                mActualFee = (cdbl(mCourseFee) - cdbl(mFeeDiscount))
            end if
            'response.write("4th condition = Discount Not Null AND % IS NULL")
        end if
    'End

    'Calculate Balance Fee
        '1. If PaidFee = NULL THEN PaidFee = 0 and BalanceFee = ActualFee and IsFeePaid = 0
        '2. If PaidFee <> NULL THEN Validate PaidFee (> 0)
        '3. If PaidFee > ActualFee THEN Error
        '4. If PaidFee = ActualFee then BalanceFee = 0, IsFeePaid = 1
        '5. If PaidFee < ActualFee then BalanceFee = ActualFee-PaidFee, IsFeePaid = 0

        if mPaidFee = "" or len(mPaidFee) <= 0 then
            mPaidFee = 0
            mBalanceFee = mActualFee
            mIsFeePaid = 0
        elseif mPaidFee <> "" or len(mPaidFee) > 0 then
            if cdbl(mPaidFee) >= 0 then
                if cdbl(mPaidFee) > cdbl(mActualFee) then
                    Session("sPaidFee") = "Paid Fee Cannot be greater than Actual Fee"
                    EnrollmentErrorFound = 1
                elseif cdbl(mPaidFee) = cdbl(mActualFee) then
                    mBalanceFee = 0
                    mIsFeePaid = 1
               else
                   mBalanceFee = (cdbl(mActualFee) - cdbl(mPaidFee))
                   mIsFeePaid = 0
               end if
           else
               Session("sPaidFee") = "Paid Fee cannot be less than Zero"
               EnrollmentErrorFound = 1
           end if
        end if
        'response.write("<br>Discount% = " & mFeeDiscountPercent)
        'response.write("<br>Discount = " & mFeeDiscount)
        'response.write("<br>Fee = " & mCourseFee)
        'response.write("<br>PaidFee = " & mPaidFee)
        'response.write("<br>Fee = " & mBalanceFee)
        'response.write("<br>ActualFee = " & mActualFee)
        'response.end
    'end

    'Check for Course Enrollment Conflict
        dim RSGetTime
        dim cTimeSlotId

        Set RSGetTime = Server.CreateObject("ADODB.RecordSet")

        RSGetTime.open "SELECT StartDate, EndDate, TimeSlotId FROM V_CourseDirectoryView WHERE(CourseDirectoryId = " & mCourseDirectoryId & ")", conn

        if RSGetTime.eof = false then 
            cTimeSlotId = RSGetTime("TimeSlotId")
            cStartDate = RSGetTime("StartDate")
            cEndDate = RSGetTime("EndDate")
        end if

        response.write("<br>" & cTimeSlotId)
        response.write("<br>")

        RSGetTime.close
        set RSGetTime = Nothing

        'response.write(GetConflictedTimeSlot(cTimeSlotId))
        'response.write("<br>")
        'response.write(IsEnrollmentConflict())
        'response.end

        if IsEnrollmentConflict() then
            Session("sEnrollmentConflict") = "Enrollment Conflict! You have been Enrolled in another Course during the same Date and Time"
            EnrollmentErrorFound = 1
        else
            Session("sEnrollmentConflict") = ""
        end if
    'end

    if EnrollmentErrorFound = 1 then
        response.Redirect("EnrollCourse.asp?Filter=1&QsId=" & mCourseDirectoryId & "&FormGrNumber=" & eStdGrNumber & "&FormStdNic=" & eStdNicNumber & "&FormStdEmail=" & eStdEmailAddress)
        'Clear all Session Var in else
    end if

    'Insert
        QryStr = "INSERT INTO StudentEnrollment (StudentId, CourseDirectoryId, FeeDiscountPercentage, FeeDiscount, ActualFee, PaidFee, BalanceFee," & _
                " IsFeePaid, EnrollmentStatusId, UserCreatedBy)" & _
                " VALUES (" & eStudentId & ", " & mCourseDirectoryId & ", " & mFeeDiscountPercent & ", " & mFeeDiscount & ", " & _
                mActualFee & ", " & mPaidFee & ", " & mBalanceFee & ", " & mIsFeePaid & ", " & mEnrollmentStatusId & ", " & mUserCreatedBy & ")"
            
        'response.write(QryStr)
        'Response.end
        Conn.Execute QryStr
    'End

    'RedirectPage
    response.redirect("EnrollCourse.asp?QsId=" & mCourseDirectoryId)
    'End
end if

if Request.QueryString("QsCancel") = "1" then
    QryStr = "UPDATE StudentEnrollment Set EnrollmentStatusId = 4, UserLastUpdatedBy = " & Session("SUserId") & ", LastUpdatedDateTime = '" & Now() &"' WHERE(StdEnrollmentId = " & Request.QueryString("QsStdEnrollmentId") & ")"
    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("EnrollCourse.asp?QsId=" & CourseDirectoryId)
end if

if Request.QueryString("Update") = "1" then
    Dim uPaidFee
    Dim uFee
    Dim uBalanceFee
    Dim uIsFeePaid
    Dim uStdEnrollmentId

    Session("sPaidFee") = ""
    uFee = Request.Form("FormFee")
    uPaidFee = Request.Form("FormPaidFee")
    uStdEnrollmentId = Request.QueryString("QsStdEnrollmentId")
    uBalanceFee = Request.Form("FormBalanceFee")

    'uFee = 200
    'uBalanceFee = 200

    'response.write("<br>Fee = " & cdbl(uFee))
    'response.write("<br>BalanceFee = " & cdbl(uBalanceFee))
    'response.write("<br>")
    'response.write(uFee = uBalanceFee)
    'response.end

    if len(uFee) > 0 then
        if cint(uFee) <= 0 then
            Session("sPaidFee") = "Invalid Fee! <br> Fee cannot be less than or equal to Zero."
            response.redirect("EnrollCourse.asp?QsId=" & CourseDirectoryId & "&QsEdit=1&QsStdEnrollmentId=" & uStdEnrollmentId)
        elseif cint(uFee) > cint(uBalanceFee) then
            Session("sPaidFee") = "Invalid Fee! <br> Fee cannot be greater than Balance Fee."
            response.redirect("EnrollCourse.asp?QsId=" & CourseDirectoryId & "&QsEdit=1&QsStdEnrollmentId=" & uStdEnrollmentId)
        end if
    else
        Session("sPaidFee") = "Fee cannot be Null."
        response.redirect("EnrollCourse.asp?QsId=" & CourseDirectoryId & "&QsEdit=1&QsStdEnrollmentId=" & uStdEnrollmentId)
    end if

    'response.write(uFee = uBalanceFee)
    if uFee = uBalanceFee then
        uPaidFee = cint(uPaidFee) + cint(uFee)
        uBalanceFee = 0
        uIsFeePaid = 1
        'response.write("true Block")
    else
        'response.write("Else Block")
        uPaidFee = cint(uPaidFee) + cint(uFee)
        uBalanceFee = cint(uBalanceFee) - cint(uFee)
        uIsFeePaid = 0
    end if

    'response.write("<br>Fee = " & uFee)
    'response.write("<br>PaidFee = " & uPaidFee)
    'response.write("<br>BalanceFee = " & uBalanceFee)
    'response.write("<br>IsFeePaid = " & uIsFeePaid)
    'response.write("<br>")

    QryStr = "UPDATE StudentEnrollment Set PaidFee = " & uPaidFee & ", BalanceFee = " & uBalanceFee & ", IsFeePaid = " & uIsFeePaid & " , UserLastUpdatedBy = " & Session("SUserId") & ", LastUpdatedDateTime = '" & Now() &"' WHERE(StdEnrollmentId = " & Request.QueryString("QsStdEnrollmentId") & ")"
    'response.write(QryStr)
    'response.end
    Conn.execute QryStr
    response.redirect("EnrollCourse.asp?QsId=" & CourseDirectoryId)
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
                            <a class="nav-link active"
                                href="EnrollCourse.asp?QsId=<% response.Write(RSCourseDirectory("CourseDirectoryId")) %>">Enroll
                                Course</a>
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

            <% if (cint(EnrollmentAvailable) > 0) then %>
            <% if (cdate(Date()) < cdate(LastEnrollmentDate)) then %>
            <div class="panel">
                <br>
                <div class="panel-head">
                    <div class="row">
                        <div class="col">
                            <label for="">Student Detail</label>
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <div class="row">
                        <div class="col">
                            <section class="action">
                                <div>
                                    <form class="search"
                                        action="EnrollCourse.asp?Filter=1&QsId=<% response.Write(CourseDirectoryId) %>"
                                        METHOD="POST">
                                        <div>
                                            <input type="search" class="search-bar" placeholder="Search By GR Number"
                                                name="FormGrNumber" value="<% response.write(mGrNumber) %>">
                                        </div>
                                        <div>
                                            <input type="search" class="search-bar" placeholder="Search By Student NIC"
                                                name="FormStdNIC" value="<% response.write(mStdNic) %>">
                                        </div>
                                        <div>
                                            <input type="search" class="search-bar"
                                                placeholder="Search By Student Email" name="FormStdEmail"
                                                value="<% response.write(mStdEmail) %>">
                                        </div>
                                        <input type="submit" name="" id="" class="search-btn" value="Search">
                                    </form>
                                </div>
                            </section>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col text-center"><span><% response.Write(StdNotFound) %></span></div>
                    </div>

                    <div class="row mt-2">
                        <div class="col-4">
                            <label for="" class="input-heading">Student First Name</label>
                            <label for="" class="form-control label-data"><% response.Write(StdFirstName) %></label>
                        </div>

                        <div class="col-4">
                            <label for="" class="input-heading">Student Last Name</label>
                            <label for="" class="form-control label-data"><% response.Write(StdLastName) %></label>
                        </div>

                        <div class="col-4">
                            <label for="" class="input-heading">Student Father Name</label>
                            <label for="" class="form-control label-data"><% response.Write(StdFatherName) %></label>
                        </div>
                    </div>

                    <div class="row mt-2">
                        <div class="col-4">
                            <label for="" class="input-heading">Student GR Number</label>
                            <label for="" class="form-control label-data"><% response.Write(StdGrNumber) %></label>
                        </div>

                        <div class="col-4">
                            <label for="" class="input-heading">Student NIC Number</label>
                            <label for="" class="form-control label-data"><% response.Write(StdNICNumber) %></label>
                        </div>

                        <div class="col-4">
                            <label for="" class="input-heading">Student Email Address</label>
                            <label for="" class="form-control label-data"><% response.Write(StdEmailAddress) %></label>
                        </div>
                    </div>
                </div>
            </div>
            <% end if %>
            <% end if %>

            <% if StdFirstName <> "" then %>
            <div class="panel">
                <br>
                <div class="panel-head">
                    <div class="row">
                        <div class="col">
                            <label for="">Course Enrollment</label>
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <br>
                    <form action="EnrollCourse.asp?Enroll=1&QsId=<% response.Write(CourseDirectoryId) %>" method="POST">

                        <div class="row">
                            <div class="col text-center">
                                <span><% response.write(Session("sDuplicateEnrollment")) %></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col text-center">
                                <span><% response.write(Session("sEnrollmentConflict")) %></span>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-6">
                                <input type="hidden" value="<% response.write(mStudentId) %>" name="FormStudentId">
                                <input type="hidden" value="<% response.write(CourseDirectoryId) %>"
                                    name="FormCourseDirectoryId">
                                <input type="hidden" name="FormCourseFee" id="CourseFee"
                                    value="<% response.Write(CourseFee) %>">
                                <input type="hidden" name="eFormGrNumber" id=""
                                    value="<% response.Write(StdGrNumber) %>">
                                <input type="hidden" name="eFormStdNic" id=""
                                    value="<% response.Write(StdNicNumber) %>">
                                <input type="hidden" name="eFormStdEmail" id=""
                                    value="<% response.Write(StdEmailAddress) %>">
                                <input type="hidden" name="FormLastEnrollmentDate" id=""
                                    value="<% response.Write(LastEnrollmentDate) %>">

                                <label for="" class="input-heading">Fee Discount %</label>
                                <input type="text" class="form-control" name="FormFeeDiscountPercentage"
                                    id="FeeDiscountPercent" onchange="CalcActualFeeByPercent(this);">
                            </div>

                            <div class="col-6">
                                <label for="" class="input-heading">Fee Discount (Amount)</label>
                                <input type="text" class="form-control" name="FormFeeDiscount" id="FeeDiscount"
                                    onchange="CalcActualFeeByAmount(this);">
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-6"><span><% response.write(Session("sFeeDiscountPercentage")) %></span>
                            </div>
                            <div class="col-6"><span><% response.write(Session("sFeeDiscount")) %></span></div>
                        </div>

                        <div class="row">
                            <div class="col-4">
                                <label for="" class="input-heading">Actual Fee (After Discount)</label>
                                <input type="text" class="form-control" name="FormActualFee" id="ActualFee" disabled>
                            </div>

                            <div class="col-4">
                                <label for="" class="input-heading">Fee Paid (Amount)</label>
                                <input type="text" class="form-control" id="PaidFee" name="FormFeePaid"
                                    onchange="CalcBalanceFee(this);">
                            </div>

                            <div class="col-4">
                                <label for="" class="input-heading">Balance Fee</label>
                                <input type="text" class="form-control" name="FormBalanceFee" id="BalanceFee" disabled>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-4"></div>
                            <div class="col-4"><span><% response.write(Session("sPaidFee")) %></span></div>
                            <div class="col-4"></div>
                        </div>

                        <div class="row">
                            <div class="col-lg d-flex justify-content-center">
                                <input type="submit" value="Enrolled" class="button">
                            </div>
                        </div>
                    </form>
                </div>
                <% end if %>
            </div>

            <% if Request.QueryString("QsEdit")= "1" then %>
            <%
                Dim RSEditEnrollment
                Set RSEditEnrollment = Server.CreateObject("ADODB.RecordSet")
                RSEditEnrollment.open "SELECT * FROM V_StdEnrollmentView WHERE(StdEnrollmentId = " & Request.QueryString("QsStdEnrollmentId") & ")", conn
                dim StdEnrollmentId
                StdEnrollmentId = RSEditEnrollment("StdEnrollmentId")
            %>
            <div class="panel">
                <br>
                <div class="panel-head">
                    <div class="row">
                        <div class="col">
                            <label for="">Course Enrollment</label>
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <br>
                    <form
                        action="EnrollCourse.asp?Update=1&QsId=<% response.Write(CourseDirectoryId) %>&QsStdEnrollmentId=<% response.write(StdEnrollmentId) %>"
                        method="POST" style="margin: 0px 10px;">
                        <div class="row">
                            <div class="col-6">
                                <label for="" class="input-heading">Fee Discount %</label>
                                <label for=""
                                    class="form-control label-data"><% response.write(RSEditEnrollment("FeeDiscountPercentage")) %></label>
                            </div>

                            <div class="col-6">
                                <label for="" class="input-heading">Fee Discount (Amount)</label>
                                <label for=""
                                    class="form-control label-data"><% response.write(RSEditEnrollment("FeeDiscount")) %></label>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-4">
                                <label for="" class="input-heading">Actual Fee (After Discount)</label>
                                <label for=""
                                    class="form-control label-data"><% response.write(RSEditEnrollment("ActualFee")) %></label>
                            </div>

                            <div class="col-4">
                                <label for="" class="input-heading">Fee Paid (Amount)</label>
                                <label for=""
                                    class="form-control label-data"><% response.write(RSEditEnrollment("PaidFee")) %></label>
                                <input type="hidden" value="<% response.write(RSEditEnrollment("PaidFee")) %>"
                                    name="FormPaidFee">
                            </div>

                            <div class="col-4">
                                <label for="" class="input-heading">Balance Fee</label>
                                <label for=""
                                    class="form-control label-data"><% response.write(RSEditEnrollment("BalanceFee")) %></label>
                                <input type="hidden" value="<% response.write(RSEditEnrollment("BalanceFee")) %>"
                                    name="FormBalanceFee">
                            </div>
                        </div>

                        <br>

                        <% if cint(RSEditEnrollment("BalanceFee")) > 0 then %>
                        <div class="row">
                            <div class="col-lg d-flex justify-content-center">
                                <div class="form-group" style="width: 20%;">
                                    <label for="" class="input-heading">Paid Fee</label>
                                    <input type="text" class="form-control" name="FormFee">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col text-center">
                                <span>
                                    <% response.write(Session("sPaidFee")) %>
                                </span>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg d-flex justify-content-center">
                                <input type="submit" value="Update" class="button">
                            </div>
                        </div>
                        <% else %>
                        <div class="row">
                            <div class="col text-center">
                                <h4><span>Your Fee is Paid, No Dues Left.</span></h4>
                            </div>
                        </div>
                        <% end if %>
                    </form>
                </div>
            </div>
            <% end if %>

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
                    <table class="table table-bordered table-hover" style="width: 100%;">
                        <thead class="thead-light">
                            <tr>
                                <th style="width: 0.5%;"></th>
                                <th style="width: 3%;">GR Number</th>
                                <th style="width: 6%;">First Name</th>
                                <th style="width: 6%;">Last Name</th>
                                <th style="width: 8%;">NIC</th>
                                <th style="width: 6%;">Father Name</th>
                                <th style="width: 2%;">Discount%</th>
                                <th style="width: 3%;">Actual Fee</th>
                                <th style="width: 3%;">Paid Fee</th>
                                <th style="width: 3%;">Balance Fee</th>
                                <th style="width: 2%;">Is Fee Paid</th>
                                <th style="width: 3%;">Status</th>
                                <th style="width: 0.5%;"></th>
                            </tr>
                        </thead>

                        <tbody>
                            <% 
                                do while NOT RSEnroll.EOF
                            %>
                            <tr>
                                <td>
                                    <% if RSEnroll("EnrollmentStatusId") = 1 then %>
                                    <a
                                        href="EnrollCourse.asp?QsEdit=1&QsId=<% response.write(CourseDirectoryId) %>&QsStdEnrollmentId=<% response.write(RSEnroll("StdEnrollmentId")) %>"><img
                                            src="Images/edit.png" alt="" style="width: 18px; height: 18px;"></a>
                                    <% end if %>
                                </td>
                                <td><% response.Write(RSEnroll("StdGrNumber")) %></td>
                                <td><% response.Write(RSEnroll("StdFirstName")) %></td>
                                <td><% response.Write(RSEnroll("StdLastName")) %></td>
                                <td><% response.Write(RSEnroll("StdNICNumber")) %></td>
                                <td><% response.Write(RSEnroll("FatherName")) %></td>
                                <td><% response.Write(RSEnroll("FeeDiscountPercentage")) %></td>
                                <td><% response.Write(RSEnroll("ActualFee")) %></td>
                                <td><% response.Write(RSEnroll("PaidFee")) %></td>
                                <td><% response.Write(RSEnroll("BalanceFee")) %></td>
                                <td><% response.Write(RSEnroll("IsFeePaid")) %></td>
                                <td><% response.Write(RSEnroll("EnrollmentStatus")) %></td>
                                <td>
                                    <% if RSEnroll("EnrollmentStatusId") = 1 then %>
                                    <a
                                        href="EnrollCourse.asp?QsCancel=1&QsId=<% response.write(CourseDirectoryId) %>&QsStdEnrollmentId=<% response.write(RSEnroll("StdEnrollmentId")) %>"><img
                                            src="Images/cancel.png" alt="" style="width: 18px; height: 18px;"
                                            onclick="return (confirm('Do you want to Cancel the Enrollment?'));"></a>
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
    <%
Function FilterStudent()
    'Variables Declaration
        Dim mGrNumber
        Dim mStdNic
        Dim mStdEmail
        Dim QryCondition
    'end

    

    'Variables Initialization
        mGrNumber = request.form("FormGrNumber")
        mStdNic = request.form("FormStdNIC")
        mStdEmail = request.form("FormStdEmail")
        QryCondition = " WHERE(1=1) "
        StdNotFound = ""
    'end

    'Building QryCondition
        if mGrNumber <> "" or len(mGrNumber) > 0 then
            QryCondition = QryCondition & " AND (StdGrNumber = '" & mGrNumber & "')"
        elseif mStdNic <> "" or len(mStdNic) > 0 then
            QryCondition = QryCondition & " AND (StdNICNumber = '" & mStdNic & "')"
        elseif mStdEmail <> "" or len(mStdEmail) > 0 then
            QryCondition = QryCondition & " AND (StdEmailAddress = '" & mStdEmail & "')"
        end if
    'end

    'response.write(QryCondition)
    
    'OpenDb, OpenRS
        call OpenDbConn()
        Dim RSStdDetail

        Set RSStdDetail = Server.CreateObject("ADODB.RecordSet")


        RSStdDetail.Open "SELECT * FROM StudentDetail" & QryCondition , conn
    'end

    if NOT RSStdDetail.EOF then
        mStudentId = RSStdDetail("StudentId")
        StdGrNumber = RSStdDetail("StdGrNumber")
        StdNICNumber = RSStdDetail("StdNICNumber")
        StdFirstName = RSStdDetail("StdFirstName")
        StdLastName = RSStdDetail("StdLastName")
        StdEmailAddress = RSStdDetail("StdEmailAddress")
        StdFatherName = RSStdDetail("FatherName")
        StdNotFound = ""
    else
        StdGrNumber = ""
        StdFirstName = ""
        StdDateOfBirth = ""
        StdMobileNumber = ""
        StdEmailAddress = ""
        StdFatherName = ""
        StdNotFound = "Invalid Search, Student Not Found"
    end if

    RSStdDetail.close
    set RSStdDetail = Nothing
End Function

Function GetConflictedTimeSlot(mTimeSlotId)
    dim RSTimeSlot
    dim mStartTime
    dim mEndTime
    dim RSTimeSlotId
    dim ConflictedTimeSlotId

    ConflictedTimeSlotId = "("

    
    Set RSTimeSlot = Server.CreateObject("ADODB.RecordSet")
    
    RSTimeSlot.open "SELECT * FROM ListTimeSlot WHERE(TimeSlotId = " & mTimeSlotId & ")", conn

    if RSTimeSlot.eof = false then 
        mStartTime = "01/01/1900 " & FormatDateTime(RSTimeSlot("StartTime"),4) & ":00"
        mEndTime = "01/01/1900 " & FormatDateTime(RSTimeSlot("EndTime"),4) & ":00"
    end if
    'response.write(mStartTime)
    'response.write("<br>" & mEndTime)
    'response.write("<br>" & RSTimeSlot("StartTime"))
    'response.write("<br>" & RSTimeSlot("EndTime"))
    
    RSTimeSlot.close
    set RSTimeSlot = Nothing

    Set RSTimeSlotId = Server.CreateObject("ADODB.RecordSet")
    'response.write("<br> SELECT TimeSlotId FROM ListTimeSlot WHERE (StartTime <= '" & mEndTime & "') AND (EndTime >= '" & mStartTime & "')")
    'response.write("<br> SELECT TimeSlotId FROM ListTimeSlot WHERE (StartTime <= '" & RSTimeSlot("EndTime") & "') AND (EndTime >= '" & RSTimeSlot("StartTime") & "')")
    
    RSTimeSlotId.open "SELECT TimeSlotId FROM ListTimeSlot WHERE (StartTime <= '" & mEndTime & "') AND (EndTime >= '" & mStartTime & "')", conn
    'RSTimeSlotId.open "SELECT TimeSlotId FROM ListTimeSlot WHERE (StartTime <= '" & RSTimeSlot("EndTime") & "') AND (EndTime >= '" & RSTimeSlot("StartTime") & "')", conn
    'response.end

    do while NOT RSTimeSlotId.EOF
        ConflictedTimeSlotId = ConflictedTimeSlotId & RSTimeSlotId("TimeSlotId") & ","
        RSTimeSlotId.MoveNext
    loop
    RSTimeSlotId.close
    set RSTimeSlotId = Nothing

    ConflictedTimeSlotId = left(ConflictedTimeSlotId,len(ConflictedTimeSlotId)-1) & ")"
    GetConflictedTimeSlot = ConflictedTimeSlotId
End Function

Function IsEnrollmentConflict()
    Dim RSFilterRec
    dim IsConflict
    
    IsConflict = false

    Set RSFilterRec = Server.CreateObject("ADODB.RecordSet")
    QryStr = "SELECT * FROM V_EnrollmentConflict WHERE (StartDate <= '" & cEndDate & "') AND (EndDate >= '" & cStartDate & "') AND (EnrollmentStatusId = 1) AND (TimeSlotId IN " & GetConflictedTimeSlot(cTimeSlotId) & ") AND (StudentId = " & eStudentId & ")"
    'response.write(QryStr)
    'response.end
    RSFilterRec.open QryStr, conn

    if NOT RSFilterRec.EOF then
        IsConflict = True
    end if

    RSFilterRec.close
    set RSFilterRec = Nothing
    IsEnrollmentConflict = IsConflict
end function
%>

</body>

<script src="Scripts/EnrollCourse.js"></script>

</html>