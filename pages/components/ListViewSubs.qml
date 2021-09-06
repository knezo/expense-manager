import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.LocalStorage 2.15
import "../js/utils.js" as Utils
import "../js/database.js" as Database

ListView {
    id: listViewData
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
        width: listViewData.width
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
        width: listViewData.width
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
                    Utils.changeChecked(index)
                    Utils.setTotalValueSubs()
                }

            }

            Button {
                id: btnEdit
                text: "Edit"
                height: 25
                display: AbstractButton.TextBesideIcon
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    Utils.openEdit(index)
                }

            }

            Button {
                id: btnDelete
                text: "Delete"
                height: 25
                display: AbstractButton.TextBesideIcon
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    Database.deleteSubscription(listModel.get(index).accountID)
                    listModel.remove(index)
                    Utils.setTotalValueSubs()
                }
                anchors.leftMargin: 10

            }

            spacing: 10
        }
    }

    Component.onCompleted: {
        Database.getAllSubscriptions()
    }
}
