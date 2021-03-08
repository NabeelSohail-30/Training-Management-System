<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->
<!--#include file=AppSetting.asp-->
<%
    Dim StdId
    StdId = request.QueryString("QsStdId")

    'Variable Declaration
        Dim mStudentId
        Dim mQualificationId
        Dim mMajorId
        Dim mInstituteName
        Dim mStartDate
        Dim mEndDate
        Dim mYearPassed
        Dim mUserCreatedBy
        Dim mAcdQualificationId
        Dim mLastUpdatedDateTime
        'Dim ErrorFound
        Dim RSQualification
        Dim RSMajor
    'end

    

    if request.QueryString("Action")="1" then   'Action:1 = Add Academic Qualification
        call InsertAcd()
    elseif request.QueryString("Action")="2" AND request.QueryString("EditForm")="true" then    'Action:2, EditForm:True = Fill Edit Academic Qualification
        Dim RSAcd
        Set RSAcd = Server.CreateObject("ADODB.RecordSet")
        RSAcd.Open "SELECT * FROM StudentAcademicQualification WHERE (AcdQualificationId=" & Request.QueryString("QsAcdId") & ")", conn
    elseif request.QueryString("Action")="2" then   'Action:2 = Update Academic Qualification
        'Session Variables
        Session("ErrorQualification")=""
        Session("ErrorMajor") = ""
        Session("ErrorInstitute") = ""
        Session("ErrorStartDate") = ""
        Session("ErrorEndDate") = ""
        Session("ErrorYearPassed") = ""
        'End
        call UpdateAcd()
    elseif request.QueryString("Action")="3" then
        call DelAcd()
    end if
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <link rel="stylesheet" href="CSS/GlobalStyle.css">
    <link rel="stylesheet" href="CSS/StyleAcademic.css">
    <title>Academic Qualification</title>
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
                            <a class="nav-link active"
                                href="AcademicQualification.asp?QsStdId=<% response.Write(StdId) %>">Academic
                                Qualification</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link"
                                href="TechnicalQualification.asp?QsStdId=<% response.Write(StdId) %>">Technical
                                Qualification</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="WorkExperience.asp?QsStdId=<% response.Write(StdId) %>">Work
                                Experience</a>
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
                            Update Academic Qualification
                        </div>
                    </div>
                </div>

                <br>

                <div class="panel-body">
                    <% if request.QueryString("Action")="2" AND request.QueryString("EditForm")="true" then %>
                    <form action="AcademicQualification.asp?QsStdId=<% response.write(StdId) %>&Action=2" method="POST">
                        <% else %>
                        <form action="AcademicQualification.asp?QsStdId=<% response.write(StdId) %>&Action=1"
                            method="POST">
                            <% end if %>
                            <div class="row">
                                <div class="col-6">
                                    <div class="form-group">
                                        <input type="hidden" name="FormAcdQualificationId"
                                            value="<% response.write(RSAcd("AcdQualificationId")) %>">

                                        <label for="" class="input-heading">Student Qualification</label>
                                        <select name="FormQualificationId" class="form-control" id="Qualification"
                                            onblur="DropDownValidate(this,document.getElementById('ErrorQualification'));">
                                            <option value="-1">Select Qualification</option>
                                            <%
                                                    'Dim RSQualification
                                                    Set RSQualification = Server.CreateObject("ADODB.RecordSet")
                                                    
                                                    RSQualification.Open "SELECT QualificationId, Qualifications FROM ListQualifications",Conn
                
                                                    do while NOT RSQualification.EOF
                                                        if RSQualification("QualificationId") = RSAcd("QualificationId") then
                                        %>
                                            <option value="<% response.write(RSQualification("QualificationId")) %>"
                                                selected><% response.write(RSQualification("Qualifications")) %>
                                            </option>
                                            <% else %>
                                            <option value="<% response.write(RSQualification("QualificationId")) %>">
                                                <% response.write(RSQualification("Qualifications")) %></option>
                                            <%
                                                        End If
                                                    RSQualification.MoveNext
                                                    Loop
                            
                                                    RSQualification.Close
                                                    Set RSQualification = Nothing
                                        %>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-6">
                                    <div class="form-group">
                                        <label for="" class="input-heading">Student Major</label>
                                        <br>
                                        <select name="FormMajorId" class="form-control" id="Major"
                                            onblur="DropDownValidate(this,document.getElementById('ErrorMajor'));">
                                            <option value="-1">Select Major</option>
                                            <%
                                                    'Dim RSMajor
                                                    Set RSMajor = Server.CreateObject("ADODB.RecordSet")
                                                    
                                                    RSMajor.Open "SELECT MajorId, Major FROM ListMajor",Conn
                
                                                    do while NOT RSMajor.EOF
                                                        if RSMajor("MajorId") = RSAcd("MajorId") then
                                        %>
                                            <option value="<% response.write(RSMajor("MajorId")) %>" selected>
                                                <% response.write(RSMajor("Major")) %></option>
                                            <% else %>
                                            <option value="<% response.write(RSMajor("MajorId")) %>">
                                                <% response.write(RSMajor("Major")) %></option>
                                            <%
                                                        end if
                                                    RSMajor.MoveNext
                                                    Loop
                            
                                                    RSMajor.Close
                                                    Set RSMajor = Nothing
                                        %>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-6"><span
                                        id="ErrorQualification"><% response.Write(Session("ErrorQualification")) %></span>
                                </div>
                                <div class="col-6"><span
                                        id="ErrorMajor"><% response.Write(Session("ErrorMajor")) %></span></div>
                            </div>

                            <div class="row mt-2">
                                <div class="col">
                                    <div class="form-group">
                                        <label for="" class="input-heading">Institute Name</label>
                                        <br>
                                        <input type="text" class="form-control" id="Institute" name="FormInstituteName"
                                            onblur="StringValidate(this,document.getElementById('ErrorInstitute'),50);"
                                            value="<% response.write(RSAcd("InstituteName")) %>">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <span id="ErrorInstitute"><% response.Write(Session("ErrorInstitute")) %></span>
                                </div>
                            </div>

                            <div class="row mt-2">
                                <div class="col-4">
                                    <div class="form-group">
                                        <label for="" class="input-heading">Start Date</label>
                                        <br>
                                        <input type="date" class="form-control" id="StDate" name="FormStartDate"
                                            onblur="ValidateDate(this,document.getElementById('ErrorStartDate'));"
                                            value="<% response.write(RSAcd("StartDate")) %>">
                                    </div>
                                </div>
                                <div class="col-4">
                                    <div class="form-group">
                                        <label for="" class="input-heading">End Date</label>
                                        <br>
                                        <input type="date" class="form-control" id="EndDate" name="FormEndDate"
                                            onblur="ValidateDate(this,document.getElementById('ErrorEndDate'));"
                                            value="<% response.write(RSAcd("EndDate")) %>">
                                    </div>
                                </div>
                                <div class="col-4">
                                    <div class="form-group">
                                        <label for="" class="input-heading">Year Passed</label>
                                        <br>
                                        <input type="text" class="form-control" id="YearPassed" name="FormYearPassed"
                                            onblur="ValidateYearPassed(this,document.getElementById('ErrorYearPassed'));"
                                            value="<% response.write(RSAcd("YearPassed")) %>">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-4"><span
                                        id="ErrorStartDate"><% response.Write(Session("ErrorStartDate")) %></span></div>
                                <div class="col-4"><span
                                        id="ErrorEndDate"><% response.Write(Session("ErrorEndDate")) %></span></div>
                                <div class="col-4"><span
                                        id="ErrorYearPassed"><% response.Write(Session("ErrorYearPassed")) %></span>
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
                            Add Academic Qualification
                        </div>
                    </div>
                </div>

                <br>

                <div class="panel-body">
                    <% if request.QueryString("Action")="2" AND request.QueryString("EditForm")="true" then %>
                    <form action="AcademicQualification.asp?QsStdId=<% response.write(StdId) %>&Action=2" method="POST">
                        <% else %>
                        <form action="AcademicQualification.asp?QsStdId=<% response.write(StdId) %>&Action=1"
                            method="POST">
                            <% end if %>
                            <div class="row">
                                <div class="col-6">
                                    <div class="form-group">
                                        <label for="" class="input-heading">Student Qualification</label>
                                        <select name="FormQualificationId" class="form-control" id="Qualification"
                                            onblur="DropDownValidate(this,document.getElementById('ErrorQualification'));">
                                            <option value="-1">Select Qualification</option>
                                            <%
                                                    'Dim RSQualification
                                                    Set RSQualification = Server.CreateObject("ADODB.RecordSet")
                                                    
                                                    RSQualification.Open "SELECT QualificationId, Qualifications FROM ListQualifications",Conn
                
                                                    do while NOT RSQualification.EOF
                                                %>
                                            <option value="<% response.write(RSQualification("QualificationId")) %>">
                                                <% response.write(RSQualification("Qualifications")) %></option>
                                            <%
                                                    RSQualification.MoveNext
                                                    Loop
                            
                                                    RSQualification.Close
                                                    Set RSQualification = Nothing
                                                %>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-6">
                                    <div class="form-group">
                                        <label for="" class="input-heading">Student Major</label>
                                        <br>
                                        <select name="FormMajorId" class="form-control" id="Major"
                                            onblur="DropDownValidate(this,document.getElementById('ErrorMajor'));">
                                            <option value="-1">Select Major</option>
                                            <%
                                                    'Dim RSMajor
                                                    Set RSMajor = Server.CreateObject("ADODB.RecordSet")
                                                    
                                                    RSMajor.Open "SELECT MajorId, Major FROM ListMajor",Conn
                
                                                    do while NOT RSMajor.EOF
                                                %>
                                            <option value="<% response.write(RSMajor("MajorId")) %>">
                                                <% response.write(RSMajor("Major")) %></option>
                                            <%
                                                    RSMajor.MoveNext
                                                    Loop
                            
                                                    RSMajor.Close
                                                    Set RSMajor = Nothing
                                                %>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-6"><span
                                        id="ErrorQualification"><% response.Write(Session("ErrorQualification")) %></span>
                                </div>
                                <div class="col-6"><span
                                        id="ErrorMajor"><% response.Write(Session("ErrorMajor")) %></span></div>
                            </div>

                            <div class="row mt-2">
                                <div class="col">
                                    <div class="form-group">
                                        <label for="" class="input-heading">Institute Name</label>
                                        <br>
                                        <input type="text" class="form-control" id="Institute" name="FormInstituteName"
                                            onblur="StringValidate(this,document.getElementById('ErrorInstitute'),80);">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <span id="ErrorInstitute"><% response.Write(Session("ErrorInstitute")) %></span>
                                </div>
                            </div>

                            <div class="row mt-2">
                                <div class="col-4">
                                    <div class="form-group">
                                        <label for="" class="input-heading">Start Date</label>
                                        <br>
                                        <input type="date" class="form-control" id="StDate" name="FormStartDate"
                                            onblur="ValidateDate(this,document.getElementById('ErrorStartDate'));">
                                    </div>
                                </div>
                                <div class="col-4">
                                    <div class="form-group">
                                        <label for="" class="input-heading">End Date</label>
                                        <br>
                                        <input type="date" class="form-control" id="EndDate" name="FormEndDate"
                                            onblur="ValidateDate(this,document.getElementById('ErrorEndDate'));">
                                    </div>
                                </div>
                                <div class="col-4">
                                    <div class="form-group">
                                        <label for="" class="input-heading">Year Passed</label>
                                        <br>
                                        <input type="text" class="form-control" id="YearPassed" name="FormYearPassed"
                                            onblur="ValidateYearPassed(this,document.getElementById('ErrorYearPassed'));">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-4"><span
                                        id="ErrorStartDate"><% response.Write(Session("ErrorStartDate")) %></span></div>
                                <div class="col-4"><span
                                        id="ErrorEndDate"><% response.Write(Session("ErrorEndDate")) %></span></div>
                                <div class="col-4"><span
                                        id="ErrorYearPassed"><% response.Write(Session("ErrorYearPassed")) %></span>
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
                Dim RSStdAcdQual
                Set RSStdAcdQual = Server.CreateObject("ADODB.RecordSet")

                RSStdAcdQual.Open "SELECT * FROM V_StdAcdQualificationView WHERE(StudentId =" & StdId & ")", conn
            %>
            <div class="panel">
                <div class="panel-head">
                    <div class="row">
                        <div class="col">
                            Student's Academic Qualification
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <table class="table table-bordered table-hover">
                        <thead class="thead-light">
                            <tr>
                                <th style="width: 1%;"></th>
                                <th style="width: 1%;"></th>
                                <th style="width: 3%;" class="qualf">Qualification</th>
                                <th style="width: 6%;" class="major">Major</th>
                                <th style="width: 18%;" class="inst">Institute Name</th>
                                <th style="width: 4%;" class="start">Start Date</th>
                                <th style="width: 4%;" class="end">End Date</th>
                                <th style="width: 4%;" class="year">Year Passed</th>
                            </tr>
                        </thead>

                        <tbody>
                            <% do while NOT RSStdAcdQual.EOF %>
                            <tr>
                                <td><a
                                        href="AcademicQualification.asp?QsStdId=<% response.write(StdId) %>&Action=2&EditForm=true&QsAcdId=<% response.write(RSStdAcdQual("AcdQualificationId")) %>"><img
                                            src="Images/edit.png" alt="" width="20px" height="20px"></a></td>
                                <td>
                                    <a href="AcademicQualification.asp?QsStdId=<% response.write(StdId) %>&Action=3&QsAcdId=<% response.write(RSStdAcdQual("AcdQualificationId")) %>" onclick="return window.confirm('Are you sure to delete?\nPress OK to Delete');">
                                    <img src="
                                        Images/delete.png" alt="" width="20px" height="20px"></a></td>
                                <td class="qualf"><% response.write(RSStdAcdQual("Qualifications")) %></td>
                                <td class="major"><% response.write(RSStdAcdQual("Major")) %></td>
                                <td class="inst"><% response.write(RSStdAcdQual("InstituteName")) %></td>
                                <td class="start"><% response.write(RSStdAcdQual("StartDate")) %></td>
                                <td class="end"><% response.write(RSStdAcdQual("EndDate")) %></td>
                                <td class="year"><% response.write(RSStdAcdQual("YearPassed")) %></td>
                            </tr>
                            <% 
                                RSStdAcdQual.MoveNext
                            loop

                                RSStdAcdQual.Close
                                set RSStdAcdQual = Nothing
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
<script src="Scripts/StdAcad.js"></script>

