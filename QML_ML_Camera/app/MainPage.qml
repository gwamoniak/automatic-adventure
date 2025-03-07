import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtMultimedia 5.8
import QtQuick.Controls.Material 2.2
import QtQuick.Dialogs 1.2
import Qt.labs.settings 1.0
import solid.broccoli 1.0
import "."

PageTheme {
    width: parent.width
    property string pictureName

    RoundButton {
        id: drawerOpen
        Layout.preferredHeight:  Style.roundButtonHeight
        Layout.preferredWidth:   Style.roundButtonWidth
        //text: qsTr("::")
        //font.pointSize: 18
        Layout.alignment: Qt.AlignRight| Qt.AlignTop
        icon.source:"qrc:/images/png/cogwheel.png"
        icon.width :Style.roundButtonWidth
        icon.height:Style.roundButtonHeight
        background: Rectangle {
            radius: Style.roundButtonRadius
            color: Style.buttonBackground
        }

        onClicked: {
            settingsDrawer.open()
            if(settingsDrawer.opened)
                settingsDrawer.close()
        }
    }

    toolbarButtons:ColumnLayout{
        //     width: 1280
        //   height: 80
        anchors.right: parent.right
        width: parent.width /13
        height: parent.height
        spacing: 3

        RoundButton {
            id:pictureAlbumButton
            Layout.preferredHeight:  Style.roundButtonHeight
            Layout.preferredWidth:   Style.roundButtonWidth
            smooth: true
            antialiasing: true
            //text: qsTr("ALBUM")
            Layout.alignment: Qt.AlignLeft | Qt.AnchorTop
            icon.source: "qrc:/images/png/album_gallery.png"
            icon.width :Style.roundButtonWidth
            icon.height:Style.roundButtonHeight
            background: Rectangle {
                radius: Style.roundButtonRadius
                color: Style.roundButtonGreen
            }

            //font.pointSize: 18
            //anchors.right: quit.left
            //rightPadding: 5
            onClicked: {
                pageStack.push("qrc:/AlbumListPage.qml")
            }

        }
//        RoundButton {
//            id:movieAlbumButton
//            Layout.preferredHeight:  65
//            Layout.preferredWidth:   65
//            smooth: true
//            antialiasing: true
//            //text: qsTr("ALBUM")
//            Layout.alignment: Qt.AlignLeft | Qt.AnchorTop
//            background: Image {
//                source: "qrc:/images/png/movie_gallery.png"
//                width: 65
//                height: 65
//            }

//            //font.pointSize: 18
//            //anchors.right: quit.left
//            //rightPadding: 5
//            onClicked: {
//                pageStack.push("qrc:/MovieAlbumListPage.qml")
//            }
//
//        }
        RoundButton {
            id: cameraPage
            Layout.preferredHeight:  Style.roundButtonHeight
            Layout.preferredWidth:   Style.roundButtonWidth
            smooth: true

            Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
            icon.source: "qrc:/images/png/camera.png"
            icon.width :Style.roundButtonWidth
            icon.height:Style.roundButtonHeight
            background: Rectangle {
                radius: Style.roundButtonRadius
                color: Style.roundButtonYellow
            }
            onClicked: {
                pageStack.push("qrc:/CameraPage.qml")
            }
        }

        RoundButton {
            id: quit
            Layout.preferredHeight:  Style.roundButtonHeight
            Layout.preferredWidth:   Style.roundButtonWidth
            smooth: true
            //text: qsTr("-Quit-")
            Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
            icon.source: "qrc:/images/png/quit.png"
            icon.width :Style.roundButtonWidth
            icon.height:Style.roundButtonHeight
            background: Rectangle {
                radius: Style.roundButtonRadius
                color: Style.roundButtonRed
            }

            onClicked: {
                Qt.quit()
            }
        }
    }

    Drawer {
        id: settingsDrawer
        y: header.height
        height: window.height - header.height
        width: 0.27* window.width
        Rectangle {
            id: drawerRect
            anchors.fill: parent
            color: Style.toolBackground

            Column{
                id: settingButtons
                spacing: 1
                //height:0.15 *window.width
                ComboBox
                {
                    id: cameraCombo
                    width: drawerRect.width
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignRight| Qt.AlignTop
                    model: QtMultimedia.availableCameras
                    textRole: "displayName"
                    delegate: ItemDelegate
                    {
                        text: modelData.displayName
                    }
                    onCurrentIndexChanged:
                    {
                        CameraPage.camera.stop()
                        CameraPage.camera.deviceId = model[currentIndex].deviceId
                        CameraPage.camera.start()
                    }

                }
                Button {
                    id: loggerButton
                    width: drawerRect.width
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignRight| Qt.AlignTop
                    text: qsTr("Logger")
                    smooth: true

                    onClicked: {
                        pageStack.push("qrc:/LoggerPage.qml")
                        settingsDrawer.close()
                    }
                }

            }
            ListView {
                id: listView
                width: settingsDrawer.width
                height: settingsDrawer.height - settingButtons.height
                anchors.top: settingButtons.bottom
                model:2

                delegate: SettingSwitcher{

                    text: qsTr("Title of Setting %1").arg(index + 1)
                    font.bold: true
                    font.pointSize: 10

                }

                ScrollIndicator.vertical: ScrollIndicator { }

            }
        }

    }


}
