import QtQuick 2.0
import QtQuick.Controls 2.15

Component {
    id: addComponent

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
}


