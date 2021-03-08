<% 
    Dim LoggedInDate
    Dim LoggedOutDate

    LoggedInDate = Session("SLoggedDateTime")
    LoggedOutDate = Now()

    'response.write("User was Logged On: " & FormatDateTime(LoggedInDate,1) & " - " & FormatDateTime(LoggedInDate,3))
    'response.write("User was Logged Off: " & FormatDateTime(LoggedOutDate,1) & " - " & FormatDateTime(LoggedOutDate,3))

    Dim SDuration

    SDuration = DateDiff("s",LoggedInDate,LoggedOutDate)

    'response.write(SDuration)

    Function Duration(SecDuration)
        Dim TotalDuration
        TotalDuration = DateAdd("s", SecDuration, #00:00:00#)

        if SecDuration < 3600 then
        'response.write("<br> Total Duration : " & "00:" & Minute(TotalDuration) & ":" & Second(TotalDuration) )
        Duration = "00:" & Minute(TotalDuration) & ":" & Second(TotalDuration)
        else
        'response.write("<br> Total Duration : " &  Hour(TotalDuration) & ":" & Minute(TotalDuration) & ":" & Second(TotalDuration) )
        Duration = Hour(TotalDuration) & ":" & Minute(TotalDuration) & ":" & Second(TotalDuration)
        end if
    end Function

    Session.abandon
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <link rel="stylesheet" href="CSS/GlobalStyle.css.css">
    <link rel="stylesheet" href="CSS/StyleHeader.css">
    <link rel="stylesheet" href="CSS/StyleFooter.css">
    <title>Sign Out</title>
</head>

<body style="background-color: lightgray">
    <header>
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
                            <a href="Login.asp">Click Here to Login Again</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>

        <marquee behavior="" direction="" class="mt-5">
            <span>Thanks for using Training Management System</span>
        </marquee>
    </header>

    <main>
        <div class="row text-center mt-5" style="background-color: darkgrey">
            <div class="col">
                <h3>You Have been Logged Out Successfully</h3>
            </div>
        </div>

        <br><br>

        <div class="row text-center mt-5">
            <div class="col-4">
                <h5>Login Date/Time</h5>
            </div>
            <div class="col-4">
                <h5>Logout Date/Time</h5>
            </div>
            <div class="col-4">
                <h5>Logged In Duration</h5>
            </div>
        </div>
        <div class="row text-center" style="background-color: rgb(73, 73, 73); color: whitesmoke;">
            <div class="col-4">
                <h5><% response.write(FormatDateTime(LoggedInDate,1) & " - " & FormatDateTime(LoggedInDate,3)) %></h5>
            </div>
            <div class="col-4">
                <h5><% response.write(FormatDateTime(LoggedOutDate,1) & " - " & FormatDateTime(LoggedOutDate,3)) %></h5>
            </div>
            <div class="col-4">
                <h5><% response.write(Duration(SDuration)) %></h5>
            </div>
        </div>
    </main>

    <footer style="background-color: rgb(73, 73, 73); color: whitesmoke; margin-top: 90px;">
        <div class="container-fluid">
            <div class="row justify-content-center mt-3">
                <div class="col-3 pt-4">
                    <h5>About Us</h5>
                    <span>This Web Application Training Management System (TMS) is created by Nabeel Sohail.</span>
                </div>

                <div class="vl"></div>

                <div class="col-5 text-center pt-4">
                    <h5>Quick Links</h5>
                    <ul class="links">
                        <li>
                            <a href="Login.asp">Click Here to Login Again</a>
                        </li>
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

</html>