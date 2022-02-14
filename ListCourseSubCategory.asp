<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->

<%
if Session("SUserRoleId") <> 2 then
call OpenDbConn()
Dim RSSubCategory
Set RSSubCategory = Server.CreateObject("ADODB.RecordSet")
QryStr = "SELECT * FROM V_SubCatgView"
RSSubCategory.Open QryStr, conn

if Request.QueryString("QsAction") = "1" then
    Dim mSubCategory
    Dim mCategory
    mSubCategory = Request.form("FormSubCategory")
    mCategory = Request.form("FormCategoryId")
    Session("sCategory") = ""
    Session("sSubCategory") = ""

    if mSubCategory = "" OR Len(mSubCategory) = 0 then
        Session("sSubCategory") = "Course Sub Category cannot be NULL"
        response.redirect("ListCourseSubCategory.asp")
    else
        Session("sSubCategory") = ""
    end if

    if cint(mCategory) = -1 then
        Session("sCategory") = "Course Sub Category cannot be NULL"
        response.redirect("ListCourseSubCategory.asp")
    else
        Session("sCategory") = ""
    end if

    QryStr = "INSERT INTO ListCourseSubCategory(SubCategory, CategoryId, UserCreatedBy, CreationDateTime)" & _
            " Values('" & mSubCategory & "', " & mCategory & "," & Session("SUserId") & ", '" & Now() & "')"
    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListCourseSubCategory.asp")
end if

if Request.QueryString("QsAction") = "3" then
    'Dim mSubCategory
    'Dim mCategory
    Dim mSubCategoryId
    mSubCategory = Request.form("FormSubCategory")
    mCategory = Request.form("FormCategoryId")
    mSubCategoryId = Request.form("FormSubCategoryId")
    Session("sCategory") = ""
    Session("sSubCategory") = ""

    if mSubCategory = "" OR Len(mSubCategory) = 0 then
        Session("sSubCategory") = "Course Sub Category cannot be NULL"
        response.redirect("ListCourseSubCategory.asp")
    else
        Session("sSubCategory") = ""
    end if

    if cint(mCategory) = -1 then
        Session("sCategory") = "Course Sub Category cannot be NULL"
        response.redirect("ListCourseSubCategory.asp")
    else
        Session("sCategory") = ""
    end if

    QryStr = "UPDATE ListCourseSubCategory SET SubCategory = '" & mSubCategory & "', CategoryId = " & mCategory & ", UserLastUpdatedBy = " & Session("SUserId") & _
    ", LastUpdatedDateTime = '" & Now() & "' WHERE(SubCategoryId = " & mSubCategoryId & ")"

    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListCourseSubCategory.asp")
end if

%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <link rel="stylesheet" href="CSS/GlobalStyle.css">
    <link rel="stylesheet" href="CSS/StyleAddCourseDir.css">
    <title>Course Sub Category</title>
</head>

<body>
    <header>
        <!--#include file=Header.asp-->
    </header>

    <div class="wrapper">
        <div class="container-fluid">

            <% 
            if request.QueryString("QsAction") = "2" then 
                Dim RSEditSubCategory
                Set RSEditSubCategory = Server.CreateObject("ADODB.RecordSet")
                RSEditSubCategory.Open "SELECT SubCategoryId, SubCategory, CategoryId FROM ListCourseSubCategory WHERE (SubCategoryId = " & Request.QueryString("QsId") & ")", conn
            %>
            <form action="ListCourseSubCategory.asp?QsAction=3" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Edit Sub Course Category</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Course Sub Category</label>
                                <input for="" class="form-control" name="FormSubCategory"
                                    value="<% response.write(RSEditSubCategory("SubCategory")) %>"></input>
                                <span><% response.write(Session("sSubCategory")) %></span>
                                <input type="hidden" name="FormSubCategoryId"
                                    value="<% response.write(RSEditSubCategory("SubCategoryId")) %>">
                            </div>
                            <div class="col-6">
                                <label for="" class="input-heading">Course Category</label>
                                <br>
                                <select name="FormCategoryId" id="" class="form-control">
                                    <option value="-1">Select Category</option>
                                    <%
                                        Dim RSCategory
                                        Set RSCategory = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSCategory.Open "SELECT CategoryId, Category FROM ListCourseCategory",Conn

                                        do while NOT RSCategory.EOF
                                            if RSEditSubCategory("CategoryId") = RSCategory("CategoryId") then
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
                                <span><% response.write(Session("sCategory")) %></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg d-flex justify-content-center">
                                <input type="submit" value="Update" class="button" style="width: 20%">
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <%
            RSEditSubCategory.close
            set RSEditSubCategory = Nothing
            %>
            <% else %>
            <form action="ListCourseSubCategory.asp?QsAction=1" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Add New Sub Course Category</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Course Sub Category</label>
                                <input for="" class="form-control" name="FormSubCategory"></input>
                                <span><% response.write(Session("sSubCategory")) %></span>
                            </div>
                            <div class="col-6">
                                <label for="" class="input-heading">Course Category</label>
                                <br>
                                <select name="FormCategoryId" id="" class="form-control">
                                    <option value="-1">Select Category</option>
                                    <%
                                        'Dim RSCategory
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
                                <span><% response.write(Session("sCategory")) %></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg d-flex justify-content-center">
                                <input type="submit" value="Add" class="button" style="width: 20%">
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <% end if %>

            <div class="panel">
                <br>
                <div class="panel-head">
                    <div class="row">
                        <div class="col">
                            <label for="">List Course Sub Category</label>
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <br>
                    <table class="table table-bordered table-hover" style="width: 60%;">
                        <thead>
                            <tr>
                                <th style="width: 3%;">Course Sub Category Id</th>
                                <th style="width: 5%;">Course Sub Category</th>
                                <th style="width: 5%;">Course Category</th>
                                <th style="width: 0.5%"></th>
                            </tr>
                        </thead>

                        <tbody>
                            <%
                                do while NOT RSSubCategory.EOF
                            %>
                            <tr>
                                <td><% response.write(RSSubCategory("SubCategoryId")) %></td>
                                <td><% response.write(RSSubCategory("SubCategory")) %></td>
                                <td><% response.write(RSSubCategory("Category")) %></td>
                                <td>
                                    <a
                                        href="ListCourseSubCategory.asp?QsAction=2&QsId=<% response.write(RSSubCategory("SubCategoryId")) %>">
                                        <img src="Images/edit.png" alt="" width="20px" height="20px">
                                    </a>
                                </td>
                            </tr>
                            <%
                                RSSubCategory.MoveNext
                                Loop

                                RSSubCategory.close
                                set RSSubCategory = Nothing
                            %>
                        </tbody>
                    </table>
                </div>
                <br>
            </div>
        </div>
    </div>

    <footer>
        <!--#include file=Footer.asp-->
    </footer>

</body>
<% 
else
response.redirect("dashboard.asp")
end if
%>

</html>