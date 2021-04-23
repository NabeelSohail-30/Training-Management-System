<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->
<%

    'Variables Declaration Start
        'Memory Variables
            Dim StdId
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

            Dim RSNationality
            Dim RSReligion
            Dim RSGender
            Dim RSMaritalStatus
            Dim RSOccupation
            Dim RSJobDesignation
        'End

        'RS Variables
            Dim RSAddStd
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
            Session("ErrorNIC")= ValidateNIC(StdNIC)
        'End

        'ValidateStdFirstName
            Session("ErrorFirstName") = ValidateStdFirstName()
        'End

        'ValidateStdMidName
            Session("ErrorMidName") = ValidateStdMidName()
        'End

        'ValidateStdLastName
            Session("ErrorLastName") = ValidateStdLastName()
        'End

        'ValidateStdDob
            Session("ErrorDob") = ValidateStdDob()
        'end

        'ValidateNationality
            Session("ErrorNationality") = ValidateNationality()
        'end

        'ValidatePOB
            Session("ErrorPob") = ValidatePOB()
        'end

        'ValidateReligion
            Session("ErrorReligion") = ValidateReligion()
        'end

        'ValidateGender
            Session("ErrorGender") = ValidateGender()
        'end

        'ValidateMaritalSt
            Session("ErrorMaritalSt") = ValidateMaritalSt()
        'end

        'ValidateMobileNumber
            Session("ErrorStdMob") = ValidateMobileNumber(StdMobile)
        'end

        'ValidateEmail
            Session("ErrorStdEmail") = ValidateEmail(StdEmail)
        'end

        'ValidateHomeTelephone
            Session("ErrorStdTel") = ValidateHomeTelephone()
        'end
        
        'ValidateOccupation
            Session("ErrorStdOcc") = ValidateOccupation(StdOccupationId)
        'End
        
        'ValidateJobDesignation
            Session("ErrorStdJob") = ValidateJobDesignation(StdJobDesignationId)
        'End

        'ValidateCompanyName
            Session("ErrorStdCompany") = ValidateCompanyName(StdCompany)
        'end
        
        'ValidateWorkPhone
            Session("ErrorStdWorkTel") = ValidateWorkPhone(StdWorkPhone)
        'end
        
        'ValidateFatherName
            Session("ErrorFatherName") = ValidateFatherName()
        'end
        
        'ValidateNIC
            Session("ErrorFatherNic") = ValidateNIC(FatherNIC)
        'End
        
        'ValidateMobileNumber
            Session("ErrorFatherMob") = ValidateMobileNumber(FatherMobile)
        'end
        
        'ValidateEmail
            Session("ErrorFatherEmail") = ValidateEmail(FatherEmail)
        'end
        
        'ValidateOccupation
            Session("ErrorFatherOcc") = ValidateOccupation(FatherOccupationId)
        'End

        'ValidateJobDesignation
            Session("ErrorFatherJob") = ValidateJobDesignation(FatherJobDesignationId)
        'End
        
        'ValidateCompanyName
            Session("ErrorFatherComp") = ValidateCompanyName(FatherCompany)
        'end

        'ValidateWorkPhone
            Session("ErrorFatherWorkTel") = ValidateWorkPhone(FatherWorkPhone)
        'end

        'Redirect with Errors in Session Variables
            if ErrorFound=true then
                response.Redirect("EditStudentDetail.asp?QsStdId=" & StdId)
            end if
        'End
    'End

    'Inserting Rec using InsertStudent Procedure
        call UpdateStudent()
    'Inserting Rec End

    'Redirecting to View Page
        response.Redirect("StudentProfile.asp")
    'End

    'Procedures and Functions

    'InitializeMVariables Procedure
        Sub InitializeMVariables()
            StdId = request.form("FormStdId")
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

    'ValidateNIC
    Function ValidateNIC(NIC)
        if isNull(NIC) = true OR NIC = "" then
        ValidateNIC = "NIC Number cannot be NULL"
            ErrorFound = true
            
        elseif len(NIC) < 15 OR len(NIC) > 15 then
        ValidateNIC = "NIC length must be 15"            
            ErrorFound = true
            
        elseif mid(NIC,7,1) <> "-" OR mid(NIC,14,1) <> "-" then
        ValidateNIC = "Invalid NIC Format"
            ErrorFound = true
            
        elseif IsNumeric(mid(NIC,15,1)) = false then
        ValidateNIC = "NIC cannot contain Non Numeric Character"
            ErrorFound = true
        else
            for counter = 1 to 6
                if IsNumeric(mid(NIC,counter,1)) = false then
                ValidateNIC = "NIC cannot contain Non Numeric Character"
                    ErrorFound = true
                    exit for
                end if
            next

            for counter = 8 to 13
                if IsNumeric(mid(NIC,counter,1)) = false then
                ValidateNIC = "NIC cannot contain Non Numeric Character"
                    ErrorFound = true
                    exit for
                end if
            next
        end if
    End Function
    'End

    'ValidateStdFirstName
        Function ValidateStdFirstName()
            if StdFirstName = "" OR IsNull(StdFirstName) = true then
                ValidateStdFirstName = "First Name cannot be NULL"
                ErrorFound = true
            elseif len(StdFirstName) > 15 then
                ValidateStdFirstName = "Maximum Length for First Name is 15 characters"
                ErrorFound = true
            else
                for counter = 1 to len(StdFirstName)
                    if Asc(mid(StdFirstName,counter,1)) >= 65 AND Asc(mid(StdFirstName,counter,1)) <= 90 then
                        ErrorFound = false
                    elseif Asc(mid(StdFirstName,counter,1)) >= 97 AND Asc(mid(StdFirstName,counter,1)) <= 122 then
                        ErrorFound = false
                    else
                        ValidateStdFirstName = "Invalid Character Found in First Name"
                        ErrorFound = true
                        exit for
                    end if
                next
            end if
        End Function
    'End

    'ValidateStdMidName
        Function ValidateStdMidName()
            
            if len(StdMidName) > 15 then
                ValidateStdMidName = "Maximum Length for Mid Name is 15 characters"
                ErrorFound = true
            else
                for counter = 1 to len(StdMidName)
                    if Asc(mid(StdMidName,counter,1)) >= 65 AND Asc(mid(StdMidName,counter,1)) <= 90 then
                        ErrorFound = false
                    elseif Asc(mid(StdMidName,counter,1)) >= 97 AND Asc(mid(StdMidName,counter,1)) <= 122 then
                        ErrorFound = false
                    else
                        ValidateStdMidName = "Invalid Character Found in Mid Name"
                        ErrorFound = true
                        exit for
                    end if
                next
            end if
        End Function
    'End

    'ValidateStdLastName
        Function ValidateStdLastName()
            
            if StdLastName = "" OR IsNull(StdLastName) = true then
                ValidateStdLastName = "Last Name cannot be NULL"
                ErrorFound = true
            elseif len(StdLastName) > 15 then
                ValidateStdLastName = "Maximum Length for Last Name is 15 characters"
                ErrorFound = true
            else
                for counter = 1 to len(StdLastName)
                    if Asc(mid(StdLastName,counter,1)) >= 65 AND Asc(mid(StdLastName,counter,1)) <= 90 then
                        ErrorFound = false
                    elseif Asc(mid(StdLastName,counter,1)) >= 97 AND Asc(mid(StdLastName,counter,1)) <= 122 then
                        ErrorFound = false
                    else
                        ValidateStdLastName = "Invalid Character Found in Last Name"
                        ErrorFound = true
                        exit for
                    end if
                next
            end if
        End Function
    'End

    'ValidateStdDob
        Function ValidateStdDob()
            
            if StdDob = "" OR IsNull(StdDob) = true then
                ValidateStdDob = "Date of Birth cannot be NULL"
                ErrorFound = true
            end if
        End Function
    'End

    'ValidateNationality
        Function ValidateNationality()
            
            if StdNationalityId = -1 then
                ValidateNationality = "No Nationality Selected"
                ErrorFound = true
            else
                set RSNationality = Server.CreateObject("ADODB.RecordSet")
                RSNationality.Open "SELECT * FROM ListNationality WHERE(NationalityId = " & StdNationalityId & ")",Conn
                if RSNationality.EOF = true then
                    ValidateNationality = "Nationality not found in Database"
                    ErrorFound = true
                end if
            end if
        End Function
    'End

    'ValidatePOB
        Function ValidatePOB()
            
            if StdPob = "" OR IsNull(StdPob) = true then
                ValidatePOB = "Place of Birth cannot be NULL"
                ErrorFound = true
            elseif len(StdPob) > 25 then
                ValidatePOB = "Maximum Length for Place of Birth is 25 characters"
                ErrorFound = true
            else
                for counter = 1 to len(StdPob)
                    if Asc(mid(StdPob,counter,1)) >= 65 AND Asc(mid(StdPob,counter,1)) <= 90 then
                        ErrorFound = false
                    elseif Asc(mid(StdPob,counter,1)) >= 97 AND Asc(mid(StdPob,counter,1)) <= 122 then
                        ErrorFound = false
                    else
                        ValidatePOB = "Invalid Character Found in Place of Birth"
                        ErrorFound = true
                        exit for
                    end if
                next
            end if
        End Function
    'End

    'ValidateReligion
        Function ValidateReligion()
            
            if StdReligionId = -1 then
                ValidateReligion = "No Religion Selected"
                ErrorFound = true
            else
                set RSReligion = Server.CreateObject("ADODB.RecordSet")
                RSReligion.Open "SELECT * FROM ListReligion WHERE(ReligionId = " & StdReligionId & ")",Conn
                if RSReligion.EOF = true then
                    ValidateReligion = "Religion not found in Database"
                    ErrorFound = true
                end if
            end if
        End Function
    'End

    'ValidateGender
        Function ValidateGender()
            
            if StdGenderId = -1 then
                ValidateGender = "No Gender Selected"
                ErrorFound = true
            else
                set RSGender = Server.CreateObject("ADODB.RecordSet")
                RSGender.Open "SELECT * FROM ListGender WHERE(GenderId = " & StdGenderId & ")",Conn
                if RSGender.EOF = true then
                    ValidateGender = "Gender not found in Database"
                    ErrorFound = true
                end if
            end if
        End Function
    'End

    'ValidateMaritalSt
        Function ValidateMaritalSt()
            
            if StdMaritalStatusId = -1 then
                ValidateMaritalSt = "No Marital Status Selected"
                ErrorFound = true
            else
                set RSMaritalStatus = Server.CreateObject("ADODB.RecordSet")
                RSMaritalStatus.Open "SELECT * FROM ListMaritalStatus WHERE(MaritalStatusId = " & StdMaritalStatusId & ")",Conn
                if RSMaritalStatus.EOF = true then
                    ValidateMaritalSt = "Marital Status not found in Database"
                    ErrorFound = true
                end if
            end if
        End Function
    'End

    'ValidateMobileNumber
        Function ValidateMobileNumber(MobNum)
            
            if MobNum = "" OR IsNull(MobNum) = true then
                ValidateMobileNumber = "Mobile Number cannot be left NULL"
                ErrorFound = true
            elseif len(MobNum) > 20 then
                ValidateMobileNumber = "Max Length for Mobile Number is 20"
                ErrorFound = true
            elseif IsNumeric(MobNum) = false then
                ValidateMobileNumber = "Invalid Character Found in Mobile Number"
                ErrorFound = true
            end if
        End Function
    'End

    'ValidateEmail
        Function ValidateEmail(Email)
            
            if Email = "" OR IsNull(Email) = true then
                ValidateEmail = "Email cannot be left NULL"
                ErrorFound = true
            elseif len(Email) > 50 then
                ValidateEmail = "Max Length for Email is 50"
                ErrorFound = true
            end if
        End Function
    'End

    'ValidateHomeTelephone
        Function ValidateHomeTelephone()
            
            if StdTelephone = "" OR IsNull(StdTelephone) = true then
                ValidateHomeTelephone = "Home Telephone Number cannot be left NULL"
                ErrorFound = true
            elseif len(StdTelephone) > 20 then
                ValidateHomeTelephone = "Max Length for Home Telephone Number is 20"
                ErrorFound = true
            elseif IsNumeric(StdTelephone) = false then
                ValidateHomeTelephone = "Invalid Character Found in Home Telephone Number"
                ErrorFound = true
            end if
        End Function
    'End

    'Occupation
        Function ValidateOccupation(Occupation)
            
            if Occupation <> -1 then
                set RSOccupation = Server.CreateObject("ADODB.RecordSet")
                RSOccupation.Open "SELECT * FROM ListOccupation WHERE(OccupationId = " & Occupation & ")",Conn
                if RSOccupation.EOF = true then
                    ValidateOccupation = "Occupation not found in Database"
                    ErrorFound = true
                end if
            end if
        End Function
    'End

    'JobDesignation
        Function ValidateJobDesignation(JobDesignation)
            
            if JobDesignation <> -1 then
                set RSJobDesignation = Server.CreateObject("ADODB.RecordSet")
                RSJobDesignation.Open "SELECT * FROM ListJobDesignation WHERE(JobDesignationId = " & JobDesignation & ")",Conn
                if RSJobDesignation.EOF = true then
                    ValidateJobDesignation = "Job Designation not found in Database"
                    ErrorFound = true
                end if
            end if
        End Function
    'End

    'ValidateCompanyName
        Function ValidateCompanyName(CompanyName)
            if len(CompanyName) > 50 then
                ValidateCompanyName = "Max Length for Company Name is 50"
                ErrorFound = true
            end if
        end Function
    'End

    'ValidateWorkPhone
        Function ValidateWorkPhone(WorkNum)
            
            if WorkNum <> "" then
                if len(WorkNum) > 20 then
                    ValidateWorkPhone = "Max Length for Work Phone Number is 20"
                    ErrorFound = true
                elseif IsNumeric(WorkNum) = false then
                    ValidateWorkPhone = "Invalid Character Found in Work Phone Number"
                    ErrorFound = true
                end if
            end if
        End Function
    'End

    'ValidateFatherName
        Function ValidateFatherName()
            
            if FatherName = "" OR IsNull(FatherName) = true then
                ValidateFatherName = "Father Name cannot be NULL"
                ErrorFound = true
            elseif len(FatherName) > 15 then
                ValidateFatherName = "Maximum Length for Father Name is 15 characters"
                ErrorFound = true
            else
                for counter = 1 to len(FatherName)
                    if Asc(mid(FatherName,counter,1)) >= 65 AND Asc(mid(FatherName,counter,1)) <= 90 then
                        ErrorFound = false
                    elseif Asc(mid(FatherName,counter,1)) >= 97 AND Asc(mid(FatherName,counter,1)) <= 122 then
                        ErrorFound = false
                    else
                        ValidateFatherName = "Invalid Character Found in Father Name"
                        ErrorFound = true
                        exit for
                    end if
                next
            end if
        End Function
    'End

    'InsertStudent 
        Sub UpdateStudent()
            QryStr = "UPDATE StudentDetail " & _
                    "Set StdNICNumber = '" & StdNIC & "', StdFirstName = '" & StdFirstName & "', StdMidName = '" & StdMidName & "', StdLastName = '" & StdLastName & _
                    "', StdDateOfBirth = '" & StdDob & "', StdGenderId = " & StdGenderId & ", StdReligionId = " & StdReligionId & ", StdMaritalStatusId = " & StdMaritalStatusId & _
                    ", StdMobileNumber = '" & StdMobile & "', StdEmailAddress = '" & StdEmail & "', StdHomeTelephone = '" & StdTelephone & _
                    "', StdOccupationId = " & StdOccupationId & ", StdJobDesignationId = " & StdJobDesignationId & ", StdCompanyName = '" & StdCompany & "', StdWorkTelephone = '" & StdWorkPhone & _
                    "', FatherName = '" & FatherName & "', FatherNICNumber = '" & FatherNIC & "', FatherMobileNumber = '" & FatherMobile & "', FatherEmailAddress = '" & FatherEmail & _
                    "', FatherOccupationId = " & FatherOccupationId & ", FatherJobDesignationId = " & FatherJobDesignationId & ", FatherCompanyName = '" & FatherCompany & _
                    "', FatherWorkTelephone = '" & FatherWorkPhone & "'" & _
                    " WHERE (StudentId = " & StdId & ")"

            'response.Write qrystr
            'response.End
            Conn.Execute QryStr
        End sub
    'End
%>