</html>
<%
    'Procedures and Functions

    sub InsertAcd()

        'Variable Initialization
            mStudentId = StdId
            mQualificationId = cint(request.form("FormQualificationId"))
            mMajorId = cint(request.form("FormMajorId"))
            mInstituteName = request.form("FormInstituteName")
            mStartDate = request.form("FormStartDate")
            mEndDate = request.form("FormEndDate")
            mYearPassed = cint(request.form("FormYearPassed"))
            mUserCreatedBy = Session("SUserId")
        'end

        'Validations
            Session("ErrorQualification") = ValidateQualification()
            Session("ErrorMajor") = ValidateMajor()
            Session("ErrorInstitute") = ValidateInstitute()
            Session("ErrorStartDate") = ValidateDate(mStartDate)
            Session("ErrorEndDate") = ValidateDate(mEndDate)
            Session("ErrorYearPassed") = ValidateYearPassed()

            if ErrorFound=true then
                response.Redirect("AcademicQualification.asp?QsStdId=" & StdId)
            end if
        'end

        'Check Duplicate
            
        'end

        'Insert Record
            QryStr = "INSERT INTO StudentAcademicQualification (StudentId, QualificationId, MajorId, InstituteName, StartDate," & _
                    " EndDate, YearPassed, UserCreatedBy) " & _ 
                    "Values(" & mStudentId & ", " & mQualificationId & ", " & mMajorId & ", '" & mInstituteName & "', '" & mStartDate & "', '" & _
                    mEndDate & "', " & mYearPassed & ", " & mUserCreatedBy & ")"
            
            'response.write QryStr
            conn.execute QryStr
        'end
    end sub

    sub UpdateAcd()
        
        'Variable Initialization
            mAcdQualificationId = cint(request.form("FormAcdQualificationId"))
            mQualificationId = cint(request.form("FormQualificationId"))
            mMajorId = cint(request.form("FormMajorId"))
            mInstituteName = request.form("FormInstituteName")
            mStartDate = request.form("FormStartDate")
            mEndDate = request.form("FormEndDate")
            mYearPassed = cint(request.form("FormYearPassed"))
            mUserLastUpdatedBy = Session("SUserId")
            mLastUpdatedDateTime = Now()
        'end

        'Validations
            Session("ErrorQualification") = ValidateQualification()
            Session("ErrorMajor") = ValidateMajor()
            Session("ErrorInstitute") = ValidateInstitute()
            Session("ErrorStartDate") = ValidateDate(mStartDate)
            Session("ErrorEndDate") = ValidateDate(mEndDate)
            Session("ErrorYearPassed") = ValidateYearPassed()

            if ErrorFound=true then
                'response.write("Error =" & Session("ErrorInstitute"))
                'response.end
                response.Redirect("AcademicQualification.asp?QsStdId=" & StdId & "&Action=2&EditForm=true&QsAcdId=" & mAcdQualificationId)
            end if
        'end

        'Update Record
            QryStr = "UPDATE StudentAcademicQualification " & _
                     "SET QualificationId = " & mQualificationId & ", MajorId = " & mMajorId & ", InstituteName = '" & mInstituteName & "', StartDate = '" & mStartDate & _
                     "', EndDate = '" & mEndDate & "', YearPassed = " & mYearPassed & ", UserLastUpdatedBy = " &  mUserLastUpdatedBy & ", LastUpdatedDateTime = '" & mLastUpdatedDateTime & "'" & _
                    " WHERE (AcdQualificationId=" & mAcdQualificationId & ")"
            
            'response.write QryStr
            conn.execute QryStr
        'end
    end sub    

    sub DelAcd()

        'Variable Initialization
            mAcdQualificationId = cint(request.QueryString("QsAcdId"))
        'end

        'Del Record
            QryStr = "DELETE FROM StudentAcademicQualification WHERE(AcdQualificationId=" & mAcdQualificationId & ")"
            
            'response.write QryStr
            conn.execute QryStr
        'end
    end sub

    'Validations Functions

    'ValidateQualification
        Function ValidateQualification()
            if mQualificationId = -1 then
                ValidateQualification = "No Qualification Selected"
                ErrorFound = true
            else
                set RSQualification = Server.CreateObject("ADODB.RecordSet")
                RSQualification.Open "SELECT * FROM ListQualifications WHERE(QualificationId = " & mQualificationId & ")",Conn
                if RSQualification.EOF = true then
                    ValidateQualification = "Qualification not found in Database"
                    ErrorFound = true
                end if
            end if
        End Function
    'End

    'ValidateMajor
        Function ValidateMajor()
            if mMajorId = -1 then
                ValidateMajor = "No Major Selected"
                ErrorFound = true
            else
                set RSMajor = Server.CreateObject("ADODB.RecordSet")
                RSMajor.Open "SELECT * FROM ListMajor WHERE(MajorId = " & mMajorId & ")",Conn
                if RSMajor.EOF = true then
                    ValidateMajor = "Major not found in Database"
                    ErrorFound = true
                end if
            end if
        End Function
    'End

    'ValidateInstitute
        Function ValidateInstitute()
        
            if mInstituteName = "" OR IsNull(mInstituteName) = true then
                ValidateInstitute = "Institute Name cannot be NULL"
                ErrorFound = true
            elseif len(mInstituteName) > 80 then
                ValidateInstitute = "Maximum Length is 80 characters"
                ErrorFound = true
            else
                for counter = 1 to len(mInstituteName)
                    if Asc(mid(mInstituteName,counter,1)) >= 65 AND Asc(mid(mInstituteName,counter,1)) <= 90 then
                        ErrorFound = false
                    elseif Asc(mid(mInstituteName,counter,1)) >= 97 AND Asc(mid(mInstituteName,counter,1)) <= 122 then
                        ErrorFound = false
                    elseif Asc(mid(mInstituteName,counter,1)) = 32 then
                        ErrorFound = false
                    else
                        ValidateInstitute = "Invalid Character Found"
                        ErrorFound = true
                        exit for
                    end if
                next
            end if
        End Function
    'End

    'ValidateDate
    Function ValidateDate(Target)
        
        if Target = "" OR IsNull(Target) = true then
            ValidateDate = "Field cannot be NULL"
            ErrorFound = true
        end if
    End Function
    'End

    'ValidateYearPassed
    Function ValidateYearPassed()
        
        if mYearPassed = "" OR IsNull(mYearPassed) = true then
            ValidateYearPassed = "Field cannot be NULL"
            ErrorFound = true
        elseif len(mYearPassed) > 4 then
            ValidateYearPassed = "Max Length is 4"
            ErrorFound = true
        else
            for counter = 1 to len(mYearPassed)
                if IsNumeric(mid(mYearPassed,counter,1)) = false then
                    ValidateYearPassed = "Invalid Character Found"
                    ErrorFound = true
                    exit for
                end if
            next
        end if
    End Function
    'End

    'Ends
%>