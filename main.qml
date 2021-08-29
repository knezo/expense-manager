import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls.Imagine 2.3
import QtQuick.Controls 2.15

Window {
    id: window
    width: 1280
    height: 720
    visible: true
    title: qsTr("Expense manager")

    Rectangle {
        id: bg
        color: "#3b3b3b"
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.leftMargin: 0

        Rectangle {
            id: menu
            width: 135
            color: "#606060"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            anchors.topMargin: 0
            anchors.bottomMargin: 0

            Text {
                id: textTitle
                x: 8
                y: 8
                width: 119
                height: 67
                color: "#f7f7f7"
                text: qsTr("Expense manager")
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WordWrap
                font.family: "Arial"
                font.bold: true
                fontSizeMode: Text.FixedSize
                minimumPointSize: 17
                minimumPixelSize: 15
            }

            Button {
                id: btnAccounts
                y: 89
                text: qsTr("Accounts")
                anchors.left: parent.left
                anchors.right: parent.right
                font.bold: true
                transformOrigin: Item.Center
                checkable: false
                autoRepeat: false
                flat: false
                highlighted: false
                anchors.rightMargin: 8
                anchors.leftMargin: 8
                onClicked: stackView.push(Qt.resolvedUrl("pages/accounts.qml"))
            }

            Button {
                id: btnSubs
                y: 146
                text: qsTr("Subscriptions")
                anchors.left: parent.left
                anchors.right: parent.right
                font.bold: true
                anchors.rightMargin: 8
                anchors.leftMargin: 8
                onClicked: stackView.push(Qt.resolvedUrl("pages/subs.qml"))
            }

            Button {
                id: btnExit
                y: 656
                text: qsTr("Exit")
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 24
                anchors.rightMargin: 20
                anchors.leftMargin: 20
                onClicked: {
                    Qt.quit()
                }
            }

        }

        Rectangle {
            id: content
            color: "#00000000"
            anchors.left: menu.right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            clip: true
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0

            StackView {
                id: stackView
                anchors.fill: parent
                initialItem: Qt.resolvedUrl("pages/accounts.qml")
            }
        }
    }
}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}D{i:4}D{i:5}D{i:6}D{i:2}D{i:8}D{i:7}
}
##^##*/
