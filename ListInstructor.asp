<!--#include file=OpenDbConn.asp-->
<!--#include file=ReValidateLogin.asp-->
<%
if Session("SUserRoleId") <> 2 then

call OpenDbConn()
Dim RSInstructor
Set RSInstructor = Server.CreateObject("ADODB.RecordSet")
QryStr = "SELECT * FROM ListInstructor"
RSInstructor.Open QryStr, conn

if request.QueryString("QsAction") = "1" then

Dim mName
Dim mDob
Dim mGenderId
Dim mReligionId
Dim mNationalityId
Dim mQualifications
Dim mPhoneNumber
Dim mEmail

mName = Request.form("FormInstructor")
mDob = Request.form("FormDob")
mGenderId = Request.form("FormGenderId")
mReligionId = Request.form("FormReligionId")
mNationalityId = Request.form("FormNationalityId")
mQualifications = Request.form("FormQualification")
mPhoneNumber = Request.form("FormNumber")
mEmail = Request.form("FormEmail")

'Validations

QryStr = "INSERT INTO ListInstructor(InstructorName, DateOfBirth, GenderId, ReligionId, NationalityId, Qualifications, PhoneNumber, EmailAddress, UserCreatedBy, CreationDateTime)" & _
            " Values('" & mName & "', '" & mDob & "', " & mGenderId & ", " & mReligionId & ", " & mNationalityId & ", '" & mQualifications & "', '" & mPhoneNumber & _
            "', '" & mEmail & "', " & Session("SUserId") & ", '" & Now() & "')"

'response.write(QryStr)
Conn.execute QryStr
response.redirect("ListInstructor.asp")

end if

if request.QueryString("QsAction") = "3" then

'Dim mName
'Dim mDob
'Dim mGenderId
'Dim mReligionId
'Dim mNationalityId
'Dim mQualifications
'Dim mPhoneNumber
'Dim mEmail
Dim mInstructorId

mName = Request.form("FormInstructor")
mInstructorId = Request.form("FormId")
mDob = Request.form("FormDob")
mGenderId = Request.form("FormGenderId")
mReligionId = Request.form("FormReligionId")
mNationalityId = Request.form("FormNationalityId")
mQualifications = Request.form("FormQualification")
mPhoneNumber = Request.form("FormNumber")
mEmail = Request.form("FormEmail")

'Validations

QryStr = "UPDATE ListInstructor SET " & _
            "InstructorName = '" & mName & "', " & _
            "DateOfBirth = '" & mDob & "', " & _
            "GenderId = " & mGenderId & ", " & _
            "ReligionId = " & mReligionId & ", " & _
            "NationalityId = " & mNationalityId & ", " & _
            "Qualifications = '" & mQualifications & "', " & _
            "PhoneNumber = '" & mPhoneNumber & "', " & _
            "EmailAddress = '" & mEmail & "', " & _
            " UserLastUpdatedBy = " & Session("SUserId") & ", LastUpdatedDateTime = '" & Now() & "' WHERE(InstructorId = " & mInstructorId & ")"


'response.write(QryStr)
Conn.execute QryStr
response.redirect("ListInstructor.asp")

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
    <title>Instructor</title>
</head>

