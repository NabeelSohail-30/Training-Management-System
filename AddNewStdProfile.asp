<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->
<%    
    'Dim Conn 
    'Dim CS

    'Set Conn = Server.CreateObject("ADODB.Connection")

    'CS = "Driver={SQL Server};Server=NABEELS-WORK;Database=TrainingManagementSystem;User Id=TMS;Password=Nabeel30;"
    'Conn.Open CS
    
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <title>Add New Student Profile</title>
    <style>
        * {
            margin: 0px;
            padding: 0px;
            text-decoration: none;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: lightgray;
        }

        .wrapper {
            width: 50%;
            height: max-content;
            background-color: whitesmoke;
            color: black;
            margin: 24px auto;
        }

        .std-img {
            width: 180px;
            height: 180px;
            background-color: white;
            border: 1px solid black;
            margin-left: 720px;
            margin-top: 10px;
        }

        .heading {
            font-size: 26px;
            font-weight: 600;
        }

        .input-heading {
            font-size: 16px;
            font-weight: 500;
        }

        .radio-btn {
            margin-right: 8px;
        }

        .add-btn {
            width: 30%;
            margin-bottom: 20px;
            border: none;
            outline: none;
            background-color: rgb(0, 0, 194);
            color: white;
            font-size: 18px;
            border-radius: 18px;
            font-weight: 600;
            margin-top: 10px;
            padding: 10px;
        }

        .add-btn:hover {
            transition: ease-in-out;
            background-color: lightgray;
            color: black;
            cursor: pointer;
        }

        div span {
            color: red;
            font-size: 14px;
            font-weight: 500;
            margin: 0px;
        }
    </style>

</head>



