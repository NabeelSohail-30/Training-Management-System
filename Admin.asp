<!--#include file=ReValidateLogin.asp-->
<% if Session("SUserRoleId") = 1 then %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <link rel="stylesheet" href="CSS/GlobalStyle.css">
    <link rel="stylesheet" href="CSS/StyleAddCourseDir.css">
    <title>Admin</title>
    <style>
        a.button {
            width: 90%;
            background-color: darkgrey;
            color: black;
            font-weight: bold;
        }

        a.button:hover {
            background-color: lightgray;
        }
    </style>
</head>

<body>
    <header>
        <!--#include file=Header.asp-->
    </header>

    <div class="wrapper">
        <div class="container-fluid">
            <div class="panel">
                <br>
                <div class="panel-head">
                    <div class="row">
                        <div class="col">
                            <label for="">Data List Menu</label>
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <br>
                    <div class="row">
                        <div class="col-3 d-flex justify-content-center">
                            <a href="ListCourseCategory.asp" class="button">Course Category</a>
                        </div>
                        <div class="col-3 d-flex justify-content-center">
                            <a href="ListCourseSubCategory.asp" class="button">Course Sub Category</a>
                        </div>
                        <div class="col-3 d-flex justify-content-center">
                            <a href="ListCourseDirectoryStatus.asp" class="button">Course Directory Status</a>
                        </div>
                        <div class="col-3 d-flex justify-content-center">
                            <a href="ListEnrollmentStatus.asp" class="button">Enrollment Status</a>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-3 d-flex justify-content-center">
                            <a href="ListGender.asp" class="button">Gender</a>
                        </div>
                        <div class="col-3 d-flex justify-content-center">
                            <a href="ListInstructor.asp" class="button">Instructor</a>
                        </div>
                        <div class="col-3 d-flex justify-content-center">
                            <a href="ListJobDesignation.asp" class="button">Job Designation</a>
                        </div>
                        <div class="col-3 d-flex justify-content-center">
                            <a href="ListLanguage.asp" class="button">Language</a>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-3 d-flex justify-content-center">
                            <a href="ListMajor.asp" class="button">Major</a>
                        </div>
                        <div class="col-3 d-flex justify-content-center">
                            <a href="ListMaritalStatus.asp" class="button">Marital Status</a>
                        </div>
                        <div class="col-3 d-flex justify-content-center">
                            <a href="ListNationality.asp" class="button">Nationality</a>
                        </div>
                        <div class="col-3 d-flex justify-content-center">
                            <a href="ListOccupation.asp" class="button">Occupation</a>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-3 d-flex justify-content-center">
                            <a href="ListQualifications.asp" class="button">Qualification</a>
                        </div>
                        <div class="col-3 d-flex justify-content-center">
                            <a href="ListReligion.asp" class="button">Religion</a>
                        </div>
                        <div class="col-3 d-flex justify-content-center">
                            <a href="ListRoom.asp" class="button">Room</a>
                        </div>
                        <div class="col-3 d-flex justify-content-center">
                            <a href="ListTechnicalQualification.asp" class="button">Technical Qualification</a>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col d-flex justify-content-center">
                            <a href="ListTimeSlot.asp" class="button" style="width:20%">Time Slot</a>
                        </div>
                    </div>
                </div>
                <br>
            </div>
        </div>
    </div>

    <footer>
        <!--#include file=Footer.asp-->
    </footer>

</body>
<%
else
response.redirect("dashboard.asp")
end if
%>

</html>