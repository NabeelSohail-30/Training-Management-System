var IsValidationPassed = true;

function IsNull(TargetElement) {
    if (TargetElement == "" || TargetElement.length == 0 || TargetElement == undefined) {
        return true;
    } else {
        return false;
    }
}

function IsAlphabet(string) {
    var ErrorFound = false;
    for (var i = 0; i < string.length; i++) {
        if (string.charCodeAt(i) >= 65 && string.charCodeAt(i) <= 90) {
            ErrorFound = false;
        } else if (string.charCodeAt(i) >= 97 && string.charCodeAt(i) <= 122) {
            ErrorFound = false;
        } else {
            ErrorFound = true;
            break;
        }
    }

    if (ErrorFound == true) {
        return true;
    } else {
        return false;
    }
}

function IsNumber(string) {
    var ErrorFound = false;
    for (var i = 0; i < string.length; i++) {
        if (isNaN(string.charAt(i)) == true) {
            ErrorFound = true;
            break;
        }
    }

    return ErrorFound;
}


function NICValidate(TargetElement, TargetError) {
    var TargetValue = TargetElement.value;
    var ErrorNIC = "";

    //window.alert(TargetValue.substr(6, 1));
    //window.alert(TargetValue.substr(13, 1));

    if (IsNull(TargetValue)) {
        ErrorNIC = 'NIC Number cannot be NULL';
    } else if (TargetValue.length < 15 || TargetValue.length > 15) {
        ErrorNIC = 'NIC length must be 15';
    } else if (TargetValue.substr(6, 1) != '-' || TargetValue.substr(13, 1) != '-') {
        ErrorNIC = 'Invalid NIC Format';
    } else if (isNaN(TargetValue.substr(14, 1)) != false) {
        ErrorNIC = 'Last Character is not a Number, NIC cannot contain Non Numeric Character';
    } else {
        for (var i = 0; i < 6; i++) {
            if (isNaN(TargetValue.charAt(i))) {
                ErrorNIC = 'NIC cannot contain Non Numeric Character';
                //window.alert(TargetValue.charAt(i));
                break;
            }
        }

        for (var i = 7; i < 13; i++) {
            if (isNaN(TargetValue.charAt(i))) {
                ErrorNIC = 'NIC cannot contain Non Numeric Character';
                //window.alert(TargetValue.charAt(i));
                break;
            }
        }
    }
    //window.alert(ErrorNIC);
    if (ErrorNIC != "") {
        IsValidationPassed = false;
        TargetElement.style.borderColor = 'red';
        TargetError.innerText = ErrorNIC;
    }

}

function FirstNameValidate(TargetElement, TargetError) {
    //window.alert(89);
    var TargetValue = TargetElement.value;
    var ErrorFirstName = "";

    if (IsNull(TargetValue)) {
        ErrorFirstName = 'First Name cannot be NULL';
    } else if (TargetValue.length > 15) {
        ErrorFirstName = 'Maximum Length for First Name is 15 characters';
    } else if (IsAlphabet(TargetValue) == true) {
        ErrorFirstName = 'Invalid Character Found in First Name';
    }
    //window.alert(ErrorName);
    if (ErrorFirstName != "") {
        IsValidationPassed = false;
        TargetElement.style.borderColor = 'red';
        TargetError.innerText = ErrorFirstName;
    }

}

function MidNameValidate(TargetElement, TargetError) {
    //window.alert(89);
    var TargetValue = TargetElement.value;
    var ErrorMidName = "";

    if (TargetValue.length > 15) {
        ErrorMidName = 'Maximum Length for Mid Name is 15 characters';
    } else if (IsAlphabet(TargetValue) == true) {
        ErrorMidName = 'Invalid Character Found in Mid Name';
    }
    //window.alert(ErrorMidName);
    if (ErrorMidName != "") {
        IsValidationPassed = false;
        TargetElement.style.borderColor = 'red';
        TargetError.innerText = ErrorMidName;
    }
}

function LastNameValidate(TargetElement, TargetError) {
    //window.alert(89);
    var TargetValue = TargetElement.value;
    var ErrorLastName = "";

    if (IsNull(TargetValue)) {
        ErrorLastName = 'Last Name cannot be NULL';
    } else if (TargetValue.length > 15) {
        ErrorLastName = 'Maximum Length for Last Name is 15 characters';
    } else if (IsAlphabet(TargetValue) == true) {
        ErrorLastName = 'Invalid Character Found in Last Name';
    }
    //window.alert(ErrorLastName);
    if (ErrorLastName != "") {
        IsValidationPassed = false;
        TargetElement.style.borderColor = 'red';
        TargetError.innerText = ErrorLastName;
    }
}

function ValidateDob(TargetElement) {
    var TargetValue = TargetElement.value;
    var ErrorDateOfBirth = "";

    if (IsNull(TargetValue)) {
        ErrorDateOfBirth = 'Date of Birth cannot be left NULL';
    }

    if (ErrorDateOfBirth != "") {
        IsValidationPassed = false;
        TargetElement.style.borderColor = 'red';
        document.getElementById("DateError").innerText = ErrorDateOfBirth;
    }
}

function ValidateNationality(TargetElement) {
    var TargetValue = TargetElement.value;
    var ErrorNationality = "";

    if (TargetValue == -1) {
        ErrorNationality = 'No Nationality Selected';
    }

    if (ErrorNationality != "") {
        IsValidationPassed = false;
        TargetElement.style.borderColor = 'red';
        document.getElementById("NationalityError").innerText = ErrorNationality;
    }
}

