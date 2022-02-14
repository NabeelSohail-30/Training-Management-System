<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->
<!--#include file=AppSetting.asp-->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <link rel="stylesheet" href="CSS/GlobalStyle.css">
    <link rel="stylesheet" href="css/StyleStdProfile.css">
    <title>Students Detail</title>
</head>

<%
    'Variables Declaration
        Dim mGrNumber
        Dim mFirstName
        Dim mLastName
        Dim mFatherName
        Dim mStdNic
        Dim mStdMobile
        Dim QryCondition
    'end

    'Variables Initialization
        mGrNumber = request.form("FormGrNumber")
        mFirstName = request.form("FormFirstName")
        mLastName = request.form("FormLastName")
        mFatherName = request.form("FormFatherName")
        mStdNic = request.form("FormStdNIC")
        mStdMobile = request.form("FormStdMobile")
        QryCondition = " WHERE(1=1) "
    'end

    'Building QryCondition
        if mGrNumber <> "" then
            QryCondition = QryCondition & " AND (StdGrNumber like '%" & mGrNumber & "%')"
        end if

        if mFirstName <> "" then
            QryCondition = QryCondition & " AND (StdFirstName like '%" & mFirstName & "%')"
        end if

        if mLastName <> "" then
            QryCondition = QryCondition & " AND (StdLastName like '%" & mLastName & "%')"
        end if

        if mFatherName <> "" then
            QryCondition = QryCondition & " AND (FatherName like '%" & mFatherName & "%')"
        end if

        if mStdNic <> "" then
            QryCondition = QryCondition & " AND (StdNICNumber like '%" & mStdNic & "%')"
        end if

        if mStdMobile <> "" then
            QryCondition = QryCondition & " AND (StdMobileNumber like '%" & mStdMobile & "%')"
        end if
    'end

    'OpenDb, OpenRS
        call OpenDbConn()
        Dim RSStdDetail
        Dim RSCount
        Dim StdId

        Set RSStdDetail = Server.CreateObject("ADODB.RecordSet")
        Set RSCount = Server.CreateObject("ADODB.RecordSet")

        RSStdDetail.Open "SELECT * FROM StudentDetail" & QryCondition & "ORDER BY StudentId DESC", conn
        RSCount.Open "SELECT COUNT(StudentId) AS TotalRecords FROM StudentDetail", conn
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
                <form class="search" action="StudentProfile.asp" METHOD="POST">
                    <div>
                        <input type="search" class="search-bar" placeholder="Search By GR Number" name="FormGrNumber"
                            value="<% response.write(mGrNumber) %>">
                    </div>
                    <div>
                        <input type="search" class="search-bar" placeholder="Search By First Name" name="FormFirstName"
                            value="<% response.write(mFirstName) %>">
                    </div>
                    <div>
                        <input type="search" class="search-bar" placeholder="Search By Last Name" name="FormLastName"
                            value="<% response.write(mLastName) %>">
                    </div>
                    <div>
                        <input type="search" class="search-bar" placeholder="Search By Father Name"
                            name="FormFatherName" value="<% response.write(mFatherName) %>">
                    </div>
                    <div>
                        <input type="search" class="search-bar" placeholder="Search By NIC" name="FormStdNIC"
                            value="<% response.write(mStdNic) %>">
                    </div>
                    <div>
                        <input type="search" class="search-bar" placeholder="Search By Mobile" name="FormStdMobile"
                            value="<% response.write(mStdMobile) %>">
                    </div>
                    <input type="submit" name="" id="" class="search-btn" value="Search">
                </form>
            </div>
            <% if Session("SUserRoleId") <> 2 then %>
            <div class="btn">
                <a href="AddNewStdProfile.asp" class="add-new" title="Add New Student Profile"><img src="Images/Add.svg"
                        alt="" title="Add New Student Profile" width="26px" height="26px"> New Student</a>
            </div>
            <% end if %>
        </section>

        <section class="grid">
            <table class="table table-bordered table-hover" style="width: 85%;">
                <thead class="thead-light">
                    <tr>
                        <th style="width: 5%;" class="gr">GR Number</th>
                        <th style="width: 10%;" class="first">First Name</th>
                        <th style="width: 10%;" class="last">Last Name</th>
                        <th style="width: 10%;" class="nic">NIC Number</th>
                        <th style="width: 10%;" class="phone">Phone Number</th>
                        <th style="width: 15%;" class="email">Email Address</th>
                        <th style="width: 10%;" class="father">Father Name</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                            Dim SkipCounter
                            
                            SkipCounter=1
                            RecNumber = 0
    
                            do while RSStdDetail.EOF=false
    
                                if SkipCounter > SkipRec then
                                StdId = RSStdDetail("StudentId")
                        %>
                    <tr>
                        <td class="gr">
                            <a href="ViewStudentDetail.asp?QsStdId=<% response.Write(StdId) %>"><% response.Write(RSStdDetail("StdGrNumber")) %>
                            </a>
                        </td>
                        <td class="first"><% response.Write(RSStdDetail("StdFirstName")) %></td>
                        <td class="last"><% response.Write(RSStdDetail("StdLastName")) %></td>
                        <td class="nic"><% response.Write(RSStdDetail("StdNICNumber")) %></td>
                        <td class="phone"><% response.Write(RSStdDetail("StdMobileNumber")) %></td>
                        <td class="email"><% response.Write(RSStdDetail("StdEmailAddress")) %></td>
                        <td class="father"><% response.Write(RSStdDetail("FatherName")) %></td>
                    </tr>
                    <%
                                    RecNumber = RecNumber + 1
                                            
                                End if
    
                                If RecPerPage = RecNumber then
                                    'PageNumber = PageNumber+1
                                    exit do
                                end if
                                
                                SkipCounter = SkipCounter+1
                                RSStdDetail.MoveNext
                            loop     
                        %>
                </tbody>
            </table>
        </section>

        <div class="page-bar">
            <div class="page-nav">
                <% if LastPage = 0 or PageNumber <=1 then %>
                <a href="StudentProfile.asp?QsPageNumber=1" class="disabled">First</a>
                <% else %>
                <a href="StudentProfile.asp?QsPageNumber=1" class="">First</a>
                <% End if %>

                <% if PageNumber > 1 then %>
                <a href="StudentProfile.asp?QsPageNumber=<% response.write(PageNumber-1) %>" class="">Previous</a>
                <% else %>
                <a href="StudentProfile.asp?QsPageNumber=<% response.write(PageNumber-1) %>"
                    class="disable-btn">Previous</a>
                <% End if %>

                <% if LastPage > PageNumber then %>
                <a href="StudentProfile.asp?QsPageNumber=<% response.write(PageNumber+1) %>" class="">Next</a>
                <% else %>
                <a href="StudentProfile.asp?QsPageNumber=<% response.write(PageNumber+1) %>" class="disabled">Next</a>
                <% end if %>

                <% if LastPage > PageNumber then %>
                <a href="StudentProfile.asp?QsPageNumber=<% response.write(LastPage) %>" class="">Last</a>
                <% else %>
                <a href="StudentProfile.asp?QsPageNumber=<% response.write(LastPage) %>" class="disabled">Last</a>
                <% End if %>
            </div>
        </div>
    </main>

    <footer>
        <!--#include file=Footer.asp-->
    </footer>
</body>

</html>