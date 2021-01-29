var ErrorNIC = "";

function NICVal(TargetElement) {
    var TargetValue = TargetElement.value;

    //window.alert(TargetValue.substr(6, 1));
    //window.alert(TargetValue.substr(13, 1));

    if (TargetValue.length < 15 || TargetValue.length > 15) {
        ErrorNIC = 'NIC length must be 15';
    }
    /*else if (TargetValue.substr(5, 1) != '-' || TargetValue.substr(13, 1) != '-') {
               ErrorNIC = 'Invalid NIC Format';
           }*/
    else if (isNaN(TargetValue.substr(14, 1)) != false) {
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
}