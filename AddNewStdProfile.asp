<%
    Dim Conn 
    Dim CS

    Set Conn = Server.CreateObject("ADODB.Connection")

    CS = "Driver={SQL Server};Server=NABEELS-WORK;Database=TrainingManagementSystem;User Id=TMS;Password=Nabeel30;"
    Conn.Open CS
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
    </style>

</head>
<script>

</script>

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
                            <input type="text" class="form-control" name="FormStdGrNum" id="GrNum">
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student NIC Number</label>
                            <br>
                            <input type="text" class="form-control" name="FormStdNIC" id="StdNic" onblur="NICVal(this);"
                                required>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-6"></div>
                    <div class="col-6"></div>
                </div>

                <br>

                <div class="row">
                    <div class="col-4">
                        <div class="form-group">
                            <label for="" class="input-heading">Student First Name</label>
                            <br>
                            <input type="text" class="form-control" name="FormStdFirstName" id="FirstName"
                                onblur="FirstNameVal(this);" required>
                        </div>
                    </div>

                    <div class="col-4">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Middle Name</label>
                            <br>
                            <input type="text" class="form-control" name="FormStdMidName" id="MidName">
                        </div>
                    </div>

                    <div class="col-4">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Last Name</label>
                            <br>
                            <input type="text" class="form-control" name="FormStdLastName" id="LastName">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-4"></div>
                    <div class="col-4"></div>
                    <div class="col-4"></div>
                </div>

                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Date of Birth</label>
                            <br>
                            <input type="date" class="form-control" name="FormStdDob" id="Dob">
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Nationality</label>
                            <br>
                            <select name="FormStdNationalityId" id="" class="form-control" id="Nationality">
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
                    <div class="col-6"></div>
                    <div class="col-6"></div>
                </div>

                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Place of Birth</label>
                            <br>
                            <input type="text" class="form-control" name="FormStdPob" id="Pob">
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Religion</label>
                            <br>
                            <select name="FormStdReligionId" id="" class="form-control" id="Religion">
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
                    <div class="col-6"></div>
                    <div class="col-6"></div>
                </div>

                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="mr-2 input-heading">Student Gender</label>
                            <br>
                            <select name="FormStdGenderId" id="" class="form-control" id="Gender">
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
                            <select name="FormStdMaritalId" id="" class="form-control" id="MaritalStatus">
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
                    <div class="col-6"></div>
                    <div class="col-6"></div>
                </div>

                <div class="row">
                    <div class="col-4">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Mobile Number</label>
                            <br>
                            <input type="text" class="form-control" name="FormStdMob" id="StdMob">
                        </div>
                    </div>

                    <div class="col-5">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Email Address</label>
                            <br>
                            <input type="email" class="form-control" name="FormStdEmail" id="StdEmail">
                        </div>
                    </div>

                    <div class="col-3">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Home Telephone</label>
                            <br>
                            <input type="text" class="form-control" name="FormStdTelephone" id="StdHome">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-4"></div>
                    <div class="col-5"></div>
                    <div class="col-3"></div>
                </div>

                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Occupation</label>
                            <br>
                            <select name="FormStdOccupationId" id="" class="form-control">
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
                            <select name="FormStdJobDesignationId" id="" class="form-control">
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
                    <div class="col-6"></div>
                    <div class="col-6"></div>
                </div>

                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Company Name</label>
                            <br>
                            <input type="text" class="form-control" name="FormStdCompany">
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Work Telephone</label>
                            <br>
                            <input type="text" class="form-control" name="FormStdWorkPhone">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-6"></div>
                    <div class="col-6"></div>
                </div>

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
                            <input type="text" class="form-control" name="FormFatherName">
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Father NIC Number</label>
                            <br>
                            <input type="text" class="form-control" name="FormFatherNIC">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-6"></div>
                    <div class="col-6"></div>
                </div>

                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Father Mobile Number</label>
                            <br>
                            <input type="text" class="form-control" name="FormFatherMobile">
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Father Email Address</label>
                            <br>
                            <input type="email" class="form-control" name="FormFatherEmail">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-6"></div>
                    <div class="col-6"></div>
                </div>

                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Father Occupation</label>
                            <br>
                            <select name="FormFatherOccupationId" id="" class="form-control">
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
                    <div class="col-6"></div>
                    <div class="col-6"></div>
                </div>

                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Company Name</label>
                            <br>
                            <input type="text" class="form-control" name="FormFatherCompany">
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Father Work Telephone</label>
                            <br>
                            <input type="text" class="form-control" name="FormFatherWorkPhone">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-6"></div>
                    <div class="col-6"></div>
                </div>

                <div class="row">
                    <div class="col">
                        <div class="form-group d-flex justify-content-center">
                            <input type="submit" value="Add New Student Profile" class="add-btn">
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>

</html>