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
        } else if (string.charCodeAt(i) == 32) {
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

function StringValidate(TargetElement, TargetError, TargetLength) {
    //window.alert('event called');
    var TargetValue = TargetElement.value;
    var ErrorString = "";

    if (IsNull(TargetValue)) {
        ErrorString = 'Field Text cannot be NULL';
    } else if (TargetValue.length > TargetLength) {
        ErrorString = 'Maximum Length is ' + TargetLength;
    } else if (IsAlphabet(TargetValue) == true) {
        ErrorString = 'Invalid Character Found. Only Alphabets and Spaces are allowed';
    }
    //window.alert(ErrorName);
    if (ErrorString != "") {
        IsValidationPassed = false;
        TargetElement.classList.add("error-border");
        //document.getElementById("Institute").classList.add("error-border");
        TargetError.innerText = ErrorString;
    } else {
        IsValidationPassed = true;
        TargetElement.classList.remove("error-border");
        TargetError.innerText = ErrorString;
    }

}

function StringNullValidate(TargetElement, TargetError, TargetLength) {
    //window.alert(89);
    var TargetValue = TargetElement.value;
    var ErrorString = "";

    if (TargetValue.length > TargetLength) {
        ErrorString = 'Maximum Length is ' + TargetLength;
    } else if (IsAlphabet(TargetValue) == true) {
        ErrorString = 'Invalid Character Found';
    }
    //window.alert(ErrorMidName);
    if (ErrorString != "") {
        IsValidationPassed = false;
        TargetElement.classList.add("error-border");
        TargetError.innerText = ErrorString;
    } else {
        IsValidationPassed = true;
        TargetElement.classList.remove("error-border");
        TargetError.innerText = ErrorString;
    }
}

//Date cannot be greater than or equal to current date
function ValidateDate(TargetElement, TargetError) {
    var TargetValue = TargetElement.value;
    var ErrorDate = "";

    if (IsNull(TargetValue)) {
        ErrorDate = 'Date cannot be NULL';
    }

    if (ErrorDate != "") {
        IsValidationPassed = false;
        TargetElement.classList.add("error-border");
        TargetError.innerText = ErrorDate;
    } else {
        IsValidationPassed = true;
        TargetElement.classList.remove("error-border");
        TargetError.innerText = ErrorDate;
    }
}

function DropDownValidate(TargetElement, TargetError) {
    var TargetValue = TargetElement.value;
    var ErrorDropDown = "";

    if (TargetValue == -1) {
        ErrorDropDown = 'Invalid Option Selected';
    }

    if (ErrorDropDown != "") {
        IsValidationPassed = false;
        TargetElement.classList.add("error-border");
        TargetError.innerText = ErrorDropDown;
    } else {
        IsValidationPassed = true;
        TargetElement.classList.remove("error-border");
        TargetError.innerText = ErrorDropDown;
    }
}

function PhoneNumberValidate(TargetElement, TargetError, TargetLength) {
    var TargetValue = TargetElement.value;
    var ErrorMobNum = "";

    if (IsNull(TargetValue)) {
        ErrorMobNum = 'Field Text cannot be NULL';
    } else if (TargetValue.length > TargetLength) {
        ErrorMobNum = 'Max Length is ' + TargetLength;
    } else if (IsNumber(TargetValue) == true) {
        ErrorMobNum = 'Invalid Character Found';
    }

    if (ErrorMobNum != "") {
        IsValidationPassed = false;
        TargetElement.classList.add("error-border");
        TargetError.innerText = ErrorMobNum;
    } else {
        IsValidationPassed = true;
        TargetElement.classList.remove("error-border");
        TargetError.innerText = ErrorMobNum;
    }
}