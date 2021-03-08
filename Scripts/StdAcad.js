var IsValidationPassed = true;

function ValidateYearPassed(TargetElement, TargetError) {
    var TargetValue = TargetElement.value;
    var ErrorYear = "";

    if (IsNull(TargetValue)) {
        ErrorYear = 'Field Text cannot be NULL';
    } else if (IsNumber(TargetValue) == true) {
        ErrorYear = 'Invalid Character Found';
    }

    if (ErrorYear != "") {
        IsValidationPassed = false;
        TargetElement.classList.add("error-border");
        TargetError.innerText = ErrorYear;
    } else {
        IsValidationPassed = true;
        TargetElement.classList.remove("error-border");
        TargetError.innerText = ErrorYear;
    }
}