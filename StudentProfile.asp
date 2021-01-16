<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Students Detail</title>
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

        .action {
            text-align: center;
            margin-top: 30px;
        }

        .add-new {
            background-color: rgb(29, 21, 172);
            padding: 12px 18px;
            font-size: 22px;
            color: whitesmoke;
            font-weight: bold;
        }

        .student-search {
            margin-top: 20px;
            padding: 10px;
            font-size: 16px;
            border: 1px solid white;
            border-radius: 10px;
        }

        .search-btn {
            background-color: rgb(29, 21, 172);
            padding: 8px 10px;
            font-size: 16px;
            color: whitesmoke;
            font-weight: 600;
            border-radius: 10px;
            cursor: pointer;
        }
    </style>
</head>

<body>
    <header>
        <!--#include file=Header.asp-->
    </header>

    <main>
        <section class="action">
            <div>
                <a href="#" class="add-new">New Student</a>
            </div>
            <div>
                <form class="search-bar" action="#">
                    <input type="search-name" class="student-search" placeholder="Search">
                    <input type="submit" name="" id="" class="search-btn" value="Search">
                </form>
            </div>
        </section>
    </main>
</body>

</html>