<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->
<!--#include file=AppSetting.asp-->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/bootstrap.css">
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
            background-color: whitesmoke;
            padding: 10px 22px;
            font-size: 22px;
            border: 0px;
            outline: 0px;
            border-radius: 20px;
            color: black;
            font-weight: bold;
        }

        .btn a:hover {
            background-color: rgb(0, 140, 255);
            padding: 10px 22px;
            font-size: 22px;
            border: 0px;
            outline: 0px;
            border-radius: 20px;
            color: whitesmoke;
            font-weight: bold;
            text-decoration: none;
        }

        .add-new img {
            margin-bottom: 3px;
        }

        .search-bar {
            margin-bottom: 28px;
            padding: 8px;
            font-size: 16px;
            border: 1px solid white;
            border-radius: 10px;
            width: 200px;
        }

        form {
            margin-top: 20px;
        }

        form div {
            display: inline-block;
            margin: 0px 20px;
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

        .student-profile-list {
            margin-top: 20px;
            margin-left: 10px;
            margin-right: 10px;
        }

        table {
            border: 2px solid black;
            background-color: whitesmoke;
            color: black;
        }

        .table {
            text-align: center;
            vertical-align: middle;
        }

        .icon img {
            width: 26px;
            height: 26px;
        }

        .link-btn {
            text-align: center;
        }
    </style>
</head>

<%
    call OpenDbConn()
    Dim RSStdDetail
    Set RSStdDetail = Server.CreateObject("ADODB.RecordSet")
    RSStdDetail.Open "SELECT StdGrNumber, StdFirstName, StdLastName, FatherName, StdMobileNumber, StdEmailAddress FROM StudentDetail ORDER BY StudentId DESC", conn 
%>

<body>
    <header>
        <!--#include file=Header.asp-->
    </header>

    <main>
        <section class="action">
            <div>
                <form class="search" action="#">
                    <div>
                        <input type="search" class="search-bar" placeholder="Search By GR Number">
                    </div>
                    <div>
                        <input type="search" class="search-bar" placeholder="Search By First Name">
                    </div>
                    <div>
                        <input type="search" class="search-bar" placeholder="Search By Last Name">
                    </div>
                    <div>
                        <input type="search" class="search-bar" placeholder="Search By Father Name">
                    </div>
                    <input type="submit" name="" id="" class="search-btn" value="Search">
                </form>
            </div>
            <div class="btn">
                <a href="AddNewStdProfile.asp" class="add-new" title="Add New Student Profile"><img src="Images/Add.svg" alt="" title="Add New Student Profile"
                        width="26px" height="26px"> New Student</a>
            </div>
        </section>

        <section class="student-profile-list">
            <table class="table table-bordered table-hover">
                <thead class="thead-light">
                    <tr>
                        <th style="width: 6%;">GR Number</th>
                        <th style="width: 14%;">First Name</th>
                        <th style="width: 14%;">Last Name</th>
                        <th style="width: 12%;">Father Name</th>
                        <th style="width: 10%;">Phone Number</th>
                        <th style="width: 18%;">Email Address</th>
                        <th style="width: 4%;"></th>
                        <th style="width: 4%;"></th>
                        <th style="width: 4%;"></th>
                        <th style="width: 4%;"></th>
                        <th style="width: 4%;"></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        do while RSStdDetail.EOF=false
                    %>
                    <tr>
                        <td><% response.Write(RSStdDetail("StdGrNumber")) %></td>
                        <td><% response.Write(RSStdDetail("StdFirstName")) %></td>
                        <td><% response.Write(RSStdDetail("StdLastName")) %></td>
                        <td><% response.Write(RSStdDetail("FatherName")) %></td>
                        <td><% response.Write(RSStdDetail("StdMobileNumber")) %></td>
                        <td><% response.Write(RSStdDetail("StdEmailAddress")) %></td>
                        <td class="link-btn">
                            <a href="#" class="icon">
                                <img src="Images/profile.png" alt="" title="View Profile">
                            </a>
                        </td>
                        <td class="link-btn">
                            <a href="#" class="icon">
                                <img src="Images/profile.png" alt="" title="Edit Profile">
                            </a>
                        </td>
                        <td class="link-btn">
                            <a href="#" class="icon">
                                <img src="Images/profile.png" alt="" title="Academic Qualifications">
                            </a>
                        </td>
                        <td class="link-btn">
                            <a href="#" class="icon">
                                <img src="Images/profile.png" alt="" title="Technical Qualifications">
                            </a>
                        </td>
                        <td class="link-btn">
                            <a href="#" class="icon">
                                <img src="Images/profile.png" alt="" title="Work Experience">
                            </a>
                        </td>
                    </tr>
                    <%
                        RSStdDetail.MoveNext
                        loop     
                    %>
                </tbody>
            </table>
        </section>
    </main>
</body>

</html>