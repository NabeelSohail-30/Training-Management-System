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
    'OpenDb, OpenRS
        call OpenDbConn()
        Dim RSStdDetail
        Dim RSCount
        Dim StdId

        Set RSStdDetail = Server.CreateObject("ADODB.RecordSet")
        Set RSCount = Server.CreateObject("ADODB.RecordSet")

        RSStdDetail.Open "SELECT StudentId, StdGrNumber, StdFirstName, StdLastName, StdNICNumber, FatherName, StdMobileNumber, StdEmailAddress FROM StudentDetail ORDER BY StudentId DESC", conn
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
                        <th style="width: 5%;" class="gr">GR Number</th>
                        <th style="width: 10%;" class="first">First Name</th>
                        <th style="width: 10%;" class="last">Last Name</th>
                        <th style="width: 10%;" class="nic">NIC Number</th>
                        <th style="width: 10%;" class="father">Father Name</th>
                        <th style="width: 10%;" class="phone">Phone Number</th>
                        <th style="width: 15%;" class="email">Email Address</th>
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
                        <td class="gr"><a
                                href="ViewStudentDetail.asp?QsStdId=<% response.Write(StdId) %>"><% response.Write(RSStdDetail("StdGrNumber")) %></a>
                        </td>
                        <td class="first"><% response.Write(RSStdDetail("StdFirstName")) %></td>
                        <td class="last"><% response.Write(RSStdDetail("StdLastName")) %></td>
                        <td class="nic"><% response.Write(RSStdDetail("StdNICNumber")) %></td>
                        <td class="father"><% response.Write(RSStdDetail("FatherName")) %></td>
                        <td class="phone"><% response.Write(RSStdDetail("StdMobileNumber")) %></td>
                        <td class="email"><% response.Write(RSStdDetail("StdEmailAddress")) %></td>
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