<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->
<%
    'Variable Declaration
        dim mCourseDirectoryId
        dim mCourseId
        dim mStartDate
        dim mEndDate
        dim mCourseDuration
        dim mTimeSlotId
        dim mInstructorId
        dim mRoomId
        dim mLanguageId
        dim mMaxEnrollment
        dim mEnrollmentClosingDate
        dim mCourseDirectoryStatusId
        dim mCourseFee
    'end

    'Variable Initialization
        mCourseDirectoryId = cint(request.form("FormCourseDirectoryId"))
        mCourseId = cint(request.form("FormCourseId"))
        mStartDate = request.form("FormStartDate")
        mEndDate = request.form("FormEndDate")
        mCourseDuration = request.form("FormCourseDuration")
        mTimeSlotId = cint(request.form("FormTimeSlotId"))
        mInstructorId = cint(request.form("FormInstructorId"))
        mRoomId = cint(request.form("FormRoomId"))
        mLanguageId = cint(request.form("FormLanguageId"))
        mMaxEnrollment = request.form("FormMaxEnrollment")
        mEnrollmentClosingDate = request.form("FormEnrollmentClosingDate")
        mCourseFee = request.form("FormCourseFee")
        mCourseDirectoryStatusId = request.form("FormCourseDirectoryStatus")

        Session("sCourseId") = ""
        Session("sStartDate") = ""
        Session("sEndDate") = ""
        Session("sDuration") = ""
        Session("sTimeSlotId") = ""
        Session("sLanguageId") = ""
        Session("sMaxEnrollment") = ""
        Session("sClosingDate") = ""
        Session("sCourseFee") = ""

        Session("smCourseId") = ""
        Session("smStartDate") = ""
        Session("smEndDate") = ""
        Session("smDuration") = ""
        Session("smTimeSlotId") = ""
        Session("smLanguageId") = ""
        Session("smMaxEnrollment") = ""
        Session("smClosingDate") = ""
        Session("smCourseFee") = ""
        Session("smCourseDirectoryStatusId") = ""
    'end

    'response.Write(mStartDate = "")
    'response.Write("<br>" & IsNull(mStartDate))
    'response.Write("<br>" & len(mStartDate))
    'response.End
    
    'Validations
        Session("sCourseId") = ValidateCourseId()
        Session("sStartDate") = ValidateStartDate()
        Session("sEndDate") = ValidateEndDate()
        Session("sDuration") = ValidateDuration()
        Session("sTimeSlotId") = ValidateTimeSlotId()
        Session("sLanguageId") = ValidateLanguageId()
        Session("sMaxEnrollment") = ValidateMaxEnrollment()
        Session("sClosingDate") = ValidateClosingDate()
        Session("sCourseFee") = ValidateCourseFee()

        if mRoomId <> -1 then
            if mTimeSlotId <> -1 and mStartDate <> "" AND mEndDate <> "" then
                If IsRoomConflict() = true then
                    Session("sConflictedRoom") = "Selected Room is not available during the provided date and time"
                end if
            end if
        end if

        if mInstructorId <> -1 then
            if mTimeSlotId <> -1 and mStartDate <> "" AND mEndDate <> "" then
                If IsInstructorConflict() = true then
                    Session("sConflictedInstructor") = "Selected Instructor is not available during the provided date and time"
                end if
            end if
        end if

        Session("smCourseId") = mCourseId
        Session("smStartDate") = mStartDate
        Session("smEndDate") = mEndDate
        Session("smDuration") = mCourseDuration
        Session("smTimeSlotId") = mTimeSlotId
        Session("smRoomId") = mRoomId
        Session("smInstructorId") = mInstructorId
        Session("smLanguageId") = mLanguageId
        Session("smMaxEnrollment") = mMaxEnrollment
        Session("smClosingDate") = mEnrollmentClosingDate
        Session("smCourseFee") = mCourseFee
        Session("smCourseDirectoryStatusId") = mCourseDirectoryStatusId

        if ErrorFound=true or IsRoomConflict() or IsInstructorConflict() then
            response.Redirect("CourseDirectoryEdit.asp?QsIsError=true&QsId=" & mCourseDirectoryId)
        end if
    'end

    'Check for Duplicate

    'end

    'Update Rec
        QryStr = "UPDATE CourseDirectory " & _
                "SET CourseId = " & mCourseId & ", StartDate = '" & mStartDate & "', EndDate = '" & mEndDate & "', CourseDuration = " & mCourseDuration & _
                ", TimeSlotId = " & mTimeSlotId & ", InstructorId = " & mInstructorId & ", RoomId = " & mRoomId & _ 
                ", LanguageId = " & mLanguageId & ", MaxEnrollment = " & mMaxEnrollment & ", EnrollmentClosingDate = '" & mEnrollmentClosingDate & _
                "', CourseFee = '" & mCourseFee & "', CourseDirectoryStatusId = " & mCourseDirectoryStatusId & _
                ", UserLastUpdatedBy = " &  Session("SUserId") & ", LastUpdatedDateTime = '" & Now() & "' WHERE(CourseDirectoryId = " & _ 
                mCourseDirectoryId & ")"

        'response.Write(QryStr)
        'response.end
        conn.execute QryStr
    'end

    'Redirect
        response.redirect("CourseDirectory.asp")
    'end

