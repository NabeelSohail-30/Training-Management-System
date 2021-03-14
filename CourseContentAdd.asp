<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <link rel="stylesheet" href="CSS/GlobalStyle.css">
    <link rel="stylesheet" href="CSS/StyleAddCourse.css">
    <title>Add Course</title>
</head>

<body>
    <header>
        <!--#include file=Header.asp-->
    </header>

    <div class="wrapper">
        <div class="container-fluid">
            <div class="panel">
                <br>
                <div class="panel-head">
                    <div class="row">
                        <div class="col">
                            <label for="">Add New Course</label>
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <form action="CourseContentSave.asp" method="POST">
                        <div class="row mt-2">
                            <div class="col">
                                <div class="form-group">
                                    <label for="" class="input-heading">Course Code</label>
                                    <input type="text" class="form-control" name="FormCourseCode">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <span><% response.write(Session("sCourseCode")) %></span>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label for="" class="input-heading">Course Name</label>
                                    <input type="text" class="form-control" name="FormCourseName">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <span><% response.write(Session("sCourseName")) %></span>
                            </div>
                        </div>

                        <div class="row mt-2">
                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Select Category</label>
                                    <select name="FormCourseCategoryId" id="" class="form-control">
                                        <option value="-1">Select Category</option>
                                        <%
                                        Dim RSCategory
                                        Set RSCategory = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSCategory.Open "SELECT CategoryId, Category FROM ListCourseCategory",Conn
    
                                        do while NOT RSCategory.EOF
                                    %>
                                        <option value="<% response.write(RSCategory("CategoryId")) %>">
                                            <% response.write(RSCategory("Category")) %></option>
                                        <%
                                        RSCategory.MoveNext
                                        Loop
                
                                        RSCategory.Close
                                        Set RSNationality = Nothing
                                    %>
                                    </select>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Select Sub Category</label>
                                    <select name="FormCourseSubCategoryId" id="" class="form-control">
                                        <option value="-1">Select Sub Category</option>
                                        <%
                                        Dim RSSubCategory
                                        Set RSSubCategory = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSSubCategory.Open "SELECT SubCategoryId, SubCategory FROM ListCourseSubCategory",Conn
    
                                        do while NOT RSSubCategory.EOF
                                    %>
                                        <option value="<% response.write(RSSubCategory("SubCategoryId")) %>">
                                            <% response.write(RSSubCategory("SubCategory")) %></option>
                                        <%
                                        RSSubCategory.MoveNext
                                        Loop
                
                                        RSSubCategory.Close
                                        Set RSNationality = Nothing
                                    %>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <span><% response.write(Session("sCourseCategory")) %></span>
                            </div>
                            <div class="col-6">
                                <span><% response.write(Session("sCourseSubCategory")) %></span>
                            </div>
                        </div>

                        <div class="row mt-2">
                            <div class="col">
                                <div class="form-group">
                                    <label for="" class="input-heading">Course Description</label>
                                    <br>
                                    <textarea name="FormCourseDescription" id="" cols="180" rows="7"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <span></span>
                            </div>
                        </div>

                        <div class="row mt-2">
                            <div class="col">
                                <div class="form-group">
                                    <label for="" class="input-heading">Audience</label>
                                    <br>
                                    <textarea name="FormAudience" id="" cols="180" rows="5"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <span></span>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg d-flex justify-content-center">
                                <input type="submit" value="Save" class="button">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <br>
        </div>
    </div>

    <footer>
        <!--#include file=Footer.asp-->
    </footer>
</body>

</html>