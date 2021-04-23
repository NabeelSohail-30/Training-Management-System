<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->
<!--#include file=AppSetting.asp-->
<% 
    Dim RSStdDetail
    Dim StdId

    StdId = request.QueryString("QsStdId")

    Set RSStdDetail = Server.CreateObject("ADODB.RecordSet")
    QryStr = "SELECT StudentDetail.StudentId, StudentDetail.StdGrNumber, StudentDetail.StdNICNumber, StudentDetail.StdFirstName, StudentDetail.StdMidName, StudentDetail.StdLastName, StudentDetail.StdPhoto," & _ 
                "StudentDetail.StdDateOfBirth, ListNationality.Nationality AS StdNationality, StudentDetail.StdPlaceOfBirth, ListGender.Gender AS StdGender, ListReligion.Religion AS StdReligion," & _
                "ListMaritalStatus.MaritalStatus AS StdMaritalSt, StudentDetail.StdMobileNumber, StudentDetail.StdEmailAddress, StudentDetail.StdHomeTelephone, ListOccupation.Occupation AS StdOccupation," & _
                "ListJobDesignation.JobDesignation AS StdJobDesignation, StudentDetail.StdCompanyName, StudentDetail.StdWorkTelephone, StudentDetail.FatherName, StudentDetail.FatherNICNumber," & _
                "StudentDetail.FatherMobileNumber, StudentDetail.FatherEmailAddress, ListOccupation_1.Occupation AS FatherOccupation, ListJobDesignation_1.JobDesignation AS FatherJobDesignation," & _
                "StudentDetail.FatherCompanyName, StudentDetail.FatherWorkTelephone " & _
                "FROM StudentDetail LEFT OUTER JOIN " & _
                "ListJobDesignation AS ListJobDesignation_1 ON StudentDetail.FatherJobDesignationId = ListJobDesignation_1.JobDesignationId LEFT OUTER JOIN " & _
                "ListOccupation AS ListOccupation_1 ON StudentDetail.FatherOccupationId = ListOccupation_1.OccupationId LEFT OUTER JOIN " & _
                "ListJobDesignation ON StudentDetail.StdJobDesignationId = ListJobDesignation.JobDesignationId LEFT OUTER JOIN " & _
                "ListOccupation ON StudentDetail.StdOccupationId = ListOccupation.OccupationId LEFT OUTER JOIN " & _
                "ListNationality ON StudentDetail.StdNationalityId = ListNationality.NationalityId LEFT OUTER JOIN " & _
                "ListReligion ON StudentDetail.StdReligionId = ListReligion.ReligionId LEFT OUTER JOIN " & _
                "ListGender ON StudentDetail.StdGenderId = ListGender.GenderId LEFT OUTER JOIN " & _
                "ListMaritalStatus ON StudentDetail.StdMaritalStatusId = ListMaritalStatus.MaritalStatusId " & _
                "WHERE(StudentDetail.StudentId =" & StdId & ")"
                    
    'response.write(QryStr)
    'response.End 
    RSStdDetail.Open QryStr, conn    

    'Variables Declaration
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
         
         StdGrNum = RSStdDetail("StdGrNumber")
         StdNIC = RSStdDetail("StdNICNumber")
         StdFirstName = RSStdDetail("StdFirstName")
         StdMidName = RSStdDetail("StdMidName")
         StdLastName = RSStdDetail("StdLastName")
         StdDob = RSStdDetail("StdDateOfBirth")
         StdNationalityId = RSStdDetail("StdNationality")
         StdPob = RSStdDetail("StdPlaceOfBirth")
         StdReligionId = RSStdDetail("StdReligion")
         RSStdDetail.MoveFirst
         StdGenderId = RSStdDetail("StdGender")
         StdMaritalStatusId = RSStdDetail("StdMaritalSt")
         StdMobile = RSStdDetail("StdMobileNumber")
         StdEmail = RSStdDetail("StdEmailAddress")
         StdTelephone = RSStdDetail("StdHomeTelephone")
         StdOccupationId = RSStdDetail("StdOccupation")
         StdJobDesignationId = RSStdDetail("StdJobDesignation")
         StdCompany = RSStdDetail("StdCompanyName")
         StdWorkPhone = RSStdDetail("StdWorkTelephone")
         FatherName = RSStdDetail("FatherName")
         FatherNIC = RSStdDetail("FatherNICNumber")
         FatherMobile = RSStdDetail("FatherMobileNumber")
         FatherEmail = RSStdDetail("FatherEmailAddress")
         FatherOccupationId = RSStdDetail("FatherOccupation")
         FatherJobDesignationId = RSStdDetail("FatherJobDesignation")
         FatherCompany = RSStdDetail("FatherCompanyName")
         FatherWorkPhone = RSStdDetail("FatherWorkTelephone")
    'end

    RSStdDetail.Close
    Set RSStdDetail = Nothing
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <link rel="stylesheet" href="CSS/GlobalStyle.css">
    <link rel="stylesheet" href="CSS/StyleViewStdDetail.css">
    <title>View Student Detail</title>
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
                            <a class="nav-link active"
                                href="ViewStudentDetail.asp?QsStdId=<% response.Write(StdId) %>">View Student Detail</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="EditStudentDetail.asp?QsStdId=<% response.Write(StdId) %>">Edit
                                Student Detail</a>
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
                        <li class="nav-item">
                            <a class="nav-link" href="StudentCourse.asp?QsStdId=<% response.Write(StdId) %>">Training
                                Courses</a>
                        </li>
                    </ul>
                </div>
            </div>

            <br>

            <div class="panel">
                <div class="panel-head">
                    <div class="row">
                        <div class="col">
                            <label for="">View Student's Detail</label>
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
                                        <label for="" class="form-control"><% response.Write(StdGrNum) %></label>
                                    </div>
                                </div>

                                <div class="col-6">
                                    <div class="form-group">
                                        <label for="" class="input-heading">Student NIC Number</label>
                                        <br>
                                        <label for="" class="form-control"><% response.Write(StdNIC) %></label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-3">
                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Student First Name</label>
                                <br>
                                <label for="" class="form-control"><% response.Write(StdFirstName) %></label>
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Student Middle Name</label>
                                <br>
                                <label for="" class="form-control"><% response.Write(StdMidName) %></label>
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Student Last Name</label>
                                <br>
                                <label for="" class="form-control"><% response.Write(StdLastName) %></label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-6">
                            <div class="form-group">
                                <label for="" class="input-heading">Student Date of Birth</label>
                                <br>
                                <label for="" class="form-control"><% response.Write(StdDob) %></label>
                            </div>
                        </div>

                        <div class="col-6">
                            <div class="form-group">
                                <label for="" class="input-heading">Student Nationality</label>
                                <br>
                                <label for="" class="form-control"><% response.Write(StdNationalityId) %></label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-6">
                            <div class="form-group">
                                <label for="" class="input-heading">Student Place of Birth</label>
                                <br>
                                <label for="" class="form-control"><% response.Write(StdPob) %></label>
                            </div>
                        </div>

                        <div class="col-6">
                            <div class="form-group">
                                <label for="" class="input-heading">Student Religion</label>
                                <br>
                                <label for="" class="form-control"><% response.Write(StdReligionId) %></label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-6">
                            <div class="form-group">
                                <label for="" class="mr-2 input-heading">Student Gender</label>
                                <br>
                                <label for="" class="form-control"><% response.Write(StdGenderId) %></label>
                            </div>
                        </div>

                        <div class="col-6">
                            <div class="form-group">
                                <label for="" class="mr-2 input-heading">Student Marital Status</label>
                                <br>
                                <label for="" class="form-control"><% response.Write(StdMaritalStatusId) %></label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-4">
                            <div class="form-group">
                                <label for="" class="input-heading">Student Mobile Number</label>
                                <br>
                                <label for="" class="form-control"><% response.Write(StdMobile) %></label>
                            </div>
                        </div>

                        <div class="col-5">
                            <div class="form-group">
                                <label for="" class="input-heading">Student Email Address</label>
                                <br>
                                <label for="" class="form-control"><% response.Write(StdEmail) %></label>
                            </div>
                        </div>

                        <div class="col-3">
                            <div class="form-group">
                                <label for="" class="input-heading">Student Home Telephone</label>
                                <br>
                                <label for="" class="form-control"><% response.Write(StdTelephone) %></label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-6">
                            <div class="form-group">
                                <label for="" class="input-heading">Student Occupation</label>
                                <br>
                                <label for="" class="form-control"><% response.Write(StdOccupationId) %></label>
                            </div>
                        </div>

                        <div class="col-6">
                            <div class="form-group">
                                <label for="" class="input-heading">Student Job Designation</label>
                                <br>
                                <label for="" class="form-control"><% response.Write(StdJobDesignationId) %></label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-6">
                            <div class="form-group">
                                <label for="" class="input-heading">Student Company Name</label>
                                <br>
                                <label for="" class="form-control"><% response.Write(StdCompany) %></label>
                            </div>
                        </div>

                        <div class="col-6">
                            <div class="form-group">
                                <label for="" class="input-heading">Student Work Telephone</label>
                                <br>
                                <label for="" class="form-control"><% response.Write(StdWorkPhone) %></label>
                            </div>
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
                                <label for="" class="form-control"><% response.Write(FatherName) %></label>
                            </div>
                        </div>

                        <div class="col-6">
                            <div class="form-group">
                                <label for="" class="input-heading">Father NIC Number</label>
                                <br>
                                <label for="" class="form-control"><% response.Write(FatherNIC) %></label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-6">
                            <div class="form-group">
                                <label for="" class="input-heading">Father Mobile Number</label>
                                <br>
                                <label for="" class="form-control"><% response.Write(FatherMobile) %></label>
                            </div>
                        </div>

                        <div class="col-6">
                            <div class="form-group">
                                <label for="" class="input-heading">Father Email Address</label>
                                <br>
                                <label for="" class="form-control"><% response.Write(FatherEmail) %></label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-6">
                            <div class="form-group">
                                <label for="" class="input-heading">Father Occupation</label>
                                <br>
                                <label for="" class="form-control"><% response.Write(FatherOccupationId) %></label>
                            </div>
                        </div>

                        <div class="col-6">
                            <div class="form-group">
                                <label for="" class="input-heading">Father Job Designation</label>
                                <br>
                                <label for="" class="form-control"><% response.Write(FatherJobDesignationId) %></label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-6">
                            <div class="form-group">
                                <label for="" class="input-heading">Company Name</label>
                                <br>
                                <label for="" class="form-control"><% response.Write(FatherCompany) %></label>
                            </div>
                        </div>

                        <div class="col-6">
                            <div class="form-group">
                                <label for="" class="input-heading">Father Work Telephone</label>
                                <br>
                                <label for="" class="form-control"><% response.Write(FatherWorkPhone) %></label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <br>
        </div>
    </div>

    <footer>
        <!--#include file=Footer.asp-->
    </footer>
</body>

</html>