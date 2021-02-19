<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->
<%
    'Variables Declaration Start
        'Memory Variables
            Dim StdGrNum
            Dim StdNIC
            Dim StdFirstName
            Dim StdMidName
            Dim StdLastName
            Dim StdDob
            Dim StdNationalityId
            Dim StdPob
            Dim StdReligionId
            Dim StdGenderId
            Dim StdMaritalStatusId
            Dim StdMobile
            Dim StdEmail
            Dim StdTelephone
            Dim StdOccupationId
            Dim StdJobDesignationId
            Dim StdCompany
            Dim StdWorkPhone
            Dim FatherName
            Dim FatherNIC
            Dim FatherMobile
            Dim FatherEmail
            Dim FatherOccupationId
            Dim FatherJobDesignationId
            Dim FatherCompany
            Dim FatherWorkPhone
            Dim UserId
            Dim Counter
            'Dim QryStr
            'Dim ErrorFound
        'End
        
        'RS Variables
            Dim RSAddStd
            Dim RSGrNumber
            Dim RSNationality
            Dim RSReligion
            Dim RSGender
            Dim RSMaritalStatus
            Dim RSOccupation
            Dim RSJobDesignation
        'End
        
        'Session Variables
            Session("ErrorNIC")=""
            Session("ErrorFirstName") = ""
            Session("ErrorMidName") = ""
            Session("ErrorLastName") = ""
            Session("ErrorDob") = ""
            Session("ErrorNationality") = ""
            Session("ErrorPob") = ""
            Session("ErrorReligion") = ""
            Session("ErrorGender") = ""
            Session("ErrorMaritalSt") = ""
            Session("ErrorStdMob") = ""
            Session("ErrorStdEmail") = ""
            Session("ErrorStdTel") = ""
            Session("ErrorStdOcc") = ""
            Session("ErrorStdJob") = ""
            Session("ErrorStdCompany") = ""
            Session("ErrorStdWorkTel") = ""
            Session("ErrorFatherName") = ""
            Session("ErrorFatherNic") = ""
            Session("ErrorFatherMob") = ""
            Session("ErrorFatherEmail") = ""
            Session("ErrorFatherOcc") = ""
            Session("ErrorFatherJob") = ""
            Session("ErrorFatherComp") = ""
            Session("ErrorFatherWorkTel") = ""
        'End
    'End

    'Memory Variables Initializing(Form Var into Memory Var) Start
        call InitializeMVariables()
    'End

    'Opening Db(From Header File) Start
        call OpenDbConn()
    'End

    'Validations Start
       
        'ValidateNIC
            Call ValidateNIC(StdNIC,Session("ErrorNIC"))
        'End

        'ValidateStdFirstName
            Call ValidateStdFirstName(Session("ErrorFirstName"))
        'End

        'ValidateStdMidName
            Call ValidateStdMidName(Session("ErrorMidName"))
        'End

        'ValidateStdLastName
            Call ValidateStdLastName(Session("ErrorLastName"))
        'End

        'ValidateStdDob
            call ValidateStdDob(Session("ErrorDob"))
        'end

        'ValidateNationality
            call ValidateNationality(Session("ErrorNationality"))
        'end

        'ValidatePOB
            call ValidatePOB(Session("ErrorPob"))
        'end

        'ValidateReligion
            call ValidateReligion(Session("ErrorReligion"))
        'end

        'ValidateGender
            call ValidateGender(Session("ErrorGender"))
        'end

        'ValidateMaritalSt
            call ValidateMaritalSt(Session("ErrorMaritalSt"))
        'end

        'ValidateMobileNumber
            call ValidateMobileNumber(StdMobile,Session("ErrorStdMob"))
        'end

        'ValidateEmail
            call ValidateEmail(StdEmail,Session("ErrorStdEmail"))
        'end

        'ValidateHomeTelephone
            call ValidateHomeTelephone(Session("ErrorStdTel"))
        'end

        'ValidateOccupation
            call ValidateOccupation(StdOccupationId,Session("ErrorStdOcc"))
        'End

        'ValidateJobDesignation
            call ValidateJobDesignation(StdJobDesignationId,Session("ErrorStdJob"))
        'End

        'ValidateCompanyName
            call ValidateCompanyName(StdCompany,Session("ErrorStdCompany"))
        'end

        'ValidateWorkPhone
            call ValidateWorkPhone(StdWorkPhone,Session("ErrorStdWorkTel"))
        'end

        'ValidateFatherName
            call ValidateFatherName(Session("ErrorFatherName"))
        'end

        'ValidateNIC
            Call ValidateNIC(FatherNIC,Session("ErrorFatherNic"))
        'End

        'ValidateMobileNumber
            call ValidateMobileNumber(FatherMobile,Session("ErrorFatherMob"))
        'end

        'ValidateEmail
            call ValidateEmail(FatherEmail,Session("ErrorFatherEmail"))
        'end

        'ValidateOccupation
            call ValidateOccupation(FatherOccupationId,Session("ErrorFatherOcc"))
        'End

        'ValidateJobDesignation
            call ValidateJobDesignation(FatherJobDesignationId,Session("ErrorFatherJob"))
        'End

        'ValidateCompanyName
            call ValidateCompanyName(FatherCompany,Session("ErrorFatherComp"))
        'end

        'ValidateWorkPhone
            call ValidateWorkPhone(FatherWorkPhone,Session("ErrorFatherWorkTel"))
        'end

        'Redirect with Errors in Session Variables
            if ErrorFound=true then
                response.Redirect("AddNewStdProfile.asp")
            end if
        'End
    'End

    'Generating Auto Gr Number using GenerateGrNum Function
        StdGrNum = StdGrNum & GenerateGrNum()
    'End

    'Inserting Rec using InsertStudent Procedure
        call InsertStudent()
    'Inserting Rec End

    'Redirecting to View Page
        response.Redirect("StudentProfile.asp")
    'End

    'Procedures and Functions

    'InitializeMVariables Procedure
        Sub InitializeMVariables()
            StdGrNum = "GR-"
            StdNIC = request.form("FormStdNIC")
            StdFirstName = request.form("FormStdFirstName")
            StdMidName = request.form("FormStdMidName")
            StdLastName = request.form("FormStdLastName")
            StdDob = request.form("FormStdDob")
            StdNationalityId = Cint(request.form("FormStdNationalityId"))
            StdPob = request.form("FormStdPob")
            StdReligionId = Cint(request.form("FormStdReligionId"))
            StdGenderId = Cint(request.form("FormStdGenderId"))
            StdMaritalStatusId = Cint(request.form("FormStdMaritalId"))
            StdMobile = request.form("FormStdMob")
            StdEmail = request.form("FormStdEmail")
            StdTelephone = request.form("FormStdTelephone")
            StdOccupationId = Cint(request.form("FormStdOccupationId"))
            StdJobDesignationId = Cint(request.form("FormStdJobDesignationId"))
            StdCompany = request.form("FormStdCompany")
            StdWorkPhone = request.form("FormStdWorkPhone")
            FatherName = request.form("FormFatherName")
            FatherNIC = request.form("FormFatherNIC")
            FatherMobile = request.form("FormFatherMobile")
            FatherEmail = request.form("FormFatherEmail")
            FatherOccupationId = Cint(request.form("FormFatherOccupationId"))
            FatherJobDesignationId = Cint(request.form("FormFatherJobDesignationId"))
            FatherCompany = request.form("FormFatherCompany")
            FatherWorkPhone = request.form("FormFatherWorkPhone")
            UserId = Cint(Session("SUserId"))
            ErrorFound = False
        End sub 
    'End

    'GenerateGrNum Function
        Function GenerateGrNum()
            Set RSGrNumber = Server.CreateObject("ADODB.RecordSet")
            RSGrNumber.Open "SELECT COUNT(StudentId)+1 AS TotalRec FROM StudentDetail",Conn
            GenerateGrNum = RSGrNumber("TotalRec")
        End function 
    'End

    'InsertStudent 
        Sub InsertStudent()
            QryStr = "INSERT INTO StudentDetail (StdGrNumber,StdNICNumber,StdFirstName,StdMidName,StdLastName,StdDateOfBirth,StdNationalityId,StdPlaceOfBirth,StdGenderId,StdReligionId,StdMaritalStatusId," & _
                    "StdMobileNumber,StdEmailAddress,StdHomeTelephone,StdOccupationId,StdJobDesignationId,StdCompanyName,StdWorkTelephone," & _
                    "FatherName,FatherNICNumber,FatherMobileNumber,FatherEmailAddress,FatherOccupationId,FatherJobDesignationId,FatherCompanyName,FatherWorkTelephone,UserCreatedBy)" & _
                    "Values('" & StdGrNum & "', '" & StdNIC & "', '" & StdFirstName & "', '" & StdMidName & "', '" & StdLastName & "', '" & StdDob & "', " & _
                    StdNationalityId & ", '" & StdPob & "', " & StdGenderId & ", " & StdReligionId & ", " & StdMaritalStatusId & ", '" & StdMobile & "', '" & _
                    StdEmail & "', '" & StdTelephone & "', " & StdOccupationId & ", " & StdJobDesignationId & ", '" & StdCompany & "', '" & StdWorkPhone & "', '" & _
                    FatherName & "', '" & FatherNIC & "', '" & FatherMobile & "', '" & StdEmail & "', " & StdOccupationId & ", " & StdJobDesignationId & ", '" & _
                    StdCompany & "', '" & StdWorkPhone & "'," & UserId & ")"
                    
            'response.Write qrystr
            'response.End
            Conn.Execute QryStr
        End sub
    'End

    'ValidateNIC
        sub ValidateNIC(NIC, byRef TargetError)
            TargetError=""
            if isNull(NIC) = true OR NIC = "" then
                TargetError = "NIC Number cannot be NULL"
                ErrorFound = true
            elseif len(NIC) < 15 OR len(NIC) > 15 then
                TargetError = "NIC length must be 15"            
                ErrorFound = true
            elseif mid(NIC,7,1) <> "-" OR mid(NIC,14,1) <> "-" then
                TargetError = "Invalid NIC Format"
                ErrorFound = true
            elseif IsNumeric(mid(NIC,14,1)) = false then
                TargetError = "NIC cannot contain Non Numeric Character"
                ErrorFound = true
            else
                for counter = 1 to 5
                    if IsNumeric(mid(NIC,counter,1)) = false then
                        TargetError = "NIC cannot contain Non Numeric Character"
                        ErrorFound = true
                        exit for
                    end if
                next

                for counter = 7 to 12
                    if IsNumeric(mid(NIC,counter,1)) = false then
                        TargetError = "NIC cannot contain Non Numeric Character"
                        ErrorFound = true
                        exit for
                    end if
                next
            end if
        End sub
    'End

    'ValidateStdFirstName
        Sub ValidateStdFirstName(ByRef TargetError)
            TargetError = ""
            if StdFirstName = "" OR IsNull(StdFirstName) = true then
                TargetError = "First Name cannot be NULL"
                ErrorFound = true
            elseif len(StdFirstName) > 15 then
                TargetError = "Maximum Length for First Name is 15 characters"
                ErrorFound = true
            else
                for counter = 1 to len(StdFirstName)
                    if Asc(mid(StdFirstName,counter,1)) >= 65 AND Asc(mid(StdFirstName,counter,1)) <= 90 then
                        ErrorFound = false
                    elseif Asc(mid(StdFirstName,counter,1)) >= 97 AND Asc(mid(StdFirstName,counter,1)) <= 122 then
                        ErrorFound = false
                    else
                        TargetError = "Invalid Character Found in First Name"
                        ErrorFound = true
                        exit for
                    end if
                next
            end if
        End sub
    'End

    'ValidateStdMidName
        Sub ValidateStdMidName(ByRef TargetError)
            TargetError = ""
            if len(StdMidName) > 15 then
                TargetError = "Maximum Length for Mid Name is 15 characters"
                ErrorFound = true
            else
                for counter = 1 to len(StdMidName)
                    if Asc(mid(StdMidName,counter,1)) >= 65 AND Asc(mid(StdMidName,counter,1)) <= 90 then
                        ErrorFound = false
                    elseif Asc(mid(StdMidName,counter,1)) >= 97 AND Asc(mid(StdMidName,counter,1)) <= 122 then
                        ErrorFound = false
                    else
                        TargetError = "Invalid Character Found in Mid Name"
                        ErrorFound = true
                        exit for
                    end if
                next
            end if
        End sub
    'End

    'ValidateStdLastName
        Sub ValidateStdLastName(ByRef TargetError)
            TargetError = ""
            if StdLastName = "" OR IsNull(StdLastName) = true then
                TargetError = "Last Name cannot be NULL"
                ErrorFound = true
            elseif len(StdLastName) > 15 then
                TargetError = "Maximum Length for Last Name is 15 characters"
                ErrorFound = true
            else
                for counter = 1 to len(StdLastName)
                    if Asc(mid(StdLastName,counter,1)) >= 65 AND Asc(mid(StdLastName,counter,1)) <= 90 then
                        ErrorFound = false
                    elseif Asc(mid(StdLastName,counter,1)) >= 97 AND Asc(mid(StdLastName,counter,1)) <= 122 then
                        ErrorFound = false
                    else
                        TargetError = "Invalid Character Found in Last Name"
                        ErrorFound = true
                        exit for
                    end if
                next
            end if
        End sub
    'End

    'ValidateStdDob
        Sub ValidateStdDob(ByRef TargetError)
            TargetError = ""
            if StdDob = "" OR IsNull(StdDob) = true then
                TargetError = "Date of Birth cannot be NULL"
                ErrorFound = true
            end if
        End sub
    'End

    'ValidateNationality
        Sub ValidateNationality(ByRef TargetError)
            TargetError = ""
            if StdNationalityId = -1 then
                TargetError = "No Nationality Selected"
                ErrorFound = true
            else
                set RSNationality = Server.CreateObject("ADODB.RecordSet")
                RSNationality.Open "SELECT * FROM ListNationality WHERE(NationalityId = " & StdNationalityId & ")",Conn
                if RSNationality.EOF = true then
                    TargetError = "Nationality not found in Database"
                    ErrorFound = true
                end if
            end if
        End sub
    'End

    'ValidatePOB
        Sub ValidatePOB(ByRef TargetError)
            TargetError = ""
            if StdPob = "" OR IsNull(StdPob) = true then
                TargetError = "Place of Birth cannot be NULL"
                ErrorFound = true
            elseif len(StdPob) > 25 then
                TargetError = "Maximum Length for Place of Birth is 25 characters"
                ErrorFound = true
            else
                for counter = 1 to len(StdPob)
                    if Asc(mid(StdPob,counter,1)) >= 65 AND Asc(mid(StdPob,counter,1)) <= 90 then
                        ErrorFound = false
                    elseif Asc(mid(StdPob,counter,1)) >= 97 AND Asc(mid(StdPob,counter,1)) <= 122 then
                        ErrorFound = false
                    else
                        TargetError = "Invalid Character Found in Place of Birth"
                        ErrorFound = true
                        exit for
                    end if
                next
            end if
        End sub
    'End
    
    'ValidateReligion
        Sub ValidateReligion(byRef TargetError)
            TargetError = ""
            if StdReligionId = -1 then
                TargetError = "No Religion Selected"
                ErrorFound = true
            else
                set RSReligion = Server.CreateObject("ADODB.RecordSet")
                RSReligion.Open "SELECT * FROM ListReligion WHERE(ReligionId = " & StdReligionId & ")",Conn
                if RSReligion.EOF = true then
                    TargetError = "Religion not found in Database"
                    ErrorFound = true
                end if
            end if
        End sub
    'End

    'ValidateGender
        Sub ValidateGender(ByRef TargetError)
            TargetError = ""
            if StdGenderId = -1 then
                TargetError = "No Gender Selected"
                ErrorFound = true
            else
                set RSGender = Server.CreateObject("ADODB.RecordSet")
                RSGender.Open "SELECT * FROM ListGender WHERE(GenderId = " & StdGenderId & ")",Conn
                if RSGender.EOF = true then
                    TargetError = "Gneder not found in Database"
                    ErrorFound = true
                end if
            end if
        End sub
    'End

    'ValidateMaritalSt
        Sub ValidateMaritalSt(ByRef TargetError)
            TargetError = ""
            if StdMaritalStatusId = -1 then
                TargetError = "No Marital Status Selected"
                ErrorFound = true
            else
                set RSMaritalStatus = Server.CreateObject("ADODB.RecordSet")
                RSMaritalStatus.Open "SELECT * FROM ListMaritalStatus WHERE(MaritalStatusId = " & StdMaritalStatusId & ")",Conn
                if RSMaritalStatus.EOF = true then
                    TargetError = "Marital Status not found in Database"
                    ErrorFound = true
                end if
            end if
        End sub
    'End

    'ValidateMobileNumber
        sub ValidateMobileNumber(MobNum, ByRef TargetError)
            TargetError = ""
            if MobNum = "" OR IsNull(MobNum) = true then
                TargetError = "Mobile Number cannot be left NULL"
                ErrorFound = true
            elseif len(MobNum) > 20 then
                TargetError = "Max Length for Mobile Number is 20"
                ErrorFound = true
            elseif IsNumeric(MobNum) = true then
                TargetError = "Invalid Character Found in Mobile Number"
                ErrorFound = true
            end if
        End sub
    'End

    'ValidateEmail
        sub ValidateEmail(Email, ByRef TargetError)
            TargetError = ""
            if Email = "" OR IsNull(Email) = true then
                TargetError = "Email cannot be left NULL"
                ErrorFound = true
            elseif len(Email) > 20 then
                TargetError = "Max Length for Email is 30"
                ErrorFound = true
            end if
        End sub
    'End

    'ValidateHomeTelephone
        Sub ValidateHomeTelephone(ByRef TargetError)
            TargetError = ""
            if StdTelephone = "" OR IsNull(StdTelephone) = true then
                TargetError = "Home Telephone Number cannot be left NULL"
                ErrorFound = true
            elseif len(StdTelephone) > 20 then
                TargetError = "Max Length for Home Telephone Number is 20"
                ErrorFound = true
            elseif IsNumeric(StdTelephone) = true then
                TargetError = "Invalid Character Found in Home Telephone Number"
                ErrorFound = true
            end if
        End sub
    'End

    'Occupation
        Sub ValidateOccupation(Occupation,ByRef TargetError)
            TargetError = ""
            if Occupation <> -1 then
                set RSOccupation = Server.CreateObject("ADODB.RecordSet")
                RSOccupation.Open "SELECT * FROM ListOccupation WHERE(OccupationId = " & Occupation & ")",Conn
                if RSOccupation.EOF = true then
                    TargetError = "Occupation not found in Database"
                    ErrorFound = true
                end if
            end if
        End sub
    'End

    'JobDesignation
        Sub ValidateJobDesignation(JobDesignation,ByRef TargetError)
            TargetError = ""
            if JobDesignation <> -1 then
                set RSJobDesignation = Server.CreateObject("ADODB.RecordSet")
                RSJobDesignation.Open "SELECT * FROM ListJobDesignation WHERE(JobDesignationId = " & JobDesignation & ")",Conn
                if RSJobDesignation.EOF = true then
                    TargetError = "Job Designation not found in Database"
                    ErrorFound = true
                end if
            end if
        End sub
    'End

    'ValidateCompanyName
        sub ValidateCompanyName(CompanyName, ByRef TargetError)
            if len(CompanyName) > 50 then
                TargetError = "Max Length for Company Name is 50"
                ErrorFound = true
            end if
        end sub
    'End

    'ValidateWorkPhone
        sub ValidateWorkPhone(WorkNum, ByRef TargetError)
            TargetError = ""
            if len(WorkNum) > 20 then
                TargetError = "Max Length for Work Phone Number is 20"
                ErrorFound = true
            elseif IsNumeric(WorkNum) = true then
                TargetError = "Invalid Character Found in Work Phone Number"
                ErrorFound = true
            end if
        End sub
    'End

    'ValidateFatherName
        Sub ValidateFatherName(ByRef TargetError)
            TargetError = ""
            if FatherName = "" OR IsNull(FatherName) = true then
                TargetError = "Father Name cannot be NULL"
                ErrorFound = true
            elseif len(FatherName) > 15 then
                TargetError = "Maximum Length for Father Name is 15 characters"
                ErrorFound = true
            else
                for counter = 1 to len(FatherName)
                    if Asc(mid(FatherName,counter,1)) >= 65 AND Asc(mid(FatherName,counter,1)) <= 90 then
                        ErrorFound = false
                    elseif Asc(mid(FatherName,counter,1)) >= 97 AND Asc(mid(FatherName,counter,1)) <= 122 then
                        ErrorFound = false
                    else
                        TargetError = "Invalid Character Found in Father Name"
                        ErrorFound = true
                        exit for
                    end if
                next
            end if
        End sub
    'End

    'CloseAllRS
        
    'End
%>