function ValidatePOB(TargetElement) {
    var TargetValue = TargetElement.value;
    var ErrorPob = "";

    if (IsNull(TargetValue)) {
        ErrorPob = 'Place of Birth cannot be NULL';
    } else if (TargetValue.length > 25) {
        ErrorPob = 'Maximum Length for Place of Birth is 25 characters';
    } else if (IsAlphabet(TargetValue) == true) {
        ErrorPob = 'Invalid Character Found in Place of Birth';
    }
    //window.alert(ErrorLastName);
    if (ErrorPob != "") {
        IsValidationPassed = false;
        TargetElement.style.borderColor = 'red';
        document.getElementById("PobError").innerText = ErrorPob;
    }
}

function ValidateReligion(TargetElement) {
    var TargetValue = TargetElement.value;
    var ErrorReligion = "";

    if (TargetValue == -1) {
        ErrorReligion = 'No Religion Selected';
    }

    if (ErrorReligion != "") {
        IsValidationPassed = false;
        TargetElement.style.borderColor = 'red';
        document.getElementById("ReligionError").innerText = ErrorReligion;
    }
}

function ValidateGender(TargetElement) {
    var TargetValue = TargetElement.value;
    var ErrorGender = "";

    if (TargetValue == -1) {
        ErrorGender = 'No Gender Selected';
    }

    if (ErrorGender != "") {
        IsValidationPassed = false;
        TargetElement.style.borderColor = 'red';
        document.getElementById("GenderError").innerText = ErrorGender;
    }
}

function ValidateMaritalSt(TargetElement) {
    var TargetValue = TargetElement.value;
    var ErrorMaritalSt = "";

    if (TargetValue == -1) {
        ErrorMaritalSt = 'No Marital Status Selected';
    }

    if (ErrorMaritalSt != "") {
        IsValidationPassed = false;
        TargetElement.style.borderColor = 'red';
        document.getElementById("MaritalStError").innerText = ErrorMaritalSt;
    }
}

function ValidateMobileNumber(TargetElement, TargetError) {
    var TargetValue = TargetElement.value;
    var ErrorMobNum = "";

    if (IsNull(TargetValue)) {
        ErrorMobNum = 'Mobile Number cannot be left NULL';
    } else if (TargetValue.length > 20) {
        ErrorMobNum = 'Max Length for Mobile Number is 20';
    } else if (IsNumber(TargetValue) == true) {
        ErrorMobNum = 'Invalid Character Found in Mobile Number';
    }

    if (ErrorMobNum != "") {
        IsValidationPassed = false;
        TargetElement.style.borderColor = 'red';
        TargetError.innerText = ErrorMobNum;
    }
}

function ValidateEmail(TargetElement, TargetError) {
    var TargetValue = TargetElement.value;
    var ErrorEmail = "";

    if (IsNull(TargetValue)) {
        ErrorEmail = 'Email cannot be left NULL';
    } else if (TargetValue.length > 30) {
        ErrorEmail = 'Max Length for Email is 30';
    }

    if (ErrorEmail != "") {
        IsValidationPassed = false;
        TargetElement.style.borderColor = 'red';
        TargetError.innerText = ErrorEmail;
    }
}

function ValidateHomeTelephone(TargetElement) {
    var TargetValue = TargetElement.value;
    var ErrorHomeTel = "";

    if (IsNull(TargetValue)) {
        ErrorHomeTel = 'Home Telephone Number cannot be left NULL';
    } else if (TargetValue.length > 20) {
        ErrorHomeTel = 'Max Length for Home Telephone Number is 20';
    } else if (IsNumber(TargetValue) == true) {
        ErrorHomeTel = 'Invalid Character Found in Home Telephone Number';
    }

    if (ErrorHomeTel != "") {
        IsValidationPassed = false;
        TargetElement.style.borderColor = 'red';
        document.getElementById("HomePhoneError").innerText = ErrorHomeTel;
    }
}

function ValidateCompanyName(TargetElement, TargetError) {
    var TargetValue = TargetElement.value;
    var ErrorCompanyName = "";

    if (TargetValue.length > 50) {
        ErrorCompanyName = 'Max Length for Company Name is 20';
    }

    if (ErrorCompanyName != "") {
        IsValidationPassed = false;
        TargetElement.style.borderColor = 'red';
        TargetError.innerText = ErrorCompanyName;
    }
}

function ValidateWorkPhone(TargetElement, TargetError) {
    var TargetValue = TargetElement.value;
    var ErrorWorkPhone = "";


    if (TargetValue.length > 20) {
        ErrorWorkPhone = 'Max Length for Work Phone Number is 20';
    } else if (IsNumber(TargetValue) == true) {
        ErrorWorkPhone = 'Invalid Character Found in Work Phone Number';
    }

    if (ErrorWorkPhone != "") {
        IsValidationPassed = false;
        TargetElement.style.borderColor = 'red';
        TargetError.innerText = ErrorWorkPhone;
    }
}

function FatherNameValidate(TargetElement) {
    //window.alert(89);
    var TargetValue = TargetElement.value;
    var FatherFirstName = "";

    if (IsNull(TargetValue)) {
        FatherFirstName = 'First Name cannot be NULL';
    } else if (TargetValue.length > 15) {
        FatherFirstName = 'Maximum Length for First Name is 15 characters';
    } else if (IsAlphabet(TargetValue) == true) {
        FatherFirstName = 'Invalid Character Found in First Name';
    }
    //window.alert(ErrorName);
    if (FatherFirstName != "") {
        IsValidationPassed = false;
        TargetElement.style.borderColor = 'red';
        document.getElementById("FatherNameError").innerText = FatherFirstName;
    }

}

function FormSubmit() {
    /*
    if (IsValidationPassed == true) {
        return true;
    } else {
        return false;
    }*/
    //Method 1
    //Above condition can be achieved using the following statement 
    return IsValidationPassed;
}