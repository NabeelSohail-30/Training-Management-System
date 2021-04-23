<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->
<!--#include file=AppSetting.asp-->
<%
    Dim StdId
    StdId = request.QueryString("QsStdId")

    'Variable Declaration
        Dim mStudentId
        Dim mTechQualificationId
        Dim mMajorId
        Dim mInstituteName
        Dim mQualDesc
        Dim mStartDate
        Dim mEndDate
        Dim mUserCreatedBy
        Dim mTQualificationId
        Dim mLastUpdatedDateTime
        'Dim ErrorFound
        Dim RSQualification
        Dim RSMajor
    'end

    if request.QueryString("Action")="1" then   'Action:1 = Add Technical Qualification
        call InsertTech()
    elseif request.QueryString("Action")="2" AND request.QueryString("EditForm")="true" then    'Action:2, EditForm:True = Fill Edit Technical Qualification
        Dim RSTech
        Set RSTech = Server.CreateObject("ADODB.RecordSet")
        RSTech.Open "SELECT * FROM StudentTechnicalQualification WHERE (TechQualificationId=" & Request.QueryString("QsTechQualificationId") & ")", conn
    elseif request.QueryString("Action")="2" then   'Action:2 = Update Technical Qualification
        'Session Variables
            Session("ErrorTechQualification")=""
            Session("ErrorMajor") = ""
            Session("ErrorInstitute") = ""
            Session("ErrorDescription") = ""
            Session("ErrorStartDate") = ""
            Session("ErrorEndDate") = ""
        'End
        call UpdateTech()
    elseif request.QueryString("Action")="3" then
        call DelTech()
    end if

