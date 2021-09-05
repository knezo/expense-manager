import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.LocalStorage 2.15

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

    property Text textEditIndex: textEditIndex
    property Text textEditID: textEditID
    property TextField textEditName: textEditName
    property SpinBox spinboxEditAmount: spinboxEditAmount
    property ComboBox comboBoxEditCurrency: comboBoxEditCurrency

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

            textFromValue: function(value, locale) {
                return Number(value / 100).toLocaleString(locale, 'f', 2)
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
