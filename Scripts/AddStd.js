var ErrorNIC = "";

function NICVal(TargetElement) {
    var TargetValue = TargetElement.value;

    if (TargetValue.length < 15 || TargetValue.length > 15) {
        ErrorNIC = 'NIC length must be 15';
    } else if (TargetValue.subStr(5, 1) == '-' || TargetValue.subStr(13, 1) == '-') {
        ErrorNIC = 'Invalid NIC Format';
    } else if (isNaN(TargetValue.subStr(14, 1))) {
        ErrorNIC = 'NIC cannot contain Non Numeric Character';
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

    window.alert(ErrorNIC);
}