%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <link rel="stylesheet" href="CSS/GlobalStyle.css">
    <link rel="stylesheet" href="CSS/StyleTechnical.css">
    <title>Technical Qualification</title>
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
                            <a class="nav-link active"
                                href="TechnicalQualification.asp?QsStdId=<% response.Write(StdId) %>">Technical
                                Qualification</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="WorkExperience.asp?QsStdId=<% response.Write(StdId) %>">Work
                                Experience</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="StudentCourse.asp?QsStdId=<% response.Write(StdId) %>">Training
                                Courses</a>
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
                            Edit Technical Qualification
                        </div>
                    </div>
                </div>

                <br>

                <div class="panel-body">
                    <form action="TechnicalQualification.asp?QsStdId=<% response.write(StdId) %>&Action=2"
                        method="POST">
                        <div class="row">
                            <div class="col-6">
                                <div class="form-group">
                                    <input type="hidden" name="FormTQualificationId"
                                        value="<% response.write(RSTech("TechQualificationId")) %>">
                                    <label for="" class="input-heading">Technical Qualification</label>
                                    <select name="FormTechQualificationId" class="form-control" id="TechQualification">
                                        <option value="-1">Select Technical Qualification</option>
                                        <%
                                                    Dim RSTechQualification
                                                    Set RSTechQualification = Server.CreateObject("ADODB.RecordSet")
                                                    
                                                    RSTechQualification.Open "SELECT TQualificationId, TechnicalQualifications FROM ListTechnicalQualifications",Conn
                
                                                    do while NOT RSTechQualification.EOF
                                                        if RSTech("TechnicalQualificationId") = RSTechQualification("TQualificationId") then
                                        %>
                                        <option value="<% response.write(RSTechQualification("TQualificationId")) %>"
                                            selected>
                                            <% response.write(RSTechQualification("TechnicalQualifications")) %>
                                        </option>
                                        <% else %>
                                        <option value="<% response.write(RSTechQualification("TQualificationId")) %>">
                                            <% response.write(RSTechQualification("TechnicalQualifications")) %>
                                        </option>
                                        <%
                                                        end if
                                                    RSTechQualification.MoveNext
                                                    Loop
                            
                                                    RSTechQualification.Close
                                                    Set RSTechQualification = Nothing
                                        %>
                                    </select>
                                </div>
                            </div>

                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Student Major</label>
                                    <br>
                                    <select name="FormMajorId" class="form-control" id="Major">
                                        <option value="-1">Select Major</option>
                                        <%
                                                    'Dim RSMajor
                                                    Set RSMajor = Server.CreateObject("ADODB.RecordSet")
                                                    
                                                    RSMajor.Open "SELECT MajorId, Major FROM ListMajor",Conn
                
                                                    do while NOT RSMajor.EOF
                                                        if RSTech("MajorId") = RSMajor("MajorId") then
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

                        <div class="row mt-2">
                            <div class="col">
                                <div class="form-group">
                                    <label for="" class="input-heading">Institute Name</label>
                                    <br>
                                    <input type="text" class="form-control" id="Institute" name="FormInstitute"
                                        value="<% response.write(RSTech("InstituteName")) %>">
                                </div>
                            </div>
                        </div>

                        <div class="row mt-2">
                            <div class="col">
                                <div class="form-group">
                                    <label for="" class="input-heading">Qualification Description</label>
                                    <br>
                                    <input type="text" class="form-control" id="QualDesc" name="FormQualDesc"
                                        value="<% response.write(RSTech("QualificationDescription")) %>">
                                </div>
                            </div>
                        </div>

                        <div class="row mt-2">
                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Start Date</label>
                                    <br>
                                    <input type="date" class="form-control" id="StDate" name="FormStartDate"
                                        value="<% response.write(RSTech("StartDate")) %>">
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">End Date</label>
                                    <br>
                                    <input type="date" class="form-control" id="EndDate" name="FormEndDate"
                                        value="<% response.write(RSTech("EndDate")) %>">
                                </div>
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
                            Add Technical Qualification
                        </div>
                    </div>
                </div>

                <br>

                <div class="panel-body">
                    <form action="TechnicalQualification.asp?QsStdId=<% response.write(StdId) %>&Action=1"
                        method="POST">
                        <div class="row">
                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Technical Qualification</label>
                                    <select name="FormTechQualificationId" class="form-control" id="TechQualification"
                                        onblur="DropDownValidate(this,document.getElementById('ErrorQualification'));">
                                        <option value="-1">Select Technical Qualification</option>
                                        <%
                                                    'Dim RSTechQualification
                                                    Set RSTechQualification = Server.CreateObject("ADODB.RecordSet")
                                                    
                                                    RSTechQualification.Open "SELECT TQualificationId, TechnicalQualifications FROM ListTechnicalQualifications",Conn
                
                                                    do while NOT RSTechQualification.EOF
                                                %>
                                        <option value="<% response.write(RSTechQualification("TQualificationId")) %>">
                                            <% response.write(RSTechQualification("TechnicalQualifications")) %>
                                        </option>
                                        <%
                                                    RSTechQualification.MoveNext
                                                    Loop
                            
                                                    RSTechQualification.Close
                                                    Set RSTechQualification = Nothing
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
                                    id="ErrorQualification"><% response.Write(Session("ErrorTechQualification")) %></span>
                            </div>
                            <div class="col-6"><span id="ErrorMajor"><% response.Write(Session("ErrorMajor")) %></span>
                            </div>
                        </div>

                        <div class="row mt-2">
                            <div class="col">
                                <div class="form-group">
                                    <label for="" class="input-heading">Institute Name</label>
                                    <br>
                                    <input type="text" class="form-control" id="Institue" name="FormInstitute"
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
                            <div class="col">
                                <div class="form-group">
                                    <label for="" class="input-heading">Qualification Description</label>
                                    <br>
                                    <input type="text" class="form-control" id="QualDesc" name="FormQualDesc"
                                        onblur="StringValidate(this,document.getElementById('ErrorDescription'),200);">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col">
                                <span id="ErrorDescription"><% response.Write(Session("ErrorDescription")) %></span>
                            </div>
                        </div>

                        <div class="row mt-2">
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
                            <div class="col-lg d-flex justify-content-center">
                                <input type="submit" value="Add" class="button">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <% end if %>

            <%
                Dim RSStdTechQual
                Set RSStdTechQual = Server.CreateObject("ADODB.RecordSet")

                RSStdTechQual.Open "SELECT * FROM V_StdTechQualificationView WHERE(StudentId =" & StdId & ")", conn
            %>
            <div class="panel">
                <div class="panel-head">
                    <div class="row">
                        <div class="col">
                            Student's Technical Qualification
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <table class="table table-bordered table-hover">
                        <thead class="thead-light">
                            <tr>
                                <th style="width: 1%;"></th>
                                <th style="width: 1%;"></th>
                                <th style="width: 10%;" class="qualf">Technical Qualification</th>
                                <th style="width: 10%;" class="major">Major</th>
                                <th style="width: 12%;" class="inst">Institute Name</th>
                                <th style="width: 12%;" class="desc">Description</th>
                                <th style="width: 5%;" class="start">Start Date</th>
                                <th style="width: 5%;" class="end">End Date</th>
                            </tr>
                        </thead>

                        <tbody>
                            <% do while NOT RSStdTechQual.EOF %>
                            <tr>
                                <td>
                                    <a
                                        href="TechnicalQualification.asp?QsStdId=<% response.write(StdId) %>&Action=2&EditForm=true&QsTechQualificationId=<% response.write(RSStdTechQual("TechQualificationId")) %>">
                                        <img src="Images/edit.png" alt="" width="20px" height="20px">
                                    </a>
                                </td>
                                <td>
                                    <a
                                        href="TechnicalQualification.asp?QsStdId=<% response.write(StdId) %>&Action=3&QsTechQualificationId=<% response.write(RSStdTechQual("TechQualificationId")) %>">
                                        <img src="Images/delete.png" alt="" width="20px" height="20px">
                                    </a>
                                </td>
                                <td class="qualf"><% response.write(RSStdTechQual("TechnicalQualifications")) %></td>
                                <td class="major"><% response.write(RSStdTechQual("Major")) %></td>
                                <td class="inst"><% response.write(RSStdTechQual("InstituteName")) %></td>
                                <td class="desc"><% response.write(RSStdTechQual("QualificationDescription")) %></td>
                                <td class="start"><% response.write(RSStdTechQual("StartDate")) %></td>
                                <td class="end"><% response.write(RSStdTechQual("EndDate")) %></td>
                            </tr>
                            <% 
                                RSStdTechQual.MoveNext
                            loop

                                RSStdTechQual.Close
                                set RSStdTechQual = Nothing
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
    sub InsertTech()

        'Variable Initialization
            mStudentId = StdId
            mTechQualificationId = cint(request.form("FormTechQualificationId"))
            mMajorId = cint(request.form("FormMajorId"))
            mInstituteName = request.form("FormInstitute")
            mQualDesc = request.form("FormQualDesc")
            mStartDate = request.form("FormStartDate")
            mEndDate = request.form("FormEndDate")
            mUserCreatedBy = Session("SUserId")
        'end
    
        'Validations
            Session("ErrorTechQualification") = ValidateTechQualification()
            Session("ErrorMajor") = ValidateMajor()
            Session("ErrorInstitute") = ValidateInstitute()
            Session("ErrorDescription") = ValidateDescription()
            Session("ErrorStartDate") = ValidateDate(mStartDate)
            Session("ErrorEndDate") = ValidateDate(mEndDate)

            if ErrorFound=true then
                response.Redirect("TechnicalQualification.asp?QsStdId=" & StdId)
            end if
        'end

        'Check Duplicate
            
        'end

        'Insert Record
            QryStr = "INSERT INTO StudentTechnicalQualification (StudentId, TechnicalQualificationId, MajorId, InstituteName, QualificationDescription," & _
                    " StartDate, EndDate, UserCreatedBy) " & _ 
                    "Values(" & mStudentId & ", " & mTechQualificationId & ", " & mMajorId & ", '" & mInstituteName & "', '" & mQualDesc & "', '" & _
                    mStartDate & "', '" & mEndDate & "', " & mUserCreatedBy & ")"
            
            'response.write QryStr
            conn.execute QryStr
        'end
    end sub
