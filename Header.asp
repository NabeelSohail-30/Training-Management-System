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