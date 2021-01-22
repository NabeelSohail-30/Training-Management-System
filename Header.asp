<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        * {
            margin: 0px;
            padding: 0px;
            text-decoration: none;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .banner {
            text-align: center;
        }

        .banner img {
            width: 100%;
            height: 300px;
        }

        /*-----------Navigation Bar ----------*/
        .NavBar ul {
            background-color: darkgrey;
            height: 100%;
            width: 100%;
            text-align: center;
            padding-top: 5px;
            padding-bottom: 5px;
        }

        .NavBar li {
            display: inline-block;
        }

        .NavBar a {
            color: black;
            display: block;
            font-size: 18px;
            text-align: center;
            padding: 10px 25px;
            font-weight: 600;
        }

        .NavBar a:hover {
            background-color: floralwhite;
            border-radius: 8px;
            text-decoration: none;
        }
    </style>
</head>

<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col">
                <div class="banner">
                    <img src="images/Banner.png" alt="">
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <!-------------------------Navigation Bar----------------------->
                <nav class="NavBar">
                    <ul>
                        <li>
                            <a href="#">Main Menu</a>
                        </li>

                        <li>
                            <a href="#">Courses</a>
                        </li>

                        <li>
                            <a href="#">Students Profiles</a>
                        </li>

                        <li>
                            <a href="#">Sign Out</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>

</body>

</html>