'End

'Update Record
    sub UpdateTech()
        'Variable Initialization
            mTQualificationId = cint(request.form("FormTQualificationId"))
            mTechQualificationId = cint(request.form("FormTechQualificationId"))
            mMajorId = cint(request.form("FormMajorId"))
            mInstituteName = request.form("FormInstitute")
            mQualDesc = request.form("FormQualDesc")
            mStartDate = request.form("FormStartDate")
            mEndDate = request.form("FormEndDate")
            mUserLastUpdatedBy = Session("SUserId")
            mLastUpdatedDateTime = Now()
        'end

        'Validations
            Session("ErrorTechQualification") = ValidateTechQualification()
            Session("ErrorMajor") = ValidateMajor()
            Session("ErrorInstitute") = ValidateInstitute()
            Session("ErrorDescription") = ValidateDescription()
            Session("ErrorStartDate") = ValidateDate(mStartDate)
            Session("ErrorEndDate") = ValidateDate(mEndDate)

            if ErrorFound=true then
                response.Redirect("TechnicalQualification.asp?QsStdId=" & StdId & "&Action=2&EditForm=true&QsTechQualificationId=" & mTQualificationId)
            end if
        'end

        'Check Duplicate
            
        'end

        'Update Record
            QryStr = "UPDATE StudentTechnicalQualification " & _
                     "SET TechnicalQualificationId = " & mTechQualificationId & ", MajorId = " & mMajorId & ", InstituteName = '" & mInstituteName & "', StartDate = '" & mStartDate & _
                     "', EndDate = '" & mEndDate & "', QualificationDescription = '" & mQualDesc & "', UserLastUpdatedBy = " &  mUserLastUpdatedBy & ", LastUpdatedDateTime = '" & mLastUpdatedDateTime & "'" & _
                    " WHERE (TechQualificationId=" & mTQualificationId & ")"
            
            'response.write QryStr
            conn.execute QryStr
        'end
    end sub  
