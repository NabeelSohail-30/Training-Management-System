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


function NICValidate(TargetElement) {
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
        ErrorNIC = 'Lat Character is not a Number, NIC cannot contain Non Numeric Character';
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
    document.getElementById("NIC").innerText = ErrorNIC;
}

function FirstNameValidate(TargetElement) {
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
    document.getElementById("FirstNameError").innerText = ErrorFirstName;
}

function MidNameValidate(TargetElement) {
    //window.alert(89);
    var TargetValue = TargetElement.value;
    var ErrorMidName = "";

    if (TargetValue.length > 15) {
        ErrorMidName = 'Maximum Length for Mid Name is 15 characters';
    } else if (IsAlphabet(TargetValue) == true) {
        ErrorMidName = 'Invalid Character Found in Mid Name';
    }
    //window.alert(ErrorMidName);
    document.getElementById("MidNameError").innerText = ErrorMidName;
}

function LastNameValidate(TargetElement) {
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
    document.getElementById("LastNameError").innerText = ErrorLastName;
}

function ValidateDob(TargetElement) {
    var TargetValue = TargetElement.value;
    var ErrorDateOfBirth = "";

    if (IsNull(TargetValue)) {
        ErrorDateOfBirth = 'Date of Birth cannot be left NULL';
    }

    document.getElementById("DateError").innerText = ErrorDateOfBirth;
}

function ValidateNationality(TargetElement) {
    var TargetValue = TargetElement.value;
    var ErrorNationality = "";

    if (TargetValue == -1) {
        ErrorNationality = 'No Nationality Selected';
    }

    document.getElementById("NationalityError").innerText = ErrorNationality;
}