<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/StyleHeader.css">
    <title>Document</title>
</head>

<body>

    <div class="banner">
        <img src="images/Banner.png" alt="" class="banner-img">
    </div>

    <div class="logo">
        Training Management System
    </div>

    <div class="row">
        <div class="col-md-12">
            <!-------------------------Navigation Bar----------------------->
            <nav class="NavBar">
                <ul>
                    <li>
                        <a href="Dashboard.asp">Main Menu</a>
                    </li>

                    <li>
                        <a href="StudentProfile.asp">Students Profiles</a>
                    </li>

                    <li>
                        <a href="CourseContent.asp">Courses</a>
                    </li>

                    <li>
                        <a href="CourseDirectory.asp">Course Directory</a>
                    </li>

                    <li class="dropdown">
                        <a href="" class="dropbtn">Data Lists</a>
                        <ul class="dropdown-content">
                            <li><a href="ListCourseCategory.asp">List Course Category</a></li>
                            <li><a href="ListCourseSubCategory.asp">List Course Sub Category</a></li>
                            <li><a href="ListCourseDirectoryStatus.asp">List Course Directory Status</a></li>
                            <li><a href="ListEnrollmentStatus.asp">List Enrollment Status</a></li>
                            <li><a href="ListGender.asp">List Gender</a></li>
                            <li><a href="ListInstructor.asp">List Instructor</a></li>
                            <li><a href="ListJobDesignation.asp">List Job Designation</a></li>
                            <li><a href="ListLanguage.asp">List Language</a></li>
                            <li><a href="ListMajor.asp">List Major</a></li>
                            <li><a href="ListMaritalStatus.asp">List Marital Status</a></li>
                            <li><a href="ListNationality.asp">List Nationality</a></li>
                            <li><a href="ListOccupation.asp">List Occupation</a></li>
                            <li><a href="ListQualification.asp">List Qualifications</a></li>
                            <li><a href="ListReligion.asp">List Religion</a></li>
                            <li><a href="ListRoom.asp">List Room</a></li>
                            <li><a href="ListTechnicalQualification.asp">List Technical Qualifications</a></li>
                            <li><a href="ListTimeSlot.asp">List Time Slot</a></li>
                        </ul>
                    </li>

                    <li>
                        <a href="SignOut.asp">Sign Out</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>

    <marquee behavior="" direction="">
        <span><% response.write("Welcome to Training Management System") %></span>
        <span><img src="Images/seperator.png" alt="" width="16px" height="16px" style="margin: auto;"></span>
        <span><% response.write("User Name : " & Session("SUserName"))%></span>
        <span><img src="Images/seperator.png" alt="" width="16px" height="16px" style="margin: auto;"></span>
        <span><% response.write("User Email : " & Session("SUserEmail")) %></span>
        <span><img src="Images/seperator.png" alt="" width="16px" height="16px" style="margin: auto;"></span>
        <span><% response.write("Logged in Date/Time : " & Session("SLoggedDateTime")) %></span>
        <span><img src="Images/seperator.png" alt="" width="16px" height="16px" style="margin: auto;"></span>
        <span><% response.write("Current Date/Time : " & Now()) %></span>
    </marquee>
</body>

</html>