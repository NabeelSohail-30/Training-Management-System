<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/GlobalStyle.css">
    <link rel="stylesheet" href="CSS/StyleFooter.css">
    <title>Footer</title>
</head>
<body>
    <body>
        <footer style="background-color: rgb(73, 73, 73); color: whitesmoke;">
            <div class="container-fluid">
                <div class="row justify-content-center mt-3">
                    <div class="col-3 pt-4">
                        <h5>About Us</h5>
                        <div>This Web Application Training Management System (TMS) is created by Nabeel Sohail.</div>
                    </div>
    
                    <div class="vl"></div>
    
                    <div class="col-5 text-center pt-4">
                        <h5>Quick Links</h5>
                        <ul class="links">
                            <li><a href="Dashboard.asp">Main Menu</a></li>
                            <li><a href="StudentProfile.asp">Students Profiles</a></li>
                            <li><a href="CourseContent.asp">Courses</a></li>
                            <li><a href="SignOut.asp">Sign Out</a></li>
                        </ul>
                    </div>
    
                    <div class="vl"></div>
    
                    <div class="col-3 text-center pt-4">
                        <h5>Social Media Links</h5>
                        <ul class="media-icons">
                            <li><a href="#"><img src="images/facebook.png" alt=""></a></li>
                            <li><a href="#"><img src="images/instagram.png" alt=""></a></li>
                            <li><a href="#"><img src="images/twitter.png" alt=""></a></li>
                            <li><a href="#"><img src="images/youtube.png" alt=""></a></li>
                            <li><a href="#"><img src="images/linkedin.png" alt=""></a></li>
                        </ul>
                    </div>
                </div>
    
                <hr style="color:gray;background-color:gray">
    
                <div class="row" style="padding-bottom: 12px;">
                    <div class="col text-center" style="font-size: small;">
                        Copyright &copy; 2020 - <% response.write(Year(Date()))%>, Training Management System. All Rights
                        Reserved
                    </div>
                </div>
            </div>
        </footer>
    </body>
</body>
</html>