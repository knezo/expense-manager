import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.LocalStorage 2.15
import "./components"
import "./js/utils.js" as Utils
import "./js/database.js" as Database

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

            roundButton.onClicked: {
                var name = textAccount.text
                var amount = spinboxValue.value/100
                var currency = comboBoxCurrency.displayText

                listModel.append({accountID: Date.now(),name: name, amount: amount, currency: currency})
                Utils.setTotalValue()
                Database.saveAccount(name, amount, currency)
                Utils.clearTextFields()
            }
        }

        ListViewAccount {
            id: listView

            model: ListModel {
                id: listModel
            }
        }

        RectangleEdit {
            id: rectangleEdit

            btnConfirm.onClicked: {
                Database.editAccount()
                Utils.setTotalValue()
            }
        }

        RectangleSum {
            id: rectangleSum
            comboBoxSumCurrency.onCurrentTextChanged: Utils.changeCurrency(comboBoxSumCurrency.currentText)
        }
    }
}

