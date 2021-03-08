<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->
<!--#include file=AppSetting.asp-->
<%
    Dim StdId

    StdId = request.QueryString("QsStdId")

    'Variable Declaration
        Dim mStudentId
        Dim mStartDate
        Dim mEndDate
        Dim mCompanyName
        Dim mJobId
        Dim mUserCreatedBy
        Dim mWorkExpId
        Dim mLastUpdatedDateTime
        'Dim ErrorFound
        Dim RSJob
    'end

    if request.QueryString("Action")="1" then   'Action:1 = Add
        call InsertWorkExp()
    elseif request.QueryString("Action")="2" AND request.QueryString("EditForm")="true" then    'Action:2, EditForm:True = Fill Edit
        Dim RSWork
        Set RSWork = Server.CreateObject("ADODB.RecordSet")
        RSWork.Open "SELECT * FROM StudentWorkExperience WHERE (WorkExperienceId=" & Request.QueryString("QsWorkExperienceId") & ")", conn
    elseif request.QueryString("Action")="2" then   'Action:2 = Update
        'Session Variables
            Session("ErrorJobDesignation") = ""
            Session("ErrorCompany") = ""
            Session("ErrorStartDate") = ""
            Session("ErrorEndDate") = ""
        'End
        call UpdateWorkExp()
    elseif request.QueryString("Action")="3" then
        call DelWorkExp()
    end if
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <link rel="stylesheet" href="CSS/GlobalStyle.css">
    <link rel="stylesheet" href="CSS/StyleWorkExp.css">
    <title>Work Experience</title>
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
                            <a class="nav-link" href="ViewStudentDetail.asp?QsStdId=<% response.Write(StdId) %>">View
                                Student Detail</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="EditStudentDetail.asp?QsStdId=<% response.Write(StdId) %>">Edit
                                Student Detail</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link"
                                href="AcademicQualification.asp?QsStdId=<% response.Write(StdId) %>">Academic
                                Qualification</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link"
                                href="TechnicalQualification.asp?QsStdId=<% response.Write(StdId) %>">Technical
                                Qualification</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active"
                                href="WorkExperience.asp?QsStdId=<% response.Write(StdId) %>">Work Experience</a>
                        </li>
                    </ul>
                </div>
            </div>

            <br>

            <!--#include file="PanelStdDetail.asp"-->

            <br>

            <% if request.QueryString("Action")="2" AND request.QueryString("EditForm")="true" then %>
            <div class="panel">
                <div class="panel-head">
                    <div class="row">
                        <div class="col">
                            Update Work Experience
                        </div>
                    </div>
                </div>

                <br>

                <div class="panel-body">
                    <form action="WorkExperience.asp?QsStdId=<% response.write(StdId) %>&Action=2" method="POST">
                        <div class="row">
                            <div class="col-6">
                                <div class="form-group">
                                    <input type="hidden" name="FormWorkExperienceId"
                                        value="<% response.write(RSWork("WorkExperienceId")) %>">
                                    <label for="" class="input-heading">Start Date</label>
                                    <br>
                                    <input type="date" class="form-control" id="StDate" name="FormStartDate"
                                        onblur="ValidateDate(this,document.getElementById('ErrorStartDate'));"
                                        value="<% response.write(RSWork("StartDate")) %>">
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">End Date</label>
                                    <br>
                                    <input type="date" class="form-control" id="EndDate" name="FormEndDate"
                                        onblur="ValidateDate(this,document.getElementById('ErrorEndDate'));"
                                        value="<% response.write(RSWork("EndDate")) %>">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-6">
                                <span id="ErrorStartDate"><% response.Write(Session("ErrorStartDate")) %></span>
                            </div>
                            <div class="col-6">
                                <span id="ErrorEndDate"><% response.Write(Session("ErrorEndDate")) %></span>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Company Name</label>
                                    <br>
                                    <input type="text" class="form-control" id="Institue" name="FormCompanyName"
                                        onblur="StringValidate(this,document.getElementById('ErrorCompany'),100);"
                                        value="<% response.write(RSWork("CompanyName")) %>">
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Job Designation</label>
                                    <br>
                                    <select name="FormJobDesignationId" class="form-control" id="job"
                                        onblur="DropDownValidate(this,document.getElementById('ErrorMajor'));">
                                        <option value="-1">Select Job Designation</option>
                                        <%
                                                Set RSJob = Server.CreateObject("ADODB.RecordSet")
                                                
                                                RSJob.Open "SELECT JobDesignationId, JobDesignation FROM ListJobDesignation",Conn
            
                                                do while NOT RSJob.EOF
                                                    if RSWork("JobDesignationId") = RSJob("JobDesignationId") then
                                        %>
                                        <option value="<% response.write(RSJob("JobDesignationId")) %>" selected>
                                            <% response.write(RSJob("JobDesignation")) %></option>
                                        <% else %>
                                        <option value="<% response.write(RSJob("JobDesignationId")) %>">
                                            <% response.write(RSJob("JobDesignation")) %></option>
                                        <%
                                                    end if
                                                RSJob.MoveNext
                                                Loop
                        
                                                RSJob.Close
                                                Set RSJob = Nothing
                                            %>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-6">
                                <span id="ErrorCompany"><% response.Write(Session("ErrorCompany")) %></span>
                            </div>
                            <div class="col-6">
                                <span
                                    id="ErrorJobDesignation"><% response.Write(Session("ErrorJobDesignation")) %></span>
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
            <% else %>
            <div class="panel">
                <div class="panel-head">
                    <div class="row">
                        <div class="col">
                            Add Work Experience
                        </div>
                    </div>
                </div>

                <br>

                <div class="panel-body">
                    <form action="WorkExperience.asp?QsStdId=<% response.write(StdId) %>&Action=1" method="POST">
                        <div class="row">
                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Start Date</label>
                                    <br>
                                    <input type="date" class="form-control" id="StDate" name="FormStartDate"
                                        onblur="ValidateDate(this,document.getElementById('ErrorStartDate'));">
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">End Date</label>
                                    <br>
                                    <input type="date" class="form-control" id="EndDate" name="FormEndDate"
                                        onblur="ValidateDate(this,document.getElementById('ErrorEndDate'));">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-6">
                                <span id="ErrorStartDate"><% response.Write(Session("ErrorStartDate")) %></span>
                            </div>
                            <div class="col-6">
                                <span id="ErrorEndDate"><% response.Write(Session("ErrorEndDate")) %></span>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Company Name</label>
                                    <br>
                                    <input type="text" class="form-control" id="Institue" name="FormCompanyName"
                                        onblur="StringValidate(this,document.getElementById('ErrorCompany'),100);">
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Job Designation</label>
                                    <br>
                                    <select name="FormJobDesignationId" class="form-control" id="job"
                                        onblur="DropDownValidate(this,document.getElementById('ErrorMajor'));">
                                        <option value="-1">Select Job Designation</option>
                                        <%
                                                Set RSJob = Server.CreateObject("ADODB.RecordSet")
                                                
                                                RSJob.Open "SELECT JobDesignationId, JobDesignation FROM ListJobDesignation",Conn
            
                                                do while NOT RSJob.EOF
                                            %>
                                        <option value="<% response.write(RSJob("JobDesignationId")) %>">
                                            <% response.write(RSJob("JobDesignation")) %></option>
                                        <%
                                                RSJob.MoveNext
                                                Loop
                        
                                                RSJob.Close
                                                Set RSJob = Nothing
                                            %>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-6">
                                <span id="ErrorCompany"><% response.Write(Session("ErrorCompany")) %></span>
                            </div>
                            <div class="col-6">
                                <span
                                    id="ErrorJobDesignation"><% response.Write(Session("ErrorJobDesignation")) %></span>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg d-flex justify-content-center">
                                <input type="submit" value="Add" class="button">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <% end if %>

            <%
                Dim RSWorkExperience
                Set RSWorkExperience = Server.CreateObject("ADODB.RecordSet")

                RSWorkExperience.Open "SELECT * FROM V_StdWorkExpView WHERE(StudentId =" & StdId & ")", conn
            %>

            <div class="panel">
                <div class="panel-head">
                    <div class="row">
                        <div class="col">
                            Student's Work Experience
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <table class="table table-bordered table-hover">
                        <thead class="thead-light">
                            <tr>
                                <th style="width: 1%;"></th>
                                <th style="width: 1%;"></th>
                                <th style="width: 6%;" class="start">Start Date</th>
                                <th style="width: 6%;" class="end">End Date</th>
                                <th style="width: 15%;" class="comp">Company Name</th>
                                <th style="width: 15%;" class="job">Job Designation</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% do while NOT RSWorkExperience.EOF %>
                            <tr>
                                <td><a
                                        href="WorkExperience.asp?QsStdId=<% response.write(StdId) %>&Action=2&EditForm=true&QsWorkExperienceId=<% response.write(RSWorkExperience("WorkExperienceId")) %>"><img
                                            src="Images/edit.png" alt="" width="20px" height="20px"></a></td>
                                <td><a
                                        href="WorkExperience.asp?QsStdId=<% response.write(StdId) %>&Action=3&QsWorkExperienceId=<% response.write(RSWorkExperience("WorkExperienceId")) %>"><img
                                            src="Images/delete.png" alt="" width="20px" height="20px"></a></td>
                                <td class="start"><% response.write(RSWorkExperience("StartDate")) %></td>
                                <td class="end"><% response.write(RSWorkExperience("EndDate")) %></td>
                                <td class="comp"><% response.write(RSWorkExperience("CompanyName")) %></td>
                                <td class="job"><% response.write(RSWorkExperience("JobDesignation")) %></td>
                            </tr>
                            <% 
                                RSWorkExperience.MoveNext
                            loop

                                RSWorkExperience.Close
                                set RSWorkExperience = Nothing
                            %>
                        </tbody>
                    </table>
                </div>
            </div>

            <br>

        </div>
    </div>

    <footer>
        <!--#include file=Footer.asp-->
    </footer>
