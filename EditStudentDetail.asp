<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->
<!--#include file=AppSetting.asp-->
<%
    dim RSStdDetail
    dim StdId

    StdId = request.QueryString("QsStdId")

    Set RSStdDetail = Server.CreateObject("ADODB.RecordSet")
    QryStr = "SELECT * FROM StudentDetail WHERE(StudentId =" & StdId & ")"
    'response.write(QryStr)
    'response.End
                 
    if RSStdDetail.state = 1 then 
        RSStdDetail.Close
    end if
    RSStdDetail.Open QryStr, conn

    if RSStdDetail.eof = true then
        response.Redirect("StudentProfile.asp")
    end if
     

    'Variables Declaration
        dim StudentId
        dim StdGrNum
        dim StdNIC
        dim StdFirstName
        dim StdMidName
        dim StdLastName
        dim StdDob
        dim StdNationalityId
        dim StdPob
        dim StdReligionId
        dim StdGenderId
        dim StdMaritalStatusId
        dim StdMobile
        dim StdEmail
        dim StdTelephone
        dim StdOccupationId
        dim StdJobDesignationId
        dim StdCompany
        dim StdWorkPhone
        dim FatherName
        dim FatherNIC
        dim FatherMobile
        dim FatherEmail
        dim FatherOccupationId
        dim FatherJobDesignationId
        dim FatherCompany
        dim FatherWorkPhone
    'end

    'Variables Initialization
         StudentId = RSStdDetail("StudentId")
         StdGrNum = RSStdDetail("StdGrNumber")
         StdNIC = RSStdDetail("StdNICNumber")
         StdFirstName = RSStdDetail("StdFirstName")
         StdMidName = RSStdDetail("StdMidName")
         StdLastName = RSStdDetail("StdLastName")
         StdDob = RSStdDetail("StdDateOfBirth")
         StdNationalityId = cint(RSStdDetail("StdNationalityId"))
         StdPob = RSStdDetail("StdPlaceOfBirth")
         StdReligionId = cint(RSStdDetail("StdReligionId"))
         RSStdDetail.MoveFirst
         StdGenderId = cint(RSStdDetail("StdGenderId"))
         StdMaritalStatusId = cint(RSStdDetail("StdMaritalStatusId"))
         StdMobile = RSStdDetail("StdMobileNumber")
         StdEmail = RSStdDetail("StdEmailAddress")
         StdTelephone = RSStdDetail("StdHomeTelephone")
         StdOccupationId = cint(RSStdDetail("StdOccupationId"))
         StdJobDesignationId = cint(RSStdDetail("StdJobDesignationId"))
         StdCompany = RSStdDetail("StdCompanyName")
         StdWorkPhone = RSStdDetail("StdWorkTelephone")
         FatherName = RSStdDetail("FatherName")
         FatherNIC = RSStdDetail("FatherNICNumber")
         FatherMobile = RSStdDetail("FatherMobileNumber")
         FatherEmail = RSStdDetail("FatherEmailAddress")
         FatherOccupationId = cint(RSStdDetail("FatherOccupationId"))
         FatherJobDesignationId = cint(RSStdDetail("FatherJobDesignationId"))
         FatherCompany = RSStdDetail("FatherCompanyName")
         FatherWorkPhone = RSStdDetail("FatherWorkTelephone")
    'end

    RSStdDetail.Close

        'response.write("<br>1 " & StdGrNum)
        'response.write("<br>2 " & StdNIC)
        'response.write("<br>3 " & StdFirstName)
        'response.write("<br>4 " & StdMidName)
        'response.write("<br>5 " & StdLastName)
        'response.write("<br>6 " & StdDob)
        'response.write("<br>7 " & StdNationalityId)
        'response.write("<br>8 " & StdPob)
        'response.write("<br>9 " & StdReligionId)
        'response.write("<br>10 " & StdGenderId)
        'response.write("<br>11 " & StdMaritalStatusId)
        'response.write("<br>12 " & StdMobile)
        'response.write("<br>13 " & StdEmail)
        'response.write("<br>14 " & StdTelephone)
        'response.write("<br>15 " & StdOccupationId)
        'response.write("<br>16 " & StdJobDesignationId)
        'response.write("<br>17 " & StdCompany)
        'response.write("<br>18 " & StdWorkPhone)
        'response.write("<br>19 " & FatherName)
        'response.write("<br>20 " & FatherNIC)
        'response.write("<br>21 " & FatherMobile)
        'response.write("<br>22 " & FatherEmail)
        'response.write("<br>23 " & FatherOccupationId)
        'response.write("<br>24 " & FatherJobDesignationId)
        'response.write("<br>25 " & FatherCompany)
        'response.write("<br>26 " & FatherWorkPhone)
        'response.End
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <link rel="stylesheet" href="CSS/GlobalStyle.css">
    <link rel="stylesheet" href="CSS/StyleEditStudent.css">
    <title>Update Student Detail</title>
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
                            <a class="nav-link" href="ViewStudentDetail.asp?QsStdId=<% response.Write(StdId) %>">View
                                Student Detail</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active"
                                href="EditStudentDetail.asp?QsStdId=<% response.Write(StdId) %>">Edit Student Detail</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link"
                                href="AcademicQualification.asp?QsStdId=<% response.Write(StdId) %>">Academic
                                Qualification</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link"
                                href="TechnicalQualification.asp?QsStdId=<% response.Write(StdId) %>">Technical
                                Qualification</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="WorkExperience.asp?QsStdId=<% response.Write(StdId) %>">Work
                                Experience</a>
                        </li>
                    </ul>
                </div>
            </div>

            <br>

            <form action="EditStudent.asp?QsStdId=<% response.Write(StdId) %>" method="POST">
                <div class="panel">
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Update Student's Detail</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <div class="row">
                            <div class="col-2">
                                <div class="std-img">

                                </div>
                            </div>

                            <div class="col-10">
                                <div class="row mt-5">
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label for="" class="input-heading">Student GR Number</label>
                                            <br>
                                            <input type="text" class="form-control" name="FormStdGrNum" id="GrNum"
                                                value="<% response.Write(StdGrNum) %>" disabled>
                                        </div>
                                    </div>

                                    <div class="col-6">
                                        <div class="form-group">
                                            <label for="" class="input-heading">Student NIC Number</label>
                                            <br>
                                            <input type="text" class="form-control" name="FormStdNIC" id="StdNic"
                                                value="<% response.Write(StdNIC) %>"
                                                onblur="NICValidate(this,document.getElementById('StdNIC'));">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-6"></div>
                                    <div class="col-6"><span
                                            id="StdNIC"><% response.Write(Session("ErrorNIC")) %></span></div>
                                </div>
                            </div>
                        </div>

                        <input type="hidden" value="<% response.Write(StudentId) %>" name="FormStdId">

                        <div class="row mt-2">
                            <div class="col-4">
                                <div class="form-group">
                                    <label for="" class="input-heading">Student First Name</label>
                                    <br>
                                    <input type="text" class="form-control" name="FormStdFirstName" id="FirstName"
                                        value="<% response.Write(StdFirstName) %>"
                                        onblur="StringValidate(this,document.getElementById('FirstNameError'),15);">
                                </div>
                            </div>

                            <div class="col-4">
                                <div class="form-group">
                                    <label for="" class="input-heading">Student Middle Name</label>
                                    <br>
                                    <input type="text" class="form-control" name="FormStdMidName" id="MidName"
                                        value="<% response.Write(StdMidName) %>"
                                        onblur="StringNullValidate(this,document.getElementById('MidNameError'),15);">
                                </div>
                            </div>

                            <div class="col-4">
                                <div class="form-group">
                                    <label for="" class="input-heading">Student Last Name</label>
                                    <br>
                                    <input type="text" class="form-control" name="FormStdLastName" id="LastName"
                                        onblur="StringValidate(this,document.getElementById('LastNameError'),15);"
                                        value="<% response.Write(StdLastName) %>">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-4"><span
                                    id="FirstNameError"><% response.Write(Session("ErrorFirstName")) %></span>
                            </div>
                            <div class="col-4"><span
                                    id="MidNameError"><% response.Write(Session("ErrorMidName")) %></span>
                            </div>
                            <div class="col-4"><span
                                    id="LastNameError"><% response.Write(Session("ErrorLastName")) %></span>
                            </div>
                        </div>

                        <div class="row mt-2">
                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Student Date of Birth</label>
                                    <br>
                                    <input type="date" class="form-control" name="FormStdDob" id="Dob"
                                        onblur="ValidateDate(this,document.getElementById('DateError'));">
                                </div>
                            </div>

                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Student Nationality</label>
                                    <br>
                                    <select name="FormStdNationalityId" class="form-control" id="Nationality"
                                        onblur="DropDownValidate(this,document.getElementById('NationalityError'));">
                                        <option value="-1">Select Nationality</option>
                                        <%
                                            dim RSNationality
                                            Set RSNationality = Server.CreateObject("ADODB.RecordSet")
                                            
                                            RSNationality.Open "SELECT NationalityId, Nationality FROM ListNationality",Conn
            
                                            do while NOT RSNationality.EOF
                                                if StdNationalityId = RSNationality("NationalityId") then
                                        %>
                                        <option value="<% response.write(RSNationality("NationalityId")) %>" selected>
                                            <% response.write(RSNationality("Nationality")) %> </option>
                                        <% else %>
                                        <option value="<% response.write(RSNationality("NationalityId")) %>">
                                            <% response.write(RSNationality("Nationality")) %> </option>
                                        <%
                                                end if
                                            RSNationality.MoveNext
                                            Loop
                    
                                            RSNationality.Close
                                            Set RSNationality = Nothing
                                        %>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6"><span id="DateError"><% response.Write(Session("ErrorDob")) %></span>
                            </div>
                            <div class="col-6"><span
                                    id="NationalityError"><% response.Write(Session("ErrorNationality")) %></span></div>
                        </div>

                        <div class="row mt-2">
                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Student Place of Birth</label>
                                    <br>
                                    <input type="text" class="form-control" name="FormStdPob" id="Pob"
                                        onblur="StringValidate(this,document.getElementById('PobError'),25);">
                                </div>
                            </div>

                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Student Religion</label>
                                    <br>
                                    <select name="FormStdReligionId" class="form-control" id="Religion"
                                        onblur="DropDownValidate(this,document.getElementById('ReligionError'));">
                                        <option value="-1">Select Religion</option>
                                        <%
                                            dim RSReligion
                                            Set RSReligion = Server.CreateObject("ADODB.RecordSet")
                                            
                                            RSReligion.Open "SELECT ReligionId, Religion FROM ListReligion",Conn
            
                                            do while NOT RSReligion.EOF
                                                if StdReligionId = RSReligion("ReligionId") then
                                        %>
                                        <option value="<% response.write(RSReligion("ReligionId")) %>" selected>
                                            <% response.write(RSReligion("Religion")) %></option>
                                        <% else %>
                                        <option value="<% response.write(RSReligion("ReligionId")) %>">
                                            <% response.write(RSReligion("Religion")) %></option>
                                        <%
                                                end if
                                            RSReligion.MoveNext
                                            Loop
                    
                                            RSReligion.Close
                                            Set RSReligion = Nothing
                                        %>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6"><span id="PobError"><% response.Write(Session("ErrorPob")) %></span>
                            </div>
                            <div class="col-6"><span
                                    id="ReligionError"><% response.Write(Session("ErrorReligion")) %></span>
                            </div>
                        </div>

                        <div class="row mt-2">
                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="mr-2 input-heading">Student Gender</label>
                                    <br>
                                    <select name="FormStdGenderId" class="form-control" id="Gender"
                                        onblur="DropDownValidate(this,document.getElementById('GenderError'));">
                                        <option value="-1">Select Gender</option>
                                        <%
                                            dim RSGender
                                            Set RSGender = Server.CreateObject("ADODB.RecordSet")
                                            
                                            RSGender.Open "SELECT GenderId, Gender FROM ListGender",Conn
            
                                            do while NOT RSGender.EOF
                                                if StdGenderId = RSGender("GenderId") then
                                        %>
                                        <option value="<% response.write(RSGender("GenderId")) %>" selected>
                                            <% response.write(RSGender("Gender")) %></option>
                                        <% else %>
                                        <option value="<% response.write(RSGender("GenderId")) %>">
                                            <% response.write(RSGender("Gender")) %></option>
                                        <%
                                                end if
                                            RSGender.MoveNext
                                            Loop
                    
                                            RSGender.Close
                                            Set RSGender = Nothing
                                        %>
                                    </select>
                                </div>
                            </div>

                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="mr-2 input-heading">Student Marital Status</label>
                                    <br>
                                    <select name="FormStdMaritalId" class="form-control" id="MaritalStatus"
                                        onblur="DropDownValidate(this,document.getElementById('MaritalStError'));">
                                        <option value="-1">Select Marital Status</option>
                                        <%
                                            dim RSMaritalStatus
                                            Set RSMaritalStatus = Server.CreateObject("ADODB.RecordSet")
                                            
                                            RSMaritalStatus.Open "SELECT MaritalStatusId, MaritalStatus FROM ListMaritalStatus",Conn
            
                                            do while NOT RSMaritalStatus.EOF
                                                if StdMaritalStatusId = RSMaritalStatus("MaritalStatusId") then
                                        %>
                                        <option value="<% response.write(RSMaritalStatus("MaritalStatusId")) %>"
                                            selected>
                                            <% response.write(RSMaritalStatus("MaritalStatus")) %></option>
                                        <% else %>
                                        <option value="<% response.write(RSMaritalStatus("MaritalStatusId")) %>">
                                            <% response.write(RSMaritalStatus("MaritalStatus")) %></option>
                                        <%  
                                                end if
                                            RSMaritalStatus.MoveNext
                                            Loop
                    
                                            RSMaritalStatus.Close
                                            Set RSMaritalStatus = Nothing
                                        %>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6"><span
                                    id="GenderError"><% response.Write(Session("ErrorGender")) %></span></div>
                            <div class="col-6"><span
                                    id="MaritalStError"><% response.Write(Session("ErrorMaritalSt")) %></span>
                            </div>
                        </div>

                        <div class="row mt-2">
                            <div class="col-4">
                                <div class="form-group">
                                    <label for="" class="input-heading">Student Mobile Number</label>
                                    <br>
                                    <input type="text" class="form-control" name="FormStdMob" id="StdMob"
                                        onblur="PhoneNumberValidate(this,document.getElementById('MobError'),20);"
                                        value="<% response.Write(StdMobile) %>">
                                </div>
                            </div>

                            <div class="col-5">
                                <div class="form-group">
                                    <label for="" class="input-heading">Student Email Address</label>
                                    <br>
                                    <input type="email" class="form-control" name="FormStdEmail" id="StdEmail"
                                        onblur="ValidateEmail(this,document.getElementById('EmailError'));"
                                        value="<% response.Write(StdEmail) %>">
                                </div>
                            </div>

                            <div class="col-3">
                                <div class="form-group">
                                    <label for="" class="input-heading">Student Home Telephone</label>
                                    <br>
                                    <input type="text" class="form-control" name="FormStdTelephone" id="StdHome"
                                        onblur="PhoneNumberValidate(this,document.getElementById('HomePhoneError'),20);"
                                        value="<% response.Write(StdTelephone) %>">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-4"><span id="MobError"><% response.Write(Session("ErrorStdMob")) %></span>
                            </div>
                            <div class="col-5"><span
                                    id="EmailError"><% response.Write(Session("ErrorStdEmail")) %></span></div>
                            <div class="col-3"><span
                                    id="HomePhoneError"><% response.Write(Session("ErrorStdTel")) %></span>
                            </div>
                        </div>

                        <div class="row mt-2">
                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Student Occupation</label>
                                    <br>
                                    <select name="FormStdOccupationId" id="OccupId" class="form-control">
                                        <option value="-1">Select Occupation</option>
                                        <%
                                            dim RSOccupation
                                            Set RSOccupation = Server.CreateObject("ADODB.RecordSet")
                                            
                                            RSOccupation.Open "SELECT OccupationId, Occupation FROM ListOccupation",Conn
            
                                            do while NOT RSOccupation.EOF
                                                if StdOccupationId = RSOccupation("OccupationId") then
                                        %>
                                        <option value="<% response.write(RSOccupation("OccupationId")) %>" selected>
                                            <% response.write(RSOccupation("Occupation")) %></option>
                                        <% else %>
                                        <option value="<% response.write(RSOccupation("OccupationId")) %>">
                                            <% response.write(RSOccupation("Occupation")) %></option>
                                        <%
                                                end if
                                            RSOccupation.MoveNext
                                            Loop
                    
                                            RSOccupation.Close
                                            Set RSOccupation = Nothing
                                        %>
                                    </select>
                                </div>
                            </div>

                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Student Job Designation</label>
                                    <br>
                                    <select name="FormStdJobDesignationId" id="JobDesignationId" class="form-control">
                                        <option value="-1">Select Job Designation</option>
                                        <%
                                            dim RSJobDesignation
                                            Set RSJobDesignation = Server.CreateObject("ADODB.RecordSet")
                                            
                                            RSJobDesignation.Open "SELECT JobDesignationId, JobDesignation FROM ListJobDesignation",Conn
            
                                            do while NOT RSJobDesignation.EOF
                                                if StdJobDesignationId = RSJobDesignation("JobDesignationId") then
                                        %>
                                        <option value="<% response.write(RSJobDesignation("JobDesignationId")) %>"
                                            selected>
                                            <% response.write(RSJobDesignation("JobDesignation")) %></option>
                                        <% else %>
                                        <option value="<% response.write(RSJobDesignation("JobDesignationId")) %>">
                                            <% response.write(RSJobDesignation("JobDesignation")) %></option>
                                        <%
                                                end if
                                            RSJobDesignation.MoveNext
                                            Loop
                    
                                            RSJobDesignation.Close
                                            Set RSJobDesignation = Nothing
                                        %>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6"><span><% response.Write(Session("ErrorStdOcc")) %></span></div>
                            <div class="col-6"><span><% response.Write(Session("ErrorStdJob")) %></span></div>
                        </div>

                        <div class="row mt-2">
                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Student Company Name</label>
                                    <br>
                                    <input type="text" class="form-control" name="FormStdCompany"
                                        onblur="StringNullValidate(this,document.getElementById('CompanyError'),50);"
                                        id="CompanyName" value="<% response.Write(StdCompany) %>">
                                </div>
                            </div>

                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Student Work Telephone</label>
                                    <br>
                                    <input type="text" class="form-control" name="FormStdWorkPhone" id="WorkPhone"
                                        onblur="ValidateWorkPhone(this,document.getElementById('WorkPhoneError'));"
                                        value="<% response.Write(StdWorkPhone) %>">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6"><span
                                    id="CompanyError"><% response.Write(Session("ErrorStdCompany")) %></span>
                            </div>
                            <div class="col-6"><span
                                    id="WorkPhoneError"><% response.Write(Session("ErrorStdWorkTel")) %></span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row mt-3 mb-3">
                    <div class="col">
                        <hr>
                    </div>
                </div>

                <div class="panel">
                    <div class="panel-head">
                        <div class="row">
                            <div class="col text-center">
                                <label for="">Student's Father Details</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <div class="row mt-2">
                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Student Father Name</label>
                                    <br>
                                    <input type="text" class="form-control" name="FormFatherName"
                                        onblur="StringValidate(this,document.getElementById('FatherNameError'),15);">
                                </div>
                            </div>

                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Father NIC Number</label>
                                    <br>
                                    <input type="text" class="form-control" name="FormFatherNIC"
                                        onblur="NICValidate(this,document.getElementById('FatherNIC'));"
                                        value="<% response.Write(FatherNIC) %>">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6"><span
                                    id="FatherNameError"><% response.Write(Session("ErrorFatherName")) %></span></div>
                            <div class="col-6"><span
                                    id="FatherNIC"><% response.Write(Session("ErrorFatherNic")) %></span></div>
                        </div>

                        <div class="row mt-2">
                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Father Mobile Number</label>
                                    <br>
                                    <input type="text" class="form-control" name="FormFatherMobile"
                                        onblur="PhoneNumberValidate(this,document.getElementById('FatherMobError'),20);"
                                        value="<% response.Write(FatherMobile) %>">
                                </div>
                            </div>

                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Father Email Address</label>
                                    <br>
                                    <input type="email" class="form-control" name="FormFatherEmail"
                                        onblur="ValidateEmail(this,document.getElementById('FatherEmailError'));"
                                        value="<% response.Write(FatherEmail) %>">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6"><span
                                    id="FatherMobError"><% response.Write(Session("ErrorFatherMob")) %></span>
                            </div>
                            <div class="col-6"><span
                                    id="FatherEmailError"><% response.Write(Session("ErrorFatherEmail")) %></span></div>
                        </div>

                        <div class="row mt-2">
                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Father Occupation</label>
                                    <br>
                                    <select name="FormFatherOccupationId" id="" class="form-control">
                                        <option value="-1">Select Occupation</option>
                                        <%
                                            'dim RSOccupation
                                            Set RSOccupation = Server.CreateObject("ADODB.RecordSet")
                                            
                                            RSOccupation.Open "SELECT OccupationId, Occupation FROM ListOccupation",Conn
            
                                            do while NOT RSOccupation.EOF
                                                if FatherOccupationId = RSOccupation("OccupationId") then
                                        %>
                                        <option value="<% response.write(RSOccupation("OccupationId")) %>" selected>
                                            <% response.write(RSOccupation("Occupation")) %></option>
                                        <% else %>
                                        <option value="<% response.write(RSOccupation("OccupationId")) %>">
                                            <% response.write(RSOccupation("Occupation")) %></option>
                                        <%
                                                end if
                                            RSOccupation.MoveNext
                                            Loop
                    
                                            RSOccupation.Close
                                            Set RSOccupation = Nothing
                                        %>
                                    </select>
                                </div>
                            </div>

                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Father Job Designation</label>
                                    <br>
                                    <select name="FormFatherJobDesignationId" id="" class="form-control">
                                        <option value="-1">Select Job Designation</option>
                                        <%
                                            'dim RSJobDesignation
                                            Set RSJobDesignation = Server.CreateObject("ADODB.RecordSet")
                                            
                                            RSJobDesignation.Open "SELECT JobDesignationId, JobDesignation FROM ListJobDesignation",Conn
            
                                            do while NOT RSJobDesignation.EOF
                                                 if FatherJobDesignationId = RSJobDesignation("JobDesignationId") then
                                        %>
                                        <option value="<% response.write(RSJobDesignation("JobDesignationId")) %>"
                                            selected>
                                            <% response.write(RSJobDesignation("JobDesignation")) %></option>
                                        <% else %>
                                        <option value="<% response.write(RSJobDesignation("JobDesignationId")) %>">
                                            <% response.write(RSJobDesignation("JobDesignation")) %></option>
                                        <%
                                                end if
                                            RSJobDesignation.MoveNext
                                            Loop
                    
                                            RSJobDesignation.Close
                                            Set RSJobDesignation = Nothing
                                        %>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6"><span><% response.Write(Session("ErrorFatherOcc")) %></span></div>
                            <div class="col-6"><span><% response.Write(Session("ErrorFatherJob")) %></span></div>
                        </div>

                        <div class="row mt-2">
                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Company Name</label>
                                    <br>
                                    <input type="text" class="form-control" name="FormFatherCompany"
                                        onblur="StringNullValidate(this,document.getElementById('FatherCompError'),50);"
                                        value="<% response.Write(FatherCompany) %>">
                                </div>
                            </div>

                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Father Work Telephone</label>
                                    <br>
                                    <input type="text" class="form-control" name="FormFatherWorkPhone"
                                        value="<% response.Write(FatherWorkPhone) %>"
                                        onblur="ValidateWorkPhone(this,document.getElementById('FatherWorkError'));">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-6"><span
                                    id="FatherCompError"><% response.Write(Session("ErrorFatherComp")) %></span></div>
                            <div class="col-lg-6"><span
                                    id="FatherWorkError"><% response.Write(Session("ErrorFatherWorkTel")) %></span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col">
                        <div class="form-group d-flex justify-content-center">
                            <input type="submit" value="Update" class="button">
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <footer>
        <!--#include file=Footer.asp-->
    </footer>
</body>
<script src="Scripts/AddNewStd.js"></script>
<script src="Scripts/Global.js"></script>

</html>