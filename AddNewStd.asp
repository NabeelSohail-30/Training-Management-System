<%
    'Data Storing Variables Declaration Start
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
    'End

    'Other Variables Declaration Start
        Dim QryStr
    'End

    'DB and RS Variables Declaration Start
        Dim Conn 
        Dim CS
    'End

    'Normal Variables Initializing Start
        StdGrNum = request.form("FormStdGrNum")
        StdNIC = request.form("FormStdNIC")
        StdFirstName = request.form("FormStdFirstName")
        StdMidName = request.form("FormStdMidName")
        StdLastName = request.form("FormStdLastName")
        StdDob = request.form("FormStdDob")
        StdNationalityId = request.form("FormStdNationalityId")
        StdPob = request.form("FormStdPob")
        StdReligionId = request.form("FormStdReligionId")
        StdGenderId = request.form("FormStdGenderId")
        StdMaritalStatusId = request.form("FormStdMaritalId")
        StdMobile = request.form("FormStdMob")
        StdEmail = request.form("FormStdEmail")
        StdTelephone = request.form("FormStdTelephone")
        StdOccupationId = request.form("FormStdOccupationId")
        StdJobDesignationId = request.form("FormStdJobDesignationId")
        StdCompany = request.form("FormStdCompany")
        StdWorkPhone = request.form("FormStdWorkPhone")
        FatherName = request.form("FormFatherName")
        FatherNIC = request.form("FormFatherNIC")
        FatherMobile = request.form("FormFatherMobile")
        FatherEmail = request.form("FormFatherEmail")
        FatherOccupationId = request.form("FormFatherOccupationId")
        FatherJobDesignationId = request.form("FormFatherJobDesignationId")
        FatherCompany = request.form("FormFatherCompany")
        FatherWorkPhone = request.form("FormFatherWorkPhone")
    'End

    'Opening Db Start
        Set Conn = Server.CreateObject("ADODB.Connection")
        CS = "Driver={SQL Server};Server=NABEELS-WORK;Database=TrainingManagementSystem;User Id=TMS;Password=Nabeel30;"
        Conn.Open CS
    'End

    'Validations Start

    'End

    'Inserting Rec Start
        QryStr = "INSERT INTO StudentDetail (StdGrNumber,StdNICNumber,StdFirstName,StdMidName,StdLastName,StdDateOfBirth,StdNationalityId,StdPlaceOfBirth,StdGenderId,StdReligionId,StdMaritalStatusId," & _
                    "StdMobileNumber,StdEmailAddress,StdHomeTelephone,StdOccupationId,StdJobDesignationId,StdCompanyName,StdWorkTelephone" & _
                    "FatherName,FatherNICNumber,FatherMobileNumber,FatherEmailAddress,FatherOccupationId,FatherJobDesignationId,FatherCompanyName,FatherWorkTelephone)" & _
                    "Values(" & StdGrNum & ", '" & StdNIC & "', '" & StdFirstName & "', '" & StdMidName & "', '" & StdLastName & "', '" & StdDob & "', " & _
                    StdNationalityId & ", '" & StdPob & "', " & StdGenderId & ", " & StdReligionId & ", " & StdMaritalStatusId & ", '" & StdMobile & "', '" & _
                    StdEmail & "', '" & StdTelephone & "', " & StdOccupationId & ", " & StdJobDesignationId & ", '" & StdCompany & "', '" & StdWorkPhone & "', '" & _
                    FatherName & "', '" & FatherNIC & "', '" & FatherMobile & "', '" & StdEmail & "', " & StdOccupationId & ", " & StdJobDesignationId & ", '" & _
                    StdCompany & "', '" & StdWorkPhone & "')"
                    
                    

        response.Write qrystr
        'Conn.Execute QryStr
    'Inserting Rec End
%>