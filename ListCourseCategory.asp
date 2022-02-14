<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->

<%
if Session("SUserRoleId") <> 2 then
call OpenDbConn()
Dim RSCourseCategory
Set RSCourseCategory = Server.CreateObject("ADODB.RecordSet")
QryStr = "SELECT * FROM ListCourseCategory"
RSCourseCategory.Open QryStr, conn

if Request.QueryString("QsAction") = "1" then
    Dim mCourseCategory
    mCourseCategory = Request.form("FormCourseCategory")
    Session("sCategory") = ""

    if mCourseCategory = "" OR Len(mCourseCategory) = 0 then
        Session("sCategory") = "Course Category cannot be NULL"
        response.redirect("ListCourseCategory.asp")
    else
        Session("sCategory") = ""
    end if

    QryStr = "INSERT INTO ListCourseCategory(Category, UserCreatedBy, CreationDateTime)" & _
            " Values('" & mCourseCategory & "', " & Session("SUserId") & ", '" & Now() & "')"
    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListCourseCategory.asp")
end if

if Request.QueryString("QsAction") = "3" then
    'Dim mCourseCategory
    Dim mCourseCategoryId
    mCourseCategory = Request.form("FormCourseCategory")
    mCourseCategoryId = Request.form("FormCourseCategoryId")
    Session("sCategory") = ""

    if mCourseCategory = "" OR Len(mCourseCategory) = 0 then
        Session("sCategory") = "Course Category cannot be NULL"
        response.redirect("ListCourseCategory.asp?QsAction=2&QsId=" & mCourseCategoryId)
    else
        Session("sCategory") = ""
    end if

    QryStr = "UPDATE ListCourseCategory SET Category = '" & mCourseCategory & "', UserLastUpdatedBy = " & Session("SUserId") & _
                ", LastUpdatedDateTime = '" & Now() & "' WHERE(CategoryId = " & mCourseCategoryId & ")"

    'response.write(QryStr)
    Conn.execute QryStr
    response.redirect("ListCourseCategory.asp")
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
    <title>Course Category</title>
</head>

<body>
    <header>
        <!--#include file=Header.asp-->
    </header>

    <div class="wrapper">
        <div class="container-fluid">

            <% 
            if request.QueryString("QsAction") = "2" then 
                Dim RSEditCourseCategory
                Set RSEditCourseCategory = Server.CreateObject("ADODB.RecordSet")
                RSEditCourseCategory.Open "SELECT CategoryId, Category FROM ListCourseCategory WHERE (CategoryId = " & Request.QueryString("QsId") & ")", conn
            %>
            <form action="ListCourseCategory.asp?QsAction=3" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Edit Course Category</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Course Category</label>
                                <input for="" class="form-control" name="FormCourseCategory"
                                    value="<% response.write(RSEditCourseCategory("Category")) %>"></input>
                                <span><% response.write(Session("sCategory")) %></span>
                                <input type="hidden" name="FormCourseCategoryId"
                                    value="<% response.write(RSEditCourseCategory("CategoryId")) %>">
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
            RSEditCourseCategory.close
            set RSEditCourseCategory = Nothing
            %>
            <% else %>
            <form action="ListCourseCategory.asp?QsAction=1" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Add New Course Category</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Course Category</label>
                                <input for="" class="form-control" name="FormCourseCategory"></input>
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
                            <label for="">List Course Category</label>
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <br>
                    <table class="table table-bordered table-hover" style="width: 60%;">
                        <thead>
                            <tr>
                                <th style="width: 3%;">Course Category Id</th>
                                <th style="width: 5%;">Course Category</th>
                                <th style="width: 0.5%"></th>
                            </tr>
                        </thead>

                        <tbody>
                            <%
                                do while NOT RSCourseCategory.EOF
                            %>
                            <tr>
                                <td><% response.write(RSCourseCategory("CategoryId")) %></td>
                                <td><% response.write(RSCourseCategory("Category")) %></td>
                                <td>
                                    <a
                                        href="ListCourseCategory.asp?QsAction=2&QsId=<% response.write(RSCourseCategory("CategoryId")) %>">
                                        <img src="Images/edit.png" alt="" width="20px" height="20px">
                                    </a>
                                </td>
                            </tr>
                            <%
                                RSCourseCategory.MoveNext
                                Loop

                                RSCourseCategory.close
                                set RSCourseCategory = Nothing
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