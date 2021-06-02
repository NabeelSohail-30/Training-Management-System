function MarkAbsent(Target) {
    var TargetElement = Target;
    var TSMinutes = document.getElementById("TSMinutes").value;
    TargetElement.value = TSMinutes;
}

function MarkPresent(Target) {
    var TargetElement = Target;
    TargetElement.value = 0;
}

function ValidateAttendanceDate(Target) {
    var StartDate = document.getElementById('StartDate').value;
    var EndDate = document.getElementById('EndDate').value;
    var ErrorMsg = "";
    var CurrentDate = new Date;
    var TargetError = document.getElementById('DateError');

    if (Target.value.length <= 0) {
        ErrorMsg = "Attendance Date cannot be NULL";
    } else if (Target.value > CurrentDate) {
        ErrorMsg = "Attendance Date cannot be Greater than Current Date";
    } else if (!(Target.value >= StartDate) && (Target.value <= EndDate)) {
        ErrorMsg = "Attendance Date must be between Course Date";
    }
    console.log(CurrentDate);
    TargetError.innerText = ErrorMsg;
}

function ValidateShortMin(Target) {
    var TSMinutes = document.getElementById('TSMinutes').value;
    var ErrorMsg = "";
    var TargetError = document.getElementById('ErrorMin');

    if (Target.value.length == 0) {
        ErrorMsg = "Short Minutes cannot be NULL";
    } else if (Target.value < 0) {
        ErrorMsg = "Short Minutes cannot be less than Zero";
    } else if (Target.value > TSMinutes) {
        ErrorMsg = "Short Minutes must be between Time Slot Minutes";
    }

    console.log(Target.value > TSMinutes);

    TargetError.innerText = ErrorMsg;
}