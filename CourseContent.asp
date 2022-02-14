<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->
<!--#include file=AppSetting.asp-->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <link rel="stylesheet" href="CSS/GlobalStyle.css">
    <link rel="stylesheet" href="CSS/StyleCourseContent.css">
    <title>Course Content</title>
</head>
<%
    'OpenDb, OpenRS
        call OpenDbConn()
        Dim RSCourseContent
        Dim RSCount
        Dim CourseId
        dim mCourseCode
        dim mCourseName
        dim mCourseCategoryId
        dim mCourseSubCategoryId
        dim QryCondition

        mCourseCode = request.Form("FormCourseCode")
        mCourseName = request.Form("FormCourseName")
        mCourseCategoryId = cint(request.Form("FormCourseCategoryId"))
        mCourseSubCategoryId = cint(request.Form("FormCourseSubCategoryId"))
        QryCondition = " WHERE(1=1) "

        if mCourseCategoryId = 0 then
            mCourseCategoryId = -1
        end if

        if mCourseSubCategoryId = 0 then
            mCourseSubCategoryId = -1
        end if

        if mCourseCode <> "" then
            QryCondition = QryCondition & " AND (CourseCode like '%" & mCourseCode & "%') "
        end if

        if mCourseName <> "" then
            QryCondition = QryCondition & " AND (CourseName like '%" & mCourseName & "%') "
        end if

        if mCourseCategoryId <> -1 then
            QryCondition = QryCondition & " AND (CategoryId = " & mCourseCategoryId & ") "
        end if

        if mCourseSubCategoryId <> -1 then
            QryCondition = QryCondition & " AND (SubCategoryId = " & mCourseSubCategoryId & ") "
        end if

        Set RSCourseContent = Server.CreateObject("ADODB.RecordSet")
        Set RSCount = Server.CreateObject("ADODB.RecordSet")

        'response.End

        'Default Query with all Records - 
        QryStr = "SELECT * FROM V_CourseContentView" & QryCondition & "ORDER BY CourseId DESC"
        RSCourseContent.Open QryStr, conn
        'response.Write(QryStr)
        RSCount.Open "SELECT COUNT(CourseId) AS TotalRecords FROM CourseContent", conn
    'end

    'Paging
        Dim RecNumber
        Dim PageNumber
        Dim SkipRec
        Dim LastPage

        TotalRec = RSCount("TotalRecords")

        If Request.QueryString("QsPageNumber")="" then
            PageNumber = 1
            SkipRec=0
        else
            PageNumber = Cint(request.QueryString("QsPageNumber"))
            SkipRec = (PageNumber*RecPerPage)-RecPerPage
        End if

        If RSCount.EOF  or RSCount("TotalRecords")=1 then
            LastPage = 0
        else
            LastPage = Cstr((RSCount("TotalRecords")/RecPerPage))

            If InStr(LastPage,".") > 1 then
                LastPage = cint(LEFT(LastPage,InStr(LastPage,".")-1)) + 1
            end if
        End If
    'end
%>

