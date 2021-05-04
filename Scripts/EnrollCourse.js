function CalcActualFeeByPercent(Discount) {
    var CourseFee = document.getElementById('CourseFee').value;
    var FeeDiscount;
    var ActualFee;

    if (document.getElementById('FeeDiscount').value == "") {
        FeeDiscount = ((CourseFee * Discount.value) / 100);
        ActualFee = (CourseFee - FeeDiscount);
        document.getElementById('ActualFee').value = ActualFee;
    }
}

function CalcActualFeeByAmount(Discount) {
    var CourseFee = document.getElementById('CourseFee').value;
    var ActualFee;

    if (document.getElementById('FeeDiscountPercent').value == "") {
        ActualFee = (CourseFee - Discount.value);
        document.getElementById('ActualFee').value = ActualFee;
    }
}

function CalcBalanceFee(PaidFee) {
    var ActualFee = document.getElementById('ActualFee').value;
    var BalanceFee;

    if (document.getElementById('ActualFee').value != "") {
        BalanceFee = (ActualFee - PaidFee.value);
        document.getElementById('BalanceFee').value = BalanceFee;
    }
}