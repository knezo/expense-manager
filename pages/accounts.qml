import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.LocalStorage 2.15

Item {
    Rectangle {
        id: bg
        color: darkgrey

        anchors {
            fill: parent;
            rightMargin: 0;
            bottomMargin: 0;
            leftMargin: 0;
            topMargin: 0
        }

        property color darkgrey: "#424242"

        Rectangle {
            id: rectangleAdd
            height: 87
            anchors {
                left: parent.left;
                top: parent.top;
                right: parent.right;
                leftMargin: 0;
                topMargin: 0;
                rightMargin: 0
            }
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#ff13d7c5"
                }

                GradientStop {
                    position: 1
                    color: "#ff039284"
                }
            }

            Rectangle {
                id: rectangleAddTitle
                height: 20
                color: "transparent"
                anchors {
                    left: parent.left;
                    top: parent.top;
                    right: parent.right;
                    leftMargin: 0;
                    topMargin: 4;
                    rightMargin: 0
                }

                Text {
                    id: text1
                    y: 46
                    text: qsTr("Add new account")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    font.pixelSize: 15
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 16
                }
            }

            Rectangle {
                id: divider
                x: 209
                width: parent.width*0.98
                height: 1
                color: bg.darkgrey
                anchors.top: rectangleAddTitle.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 2
            }

            Rectangle {
                id: rectangleAddValue
                height: 60
                color: "transparent"
                anchors {
                    left: parent.left;
                    top: divider.bottom;
                    right: parent.right;
                    leftMargin: 0;
                    topMargin: 0;
                    rightMargin: 0
                }

                TextField {
                    id: textAccount
                    width: parent.width*0.3
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    horizontalAlignment: Text.AlignLeft
                    anchors.leftMargin: 8
                    placeholderText: qsTr("Account name")
                }

                SpinBox {
                    id: spinboxValue
                    width: parent.width*0.3
                    anchors {
                        left: textAccount.right;
                        leftMargin: 16;
                        verticalCenter: parent.verticalCenter
                    }
                    editable: true
                    from: -999999999
                    to: 999999999
                    stepSize: 10000

                    property int decimals: 2

                    textFromValue: function(value, locale) {
                        return Number(value / 100).toLocaleString(locale, 'f', spinboxValue.decimals)
                    }

                    valueFromText: function(text, locale) {
                        return Number.fromLocaleString(locale, text) * 100
                    }
                }

                ComboBox {
                    id: comboBoxCurrency
                    width: parent.width*0.15
                    height: 30
                    anchors {
                        left: spinboxValue.right;
                        leftMargin: 16;
                        verticalCenter: parent.verticalCenter
                    }
                    model: ["HRK", "EUR", "GBP"]
                }

                RoundButton {
                    id: roundButton
                    height: 40
                    text: "+"
                    anchors {
                        right: parent.right;
                        rightMargin: 25;
                        verticalCenter: parent.verticalCenter
                    }
                    topPadding: 3
                    autoExclusive: false
                    display: AbstractButton.TextBesideIcon
                    font.bold: false
                    font.pointSize: 20

                    onClicked: {
                        var name = textAccount.text
                        var amount = spinboxValue.value/100
                        var currency = comboBoxCurrency.displayText

                        console.log(amount)

                        listModel.append({accountID: Date.now(),name: name, amount: amount, currency: currency})
                        setTotalValue()
                        saveAccount(name, amount, currency)
                        clearTextFields()
                    }
                }

            }
        }

        ListView {
            id: listView
            anchors {
                left: parent.left;
                right: parent.right;
                top: rectangleAdd.bottom;
                bottom: rectangleSum.top;
                leftMargin: 0;
                rightMargin: 0;
                topMargin: 0;
                bottomMargin: 0
            }
            clip: true

            header: Rectangle {
                id: header
                width: listView.width
                height: 40
                color: "transparent"

                Row {
                    id: rowHeader
                    width: parent.width
                    anchors.leftMargin: 15
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left

                    Text {
                        width: parent.width*0.3
                        color: "white"
                        text: "Account name"
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 13
                        font.bold: true

                    }

                    Text {
                        width: parent.width*0.15
                        color: "white"
                        text: "Amount"
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 13
                        font.bold: true
                    }

                    Text {
                        width: parent.width*0.1
                        color: "white"
                        text: "Currency"
                        anchors.verticalCenter: parent.verticalCenter
                        font.bold: true
                    }
                }

            }

            delegate: Item {
                id: item1
                x: 5
                width: parent.width
                height: 50

                Rectangle {
                    id: topBorder
                    width: parent.width
                    height: 1
                    color: "darkgrey"
                }

                Row {
                    id: row1
                    width: parent.width
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left


                    Text {
                        id: id
                        text: accountID
                        visible: false
                    }
                    Text {
                        width: parent.width*0.3
                        color: "white"
                        text: name
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 13
                    }

                    Text {
                        width: parent.width*0.15
                        color: "white"
                        text: amount
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 13
                        font.bold: true
                    }

                    Text {
                        width: parent.width*0.1
                        color: "white"
                        text: currency
                        anchors.verticalCenter: parent.verticalCenter
                        font.bold: true
                    }

                    Button {
                        id: btnEdit
                        text: "Edit"
                        height: 25
                        display: AbstractButton.TextBesideIcon
                        anchors.verticalCenter: parent.verticalCenter
                        onClicked: {
                            openEditAccount(index)
                        }

                    }

                    Button {
                        id: btnDelete
                        text: "Delete"
                        height: 25
                        display: AbstractButton.TextBesideIcon
                        anchors.verticalCenter: parent.verticalCenter
                        onClicked: {
                            console.log(listModel.get(index).accountID)
                            deleteAccount(listModel.get(index).accountID)
                            listModel.remove(index)
                            setTotalValue()
                        }
                    }

                    spacing: 10
                }
            }

            model: ListModel {
                id: listModel
            }

            Component.onCompleted: {
                getAllAccounts()
            }
        }

        Rectangle {
            id: rectangleEdit
            height: 70
            visible: false
            anchors {
                left: parent.left;
                right: parent.right;
                bottom: rectangleSum.top;
                leftMargin: 0;
                rightMargin: 0;
                bottomMargin: 0
            }

            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#c8c8c8"
                }

                GradientStop {
                    position: 1
                    color: "#8a8a8a"
                }
            }


            Rectangle {
                id: rectangleEditLabel
                height: 20
                color: "transparent"
                anchors {
                    left: parent.left;
                    right: parent.right;
                    top: parent.top;
                    leftMargin: 0;
                    rightMargin: 0;
                    topMargin: 0
                }

                Text {
                    id: textEditLabel
                    text: qsTr("Edit account data:")
                    anchors {
                        verticalCenter: parent.verticalCenter;
                        verticalCenterOffset: 2;
                        left: parent.left;
                        leftMargin: 8
                    }
                    font.pixelSize: 15

                }

                Button {
                    id: btnClose
                    width: 100
                    height: 20
                    text: qsTr("Close")
                    anchors {
                        verticalCenter: parent.verticalCenter;
                        right: parent.right;
                        rightMargin: 8
                    }

                    onClicked: {
                        rectangleEdit.visible = false
                    }
                }
            }

            Rectangle {
                id: rectangleEditValues
                height: 50
                color: "transparent"
                anchors {
                    left: parent.left;
                    right: parent.right;
                    top: rectangleEditLabel.bottom;
                    bottom: parent.bottom;
                    bottomMargin: 0;
                    leftMargin: 0;
                    rightMargin: 0;
                    topMargin: 0
                }

                Text {
                    id: textEditIndex
                    text: "1"
                    visible: false
                }

                Text {
                    id: textEditID
                    text: "0"
                    visible: false
                }

                TextField {
                    id: textEditName
                    width: parent.width*0.3
                    anchors {
                        verticalCenter: parent.verticalCenter;
                        left: parent.left;
                        leftMargin: 8
                    }
                    horizontalAlignment: Text.AlignLeft
                    placeholderText: qsTr("Account name")
                }

                SpinBox {
                    id: spinboxEditAmount
                    width: parent.width*0.3
                    anchors {
                        verticalCenter: parent.verticalCenter;
                        left: textEditName.right;
                        verticalCenterOffset: 0;
                        leftMargin: 16
                    }
                    editable: true
                    from: -999999999
                    to: 999999999
                    stepSize: 10000

                    property int decimals: 2

                    textFromValue: function(value, locale) {
                        return Number(value / 100).toLocaleString(locale, 'f', spinboxValue.decimals)
                    }

                    valueFromText: function(text, locale) {
                        return Number.fromLocaleString(locale, text) * 100
                    }
                }

                ComboBox {
                    id: comboBoxEditCurrency
                    width: parent.width*0.15
                    height: 30
                    anchors {
                        verticalCenter: parent.verticalCenter;
                        left: spinboxEditAmount.right;
                        leftMargin: 16
                    }
                    model: ["HRK", "EUR", "GBP"]
                }

                Button {
                    id: btnConfirm
                    text: qsTr("Confirm")
                    anchors {
                        verticalCenter: parent.verticalCenter;
                        right: parent.right;
                        rightMargin: 8
                    }
                    onClicked: {
                        editAccount()
                    }
                }
            }

        }

        Rectangle {
            id: rectangleSum
            width: parent.width
            height: 50
            anchors {
                left: parent.left;
                right: parent.right;
                bottom: parent.bottom;
                bottomMargin: 0;
                leftMargin: 0;
                rightMargin: 0
            }

            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#08d5c1"
                }

                GradientStop {
                    position: 1
                    color: "#059d8e"
                }
            }


            Text {
                id: textSumLabel
                text: qsTr("Total:")
                anchors {
                    verticalCenter: parent.verticalCenter;
                    left: parent.left;
                    leftMargin: 20
                }
                font.pixelSize: 20
            }

            Text {
                id: textSumValue
                color: "white"
                text: qsTr("Value")
                anchors {
                    verticalCenter: parent.verticalCenter;
                    right: comboBoxSumCurrency.left;
                    rightMargin: 20
                }
                font.pixelSize: 20
            }
            ComboBox {
                id: comboBoxSumCurrency
                width: parent.width*0.15
                height: 25
                anchors {
                    verticalCenter: parent.verticalCenter;
                    right: parent.right
                    rightMargin: 20
                }
                model: ["HRK", "EUR", "GBP"]

                onCurrentTextChanged: changeCurrency(currentText)

            }
        }


    }

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

    function setTotalValue(){
        var HRKSum = calculateSum()
        switch(comboBoxSumCurrency.displayText){
        case "HRK":
            textSumValue.text = HRKSum.toFixed(2)
            break
        case "EUR":
            textSumValue.text = (HRKSum/7.49).toFixed(2)
            break
        case "GBP":
            textSumValue.text = (HRKSum/8.75).toFixed(2)
            break
        }
    }

    function changeCurrency(newCurrency){
        var HRKSum = calculateSum()
        switch(newCurrency){
        case "HRK":
            textSumValue.text = HRKSum.toFixed(2)
            break
        case "EUR":
            textSumValue.text = (HRKSum/7.49).toFixed(2)
            break
        case "GBP":
            textSumValue.text = (HRKSum/8.75).toFixed(2)
            break
        }
    }

    function getAllAccounts(){
        var db = LocalStorage.openDatabaseSync("AccountsDB", "1.0", "Data about accounts", 1000000)

        db.transaction(
            function(tx) {
                // Create the database if it doesn't already exist
                tx.executeSql('CREATE TABLE IF NOT EXISTS Accounts(id INT, name TEXT, amount TEXT, currency TEXT)');

                // Get all accounts
                var rs = tx.executeSql('SELECT * FROM Accounts');

                for (var i = 0; i < rs.rows.length; i++) {
                    var account = rs.rows.item(i)
                    listModel.append({accountID: parseInt(account.id), name: account.name, amount: parseFloat(account.amount), currency: account.currency})
                }

                // update total value
                setTotalValue()
            }
         )
    }

    function saveAccount(name, amount, currency){
        var db = LocalStorage.openDatabaseSync("AccountsDB", "1.0", "Data about accounts", 1000000)

        db.transaction(
            function(tx) {
                tx.executeSql('INSERT INTO Accounts VALUES(?, ?, ?, ?)', [ Date.now(), name, amount, currency ]);
            }
        )
    }

    function deleteAccount(id){
        var db = LocalStorage.openDatabaseSync("AccountsDB", "1.0", "Data about accounts", 1000000)

        db.transaction(
            function(tx) {
                tx.executeSql('DELETE FROM Accounts WHERE id=?', [ id ]);
            }
        )
    }

    function openEditAccount(index){
        textEditIndex.text = index
        textEditID.text = listModel.get(index).accountID
        textEditName.text = listModel.get(index).name
        spinboxEditAmount.value = listModel.get(index).amount*100
        comboBoxCurrency.displayText = listModel.get(index).currency

        rectangleEdit.visible = true
    }

    function editAccount(){
        var index = textEditIndex.text
        var id = textEditID.text
        var newName = textEditName.text
        var newAmount = spinboxEditAmount.value/100
        var newCurrency = comboBoxEditCurrency.displayText

        // update ListModel
        listModel.set(index, { name: newName, amount: parseFloat(newAmount), currency: newCurrency})

        // update database
        var db = LocalStorage.openDatabaseSync("AccountsDB", "1.0", "Data about accounts", 1000000)

        db.transaction(
            function(tx) {
                tx.executeSql('UPDATE Accounts SET name=?, amount=?, currency=? WHERE id=?', [ newName, newAmount, newCurrency, id ]);
            }
        )

        // refresh total sum
        setTotalValue()
    }

    function clearTextFields(){
        textAccount.text = ""
        spinboxValue.value = 0
        comboBoxCurrency.displayText = "HRK"
    }
}







/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:34}D{i:37}D{i:30}
}
##^##*/