<body>
    <header>
        <!--#include file=Header.asp-->
    </header>

    <div class="wrapper">
        <div class="container-fluid">

            <% 
            if request.QueryString("QsAction") = "2" then 
                Dim RSEditInstructor
                Set RSEditInstructor = Server.CreateObject("ADODB.RecordSet")
                RSEditInstructor.Open "SELECT * FROM ListInstructor WHERE (InstructorId = " & Request.QueryString("QsId") & ")", conn
            %>
            <form action="ListInstructor.asp?QsAction=3" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Edit Instructor</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <input type="hidden" value="<% response.write(RSEditInstructor("InstructorId")) %>"
                                name="FormId">
                            <div class="col-4">
                                <label for="" class="input-heading">Instructor Name</label>
                                <input type="text" class="form-control" name="FormInstructor"
                                    value="<% response.write(RSEditInstructor("InstructorName")) %>"></input>
                            </div>

                            <div class="col-4">
                                <label for="" class="input-heading">Date of Birth</label>
                                <input type="date" class="form-control" name="FormDob"
                                    value="<% response.write(RSEditInstructor("DateOfBirth")) %>"></input>
                            </div>

                            <div class="col-4">
                                <label for="" class="input-heading">Gender</label>
                                <br>
                                <select name="FormGenderId" id="" class="form-control">
                                    <option value="-1">Select Gender</option>
                                    <%
                                        Dim RSGender
                                        Set RSGender = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSGender.Open "SELECT GenderId, Gender FROM ListGender",Conn

                                        do while NOT RSGender.EOF
                                            if RSGender("GenderId") = RSEditInstructor("GenderId") then
                                    %>
                                    <option value="<% response.write(RSGender("GenderId")) %>" selected>
                                        <% response.write(RSGender("Gender")) %></option>
                                    <% else %>
                                    <option value="<% response.write(RSGender("GenderId")) %>">
                                        <% response.write(RSGender("Gender")) %></option>
                                    <%
                                            end if
                                        RSGender.MoveNext
                                        Loop
                
                                        RSGender.Close
                                        Set RSNationality = Nothing
                                    %>
                                </select>
                            </div>
                        </div>

                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Religion</label>
                                <br>
                                <select name="FormReligionId" id="" class="form-control">
                                    <option value="-1">Select Religion</option>
                                    <%
                                        Dim RSReligion
                                        Set RSReligion = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSReligion.Open "SELECT ReligionId, Religion FROM ListReligion",Conn

                                        do while NOT RSReligion.EOF
                                            if RSReligion("ReligionId") = RSEditInstructor("ReligionId") then
                                    %>
                                    <option value="<% response.write(RSReligion("ReligionId")) %>" selected>
                                        <% response.write(RSReligion("Religion")) %></option>
                                    <% else %>
                                    <option value="<% response.write(RSReligion("ReligionId")) %>">
                                        <% response.write(RSReligion("Religion")) %></option>
                                    <%
                                            end if
                                        RSReligion.MoveNext
                                        Loop
                
                                        RSReligion.Close
                                        Set RSNationality = Nothing
                                    %>
                                </select>
                            </div>

                            <div class="col-6">
                                <label for="" class="input-heading">Nationality</label>
                                <br>
                                <select name="FormNationalityId" id="" class="form-control">
                                    <option value="-1">Select Nationality</option>
                                    <%
                                        Dim RSNationality
                                        Set RSNationality = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSNationality.Open "SELECT * FROM ListNationality",Conn

                                        do while NOT RSNationality.EOF
                                            if RSNationality("NationalityId") = RSEditInstructor("NationalityId") then
                                    %>
                                    <option value="<% response.write(RSNationality("NationalityId")) %>" selected>
                                        <% response.write(RSNationality("Nationality")) %></option>
                                    <% else %>
                                    <option value="<% response.write(RSNationality("NationalityId")) %>">
                                        <% response.write(RSNationality("Nationality")) %></option>
                                    <%
                                            end if
                                        RSNationality.MoveNext
                                        Loop
                
                                        RSNationality.Close
                                        Set RSNationality = Nothing
                                    %>
                                </select>
                            </div>
                        </div>

                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col">
                                <label for="" class="input-heading">Qualification</label>
                                <br>
                                <input type="text" name="FormQualification" class="form-control"
                                    value="<% response.write(RSEditInstructor("Qualifications")) %>">
                            </div>
                        </div>

                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Phone Number</label>
                                <br>
                                <input type="text" name="FormNumber" class="form-control"
                                    value="<% response.write(RSEditInstructor("PhoneNumber")) %>">
                            </div>

                            <div class="col-6">
                                <label for="" class="input-heading">Email Address</label>
                                <br>
                                <input type="email" name="FormEmail" class="form-control"
                                    value="<% response.write(RSEditInstructor("EmailAddress")) %>">
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
            RSEditInstructor.close
            set RSEditInstructor = Nothing
            %>
            <% else %>
            <form action="ListInstructor.asp?QsAction=1" method="POST">
                <div class="panel">
                    <br>
                    <div class="panel-head">
                        <div class="row">
                            <div class="col">
                                <label for="">Add New Instructor</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <br>
                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-4">
                                <label for="" class="input-heading">Instructor Name</label>
                                <input type="text" class="form-control" name="FormInstructor"></input>
                                <span><% response.write(Session("sInstructor")) %></span>
                            </div>

                            <div class="col-4">
                                <label for="" class="input-heading">Date of Birth</label>
                                <input type="date" class="form-control" name="FormDob"></input>
                                <span><% response.write(Session("sDob")) %></span>
                            </div>

                            <div class="col-4">
                                <label for="" class="input-heading">Gender</label>
                                <br>
                                <select name="FormGenderId" id="" class="form-control">
                                    <option value="-1">Select Gender</option>
                                    <%
                                        'Dim RSGender
                                        Set RSGender = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSGender.Open "SELECT GenderId, Gender FROM ListGender",Conn

                                        do while NOT RSGender.EOF
                                    %>
                                    <option value="<% response.write(RSGender("GenderId")) %>">
                                        <% response.write(RSGender("Gender")) %></option>
                                    <%
                                        RSGender.MoveNext
                                        Loop
                
                                        RSGender.Close
                                        Set RSNationality = Nothing
                                    %>
                                </select>
                                <span><% response.write(Session("sGender")) %></span>
                            </div>
                        </div>

                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Religion</label>
                                <br>
                                <select name="FormReligionId" id="" class="form-control">
                                    <option value="-1">Select Religion</option>
                                    <%
                                        'Dim RSReligion
                                        Set RSReligion = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSReligion.Open "SELECT ReligionId, Religion FROM ListReligion",Conn

                                        do while NOT RSReligion.EOF
                                    %>
                                    <option value="<% response.write(RSReligion("ReligionId")) %>">
                                        <% response.write(RSReligion("Religion")) %></option>
                                    <%
                                        RSReligion.MoveNext
                                        Loop
                
                                        RSReligion.Close
                                        Set RSNationality = Nothing
                                    %>
                                </select>
                                <span><% response.write(Session("sGender")) %></span>
                            </div>

                            <div class="col-6">
                                <label for="" class="input-heading">Nationality</label>
                                <br>
                                <select name="FormNationalityId" id="" class="form-control">
                                    <option value="-1">Select Nationality</option>
                                    <%
                                        'Dim RSNationality
                                        Set RSNationality = Server.CreateObject("ADODB.RecordSet")
                                        
                                        RSNationality.Open "SELECT * FROM ListNationality",Conn

                                        do while NOT RSNationality.EOF
                                    %>
                                    <option value="<% response.write(RSNationality("NationalityId")) %>">
                                        <% response.write(RSNationality("Nationality")) %></option>
                                    <%
                                        RSNationality.MoveNext
                                        Loop
                
                                        RSNationality.Close
                                        Set RSNationality = Nothing
                                    %>
                                </select>
                                <span><% response.write(Session("sGender")) %></span>
                            </div>
                        </div>

                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col">
                                <label for="" class="input-heading">Qualification</label>
                                <br>
                                <input type="text" name="FormQualification" class="form-control">
                                <span><% response.write(Session("sQualification")) %></span>
                            </div>
                        </div>

                        <div class="row mt-2 d-flex justify-content-center">
                            <div class="col-6">
                                <label for="" class="input-heading">Phone Number</label>
                                <br>
                                <input type="text" name="FormNumber" class="form-control">
                                <span><% response.write(Session("sPhoneNumber")) %></span>
                            </div>

                            <div class="col-6">
                                <label for="" class="input-heading">Email Address</label>
                                <br>
                                <input type="email" name="FormEmail" class="form-control">
                                <span><% response.write(Session("sEmail")) %></span>
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
                            <label for="">Instructor</label>
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <br>
                    <table class="table table-bordered table-hover" style="width: 80%;">
                        <thead>
                            <tr>
                                <th style="width: 3%;">Instructor Id</th>
                                <th style="width: 10%;">Instructor Name</th>
                                <th style="width: 10%;">Phone Number</th>
                                <th style="width: 10%;">Email Address</th>
                                <th style="width: 0.5%"></th>
                            </tr>
                        </thead>

                        <tbody>
                            <%
                                do while NOT RSInstructor.EOF
                            %>
                            <tr>
                                <td><% response.write(RSInstructor("InstructorId")) %></td>
                                <td><% response.write(RSInstructor("InstructorName")) %></td>
                                <td><% response.write(RSInstructor("PhoneNumber")) %></td>
                                <td><% response.write(RSInstructor("EmailAddress")) %></td>
                                <td>
                                    <a
                                        href="ListInstructor.asp?QsAction=2&QsId=<% response.write(RSInstructor("InstructorId")) %>">
                                        <img src="Images/edit.png" alt="" width="20px" height="20px">
                                    </a>
                                </td>
                            </tr>
                            <%
                                RSInstructor.MoveNext
                                Loop

                                RSInstructor.close
                                set RSInstructor = Nothing
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