<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
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

        .loginbox {
            width: 340px;
            height: 420px;
            top: 50%;
            left: 50%;
            background-color: whitesmoke;
            color: black;
            position: absolute;
            transform: translate(-50%, -50%);
            padding: 30px 70px;
        }

        .avatar {
            width: 100px;
            height: 100px;
            position: absolute;
            top: -10%;
            left: calc(50% - 50px);
        }

        h1 {
            margin: 0px;
            padding: 0 0 20px;
            text-align: center;
            margin-top: 30px;
            margin-bottom: 5px;
        }

        .loginbox label {
            margin: 0px;
            padding: 0px;
            font-weight: bold;
        }

        .loginbox input[type="submit"]{
            width: 100%;
            margin-bottom: 20px;
            border: none;
            outline: none;
            height: 40px;
            background-color: blue;
            color: whitesmoke;
            font-size: 18px;
            border-radius: 20px;
            font-weight: 600;
            margin-top: 10px;
        }

        .loginbox input[type="submit"]:hover{
            width: 100%;
            margin-bottom: 20px;
            border: none;
            outline: none;
            height: 40px;
            background-color: lightgray;
            color: black;
            font-size: 18px;
            border-radius: 20px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 10px;
        }

        .loginbox input[type="email"],
        input[type="password"] {
            width: 100%;
            margin-bottom: 20px;
            border: none;
            border-bottom: 1px solid black;
            background: transparent;
            outline: none;
            height: 40px;
            font-size: 16px;
            color: black;
        }
    </style>
</head>

<body>
    <main>
        <div class="loginbox">
            <img src="images/Avatar.png" alt="" class="avatar">

            <div class="header">
                <h1>Login</h1>
            </div>

            <form action="#">
                <label for="">User Email</label>
                <input type="email" name="" id="" placeholder="Enter Login Email">
                <label for="">Password</label>
                <input type="password" name="" id="" placeholder="Enter Password">
                <input type="submit" value="Login">
            </form>
        </div>
    </main>
</body>

</html>