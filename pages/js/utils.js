function clearTextFields(){
    rectangleAdd.textAccount.text = ""
    rectangleAdd.spinboxValue.value = 0
    rectangleAdd.comboBoxCurrency.displayText = "HRK"
}

function openEdit(index){
    rectangleEdit.textEditIndex.text = index
    rectangleEdit.textEditID.text = listModel.get(index).accountID
    rectangleEdit.textEditName.text = listModel.get(index).name
    rectangleEdit.spinboxEditAmount.value = listModel.get(index).amount*100

    rectangleEdit.visible = true
}


// Subscriptions

function setTotalValueSubs(){
    var HRKSum = sumCheckedSubscriptions()
    switch(rectangleSum.comboBoxSumCurrency.displayText){
    case "HRK":
        rectangleSum.textSumValue.text = HRKSum.toFixed(2)
        break
    case "EUR":
        rectangleSum.textSumValue.text = (HRKSum/7.49).toFixed(2)
        break
    case "GBP":
        rectangleSum.textSumValue.text = (HRKSum/8.75).toFixed(2)
        break
    }
}

function changeChecked(index){
    listModel.get(index).checked = !listModel.get(index).checked
}

function sumCheckedSubscriptions(){
    var HRKSum = 0
    for (var i = 0; i < listModel.rowCount(); i ++) {
        var rowElement = listModel.get(i)

        if(rowElement.checked){
            if (rowElement.currency === "EUR"){
                HRKSum += rowElement.amount * 7.49
            } else if (rowElement.currency === "GBP"){
                HRKSum += rowElement.amount * 8.75
            } else {
                HRKSum += rowElement.amount
            }
        }
    }

    return HRKSum
}

function changeCurrencySubs(newCurrency){
    var HRKSum = sumCheckedSubscriptions()
    switch(newCurrency){
    case "HRK":
        rectangleSum.textSumValue.text = HRKSum.toFixed(2)
        break
    case "EUR":
        rectangleSum.textSumValue.text = (HRKSum/7.49).toFixed(2)
        break
    case "GBP":
        rectangleSum.textSumValue.text = (HRKSum/8.75).toFixed(2)
        break
    }
}


// Accounts

function calculateSum(){
    var HRKSum = 0
    for (var i = 0; i < listModel.rowCount(); i ++) {
        var rowElement = listModel.get(i)

        if (rowElement.currency === "EUR"){
            HRKSum += rowElement.amount * 7.49
        } else if (rowElement.currency === "GBP"){
            HRKSum += rowElement.amount * 8.75
        } else {
            HRKSum += rowElement.amount
        }
    }

    return HRKSum
}

function changeCurrency(newCurrency){
    var HRKSum = calculateSum()
    switch(newCurrency){
    case "HRK":
        rectangleSum.textSumValue.text = HRKSum.toFixed(2)
        break
    case "EUR":
        rectangleSum.textSumValue.text = (HRKSum/7.49).toFixed(2)
        break
    case "GBP":
        rectangleSum.textSumValue.text = (HRKSum/8.75).toFixed(2)
        break
    }
}

function setTotalValue(){
    var HRKSum = calculateSum()
    switch(rectangleSum.comboBoxSumCurrency.displayText){
    case "HRK":
        rectangleSum.textSumValue.text = HRKSum.toFixed(2)
        break
    case "EUR":
        rectangleSum.textSumValue.text = (HRKSum/7.49).toFixed(2)
        break
    case "GBP":
        rectangleSum.textSumValue.text = (HRKSum/8.75).toFixed(2)
        break
    }
}







