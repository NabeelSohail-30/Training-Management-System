<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->
<%

    Dim CourseId
    CourseId = request.QueryString("QsCourseId")

    Dim RSCourseContent
    Set RSCourseContent = Server.CreateObject("ADODB.RecordSet")
    RSCourseContent.Open "SELECT * FROM V_CourseContentView WHERE(CourseId = " & CourseId & ")", conn

%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <link rel="stylesheet" href="CSS/GlobalStyle.css">
    <link rel="stylesheet" href="CSS/StyleAddCourse.css">
    <title>View Course Content</title>
</head>

<body>
    <header>
        <!--#include file=Header.asp-->
    </header>

    <div class="wrapper">
        <div class="container-fluid">
            <div class="row justify-content-center">
                <div class="col">
                    <ul class="nav nav-tabs">
                        <li class="nav-item">
                            <a class="nav-link active"
                                href="CourseContentView.asp?QsCourseId=<% response.write(CourseId) %>">View Course
                                Content</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link"
                                href="CourseContentEdit.asp?QsCourseId=<% response.write(CourseId) %>">Edit
                                Course Content</a>
                        </li>
                    </ul>
                </div>
            </div>

            <br>

            <div class="panel">
                <div class="panel-head">
                    <div class="row">
                        <div class="col">
                            <label for="">View Course Content</label>
                        </div>
                    </div>
                </div>

                <div class="panel-body">

                    <div class="row mt-3">
                        <div class="col">
                            <div class="form-group">
                                <label for="" class="input-heading">Course Code</label>
                                <br>
                                <label for="" class="form-control"><% response.Write(RSCourseContent("CourseCode")) %></label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            <div class="form-group">
                                <label for="" class="input-heading">Course Name</label>
                                <br>
                                <label for="" class="form-control"><% response.Write(RSCourseContent("CourseName")) %></label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-6">
                            <div class="form-group">
                                <label for="" class="input-heading">Category</label>
                                <br>
                                <label for="" class="form-control"><% response.Write(RSCourseContent("Category")) %></label>
                            </div>
                        </div>

                        <div class="col-6">
                            <div class="form-group">
                                <label for="" class="input-heading">Sub Category</label>
                                <br>
                                <label for="" class="form-control"><% response.Write(RSCourseContent("SubCategory")) %></label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            <div class="form-group">
                                <label for="" class="input-heading">Course Description</label>
                                <br>
                                <div class=""><% response.Write(RSCourseContent("CourseDescription")) %></div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            <div class="form-group">
                                <label for="" class="input-heading">Audience</label>
                                <br>
                                <label for="" class="form-control"><% response.Write(RSCourseContent("Audience")) %></label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%
        RSCourseContent.close
        set RSCourseContent = Nothing
    %>
    <footer>
        <!--#include file=Footer.asp-->
    </footer>
</body>

</html>