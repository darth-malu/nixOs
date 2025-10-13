import Quickshell
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick 

PanelWindow {
        id: launcher
        width: 350
        height:350
        color: "transparent"
        focusable: true
        WrapperRectangle {
            id: wrap
            color: white

            width: 300
            height:300
            
            ColumnLayout {
                anchors.fill: parent
                spacing: 6

                TextField {
                    id: search

                    Layout.preferredWidth: 300
                    Layout.preferredHeight: 30

                    placeholderText: "Type to search"

                    enabled: true
                    focus: true
                    activeFocusOnPress: true
                }
                ListView {
                    Layout.preferredWidth: 300
                    Layout.preferredHeight: 500

                    model: DesktopEntries.applications.values.filter(a => a.name.includes(search.text))

                    delegate: Text {
                        required property DesktopEntry modelData
                        text: modelData.name
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                // launch the app
                                modelData.execute()
                            }
                        }
                    }
                }
            }
        }
    }
