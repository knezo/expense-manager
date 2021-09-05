import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.LocalStorage 2.15
import "./components"

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

        RectangleAdd {
            id: rectangleAdd
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "lightpink"
                }

                GradientStop {
                    position: 1
                    color: "red"
                }
            }
            text1.text: qsTr("Add new subscription:")
            textAccount.placeholderText: qsTr("Subscription")
            roundButton.onClicked: {
                var name = textAccount.text
                var amount = spinboxValue.value/100
                var currency = comboBoxCurrency.displayText

                listModel.append({accountID: Date.now(),name: name, amount: amount, currency: currency, checked: true})
                setTotalValue()
                saveSubscription(name, amount, currency)
                clearTextFields()
            }

        }

        ListView {
            id: listView
            anchors {
                left: parent.left;
                right: parent.right;
                top: rectangleAdd.bottom;
                bottom: rectangleSum.top;
                bottomMargin: 0;
                topMargin: 0
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
                    anchors {
                        verticalCenter: parent.verticalCenter;
                        leftMargin: 15;
                        left: parent.left
                    }

                    Text {
                        width: parent.width*0.3
                        color: "white"
                        text: "Subscription"
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 13
                        font.bold: true

                    }

                    Text {
                        width: parent.width*0.15
                        color: "white"
                        text: "Cost"
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

                    Text {
                        width: parent.width*0.1
                        color: "white"
                        text: "      Include"
                        anchors.verticalCenter: parent.verticalCenter
                        font.bold: true
                        anchors.leftMargin: 30
                    }
                }

            }

            delegate: Item {
                id: item1
                width: listView.width
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
                    anchors {
                        verticalCenter: parent.verticalCenter;
                        leftMargin: 10;
                        left: parent.left
                    }

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
                    }

                    Text {
                        width: parent.width*0.1
                        color: "white"
                        text: currency
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    CheckBox {
                        id: checkBoxInclude
                        anchors.verticalCenter: parent.verticalCenter
                        checked: true
                        rightPadding: 30

                        onCheckStateChanged: {
                            changeChecked(index)
                            setTotalValue()
                        }

                    }

                    Button {
                        id: btnEdit
                        text: "Edit"
                        height: 25
                        display: AbstractButton.TextBesideIcon
                        anchors.verticalCenter: parent.verticalCenter
                        onClicked: {
                            openEdit(index)
                        }

                    }

                    Button {
                        id: btnDelete
                        text: "Delete"
                        height: 25
                        display: AbstractButton.TextBesideIcon
                        anchors.verticalCenter: parent.verticalCenter
                        onClicked: {
                            deleteSubscription(listModel.get(index).accountID)
                            listModel.remove(index)
                            setTotalValue()
                        }
                        anchors.leftMargin: 10

                    }

                    spacing: 10
                }
            }

            model: ListModel {
                id: listModel
            }

            Component.onCompleted: {
                getAllSubscriptions()
            }
        }

        RectangleEdit{
            id: rectangleEdit
        }

        RectangleSum {
            id: rectangleSum
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "lightpink"
                }

                GradientStop {
                    position: 1
                    color: "red"
                }
            }
            textSumLabel.text: qsTr("Total monthly cost:")
        }

    }

    function setTotalValue(){
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

    function changeCurrency(newCurrency){
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

    function getAllSubscriptions(){
        var db = LocalStorage.openDatabaseSync("AccountsDB", "1.0", "Data about accounts", 1000000)

        db.transaction(
            function(tx) {
                // Create the database if it doesn't already exist
                tx.executeSql('CREATE TABLE IF NOT EXISTS Subscriptions(id INT, name TEXT, amount TEXT, currency TEXT)');

                // Get all accounts
                var rs = tx.executeSql('SELECT * FROM Subscriptions');

                for (var i = 0; i < rs.rows.length; i++) {
                    var account = rs.rows.item(i)
                    listModel.append({accountID: parseInt(account.id), name: account.name, amount: parseFloat(account.amount), currency: account.currency, checked: true})
                }

                // update total value
                setTotalValue()
            }
         )
    }

    function saveSubscription(name, amount, currency){
        var db = LocalStorage.openDatabaseSync("AccountsDB", "1.0", "Data about accounts", 1000000)

        db.transaction(
            function(tx) {
                tx.executeSql('INSERT INTO Subscriptions VALUES(?, ?, ?, ?)', [ Date.now(), name, amount, currency ]);
            }
        )
    }

    function deleteSubscription(id){
        var db = LocalStorage.openDatabaseSync("AccountsDB", "1.0", "Data about accounts", 1000000)

        db.transaction(
            function(tx) {
                tx.executeSql('DELETE FROM Subscriptions WHERE id=?', [ id ]);
            }
        )
    }

    function openEdit(index){
        rectangleEdit.textEditIndex.text = index
        rectangleEdit.textEditID.text = listModel.get(index).accountID
        rectangleEdit.textEditName.text = listModel.get(index).name
        rectangleEdit.spinboxEditAmount.value = listModel.get(index).amount*100

        rectangleEdit.visible = true
    }

    function editAccount(){
        var index = rectangleEdit.textEditIndex.text
        var id = rectangleEdit.textEditID.text
        var newName = rectangleEdit.textEditName.text
        var newCost = rectangleEdit.spinboxEditAmount.value/100
        var newCurrency = rectangleEdit.comboBoxEditCurrency.displayText

        // update ListModel
        listModel.set(index, { name: newName, amount: parseFloat(newCost), currency: newCurrency})

        // update database
        var db = LocalStorage.openDatabaseSync("AccountsDB", "1.0", "Data about accounts", 1000000)

        db.transaction(
            function(tx) {
                tx.executeSql('UPDATE Subscriptions SET name=?, amount=?, currency=? WHERE id=?', [ newName, newCost, newCurrency, id ]);
            }
        )

        // refresh total sum
        setTotalValue()
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

    function clearTextFields(){
        rectangleAdd.textAccount.text = ""
        rectangleAdd.spinboxValue.value = 0
        rectangleAdd.comboBoxCurrency.displayText = "HRK"
    }
}







/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