'Functions
    'ValidateCourseId
        function ValidateCourseId()
            if mCourseId <= 0 then
                ValidateCourseId = "No Course Name Selected"
                ErrorFound = True
            else
                Dim RSCourseId
                Set RSCourseId = Server.CreateObject("ADODB.RecordSet")
                RSCourseId.open "SELECT * FROM CourseContent WHERE(CourseId = " & mCourseId & ")", conn
                if RSCourseId.eof then 
                    ValidateCourseId = "Course Name not found in Database"
                    ErrorFound = True
                end if
            end if
        end function
    'end

    'ValidateTimeSlotId
        function ValidateTimeSlotId()
            if mTimeSlotId <= 0 then
                ValidateTimeSlotId = "No Time Slot Selected"
                ErrorFound = True
            else
                Dim RSTimeSlot
                Set RSTimeSlot = Server.CreateObject("ADODB.RecordSet")
                RSTimeSlot.open "SELECT * FROM ListTimeSlot WHERE(TimeSlotId = " & mTimeSlotId & ")", conn
                if RSTimeSlot.eof then 
                    ValidateTimeSlotId = "Time Slot not found in Database"
                    ErrorFound = True
                end if
            end if
        end function
    'end

    'ValidateLanguageId
        function ValidateLanguageId()
            if mLanguageId <= 0 then
                ValidateLanguageId = "No Language Selected"
                ErrorFound = True
            else
                Dim RSLanguage
                Set RSLanguage = Server.CreateObject("ADODB.RecordSet")
                RSLanguage.open "SELECT * FROM ListLanguage WHERE(LanguageId = " & mLanguageId & ")", conn
                if RSLanguage.eof then 
                    ValidateLanguageId = "Language not found in Database"
                    ErrorFound = True
                end if
            end if
        end function
    'end

    'ValidateStartDate
        function ValidateStartDate()
            if mStartDate = "" OR len(mStartDate) = 0 then
                ValidateStartDate = "Start Date cannot be NULL"
                ErrorFound = True
            elseif cdate(mStartDate) < Date() then
                ValidateStartDate = "Start Date cannot be less than or equal to current Date"
                ErrorFound = True
            end if
        end function
    'end

    'ValidateEndDate
        function ValidateEndDate()
            if mEndDate = "" OR len(mEndDate) = 0 then
                ValidateEndDate = "End Date cannot be NULL"
                ErrorFound = True
            elseif mStartDate <> "" OR len(mStartDate) > 0 then
                if cdate(mEndDate) < cdate(mStartDate) then
                    ValidateEndDate = "End Date cannot be less than Start Date"
                    ErrorFound = True
                end if
            else
                ValidateEndDate = "End Date cannot be used without Start Date"
                ErrorFound = True
            end if
        end function
    'end

    'ValidateDuration
        function ValidateDuration()
            if mCourseDuration = "" or isNull(mCourseDuration) then
                ValidateDuration = "Course Duration cannot be NULL or Zero"
                ErrorFound = True
            elseif mCourseDuration < 0 then
                ValidateDuration = "Course Duration cannot be less than Zero"
                ErrorFound = True
            elseif (mStartDate <> "" OR len(mStartDate) > 0) AND (mEndDate <> "" OR len(mEndDate) > 0) then
                Dim DateDifference
                DateDifference = DateDiff("d",cdate(mStartDate),cdate(mEndDate))
                
                if cint(mCourseDuration) > DateDifference then
                    ValidateDuration = "Invalid Course Duration, Cannot Exceed from " & DateDifference & " Days"
                    ErrorFound = True
                end if
            end if
        end function
    'end

    'ValidateMaxEnrollment
        function ValidateMaxEnrollment()
            if mMaxEnrollment = "" or isNull(mCourseDuration) then
                ValidateMaxEnrollment = "Max Enrollment cannot be NULL or Zero"
                ErrorFound = True
            elseif cint(mMaxEnrollment) < 0 then
                ValidateMaxEnrollment = "Max Enrollment cannot be less than Zero"
                ErrorFound = True
            end if
        end function
    'end

    'ValidateClosingDate
        function ValidateClosingDate()
            if mEnrollmentClosingDate = "" OR len(mEnrollmentClosingDate) = 0 then
                ValidateClosingDate = "Closing Date cannot be NULL"
                ErrorFound = True
            elseif mStartDate <> "" OR len(mStartDate) > 0 then
                if cdate(mEnrollmentClosingDate) > cdate(mStartDate) then
                    ValidateClosingDate = "Closing Date cannot be greater than Start Date"
                    ErrorFound = True
                end if
            else
                ValidateClosingDate = "Closing Date cannot be used without Start Date"
                ErrorFound = True
            end if
        end function
    'end

    'ValidateCourseFee
        function ValidateCourseFee()
            if mCourseFee = "" or isNull(mCourseFee) then
                ValidateCourseFee = "Course Fee cannot be NULL or Zero"
                ErrorFound = True
            elseif cint(mCourseFee) <= 0 then
                ValidateCourseFee = "Course Fee cannot be less than OR equal to Zero"
                ErrorFound = True
            end if
        end function
    'end
