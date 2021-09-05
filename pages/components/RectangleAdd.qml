import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.LocalStorage 2.15

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

    property color darkgrey: "#424242"

    property SpinBox spinboxValue: spinboxValue
    property ComboBox comboBoxCurrency: comboBoxCurrency

    property alias text1: text1
    property alias textAccount: textAccount
    property alias roundButton: roundButton

    gradient: Gradient {
        GradientStop {
            position: 0
            color: "mediumturquoise"
        }

        GradientStop {
            position: 1
            color: "mediumseagreen"
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
            text: qsTr("Add new account")
            anchors {
                verticalCenter: parent.verticalCenter;
                left: parent.left;
                leftMargin: 16
            }
            font.pixelSize: 15
            verticalAlignment: Text.AlignVCenter
        }
    }

    Rectangle {
        id: divider
        width: parent.width*0.98
        height: 1
        color: rectangleAdd.darkgrey
        anchors {
            horizontalCenter: parent.horizontalCenter;
            top: rectangleAddTitle.bottom;
            topMargin: 2
        }
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
            anchors {
                verticalCenter: parent.verticalCenter;
                left: parent.left;
                leftMargin: 8
            }
            horizontalAlignment: Text.AlignLeft
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
        }

    }
}
