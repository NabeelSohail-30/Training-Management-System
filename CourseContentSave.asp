<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->
<%
    'Variable Declaration
        dim mCourseCode
        dim mCourseName
        dim mCourseDescription
        dim mCourseCategoryId
        dim mCourseSubCategoryId
        dim mAudience
        'dim ErrorFound
        Session("sCourseCode") = ""
        Session("sCourseName") = ""
        Session("sCourseCategory") = ""
        Session("sCourseSubCategory") = ""

        Session("smCourseCode") = ""
        Session("smCourseName") = ""
        Session("smCourseCategory") = ""
        Session("smCourseSubCategory") = ""
        Session("smCourseDescription") = ""
        Session("smAudience") = ""
    'end

    'Variable Initialization
        mCourseCode = request.Form("FormCourseCode")
        mCourseName = request.Form("FormCourseName")
        mCourseDescription = request.Form("FormCourseDescription")
        mCourseCategoryId = cint(request.Form("FormCourseCategoryId"))
        mCourseSubCategoryId = cint(request.Form("FormCourseSubCategoryId"))
        mAudience = request.Form("FormAudience")
        ErrorFound = False
    'end

    'Validations
        Session("sCourseCode") = ValidateCourseCode()
        Session("sCourseName") = ValidateCourseName()
        Session("sCourseCategory") = ValidateCategory()
        Session("sCourseSubCategory") = ValidateSubCategory()

        Session("smCourseCode") = mCourseCode
        Session("smCourseName") = mCourseName
        Session("smCourseCategory") = mCourseCategoryId
        Session("smCourseSubCategory") = mCourseSubCategoryId
        Session("smCourseDescription") = mCourseDescription
        Session("smAudience") = mAudience

        if ErrorFound=true then
            response.Redirect("CourseContentAdd.asp")
        end if
    'end

    'Check for Duplicate

    'end

    'Insert Rec
        QryStr = "INSERT INTO CourseContent (CourseCode, CourseName, CategoryId, SubCategoryId, CourseDescription, Audience, UserCreatedBy)" & _
                " Values('" & mCourseCode & "', '" & mCourseName & "', " & mCourseCategoryId & ", " & mCourseSubCategoryId & ", '" & mCourseDescription & _
                "', '" & mAudience & "', " & Session("SUserId") & ")"

        'response.Write(Qrystr)
        conn.execute QryStr

    'end

    'Redirect
        response.redirect("CourseContent.asp")
    'end

'Functions

    'ValidateCourseCode
    function ValidateCourseCode()
        if mCourseCode = "" then 
            ValidateCourseCode = "Course Code cannot be Null"
            ErrorFound = True
        elseif len(mCourseCode) > 10 then
            ValidateCourseCode = "Max Length is 10"
            ErrorFound = True
        else
            Dim RSCourseCode
            Set RSCourseCode = Server.CreateObject("ADODB.RecordSet")
            RSCourseCode.open "SELECT * FROM CourseContent WHERE(CourseCode = '" & mCourseCode & "')", conn
            if RSCourseCode.eof = false then
                ValidateCourseCode = "Duplicate Course Code Found"
                ErrorFound = True
            end if
        end if
    end function
    'end

    'ValidateCourseName
        function ValidateCourseName()
            if mCourseName = "" then 
                ValidateCourseName = "Course Name cannot be Null"
                ErrorFound = True
            elseif len(mCourseName) > 150 then
                ValidateCourseName = "Max Length is 150"
                ErrorFound = True
            else 
                Dim RSName
                Set RSName = Server.CreateObject("ADODB.RecordSet")
                RSName.open "SELECT * FROM CourseContent WHERE(CourseName = '" & mCourseName & "')", conn
                if RSName.eof = False then
                    ValidateCourseName = "Duplicate Course Name Found"
                    ErrorFound = True
                    RSName.close 
                    set RSName = Nothing
                end if
            end if
        end function
    'end

    'ValidateCategory
        function ValidateCategory()
            if mCourseCategoryId = -1 then
                ValidateCategory = "No Category Selected"
                ErrorFound = True
            else
                Dim RSCatg
                Set RSCatg = Server.CreateObject("ADODB.RecordSet")
                RSCatg.open "SELECT * FROM ListCourseCategory WHERE(CategoryId = " & mCourseCategoryId & ")", conn
                if RSCatg.eof then 
                    ValidateCategory = "Category not found in Database"
                    ErrorFound = True
                end if
            end if
        end function
    'end

    'ValidateSubCategory
        function ValidateSubCategory()
            if mCourseSubCategoryId = -1 then
            ValidateSubCategory = "No Sub Category Selected"
                ErrorFound = True
            else
                Dim RSSubCatg
                Set RSSubCatg = Server.CreateObject("ADODB.RecordSet")
                RSSubCatg.open "SELECT * FROM ListCourseSubCategory WHERE(SubCategoryId = " & mCourseSubCategoryId & ")", conn
                if RSSubCatg.eof then 
                    ValidateSubCategory = "Sub Category not found in Database"
                    ErrorFound = True
                end if
            end if
        end function
    'end

'end
%>