'End

Function GetConflictedTimeSlot()
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

Function IsRoomConflict()
    Dim RSFilterRec
    dim IsConflict
    
    IsConflict = false

    Set RSFilterRec = Server.CreateObject("ADODB.RecordSet")
    QryStr = "SELECT * FROM V_CourseDirectoryView WHERE (StartDate <= '" & mEndDate & "') AND (EndDate >= '" & mStartDate & "') AND (CourseDirectoryStatusId = 1) AND (TimeSlotId IN " & GetConflictedTimeSlot() & ") AND (RoomId = " & mRoomId & ") AND (CourseDirectoryId <> " & mCourseDirectoryId & ")"
    'response.write(QryStr)
    RSFilterRec.open QryStr, conn

    if NOT RSFilterRec.EOF then
        IsConflict = True
        'Session("sConflictedRoom") = "Invalid Room Id, Room not available"
    end if

    RSFilterRec.close
    set RSFilterRec = Nothing
    IsRoomConflict = IsConflict
end function

Function IsInstructorConflict()
    Dim RSFilterRec
    dim IsConflict
    
    IsConflict = false

    Set RSFilterRec = Server.CreateObject("ADODB.RecordSet")
    QryStr = "SELECT * FROM V_CourseDirectoryView WHERE (StartDate <= '" & mEndDate & "') AND (EndDate >= '" & mStartDate & "') AND (CourseDirectoryStatusId = 1) AND (TimeSlotId IN " & GetConflictedTimeSlot() & ") AND (InstructorId = " & mInstructorId & ") AND (CourseDirectoryId <> " & mCourseDirectoryId & ")"
    'response.write(QryStr)
    RSFilterRec.open QryStr, conn

    if NOT RSFilterRec.EOF then
        IsConflict = True
    end if

    RSFilterRec.close
    set RSFilterRec = Nothing
    IsInstructorConflict = IsConflict
end function
%>