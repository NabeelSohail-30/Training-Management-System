<!--#include file=../OpenDbConn.asp-->
<!--#include file=../ReValidateLogin.asp-->

<%
call OpenDbConn()
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../CSS/bootstrap.css">
    <link rel="stylesheet" href="../CSS/StyleReports.css">
    <title>Report Template</title>
</head>

<body>
    <header>
        <h1 class="text-center">Training Management System</h1>
        <h3 class="text-center">Report Name</h3>
    </header>

    <main>

    </main>

    <footer>
        <div class="row" style="padding-bottom: 12px;">
            <div class="col text-center" style="font-size: small;">
                Copyright &copy; 2020 - <% response.write(Year(Date()))%>, Training Management System. All
                Rights
                Reserved
            </div>
        </div>
    </footer>
</body>

</html>