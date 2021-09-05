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
        anchors {
            fill: parent;
            rightMargin: 0;
            leftMargin: 0
        }

        Rectangle {
            id: menu
            width: 135
            color: "dimgrey"
            anchors {
                left: parent.left;
                top: parent.top;
                bottom: parent.bottom;
                leftMargin: 0;
                topMargin: 0;
                bottomMargin: 0
            }

            Text {
                id: textTitle
                width: 119
                height: 67
                color: "white"
                text: qsTr("Expense manager")
                anchors {
                    top: parent.top;
                    topMargin: 8
                }
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WordWrap
                font.bold: true

            }

            Button {
                id: btnAccounts
                text: qsTr("Accounts")
                anchors {
                    left: parent.left;
                    right: parent.right;
                    top: textTitle.bottom;
                    topMargin: 16;
                    rightMargin: 8;
                    leftMargin: 8
                }
                font.bold: true

                onClicked: stackView.push(Qt.resolvedUrl("pages/accounts.qml"))
            }

            Button {
                id: btnSubs
                text: qsTr("Subscriptions")
                anchors {
                    left: parent.left;
                    right: parent.right;
                    top: btnAccounts.bottom;
                    topMargin: 16;
                    rightMargin: 8;
                    leftMargin: 8
                }
                font.bold: true

                onClicked: stackView.push(Qt.resolvedUrl("pages/subs.qml"))
            }

            Button {
                id: btnExit
                text: qsTr("Exit")
                anchors {
                    left: parent.left;
                    right: parent.right;
                    bottom: parent.bottom;
                    bottomMargin: 24;
                    rightMargin: 20;
                    leftMargin: 20
                }

                onClicked: {
                    Qt.quit()
                }
            }

        }

        Rectangle {
            id: content
            color: "transparent"
            anchors {
                left: menu.right;
                right: parent.right;
                top: parent.top;
                bottom: parent.bottom;
                topMargin: 0;
                rightMargin: 0;
                leftMargin: 0;
                bottomMargin: 0
            }
            clip: true

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
    D{i:0;formeditorZoom:0.75}D{i:3}D{i:4}D{i:5}
}
##^##*/
