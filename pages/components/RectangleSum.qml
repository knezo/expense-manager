import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.LocalStorage 2.15
import "../js/utils.js" as Utils

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
            color: "mediumturquoise"
        }

        GradientStop {
            position: 1
            color: "mediumseagreen"
        }
    }

    property Text textSumValue: textSumValue
    property alias comboBoxSumCurrency: comboBoxSumCurrency
    property alias textSumLabel: textSumLabel

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
    }
}