</body>
<script src="Scripts/Global.js"></script>

</html>
<%

'Insert Record
    sub InsertWorkExp()

        'Variable Initialization
            mStudentId = StdId
            mStartDate = request.form("FormStartDate")
            mEndDate = request.form("FormEndDate")
            mCompanyName = request.form("FormCompanyName")
            mJobDesignationId = cint(request.form("FormJobDesignationId"))
            mUserCreatedBy = Session("SUserId")
        'end
    
        'Validations
            Session("ErrorJobDesignation") = ValidateJobDesignation()
            Session("ErrorCompany") = ValidateCompany()
            Session("ErrorStartDate") = ValidateDate(mStartDate)
            Session("ErrorEndDate") = ValidateDate(mEndDate)

            if ErrorFound=true then
                response.Redirect("WorkExperience.asp?QsStdId=" & StdId)
            end if
        'end

        'Check Duplicate
            
        'end

        'Insert Record
            QryStr = "INSERT INTO StudentWorkExperience (StudentId, StartDate, EndDate, CompanyName, JobDesignationId, UserCreatedBy) " & _
                    "Values(" & mStudentId & ", '" & mStartDate & "', '" & mEndDate & "', '" & mCompanyName & "', " & mJobDesignationId & ", " & mUserCreatedBy & ")"
            
            'response.write QryStr
            conn.execute QryStr
        'end
    end sub
