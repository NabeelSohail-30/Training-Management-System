<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <title>Add New Student Profile</title>
    <style>
        * {
            margin: 0px;
            padding: 0px;
            text-decoration: none;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: lightgray;
        }

        .wrapper {
            width: 50%;
            height: max-content;
            background-color: whitesmoke;
            color: black;
            margin: 24px auto;
        }

        .std-img {
            width: 180px;
            height: 180px;
            background-color: white;
            border: 1px solid black;
            margin-left: 720px;
            margin-top: 10px;
        }

        .heading {
            font-size: 26px;
            font-weight: 600;
        }

        .input-heading {
            font-size: 16px;
            font-weight: 500;
        }

        .radio-btn {
            margin-right: 8px;
        }

        .add-btn {
            width: 30%;
            margin-bottom: 20px;
            border: none;
            outline: none;
            background-color: rgb(0, 0, 194);
            color: white;
            font-size: 18px;
            border-radius: 18px;
            font-weight: 600;
            margin-top: 10px;
            padding: 10px;
        }

        .add-btn:hover {
            transition: ease-in-out;
            background-color: lightgray;
            color: black;
            cursor: pointer;
        }
    </style>
</head>

<body>
    <header>
        <!--#include file=Header.asp-->
    </header>

    <div class="wrapper">
        <div class="container">
            <form action="#" method="POST">

                <div class="row">
                    <div class="col text-center mt-2">
                        <label for="" class="heading">Student's Details</label>
                    </div>
                </div>

                <div class="row">
                    <div class="col">
                        <div class="std-img">
                            <img src="" alt="">
                        </div>
                    </div>
                </div>

                <div class="row mt-3">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student GR Number</label>
                            <br>
                            <input type="text" class="form-control">
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student NIC Number</label>
                            <br>
                            <input type="text" class="form-control">
                        </div>
                    </div>
                </div>

                <br>

                <div class="row">
                    <div class="col-4">
                        <div class="form-group">
                            <label for="" class="input-heading">Student First Name</label>
                            <br>
                            <input type="text" class="form-control">
                        </div>
                    </div>

                    <div class="col-4">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Middle Name</label>
                            <br>
                            <input type="text" class="form-control">
                        </div>
                    </div>

                    <div class="col-4">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Last Name</label>
                            <br>
                            <input type="text" class="form-control">
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Date of Birth</label>
                            <br>
                            <input type="date" class="form-control">
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Nationality</label>
                            <br>
                            <select name="" id="" class="form-control">
                                <option value="">Select Nationality</option>
                                <option value="">Pakistani</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Place of Birth</label>
                            <br>
                            <input type="text" class="form-control">
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Religion</label>
                            <br>
                            <select name="" id="" class="form-control">
                                <option value="">Select Religion</option>
                                <option value="">Islam</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="mr-2 input-heading">Student Gender</label>
                            <br>
                            <input type="radio" name="gender">
                            <label for="" class="radio-btn">Male</label>
                            <input type="radio" name="gender">
                            <label for="" class="radio-btn">Female</label>
                            <input type="radio" name="gender">
                            <label for="" class="radio-btn">Other</label>
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="mr-2 input-heading">Student Marital Status</label>
                            <br>
                            <input type="radio" name="MaritalStatus">
                            <label for="" class="radio-btn">Married</label>
                            <input type="radio" name="MaritalStatus">
                            <label for="" class="radio-btn">Single</label>
                            <input type="radio" name="MaritalStatus">
                            <label for="" class="radio-btn">Divorced</label>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-4">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Mobile Number</label>
                            <br>
                            <input type="text" class="form-control">
                        </div>
                    </div>

                    <div class="col-5">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Email Address</label>
                            <br>
                            <input type="email" class="form-control">
                        </div>
                    </div>

                    <div class="col-3">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Home Telephone</label>
                            <br>
                            <input type="text" class="form-control">
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Occupation</label>
                            <br>
                            <select name="" id="" class="form-control">
                                <option value="">Select Occupation</option>
                                <option value="">Computer Engineer</option>
                            </select>
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Job Designation</label>
                            <br>
                            <select name="" id="" class="form-control">
                                <option value="">Select Job Designation</option>
                                <option value="">General Manager</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Company Name</label>
                            <br>
                            <input type="text" class="form-control">
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Work Telephone</label>
                            <br>
                            <input type="text" class="form-control">
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col">
                        <hr>
                    </div>
                </div>

                <div class="row">
                    <div class="col text-center mb-4">
                        <label for="" class="heading">Student's Father Details</label>
                    </div>
                </div>

                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Student Father Name</label>
                            <br>
                            <input type="text" class="form-control">
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Father NIC Number</label>
                            <br>
                            <input type="text" class="form-control">
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Father Mobile Number</label>
                            <br>
                            <input type="text" class="form-control">
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Father Email Address</label>
                            <br>
                            <input type="email" class="form-control">
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Father Occupation</label>
                            <br>
                            <select name="" id="" class="form-control">
                                <option value="">Select Occupation</option>
                                <option value="">Computer Engineer</option>
                            </select>
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Father Job Designation</label>
                            <br>
                            <select name="" id="" class="form-control">
                                <option value="">Select Job Designation</option>
                                <option value="">General Manager</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Company Name</label>
                            <br>
                            <input type="text" class="form-control">
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="form-group">
                            <label for="" class="input-heading">Father Work Telephone</label>
                            <br>
                            <input type="text" class="form-control">
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col">
                        <div class="form-group d-flex justify-content-center">
                            <input type="submit" value="Add New Student Profile" class="add-btn">
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>

</html>