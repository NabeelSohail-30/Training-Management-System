<%
    Dim RSStdDetail
    'Dim StdId

    StdId = request.QueryString("QsStdId")

    Set RSStdDetail = Server.CreateObject("ADODB.RecordSet") 

    RSStdDetail.Open "SELECT * FROM StudentDetail WHERE (StudentId = " & StdId & ")", conn

'Variables Declaration
    dim StdGrNum
    dim StdFirstName
    dim StdDob
    dim StdMobile
    dim StdEmail
    dim FatherName
'end

'Variables Initialization
    StdGrNum = RSStdDetail("StdGrNumber")
    StdFirstName = RSStdDetail("StdFirstName")
    StdDob = RSStdDetail("StdDateOfBirth")
    StdMobile = RSStdDetail("StdMobileNumber")
    StdEmail = RSStdDetail("StdEmailAddress")
    FatherName = RSStdDetail("FatherName")
'end

RSStdDetail.close
Set RSStdDetail = Nothing
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <div class="panel">
        <div class="panel-head">
            <div class="row">
                <div class="col">
                    Student's Detail
                </div>
            </div>
        </div>

        <div class="panel-body">
            <div class="row">
                <div class="col-2">
                    <div class="std-img">
                    </div>
                </div>

                <div class="col-10 mt-3">
                    <div class="row">
                        <div class="col-4">
                            <label for="" class="input-heading">Student GR Number</label>
                            <label for="" class="form-control label-data"><% response.Write(StdGrNum) %></label>
                        </div>

                        <div class="col-4">
                            <label for="" class="input-heading">Student First Name</label>
                            <label for="" class="form-control label-data"><% response.Write(StdFirstName) %></label>
                        </div>

                        <div class="col-4">
                            <label for="" class="input-heading">Student Father Name</label>
                            <label for="" class="form-control label-data"><% response.Write(FatherName) %></label>
                        </div>
                    </div>

                    <div class="row mt-2">
                        <div class="col-4">
                            <label for="" class="input-heading">Student Date of Birth</label>
                            <label for="" class="form-control label-data"><% response.Write(StdDob) %></label>
                        </div>

                        <div class="col-4">
                            <label for="" class="input-heading">Student Mobile Number</label>
                            <label for="" class="form-control label-data"><% response.Write(StdMobile) %></label>
                        </div>

                        <div class="col-4">
                            <label for="" class="input-heading">Student Email Address</label>
                            <label for="" class="form-control label-data"><% response.Write(StdEmail) %></label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>