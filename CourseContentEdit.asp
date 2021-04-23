<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->
<%

    Dim CourseId
    Dim IsError

    CourseId = request.QueryString("QsCourseId")
    IsError = request.QueryString("QsIsError")

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
    <title>Edit Course Content</title>
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
                            <a class="nav-link"
                                href="CourseContentView.asp?QsCourseId=<% response.write(CourseId) %>">View Course
                                Content</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active"
                                href="CourseContentEdit.asp?QsCourseId=<% response.write(CourseId) %>">Edit
                                Course Content</a>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="panel">
                <br>
                <div class="panel-head">
                    <div class="row">
                        <div class="col">
                            <label for="">Edit Course Content</label>
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <form action="CourseContentUpdate.asp" method="POST">
                        <div class="row mt-2">
                            <div class="col">
                                <div class="form-group">
                                    <input type="hidden" name="FormCourseId"
                                        value="<% response.Write(RSCourseContent("CourseId")) %>">
                                    <label for="" class="input-heading">Course Code</label>
                                    <% if IsError = "1" then %>
                                    <input type="text" class="form-control" name="FormCourseCode"
                                        value="<% response.Write(Session("smCourseCode")) %>">
                                    <% else %>
                                    <input type="text" class="form-control" name="FormCourseCode"
                                        value="<% response.Write(RSCourseContent("CourseCode")) %>">
                                    <% end if %>
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
                                    <% if IsError = "1" then %>
                                    <input type="text" class="form-control" name="FormCourseName"
                                        value="<% response.Write(Session("smCourseName")) %>">
                                    <% else %>
                                    <input type="text" class="form-control" name="FormCourseName"
                                        value="<% response.Write(RSCourseContent("CourseName")) %>">
                                    <% end if %>
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
                                    <% if IsError = "1" then %>
                                    <select name="FormCourseCategoryId" id="" class="form-control">
                                        <option value="-1">Select Category</option>
                                        <%
                                        Dim RSCategory
                                        Set RSCategory = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSCategory.Open "SELECT CategoryId, Category FROM ListCourseCategory",Conn
    
                                        do while NOT RSCategory.EOF
                                            if RSCategory("CategoryId") = Session("smCourseCategory") then
                                        %>
                                        <option value="<% response.write(RSCategory("CategoryId")) %>" selected>
                                            <% response.write(RSCategory("Category")) %></option>
                                        <% else %>
                                        <option value="<% response.write(RSCategory("CategoryId")) %>">
                                            <% response.write(RSCategory("Category")) %></option>
                                        <%
                                            end if
                                        RSCategory.MoveNext
                                        Loop
                
                                        RSCategory.Close
                                        Set RSNationality = Nothing
                                        %>
                                    </select>
                                    <% else %>
                                    <select name="FormCourseCategoryId" id="" class="form-control">
                                        <option value="-1">Select Category</option>
                                        <%
                                        'Dim RSCategory
                                        Set RSCategory = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSCategory.Open "SELECT CategoryId, Category FROM ListCourseCategory",Conn
    
                                        do while NOT RSCategory.EOF
                                            if RSCategory("CategoryId") = RSCourseContent("CategoryId") then
                                        %>
                                        <option value="<% response.write(RSCategory("CategoryId")) %>" selected>
                                            <% response.write(RSCategory("Category")) %></option>
                                        <% else %>
                                        <option value="<% response.write(RSCategory("CategoryId")) %>">
                                            <% response.write(RSCategory("Category")) %></option>
                                        <%
                                            end if
                                        RSCategory.MoveNext
                                        Loop
                
                                        RSCategory.Close
                                        Set RSNationality = Nothing
                                        %>
                                    </select>
                                    <% end if %>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Select Sub Category</label>
                                    <% if IsError = "1" then %>
                                    <select name="FormCourseSubCategoryId" id="" class="form-control">
                                        <option value="-1">Select Sub Category</option>
                                        <%
                                        'Dim RSSubCategory
                                        Set RSSubCategory = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSSubCategory.Open "SELECT SubCategoryId, SubCategory FROM ListCourseSubCategory",Conn
    
                                        do while NOT RSSubCategory.EOF
                                            if RSSubCategory("SubCategoryId") = Session("smCourseSubCategory") then
                                    %>
                                        <option value="<% response.write(RSSubCategory("SubCategoryId")) %>" selected>
                                            <% response.write(RSSubCategory("SubCategory")) %></option>
                                        <% else %>
                                        <option value="<% response.write(RSSubCategory("SubCategoryId")) %>">
                                            <% response.write(RSSubCategory("SubCategory")) %></option>
                                        <%
                                            end if
                                        RSSubCategory.MoveNext
                                        Loop
                
                                        RSSubCategory.Close
                                        Set RSNationality = Nothing
                                    %>
                                    </select>
                                    <% else %>
                                    <select name="FormCourseSubCategoryId" id="" class="form-control">
                                        <option value="-1">Select Sub Category</option>
                                        <%
                                        Dim RSSubCategory
                                        Set RSSubCategory = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSSubCategory.Open "SELECT SubCategoryId, SubCategory FROM ListCourseSubCategory",Conn
    
                                        do while NOT RSSubCategory.EOF
                                            if RSSubCategory("SubCategoryId") = RSCourseContent("SubCategoryId") then
                                    %>
                                        <option value="<% response.write(RSSubCategory("SubCategoryId")) %>" selected>
                                            <% response.write(RSSubCategory("SubCategory")) %></option>
                                        <% else %>
                                        <option value="<% response.write(RSSubCategory("SubCategoryId")) %>">
                                            <% response.write(RSSubCategory("SubCategory")) %></option>
                                        <%
                                            end if
                                        RSSubCategory.MoveNext
                                        Loop
                
                                        RSSubCategory.Close
                                        Set RSNationality = Nothing
                                    %>
                                    </select>
                                    <% end if %>

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
                                    <% if IsError = "1" then %>
                                    <textarea name="FormCourseDescription" id="" cols="180"
                                        rows="7"><% response.Write(Session("smCourseDescription")) %></textarea>
                                    <% else %>
                                    <textarea name="FormCourseDescription" id="" cols="180"
                                        rows="7"><% response.Write(RSCourseContent("CourseDescription")) %></textarea>
                                    <% end if %>

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
                                    <% if IsError = "1" then %>
                                    <textarea name="FormAudience" id="" cols="180"
                                        rows="5"><% response.Write(Session("smAudience")) %></textarea>
                                    <% else %>
                                    <textarea name="FormAudience" id="" cols="180"
                                        rows="5"><% response.Write(RSCourseContent("Audience")) %></textarea>
                                    <% end if %>

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
                                <input type="submit" value="Update" class="button">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <footer>
        <!--#include file=Footer.asp-->
    </footer>
</body>

</html>