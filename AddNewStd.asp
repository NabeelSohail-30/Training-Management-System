<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->
<!--#include file=GlobalFunctions.asp-->
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
                    FatherName & "', '" & FatherNIC & "', '" & FatherMobile & "', '" & FatherEmail & "', " & FatherOccupationId & ", " & FatherJobDesignationId & ", '" & _
                    FatherCompany & "', '" & FatherWorkPhone & "'," & UserId & ")"
                    
            'response.Write qrystr
            'response.End
            Conn.Execute QryStr
        End sub
    'End

    'CloseAllRS
        
    'End
%>