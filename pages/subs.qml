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
                Utils.setTotalValueSubs()
                Database.saveSubscription(name, amount, currency)
                Utils.clearTextFields()
            }

        }

        ListViewSubs {
            id: listViewData

            model: ListModel {
                id: listModel
            }
        }

        RectangleEdit{
            id: rectangleEdit
            btnConfirm.onClicked: {
                Database.editSubscription()
                Utils.setTotalValueSubs()
            }
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
            comboBoxSumCurrency.onCurrentTextChanged: Utils.changeCurrencySubs(comboBoxSumCurrency.currentText)
        }

    }

}