'End

'Update Record
    sub UpdateWorkExp()
        'Variable Initialization
            mWorkExperienceId = cint(request.form("FormWorkExperienceId"))
            mStartDate = request.form("FormStartDate")
            mEndDate = request.form("FormEndDate")
            mCompanyName = request.form("FormCompanyName")
            mJobDesignationId = cint(request.form("FormJobDesignationId"))
            mUserLastUpdatedBy = Session("SUserId")
            mLastUpdatedDateTime = Now()
        'end

        'Validations
            Session("ErrorJobDesignation") = ValidateJobDesignation()
            Session("ErrorCompany") = ValidateCompany()
            Session("ErrorStartDate") = ValidateDate(mStartDate)
            Session("ErrorEndDate") = ValidateDate(mEndDate)

            if ErrorFound=true then
                response.Redirect("WorkExperience.asp?QsStdId=" & StdId & "&Action=2&EditForm=true&QsWorkExperienceId=" & mWorkExperienceId)
            end if
        'end

        'Check Duplicate
            
        'end

        'Update Record
            QryStr = "UPDATE StudentWorkExperience " & _
                     "SET StartDate = '" & mStartDate & "', EndDate = '" & mEndDate & "', CompanyName = '" & mCompanyName & "', JobDesignationId = " & mJobDesignationId & _
                     ", UserLastUpdatedBy = " &  mUserLastUpdatedBy & ", LastUpdatedDateTime = '" & mLastUpdatedDateTime & "'" & _
                    " WHERE (WorkExperienceId=" & mWorkExperienceId & ")"
            
            'response.write QryStr
            conn.execute QryStr
        'end
    end sub  
'end

'Delete Record
    sub DelWorkExp()

        'Variable Initialization
            mWorkExperienceId = cint(request.QueryString("QsWorkExperienceId"))
        'end

        'Del Record
            QryStr = "DELETE FROM StudentWorkExperience WHERE(WorkExperienceId=" & mWorkExperienceId & ")"
            
            'response.write QryStr
            conn.execute QryStr
        'end
    end sub
'end

'Validation Functions
    'ValidateDate
        Function ValidateDate(Target)

            if Target = "" OR IsNull(Target) = true then
                ValidateDate = "Field cannot be NULL"
                ErrorFound = true
            end if
        End Function
    'End

    'ValidateCompany
        Function ValidateCompany()
        
            if mCompanyName = "" OR IsNull(mCompanyName) = true then
                ValidateCompany = "Company Name cannot be NULL"
                ErrorFound = true
            elseif len(mCompanyName) > 100 then
                ValidateCompany = "Maximum Length is 100 characters"
                ErrorFound = true
            else
                for counter = 1 to len(mCompanyName)
                    if Asc(mid(mCompanyName,counter,1)) >= 65 AND Asc(mid(mCompanyName,counter,1)) <= 90 then
                        ErrorFound = false
                    elseif Asc(mid(mCompanyName,counter,1)) >= 97 AND Asc(mid(mCompanyName,counter,1)) <= 122 then
                        ErrorFound = false
                    elseif Asc(mid(mCompanyName,counter,1)) = 32 then
                        ErrorFound = false
                    else
                        ValidateCompany = "Invalid Character Found"
                        ErrorFound = true
                        exit for
                    end if
                next
            end if
        End Function
    'End

    'ValidateJobDesignation
        Function ValidateJobDesignation()
            if mJobDesignationId = -1 then
                ValidateJobDesignation = "No Major Selected"
                ErrorFound = true
            else
                Set RSJob = Server.CreateObject("ADODB.RecordSet")                                 
                RSJob.Open "SELECT JobDesignationId, JobDesignation FROM ListJobDesignation",Conn

                if RSJob.eof = true then 
                    ValidateJobDesignation = "Job Designation not found in Database"
                    ErrorFound = true
                end if
            end if
        End Function
    'End
'end
%>