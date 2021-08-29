import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.LocalStorage 2.15

Item {
    Rectangle {
        id: bg
        color: "#424242"
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        Rectangle {
            id: rectangleAdd
            height: 87
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
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
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.topMargin: 0

            Rectangle {
                id: rectangleAddTitle
                height: 20
                color: "#00000000"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.leftMargin: 0
                anchors.topMargin: 4
                anchors.rightMargin: 0

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
                color: "#424242"
                anchors.top: rectangleAddTitle.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 2
            }

            Rectangle {
                id: rectangleAddValue
                height: 60
                color: "#00000000"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: divider.bottom
                anchors.topMargin: 0
                anchors.rightMargin: 0
                anchors.leftMargin: 0

                TextField {
                    id: textAccount
                    x: 8
                    y: 10
                    width: parent.width*0.3
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    horizontalAlignment: Text.AlignLeft
                    anchors.leftMargin: 8
                    placeholderText: qsTr("Account name")
                }

                TextField {
                    id: textValue
                    x: 216
                    y: 10
                    width: parent.width*0.3
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: textAccount.right
                    anchors.leftMargin: 16
                    placeholderText: qsTr("Amount")
                    inputMethodHints: Qt.ImhHiddenText
                }

                ComboBox {
                    id: comboBoxCurrency
                    x: 424
                    y: 17
                    width: parent.width*0.15
                    height: 30
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: textValue.right
                    anchors.leftMargin: 16
                    model: ["hrk", "eur", "gbp"]
                }

                RoundButton {
                    id: roundButton
                    x: 575
                    y: 10
                    height: 40
                    text: "+"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    topPadding: 3
                    autoExclusive: false
                    display: AbstractButton.TextBesideIcon
                    font.bold: false
                    font.pointSize: 20
                    anchors.rightMargin: 25

                    onClicked: {
                        var name = textAccount.text
                        var amount = Math.round(parseFloat(textValue.text)*100)/100
                        var currency = comboBoxCurrency.displayText

                        if(isNaN(amount)){
                            return
                        }

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
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: rectangleAdd.bottom
            anchors.bottom: rectangleSum.top
            anchors.bottomMargin: 0
            clip: true
            anchors.topMargin: 0

            header: Rectangle {
                id: header
                width: listView.width
                height: 40
                color: "#00000000"

                Row {
                    id: rowHeader
                    width: parent.width
                    anchors.leftMargin: 15
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left

                    Text {
                        width: parent.width*0.3
                        color: "#ffffff"
                        text: "Account name"
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 13
                        font.bold: true

                    }

                    Text {
                        width: parent.width*0.15
                        color: "#ffffff"
                        text: "Amount"
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 13
                        font.bold: true
                    }

                    Text {
                        width: parent.width*0.1
                        color: "#ffffff"
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
                    color: "#c8c8c8"
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
                        color: "#ffffff"
                        text: name
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 13
                    }

                    Text {
                        width: parent.width*0.15
                        color: "#ffffff"
                        text: amount
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 13
                        font.bold: true
                    }

                    Text {
                        width: parent.width*0.1
                        color: "#ffffff"
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
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: rectangleSum.top
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
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 0

            Rectangle {
                id: rectangleEditLabel
                height: 20
                color: "#00000000"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.rightMargin: 0
                anchors.leftMargin: 0

                Text {
                    id: textEditLabel
                    text: qsTr("Edit account data:")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    font.pixelSize: 15
                    anchors.verticalCenterOffset: 2
                    anchors.leftMargin: 8
                }

                Button {
                    id: btnClose
                    width: 100
                    height: 20
                    text: qsTr("Close")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 8
                    onClicked: {
                        rectangleEdit.visible = false
                    }
                }
            }

            Rectangle {
                id: rectangleEditValues
                height: 50
                color: "#00000000"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: rectangleEditLabel.bottom
                anchors.bottom: parent.bottom
                anchors.topMargin: 0

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
                    x: 8
                    y: 5
                    width: parent.width*0.3
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    horizontalAlignment: Text.AlignLeft
                    anchors.leftMargin: 8
                    placeholderText: qsTr("Account name")
                }

                TextField {
                    id: textEditAmount
                    x: 216
                    y: 5
                    width: parent.width*0.3
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: textEditName.right
                    anchors.verticalCenterOffset: 0
                    anchors.leftMargin: 16
                    placeholderText: qsTr("Amount")
                    inputMethodHints: Qt.ImhHiddenText
                }

                ComboBox {
                    id: comboBoxEditCurrency
                    x: 424
                    y: 12
                    width: parent.width*0.15
                    height: 30
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: textEditAmount.right
                    anchors.leftMargin: 16
                    model: ["hrk", "eur", "gbp"]
                }

                Button {
                    id: btnConfirm
                    text: qsTr("Confirm")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 8
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
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
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
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.bottomMargin: 0


            Text {
                id: textSumLabel
                text: qsTr("Total:")
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                font.pixelSize: 20
                anchors.leftMargin: 20
            }

            Text {
                id: textSumValue
                color: "#ffffff"
                text: qsTr("Value")
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: comboBoxSumCurrency.left
                font.pixelSize: 20
                anchors.rightMargin: 20
            }
            ComboBox {
                id: comboBoxSumCurrency
                x: 424
                y: 17
                width: parent.width*0.15
                height: 25
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 20
                model: ["hrk", "eur", "gbp"]

                onCurrentTextChanged: changeCurrency(currentText)

            }
        }


    }

    Connections{
        target: backend

    }

    function calculateSum(){
        var hrkSum = 0
        for (var i = 0; i < listModel.rowCount(); i ++) {
            var rowElement = listModel.get(i)

            if (rowElement.currency === "eur"){
                hrkSum += rowElement.amount * 7.49
            } else if (rowElement.currency === "gbp"){
                hrkSum += rowElement.amount * 8.75
            } else {
                hrkSum += rowElement.amount
            }
        }

        return hrkSum
    }

    function setTotalValue(){
        var hrkSum = calculateSum()
        switch(comboBoxSumCurrency.displayText){
        case "hrk":
            textSumValue.text = hrkSum.toFixed(2)
            break
        case "eur":
            textSumValue.text = (hrkSum/7.49).toFixed(2)
            break
        case "gbp":
            textSumValue.text = (hrkSum/8.75).toFixed(2)
            break
        }
    }

    function changeCurrency(newCurrency){
        var hrkSum = calculateSum()
        switch(newCurrency){
        case "hrk":
            textSumValue.text = hrkSum.toFixed(2)
            break
        case "eur":
            textSumValue.text = (hrkSum/7.49).toFixed(2)
            break
        case "gbp":
            textSumValue.text = (hrkSum/8.75).toFixed(2)
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
        textEditAmount.text = listModel.get(index).amount
        comboBoxCurrency.displayText = listModel.get(index).currency

        rectangleEdit.visible = true
    }

    function editAccount(){
        var index = textEditIndex.text
        var id = textEditID.text
        var newName = textEditName.text
        var newAmount = textEditAmount.text
        var newCurrency = comboBoxEditCurrency.displayText

        if(isNaN(newAmount)){
            return
        }

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
        textValue.text = ""
        comboBoxCurrency.displayText = "hrk"
    }
}







/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:34}D{i:37}D{i:30}
}
##^##*/
