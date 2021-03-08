var IsValidationPassed = true;

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
        TargetElement.classList.add("error-border");
        TargetError.innerText = ErrorNIC;
    }
    else
    {
        IsValidationPassed = true;
        TargetElement.classList.remove("error-border");
        TargetError.innerText = ErrorNIC;
    }

}

function ValidateEmail(TargetElement, TargetError) {
    var TargetValue = TargetElement.value;
    var ErrorEmail = "";

    if (IsNull(TargetValue)) {
        ErrorEmail = 'Email cannot be left NULL';
    } else if (TargetValue.length > 50) {
        ErrorEmail = 'Max Length for Email is 50';
    }

    if (ErrorEmail != "") {
        IsValidationPassed = false;
        TargetElement.classList.add("error-border");
        TargetError.innerText = ErrorEmail;
    }
    else
    {
        IsValidationPassed = true;
        TargetElement.classList.remove("error-border");
        TargetError.innerText = ErrorEmail;
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
        TargetElement.classList.add("error-border");
        TargetError.innerText = ErrorWorkPhone;
    }
    else
    {
        IsValidationPassed = true;
        TargetElement.classList.remove("error-border");
        TargetError.innerText = ErrorWorkPhone;
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