<body>
    <header>
        <!--#include file=Header.asp-->
    </header>

    <div class="wrapper">
        <div class="container">
            <form action="AddNewStd.asp" method="POST">

                <div class="row">
                    <div class="col text-center mt-2">
                        <label for="" class="heading">Student's Details</label>
                    </div>
                </div>

                <div class="row">
                    <div class="col">
                        <div class="std-img">

                        </div>
                    </div>
                </div>

                <div class="row mt-3">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student GR Number</label>
                            <br>
                            <input type="text" class="form-control" name="FormStdGrNum" id="GrNum" disabled>
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student NIC Number</label>
                            <br>
                            <input type="text" class="form-control" name="FormStdNIC" id="StdNic"
                                onblur="NICValidate(this,document.getElementById('StdNIC'));">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-6"></div>
                    <div class="col-6"><span id="StdNIC"><% response.Write(Session("ErrorNIC")) %></span></div>
                </div>

                <br>

                <div class="row">
                    <div class="col-4">
                        <div class="form-group">
                            <label for="" class="input-heading">Student First Name</label>
                            <br>
                            <input type="text" class="form-control" name="FormStdFirstName" id="FirstName"
                                onblur="FirstNameValidate(this,document.getElementById('FirstNameError'));">
                        </div>
                    </div>

                    <div class="col-4">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Middle Name</label>
                            <br>
                            <input type="text" class="form-control" name="FormStdMidName" id="MidName"
                                onblur="MidNameValidate(this,document.getElementById('MidNameError'));">
                        </div>
                    </div>

                    <div class="col-4">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Last Name</label>
                            <br>
                            <input type="text" class="form-control" name="FormStdLastName" id="LastName"
                                onblur="LastNameValidate(this,document.getElementById('LastNameError'));">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-4"><span id="FirstNameError"><% response.Write(Session("ErrorFirstName")) %></span></div>
                    <div class="col-4"><span id="MidNameError"><% response.Write(Session("ErrorMidName")) %></span></div>
                    <div class="col-4"><span id="LastNameError"><% response.Write(Session("ErrorLastName")) %></span></div>
                </div>

                <br>

                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Date of Birth</label>
                            <br>
                            <input type="date" class="form-control" name="FormStdDob" id="Dob"
                                onblur="ValidateDob(this);">
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Nationality</label>
                            <br>
                            <select name="FormStdNationalityId" class="form-control" id="Nationality"
                                onblur="ValidateNationality(this);">
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
                    <div class="col-6"><span id="DateError"><% response.Write(Session("ErrorDob")) %></span></div>
                    <div class="col-6"><span id="NationalityError"><% response.Write(Session("ErrorNationality")) %></span></div>
                </div>

                <br>

                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Place of Birth</label>
                            <br>
                            <input type="text" class="form-control" name="FormStdPob" id="Pob"
                                onblur="ValidatePOB(this);">
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Religion</label>
                            <br>
                            <select name="FormStdReligionId" class="form-control" id="Religion"
                                onblur="ValidateReligion(this);">
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
                    <div class="col-6"><span id="PobError"><% response.Write(Session("ErrorPob")) %></span></div>
                    <div class="col-6"><span id="ReligionError"><% response.Write(Session("ErrorReligion")) %></span></div>
                </div>

                <br>

                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="mr-2 input-heading">Student Gender</label>
                            <br>
                            <select name="FormStdGenderId" class="form-control" id="Gender"
                                onblur="ValidateGender(this);">
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

                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="mr-2 input-heading">Student Marital Status</label>
                            <br>
                            <select name="FormStdMaritalId" class="form-control" id="MaritalStatus"
                                onblur="ValidateMaritalSt(this);">
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
                    <div class="col-6"><span id="GenderError"><% response.Write(Session("ErrorGender")) %></span></div>
                    <div class="col-6"><span id="MaritalStError"><% response.Write(Session("ErrorMaritalSt")) %></span></div>
                </div>

                <br>

                <div class="row">
                    <div class="col-4">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Mobile Number</label>
                            <br>
                            <input type="text" class="form-control" name="FormStdMob" id="StdMob"
                                onblur="ValidateMobileNumber(this,document.getElementById('MobError'));">
                        </div>
                    </div>

                    <div class="col-5">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Email Address</label>
                            <br>
                            <input type="email" class="form-control" name="FormStdEmail" id="StdEmail"
                                onblur="ValidateEmail(this,document.getElementById('EmailError'));">
                        </div>
                    </div>

                    <div class="col-3">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Home Telephone</label>
                            <br>
                            <input type="text" class="form-control" name="FormStdTelephone" id="StdHome"
                                onblur="ValidateHomeTelephone(this);">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-4"><span id="MobError"><% response.Write(Session("ErrorStdMob")) %></span></div>
                    <div class="col-5"><span id="EmailError"><% response.Write(Session("ErrorStdEmail")) %></span></div>
                    <div class="col-3"><span id="HomePhoneError"><% response.Write(Session("ErrorStdTel")) %></span></div>
                </div>

                <br>

                <div class="row">
                    <div class="col-6">
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

                    <div class="col-6">
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
                    <div class="col-6"><span><% response.Write(Session("ErrorStdOcc")) %></span></div>
                    <div class="col-6"><span><% response.Write(Session("ErrorStdJob")) %></span></div>
                </div>

                <br>

                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Company Name</label>
                            <br>
                            <input type="text" class="form-control" name="FormStdCompany"
                                onblur="ValidateCompanyName(this,document.getElementById('CompanyError'));"
                                id="CompanyName">
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Work Telephone</label>
                            <br>
                            <input type="text" class="form-control" name="FormStdWorkPhone" id="WorkPhone"
                                onblur="ValidateWorkPhone(this,document.getElementById('WorkPhoneError'));">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-6"><span id="CompanyError"><% response.Write(Session("ErrorStdCompany")) %></span></div>
                    <div class="col-6"><span id="WorkPhoneError"><% response.Write(Session("ErrorStdWorkTel")) %></span></div>
                </div>

                <br>

                <div class="row">
                    <div class="col">
                        <hr>
                    </div>
                </div>

                <div class="row">
                    <div class="col text-center mb-4">
                        <label for="" class="heading">Student's Father Details</label>
                    </div>
                </div>

                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Father Name</label>
                            <br>
                            <input type="text" class="form-control" name="FormFatherName"
                                onblur="FatherNameValidate(this);">
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Father NIC Number</label>
                            <br>
                            <input type="text" class="form-control" name="FormFatherNIC"
                                onblur="NICValidate(this,document.getElementById('FatherNIC'));">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-6"><span id="FatherNameError"><% response.Write(Session("ErrorFatherName")) %></span></div>
                    <div class="col-6"><span id="FatherNIC"><% response.Write(Session("ErrorFatherNic")) %></span></div>
                </div>

                <br>

                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Father Mobile Number</label>
                            <br>
                            <input type="text" class="form-control" name="FormFatherMobile"
                                onblur="ValidateMobileNumber(this,document.getElementById('FatherMobError'));">
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Father Email Address</label>
                            <br>
                            <input type="email" class="form-control" name="FormFatherEmail"
                                onblur="ValidateEmail(this,document.getElementById('FatherEmailError'));">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-6"><span id="FatherMobError"><% response.Write(Session("ErrorFatherMob")) %></span></div>
                    <div class="col-6"><span id="FatherEmailError"><% response.Write(Session("ErrorFatherEmail")) %></span></div>
                </div>

                <br>

                <div class="row">
                    <div class="col-6">
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

                    <div class="col-6">
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
                    <div class="col-6"><span><% response.Write(Session("ErrorFatherOcc")) %></span></div>
                    <div class="col-6"><span><% response.Write(Session("ErrorFatherJob")) %></span></div>
                </div>

                <br>

                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Company Name</label>
                            <br>
                            <input type="text" class="form-control" name="FormFatherCompany"
                                onblur="ValidateCompanyName(this,document.getElementById('FatherCompError'));">
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Father Work Telephone</label>
                            <br>
                            <input type="text" class="form-control" name="FormFatherWorkPhone"
                                onblur="ValidateWorkPhone(this,document.getElementById('FatherWorkError'));">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-6"><span id="FatherCompError"><% response.Write(Session("ErrorFatherComp")) %></span></div>
                    <div class="col-6"><span id="FatherWorkError"><% response.Write(Session("ErrorFatherWorkTel")) %></span></div>
                </div>

                <br>

                <div class="row">
                    <div class="col">
                        <div class="form-group d-flex justify-content-center">
                            <input type="submit" value="Add New Student Profile" class="add-btn"
                                onclick="return FormSubmit();">
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>
<script src="Scripts/AddNewStd.js"></script>

</html>