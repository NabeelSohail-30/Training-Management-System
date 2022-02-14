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
    <link rel="stylesheet" href="CSS/StyleCourseDirectory.css">
    <title>Course Directory</title>
</head>
<%
    'OpenDb, OpenRS
        call OpenDbConn()
        Dim RSCourseDirectory
        Dim RSCount
        dim mCourseCode
        dim mCourseName
        dim mStartDate
        dim mEndDate
        dim mCourseCategoryId
        dim mCourseSubCategoryId
        dim QryCondition
        'dim FormattedEndDate

        mCourseCode = request.Form("FormCourseCode")
        mCourseName = request.Form("FormCourseName")
        mStartDate = request.Form("FormStartDate")
        mEndDate = request.Form("FormEndDate")
        mCourseCategoryId = cint(request.Form("FormCourseCategoryId"))
        mCourseSubCategoryId = cint(request.Form("FormCourseSubCategoryId"))
        QryCondition = " WHERE(1=1) "
        'FormattedEndDate = year(cdate(mEndDate)) & "-" & month(cdate(mEndDate)) & "-" & day(cdate(mEndDate))

        'response.write(mStartDate)
        'response.write("<br>" & cdate(mEndDate))
        'response.write("<br>" & FormattedEndDate)
        

        if mCourseCode <> "" then
            QryCondition = QryCondition & " AND (CourseCode like '%" & mCourseCode & "%') "
        end if

        if mCourseName <> "" then
            QryCondition = QryCondition & " AND (CourseName like '%" & mCourseName & "%') "
        end if

        if mStartDate <> "" AND mEndDate <> "" then
            QryCondition = QryCondition & " AND (StartDate >= '" & mStartDate & "') "
            QryCondition = QryCondition & " AND (StartDate <= '" & mEndDate & "') "
        end if

        if mStartDate <> "" AND mEndDate = "" then
            QryCondition = QryCondition & " AND (StartDate >= '" & mStartDate & "') "
        end if

        if mEndDate <> "" AND mStartDate = "" then
            QryCondition = QryCondition & " AND (EndDate <= '" & mEndDate & "') "
        end if

        if mCourseCategoryId > 0 then
            QryCondition = QryCondition & " AND (CategoryId = " & mCourseCategoryId & ") "
        end if

        if mCourseSubCategoryId > 0 then
            QryCondition = QryCondition & " AND (SubCategoryId = " & mCourseSubCategoryId & ") "
        end if

        Set RSCourseDirectory = Server.CreateObject("ADODB.RecordSet")
        Set RSCount = Server.CreateObject("ADODB.RecordSet")

        QryStr = "SELECT * FROM V_CourseDirectoryView" & QryCondition & "ORDER BY CourseDirectoryId DESC"
        RSCourseDirectory.Open QryStr, conn
        'response.Write(QryStr)
        'response.End
        RSCount.Open "SELECT COUNT(CourseDirectoryId) AS TotalRecords FROM CourseDirectory", conn
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
                <form class="search" action="CourseDirectory.asp" method="POST" id="SearchForm">
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
                    <div>
                        <input type="date" class="search-bar" placeholder="Search By Start Date" name="FormStartDate"
                            value="<% response.write(mStartDate) %>">
                    </div>
                    <div>
                        <input type="date" class="search-bar" placeholder="Search By End Date" name="FormEndDate"
                            value="<% response.write(mEndDate) %>">
                    </div>
                    <input type="submit" name="" id="" class="search-btn" value="Search">
                </form>
            </div>
            <% if Session("SUserRoleId") <> 2 then %>
            <div class="btn">
                <a href="CourseDirectoryAdd.asp" class="add-new" title="Add New Course Directory"><img
                        src="Images/Add.svg" alt="" title="Add New Course Directory" width="26px" height="26px"> New
                    Course Directory</a>
            </div>
            <% end if %>
        </section>

        <section class="grid">
            <table class="table table-bordered table-hover" style="width: 97%;">
                <thead class="thead-light">
                    <tr>
                        <th style="width: 3%;" class="code">Course Code</th>
                        <th style="width: 15%;" class="name">Course Name</th>
                        <th style="width: 4%;" class="startdate">Start Date</th>
                        <th style="width: 4%;" class="enddate">End Date</th>
                        <th style="width: 3%;" class="duration">Course Duration</th>
                        <th style="width: 7%;" class="time">Time Slot</th>
                        <th style="width: 4%;" class="closing">Enrollment Closing Date</th>
                        <th style="width: 5%;" class="fee">Course Fee</th>
                        <th style="width: 5%;" class="status">Course Directory Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Dim SkipCounter
                        
                        SkipCounter=1
                        RecNumber = 0

                        do while NOT RSCourseDirectory.EOF

                            if SkipCounter > SkipRec then
                                CourseId = RSCourseDirectory("CourseId")
                    %>
                    <tr>
                        <td><a
                                href="CourseDirectoryView.asp?QsId=<% response.Write(RSCourseDirectory("CourseDirectoryId")) %>"><% response.Write(RSCourseDirectory("CourseCode")) %></a>
                        </td>
                        <td><% response.Write(RSCourseDirectory("CourseName")) %></td>
                        <td><% response.Write(RSCourseDirectory("StartDate")) %></td>
                        <td><% response.Write(RSCourseDirectory("EndDate")) %></td>
                        <td><% response.Write(RSCourseDirectory("CourseDuration")) %></td>
                        <td><% response.Write(FormatDateTime(RSCourseDirectory("StartTime"),3)& " - " & FormatDateTime(RSCourseDirectory("EndTime"),3)) %>
                        </td>
                        <td><% response.Write(RSCourseDirectory("EnrollmentClosingDate")) %></td>
                        <td><% response.Write(RSCourseDirectory("CourseFee") & " PKR") %></td>
                        <td><% response.Write(RSCourseDirectory("CourseDirectoryStatus")) %></td>
                    </tr>
                    <%
                                RecNumber = RecNumber + 1
                                        
                            End if

                            If RecPerPage = RecNumber then
                                'PageNumber = PageNumber+1
                                exit do
                            end if
                            
                            SkipCounter = SkipCounter+1
                            RSCourseDirectory.MoveNext
                        loop

                        RSCourseDirectory.close
                        set RSCourseDirectory = Nothing
                    %>
                </tbody>
            </table>
        </section>
    </main>

    <div class="page-bar">
        <div class="page-nav">
            <% if LastPage = 0 or PageNumber <=1 then %>
            <a href="CourseDirectory.asp?QsPageNumber=1" class="disabled">First</a>
            <% else %>
            <a href="CourseDirectory.asp?QsPageNumber=1" class="">First</a>
            <% End if %>

            <% if PageNumber > 1 then %>
            <a href="CourseDirectory.asp?QsPageNumber=<% response.write(PageNumber-1) %>" class="">Previous</a>
            <% else %>
            <a href="CourseDirectory.asp?QsPageNumber=<% response.write(PageNumber-1) %>"
                class="disable-btn">Previous</a>
            <% End if %>

            <% if LastPage > PageNumber then %>
            <a href="CourseDirectory.asp?QsPageNumber=<% response.write(PageNumber+1) %>" class="">Next</a>
            <% else %>
            <a href="CourseDirectory.asp?QsPageNumber=<% response.write(PageNumber+1) %>" class="disabled">Next</a>
            <% end if %>

            <% if LastPage > PageNumber then %>
            <a href="CourseDirectory.asp?QsPageNumber=<% response.write(LastPage) %>" class="">Last</a>
            <% else %>
            <a href="CourseDirectory.asp?QsPageNumber=<% response.write(LastPage) %>" class="disabled">Last</a>
            <% End if %>
        </div>
    </div>

    <footer>
        <!--#include file=Footer.asp-->
    </footer>
</body>

</html>