<body>
    <header>
        <!--#include file=Header.asp-->
    </header>

    <main>
        <section class="action">
            <div>
                <form class="search" action="CourseContent.asp" method="POST" id="SearchForm">
                    <div>
                        <input type="search" class="search-bar" placeholder="Search By Course Code"
                            name="FormCourseCode" value="<% response.write(mCourseCode) %>">
                    </div>
                    <div>
                        <input type="search" class="search-bar" placeholder="Search By Course Name"
                            name="FormCourseName" value="<% response.write(mCourseName) %>">
                    </div>
                    <div>
                        <select name="FormCourseCategoryId" id="" class="search-bar"
                            onchange="document.getElementById('SearchForm').submit();">
                            <option value="-1">Select Category</option>
                            <%
                            Dim RSCategory
                            Set RSCategory = Server.CreateObject("ADODB.RecordSet")
                            
                            RSCategory.Open "SELECT CategoryId, Category FROM ListCourseCategory",Conn

                            do while NOT RSCategory.EOF
                                if mCourseCategoryId = RSCategory("CategoryId") then
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
                    </div>
                    <div>
                        <select name="FormCourseSubCategoryId" id="" class="search-bar"
                            onchange="document.getElementById('SearchForm').submit();">
                            <option value="-1">Select Sub Category</option>
                            <%
                            Dim RSSubCategory
                            Set RSSubCategory = Server.CreateObject("ADODB.RecordSet")
                            
                            RSSubCategory.Open "SELECT SubCategoryId, SubCategory FROM ListCourseSubCategory",Conn

                            do while NOT RSSubCategory.EOF
                                if mCourseSubCategoryId = RSSubCategory("SubCategoryId") then
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
                    </div>
                    <input type="submit" name="" id="" class="search-btn" value="Search">
                </form>
            </div>
            <% if Session("SUserRoleId") <> 2 then %>
            <div class="btn">
                <a href="CourseContentAdd.asp" class="add-new" title="Add New Course"><img src="Images/Add.svg" alt=""
                        title="Add New Course" width="26px" height="26px"> New Course</a>
            </div>
            <% end if %>
        </section>

        <section class="grid">
            <table class="table table-bordered table-hover" style="width: 70%;">
                <thead class="thead-light">
                    <tr>
                        <th style="width: 4%;" class="code">Course Code</th>
                        <th style="width: 12%;" class="name">Course Name</th>
                        <th style="width: 10%;" class="catg">Category</th>
                        <th style="width: 10%;" class="sub">Sub Category</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Dim SkipCounter
                        
                        SkipCounter=1
                        RecNumber = 0

                        do while NOT RSCourseContent.EOF

                            if SkipCounter > SkipRec then
                                CourseId = RSCourseContent("CourseId")
                    %>
                    <tr>
                        <td class="code"><a
                                href="CourseContentView.asp?QsCourseId=<% response.write(CourseId) %>"><% response.Write(RSCourseContent("CourseCode")) %></a>
                        </td>
                        <td class="name"><% response.Write(RSCourseContent("CourseName")) %></td>
                        <td class="catg"><% response.Write(RSCourseContent("Category")) %></td>
                        <td class="sub"><% response.Write(RSCourseContent("SubCategory")) %></td>
                    </tr>
                    <%
                                RecNumber = RecNumber + 1
                                        
                            End if

                            If RecPerPage = RecNumber then
                                'PageNumber = PageNumber+1
                                exit do
                            end if
                            
                            SkipCounter = SkipCounter+1
                            RSCourseContent.MoveNext
                        loop

                        RSCourseContent.close
                        set RSCourseContent = Nothing
                    %>
                </tbody>
            </table>
        </section>
    </main>

    <div class="page-bar">
        <div class="page-nav">
            <% if LastPage = 0 or PageNumber <=1 then %>
            <a href="CourseContent.asp?QsPageNumber=1" class="disabled">First</a>
            <% else %>
            <a href="CourseContent.asp?QsPageNumber=1" class="">First</a>
            <% End if %>

            <% if PageNumber > 1 then %>
            <a href="CourseContent.asp?QsPageNumber=<% response.write(PageNumber-1) %>" class="">Previous</a>
            <% else %>
            <a href="CourseContent.asp?QsPageNumber=<% response.write(PageNumber-1) %>" class="disable-btn">Previous</a>
            <% End if %>

            <% if LastPage > PageNumber then %>
            <a href="CourseContent.asp?QsPageNumber=<% response.write(PageNumber+1) %>" class="">Next</a>
            <% else %>
            <a href="CourseContent.asp?QsPageNumber=<% response.write(PageNumber+1) %>" class="disabled">Next</a>
            <% end if %>

            <% if LastPage > PageNumber then %>
            <a href="CourseContent.asp?QsPageNumber=<% response.write(LastPage) %>" class="">Last</a>
            <% else %>
            <a href="CourseContent.asp?QsPageNumber=<% response.write(LastPage) %>" class="disabled">Last</a>
            <% End if %>
        </div>
    </div>

    <footer>
        <!--#include file=Footer.asp-->
    </footer>
</body>

</html>