<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->
<% if Session("SUserRoleId") <> 2 then %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <link rel="stylesheet" href="CSS/StyleAddNewStd.css">
    <title>Add New Student Profile</title>
</head>

<body>
    <header>
        <!--#include file=Header.asp-->
    </header>

    <div class="container-fluid">
        <div class="wrapper">
            <form action="AddNewStd.asp" method="POST">
                <div class="row">
                    <div class="col text-center mt-2">
                        <label for="" class="heading">Student's Details</label>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm">
                        <div class="std-img">
                        </div>
                    </div>
                </div>

                <div class="row mt-3">
                    <div class="col-lg-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student GR Number</label>
                            <br>
                            <input type="text" class="form-control" name="FormStdGrNum" id="GrNum" disabled>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student NIC Number</label>
                            <br>
                            <input type="text" class="form-control" name="FormStdNIC" id="StdNic"
                                onblur="NICValidate(this,document.getElementById('StdNIC'));">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6"></div>
                    <div class="col-lg-6"><span id="StdNIC"><% response.Write(Session("ErrorNIC")) %></span></div>
                </div>

                <br>

                <div class="row">
                    <div class="col-lg-4">
                        <div class="form-group">
                            <label for="" class="input-heading">Student First Name</label>
                            <br>
                            <input type="text" class="form-control" name="FormStdFirstName" id="FirstName"
                                onblur="StringValidate(this,document.getElementById('FirstNameError'),15);">
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Middle Name</label>
                            <br>
                            <input type="text" class="form-control" name="FormStdMidName" id="MidName"
                                onblur="StringNullValidate(this,document.getElementById('MidNameError'),15);">
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Last Name</label>
                            <br>
                            <input type="text" class="form-control" name="FormStdLastName" id="LastName"
                                onblur="StringValidate(this,document.getElementById('LastNameError'),15);">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-4"><span
                            id="FirstNameError"><% response.Write(Session("ErrorFirstName")) %></span>
                    </div>
                    <div class="col-lg-4"><span id="MidNameError"><% response.Write(Session("ErrorMidName")) %></span>
                    </div>
                    <div class="col-lg-4"><span id="LastNameError"><% response.Write(Session("ErrorLastName")) %></span>
                    </div>
                </div>

                <br>

                <div class="row">
                    <div class="col-lg-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Date of Birth</label>
                            <br>
                            <input type="date" class="form-control" name="FormStdDob" id="Dob"
                                onblur="ValidateDate(this,document.getElementById('DateError'));">
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Nationality</label>
                            <br>
                            <select name="FormStdNationalityId" class="form-control" id="Nationality"
                                onblur="DropDownValidate(this,document.getElementById('NationalityError'));">
                                <option value="-1">Select Nationality</option>
                                <%
                                        Dim RSNationality
                                        Set RSNationality = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSNationality.Open "SELECT NationalityId, Nationality FROM ListNationality",Conn
    
                                        do while NOT RSNationality.EOF
                                    %>
                                <option value="<% response.write(RSNationality("NationalityId")) %>">
                                    <% response.write(RSNationality("Nationality")) %></option>
                                <%
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
                    <div class="col-lg-6"><span id="DateError"><% response.Write(Session("ErrorDob")) %></span></div>
                    <div class="col-lg-6"><span
                            id="NationalityError"><% response.Write(Session("ErrorNationality")) %></span></div>
                </div>

                <br>

                <div class="row">
                    <div class="col-lg-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Place of Birth</label>
                            <br>
                            <input type="text" class="form-control" name="FormStdPob" id="Pob"
                                onblur="StringValidate(this,document.getElementById('PobError'),25);">
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Religion</label>
                            <br>
                            <select name="FormStdReligionId" class="form-control" id="Religion"
                                onblur="DropDownValidate(this,document.getElementById('ReligionError'));">
                                <option value="-1">Select Religion</option>
                                <%
                                        Dim RSReligion
                                        Set RSReligion = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSReligion.Open "SELECT ReligionId, Religion FROM ListReligion",Conn
    
                                        do while NOT RSReligion.EOF
                                    %>
                                <option value="<% response.write(RSReligion("ReligionId")) %>">
                                    <% response.write(RSReligion("Religion")) %></option>
                                <%
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
                    <div class="col-lg-6"><span id="PobError"><% response.Write(Session("ErrorPob")) %></span></div>
                    <div class="col-lg-6"><span id="ReligionError"><% response.Write(Session("ErrorReligion")) %></span>
                    </div>
                </div>

                <br>

                <div class="row">
                    <div class="col-lg-6">
                        <div class="form-group">
                            <label for="" class="mr-2 input-heading">Student Gender</label>
                            <br>
                            <select name="FormStdGenderId" class="form-control" id="Gender"
                                onblur="DropDownValidate(this,document.getElementById('GenderError'));">
                                <option value="-1">Select Gender</option>
                                <%
                                        Dim RSGender
                                        Set RSGender = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSGender.Open "SELECT GenderId, Gender FROM ListGender",Conn
    
                                        do while NOT RSGender.EOF
                                    %>
                                <option value="<% response.write(RSGender("GenderId")) %>">
                                    <% response.write(RSGender("Gender")) %></option>
                                <%
                                        RSGender.MoveNext
                                        Loop
                
                                        RSGender.Close
                                        Set RSGender = Nothing
                                    %>
                            </select>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="form-group">
                            <label for="" class="mr-2 input-heading">Student Marital Status</label>
                            <br>
                            <select name="FormStdMaritalId" class="form-control" id="MaritalStatus"
                                onblur="DropDownValidate(this,document.getElementById('MaritalStError'));">
                                <option value="-1">Select Marital Status</option>
                                <%
                                        Dim RSMaritalStatus
                                        Set RSMaritalStatus = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSMaritalStatus.Open "SELECT MaritalStatusId, MaritalStatus FROM ListMaritalStatus",Conn
    
                                        do while NOT RSMaritalStatus.EOF
                                    %>
                                <option value="<% response.write(RSMaritalStatus("MaritalStatusId")) %>">
                                    <% response.write(RSMaritalStatus("MaritalStatus")) %></option>
                                <%
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
                    <div class="col-lg-6"><span id="GenderError"><% response.Write(Session("ErrorGender")) %></span>
                    </div>
                    <div class="col-lg-6"><span
                            id="MaritalStError"><% response.Write(Session("ErrorMaritalSt")) %></span>
                    </div>
                </div>

                <br>

                <div class="row">
                    <div class="col-lg-4">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Mobile Number</label>
                            <br>
                            <input type="text" class="form-control" name="FormStdMob" id="StdMob"
                                onblur="PhoneNumberValidate(this,document.getElementById('MobError'),20);">
                        </div>
                    </div>

                    <div class="col-lg-5">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Email Address</label>
                            <br>
                            <input type="email" class="form-control" name="FormStdEmail" id="StdEmail"
                                onblur="ValidateEmail(this,document.getElementById('EmailError'));">
                        </div>
                    </div>

                    <div class="col-lg-3">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Home Telephone</label>
                            <br>
                            <input type="text" class="form-control" name="FormStdTelephone" id="StdHome"
                                onblur="PhoneNumberValidate(this,document.getElementById('ErrorStdTel'),20);">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-4"><span id="MobError"><% response.Write(Session("ErrorStdMob")) %></span></div>
                    <div class="col-lg-5"><span id="EmailError"><% response.Write(Session("ErrorStdEmail")) %></span>
                    </div>
                    <div class="col-lg-3"><span id="HomePhoneError"><% response.Write(Session("ErrorStdTel")) %></span>
                    </div>
                </div>

                <br>

                <div class="row">
                    <div class="col-lg-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Occupation</label>
                            <br>
                            <select name="FormStdOccupationId" id="OccupId" class="form-control">
                                <option value="-1">Select Occupation</option>
                                <%
                                        Dim RSOccupation
                                        Set RSOccupation = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSOccupation.Open "SELECT OccupationId, Occupation FROM ListOccupation",Conn
    
                                        do while NOT RSOccupation.EOF
                                    %>
                                <option value="<% response.write(RSOccupation("OccupationId")) %>">
                                    <% response.write(RSOccupation("Occupation")) %></option>
                                <%
                                        RSOccupation.MoveNext
                                        Loop
                
                                        RSOccupation.Close
                                        Set RSOccupation = Nothing
                                    %>
                            </select>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Job Designation</label>
                            <br>
                            <select name="FormStdJobDesignationId" id="JobDesignationId" class="form-control">
                                <option value="-1">Select Job Designation</option>
                                <%
                                        Dim RSJobDesignation
                                        Set RSJobDesignation = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSJobDesignation.Open "SELECT JobDesignationId, JobDesignation FROM ListJobDesignation",Conn
    
                                        do while NOT RSJobDesignation.EOF
                                    %>
                                <option value="<% response.write(RSJobDesignation("JobDesignationId")) %>">
                                    <% response.write(RSJobDesignation("JobDesignation")) %></option>
                                <%
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
                    <div class="col-lg-6"><span><% response.Write(Session("ErrorStdOcc")) %></span></div>
                    <div class="col-lg-6"><span><% response.Write(Session("ErrorStdJob")) %></span></div>
                </div>

                <br>

                <div class="row">
                    <div class="col-lg-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Company Name</label>
                            <br>
                            <input type="text" class="form-control" name="FormStdCompany"
                                onblur="StringNullValidate(this,document.getElementById('CompanyError'),50);"
                                id="CompanyName">
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Work Telephone</label>
                            <br>
                            <input type="text" class="form-control" name="FormStdWorkPhone" id="WorkPhone"
                                onblur="ValidateWorkPhone(this,document.getElementById('WorkPhoneError'));">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6"><span
                            id="CompanyError"><% response.Write(Session("ErrorStdCompany")) %></span>
                    </div>
                    <div class="col-lg-6"><span
                            id="WorkPhoneError"><% response.Write(Session("ErrorStdWorkTel")) %></span>
                    </div>
                </div>

                <br>

                <div class="row">
                    <div class="col-lg">
                        <hr>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg text-center mb-4">
                        <label for="" class="heading">Student's Father Details</label>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Father Name</label>
                            <br>
                            <input type="text" class="form-control" name="FormFatherName"
                                onblur="StringValidate(this,document.getElementById('FatherNameError'),15);">
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Father NIC Number</label>
                            <br>
                            <input type="text" class="form-control" name="FormFatherNIC"
                                onblur="NICValidate(this,document.getElementById('FatherNIC'));">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6"><span
                            id="FatherNameError"><% response.Write(Session("ErrorFatherName")) %></span></div>
                    <div class="col-lg-6"><span id="FatherNIC"><% response.Write(Session("ErrorFatherNic")) %></span>
                    </div>
                </div>

                <br>

                <div class="row">
                    <div class="col-lg-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Father Mobile Number</label>
                            <br>
                            <input type="text" class="form-control" name="FormFatherMobile"
                                onblur="PhoneNumberValidate(this,document.getElementById('FatherMobError'),20);">
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Father Email Address</label>
                            <br>
                            <input type="email" class="form-control" name="FormFatherEmail"
                                onblur="ValidateEmail(this,document.getElementById('FatherEmailError'));">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6"><span
                            id="FatherMobError"><% response.Write(Session("ErrorFatherMob")) %></span>
                    </div>
                    <div class="col-lg-6"><span
                            id="FatherEmailError"><% response.Write(Session("ErrorFatherEmail")) %></span></div>
                </div>

                <br>

                <div class="row">
                    <div class="col-lg-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Father Occupation</label>
                            <br>
                            <select name="FormFatherOccupationId" id="" class="form-control">
                                <option value="-1">Select Occupation</option>
                                <%
                                        'Dim RSOccupation
                                        Set RSOccupation = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSOccupation.Open "SELECT OccupationId, Occupation FROM ListOccupation",Conn
    
                                        do while NOT RSOccupation.EOF
                                    %>
                                <option value="<% response.write(RSOccupation("OccupationId")) %>">
                                    <% response.write(RSOccupation("Occupation")) %></option>
                                <%
                                        RSOccupation.MoveNext
                                        Loop
                
                                        RSOccupation.Close
                                        Set RSOccupation = Nothing
                                    %>
                            </select>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Father Job Designation</label>
                            <br>
                            <select name="FormFatherJobDesignationId" id="" class="form-control">
                                <option value="-1">Select Job Designation</option>
                                <%
                                        'Dim RSJobDesignation
                                        Set RSJobDesignation = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSJobDesignation.Open "SELECT JobDesignationId, JobDesignation FROM ListJobDesignation",Conn
    
                                        do while NOT RSJobDesignation.EOF
                                    %>
                                <option value="<% response.write(RSJobDesignation("JobDesignationId")) %>">
                                    <% response.write(RSJobDesignation("JobDesignation")) %></option>
                                <%
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
                    <div class="col-lg-6"><span><% response.Write(Session("ErrorFatherOcc")) %></span></div>
                    <div class="col-lg-6"><span><% response.Write(Session("ErrorFatherJob")) %></span></div>
                </div>

                <br>

                <div class="row">
                    <div class="col-lg-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Company Name</label>
                            <br>
                            <input type="text" class="form-control" name="FormFatherCompany"
                                onblur="StringNullValidate(this,document.getElementById('FatherCompError'),50);">
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Father Work Telephone</label>
                            <br>
                            <input type="text" class="form-control" name="FormFatherWorkPhone"
                                onblur="ValidateWorkPhone(this,document.getElementById('FatherWorkError'));">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6"><span
                            id="FatherCompError"><% response.Write(Session("ErrorFatherComp")) %></span></div>
                    <div class="col-lg-6"><span
                            id="FatherWorkError"><% response.Write(Session("ErrorFatherWorkTel")) %></span></div>
                </div>

                <br>

                <div class="row">
                    <div class="col-lg d-flex justify-content-center">
                        <input type="submit" value="Save" class="add-btn">
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
<!--onclick="return FormSubmit();"-->

</html>
<% 
else
    Response.redirect("Dashboard.asp")
end if
%>