<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <link rel="stylesheet" href="CSS/StyleLogin.css">
</head>

<body>
    <main>
        <div class="loginbox">
            <img src="images/Avatar.png" alt="" class="avatar">

            <div class="header">
                <h1>Login</h1>
            </div>

            <form action="ValidateLogin.asp" method="POST">
                <div>
                    <label for="">User Email</label>
                    <input type="email" name="TxtUserEmail" id="" placeholder="Enter Login Email" value="
                        <% response.write(Session("SUserEmail")) %>"">
                    <span style=" color: red; font-size:medium; text-align: center;"><% response.Write(Session("SErrorEmail")) %></span>
                </div>

                <div>
                    <label for="">Password</label>
                    <input type="password" name="TxtUserPass" id="TxtPassword" placeholder="Enter Password">
                    <span style=" color: red; font-size:medium; text-align: center;"><% response.Write(Session("SErrorPass")) %></span>
                </div>

                <div>
                    <span style="color: red; font-size:medium;"><% response.Write(Session("SErrorInvalid")) %></span>
                    <span style="color: red; font-size:medium;"><% response.Write(Session("STimeoutError")) %></span>
                </div>
                <input type="submit" value="Login">
            </form>
        </div>
    </main>
</body>

</html>