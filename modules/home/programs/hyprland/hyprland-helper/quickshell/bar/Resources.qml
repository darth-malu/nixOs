import QtQuick
import QtQuick.Layouts
import qs.customItems
import qs.services

Rectangle {
    id: root

    Layout.fillHeight: true
    Layout.leftMargin: 5
    Layout.rightMargin: 5
    color: "transparent"
    implicitWidth: rowLayout.width

    property int valueSize: 8

    property int textSize: 8
    property string textFont: 'inter'
    property bool textBold: true

    property int symbolSize: 10

    property color valueColor: 'white'
    property color cpuColor: '#ccccccff'
    property color memoryColor: '#ccccccff'
    property string textColor: "lightgray"

    RowLayout {
        id: rowLayout
        anchors.centerIn: parent
        spacing: 10
        uniformCellSizes: true

        RowLayout {
            spacing: 6
            BarText {
                font.pointSize: root.symbolSize
                symbolText: "🧠"
                Layout.alignment: Qt.AlignCenter
            }
            BarText {
                color: memoryColor
                font.pointSize: root.textSize
                font.family: root.textFont
                font.bold: root.textBold
                text: ResourcesState.mem_percent
                Layout.alignment: Qt.AlignCenter
            }
        }

        RowLayout {
            id: cpuColumn
            spacing: 6
            BarText {
                //color: 'white'
                font.pointSize: root.symbolSize
                symbolText: "🤖"
                Layout.alignment: Qt.AlignCenter
            }
            BarText {
                //color: 'white'
                font.pointSize: root.textSize
                font.family: root.textFont
                font.bold: root.textBold
                //text: ResourcesState.cpu_percent + "%"
                text: ResourcesState.cpu_percent
                Layout.alignment: Qt.AlignCenter
                color: root.cpuColor
            }
        }

    }
}
