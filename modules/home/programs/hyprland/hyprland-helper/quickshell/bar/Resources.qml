import QtQuick
import QtQuick.Layouts
import "../services"
import qs.customItems
//import "../utils/."
//import "../components"

Rectangle {
    id: root

    Layout.fillHeight: true
    color: "transparent"
    implicitWidth: rowLayout.width

    property int valueSize: 8
    property int textSize: 10

    property color valueColor: 'white'
    property string textColor: "lightgray"

    RowLayout {
        id: rowLayout
        anchors.centerIn: parent
        spacing: 10

        RowLayout {
            BarText {
                font.pointSize: root.textSize
                symbolText: "🧠"
                Layout.alignment: Qt.AlignCenter
            }
            BarText {
                color: '#ccccccff'
                font.pointSize: root.valueSize
                text: ResourcesState.mem_percent
                Layout.alignment: Qt.AlignCenter
            }
        }

        RowLayout {
            id: cpuColumn
            BarText {
                //color: 'white'
                font.pointSize: root.textSize
                symbolText: "🤖"
                Layout.alignment: Qt.AlignCenter
            }
            BarText {
                //color: 'white'
                font.pointSize: root.valueSize
                //text: ResourcesState.cpu_percent + "%"
                text: ResourcesState.cpu_percent
                Layout.alignment: Qt.AlignCenter
                color: '#ccccccff'
            }
        }

    }
}
