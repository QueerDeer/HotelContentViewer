import QtQuick 2.9
import QtQuick.Controls 1.2
import QtQuick.Controls 2.2

ApplicationWindow {
    visible: true
    width: 1680
    height: 960
    title: qsTr("Content Viewer")
    color: "snow"

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page {
            TableView {
                id: tableView
                anchors.fill: parent
                frameVisible: true
                selectionMode: SelectionMode.ExtendedSelection

                TableViewColumn {
                    role: "hotel_id"
                    title: "hotel id"
                    width: 110
                    horizontalAlignment: TextInput.AlignHCenter
                    elideMode: Text.ElideMiddle
                }
                TableViewColumn {
                    role: "address"
                    title: "address"
                    width: 400
                    horizontalAlignment: TextInput.AlignHCenter
                    elideMode: Text.ElideMiddle
                }
                TableViewColumn {
                    role: "house_number"
                    title: "house number"
                    width: 110
                    horizontalAlignment: TextInput.AlignHCenter
                    elideMode: Text.ElideMiddle
                }
                TableViewColumn {
                    role: "hotel_name"
                    title: "hotel name"
                    width: 230
                    horizontalAlignment: TextInput.AlignHCenter
                    elideMode: Text.ElideMiddle
                }
                TableViewColumn {
                    role: "email"
                    title: "email"
                    width: 200
                    horizontalAlignment: TextInput.AlignHCenter
                    elideMode: Text.ElideMiddle
                }
                TableViewColumn {
                    role: "phone"
                    title: "phone"
                    width: 200
                    horizontalAlignment: TextInput.AlignHCenter
                    elideMode: Text.ElideMiddle
                }
                TableViewColumn {
                    role: "city"
                    title: "city"
                    width: 210
                    horizontalAlignment: TextInput.AlignHCenter
                    elideMode: Text.ElideMiddle
                }
                TableViewColumn {
                    role: "country"
                    title: "country"
                    width: 200
                    horizontalAlignment: TextInput.AlignHCenter
                    elideMode: Text.ElideMiddle
                }

                rowDelegate: Component {
                    Rectangle {
                        border.color: "gainsboro"
                        border.width: 0.5
                        height: 22
                        SystemPalette {
                            id: myPalette;
                            colorGroup: SystemPalette.Active
                        }
                        color: if ((listModel.get(styleData.row) ? listModel.get(styleData.row).hotel_id : 0) === "")
                                   "lightpink"
                               else if ((listModel.get(styleData.row) ? listModel.get(styleData.row).address : 0) === "")
                                   "lightpink"
                               else if ((listModel.get(styleData.row) ? listModel.get(styleData.row).house_number : 0) === "")
                                   "lightpink"
                               else if ((listModel.get(styleData.row) ? listModel.get(styleData.row).hotel_name : 0) === "")
                                   "lightpink"
                               else if ((listModel.get(styleData.row) ? listModel.get(styleData.row).email : 0) === "")
                                   "lightpink"
                               else if ((listModel.get(styleData.row) ? listModel.get(styleData.row).phone : 0) === "")
                                   "lightpink"
                               else if ((listModel.get(styleData.row) ? listModel.get(styleData.row).city : 0) === "")
                                   "lightpink"
                               else if ((listModel.get(styleData.row) ? listModel.get(styleData.row).country : 0) === "")
                                   "lightpink"
                               else
                                   "snow"
                    }
                }

                itemDelegate: TextInput {
                    id: textEdit
                    anchors.centerIn: parent.Center
                    text: styleData.value ? styleData.value : ''
                    font.pixelSize: 16
                    clip: true
                    onEditingFinished: {
//                        console.log(styleData.row); console.log(styleData.column);
                        handler.addChanges(text, styleData.row, styleData.column);

                        if (styleData.role == "hotel_id")
                            listModel.set(styleData.row, {"hotel_id": text})
                        if (styleData.role == "address")
                            listModel.set(styleData.row, {"address": text})
                        if (styleData.role == "house_number")
                            listModel.set(styleData.row, {"house_number": text})
                        if (styleData.role == "email")
                            listModel.set(styleData.row, {"email": text})
                        if (styleData.role == "phone")
                            listModel.set(styleData.row, {"phone": text})
                        if (styleData.role == "city")
                            listModel.set(styleData.row, {"city": text})
                        if (styleData.role == "country")
                            listModel.set(styleData.row, {"country": text})}
                    selectionColor: "lightblue"
                    horizontalAlignment: TextInput.AlignHCenter
                    ItemDelegate {
                        id: it
                        anchors.fill: parent
                        onClicked: textEdit.forceActiveFocus()
                        onPressAndHold: {textEdit.selectAll(); textEdit.copy()}
                        onReleased: textEdit.deselect()
                    }
                }

                model: listModel
            }

            ListModel{
                id:listModel
                ListElement{
                    hotel_id: "0000000"
                    address: "0, Street, Town, Country, Hotel"
                    house_number: "0/0"
                    hotel_name: "Nice name"
                    email: "mail@nail.com"
                    phone: "(+000)000-00-00"
                    city: "Town"
                    country: "Great Country"
                }
            }

        }

        Page {
            width: 600
            height: 400

            header: Label {
                text: qsTr("Press and hold the table cell to copy it to clipboard")
                font.pixelSize: Qt.application.font.pixelSize * 1.5
                padding: 10
            }

            Image {
                id: pusheen
                source: "pics/Pusheen.png"
                anchors.centerIn: parent
                MouseArea {
                    anchors.fill: parent
                    onClicked: {pusheen.height = pusheen.height+10; pusheen.width = pusheen.width+10;}
                }
            }
        }

    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("Editor")
        }
        TabButton {
            text: qsTr("Settings")
        }
    }

    Connections {
        target: handler

        onRowAdd: {
            listModel.append({"hotel_id": msg1, "address": msg2, "house_number": msg3, "hotel_name": msg4, "email": msg5, "phone": msg6, "city": msg7, "country": msg8});
            tableView.viewport.update()
        }

        onSetUp: {
            listModel.clear();
        }

    }

}