'end

'Delete Record
    sub DelTech()

        'Variable Initialization
            mTQualificationId = cint(request.QueryString("QsTechQualificationId"))
        'end

        'Del Record
            QryStr = "DELETE FROM StudentTechnicalQualification WHERE(TechQualificationId=" & mTQualificationId & ")"
            
            'response.write QryStr
            conn.execute QryStr
        'end
    end sub
'end

'Validations Functions
    'ValidateTechQualification
        Function ValidateTechQualification()
            if mTechQualificationId = -1 then
                ValidateQualification = "No Qualification Selected"
                ErrorFound = true
            else
                set RSTechQualification = Server.CreateObject("ADODB.RecordSet")
                RSTechQualification.Open "SELECT * FROM ListTechnicalQualifications WHERE(TQualificationId = " & mTechQualificationId & ")",Conn
                if RSTechQualification.EOF = true then
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

    'ValidateInstitute
        Function ValidateDescription()
        
            if mQualDesc = "" OR IsNull(mQualDesc) = true then
                ValidateDescription = "Description cannot be NULL"
                ErrorFound = true
            elseif len(mQualDesc) > 200 then
                ValidateDescription = "Maximum Length is 80 characters"
                ErrorFound = true
            else
                for counter = 1 to len(mQualDesc)
                    if Asc(mid(mQualDesc,counter,1)) >= 65 AND Asc(mid(mQualDesc,counter,1)) <= 90 then
                        ErrorFound = false
                    elseif Asc(mid(mQualDesc,counter,1)) >= 97 AND Asc(mid(mQualDesc,counter,1)) <= 122 then
                        ErrorFound = false
                    elseif Asc(mid(mQualDesc,counter,1)) = 32 then
                        ErrorFound = false
                    else
                        ValidateDescription = "Invalid Character Found"
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


'End

%>