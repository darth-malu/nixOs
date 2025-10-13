import QtQuick
import QtQuick.Layouts
import qs.customItems
import qs.services

Rectangle {
    id: root

    Layout.fillHeight: true
    //Layout.leftMargin: 5
    //Layout.rightMargin: 5
    color: "transparent"
    implicitWidth: resourcesRow.width

    property int valueSize: 8

    property int textSize: 8
    property string textFont: 'quicksand medium'
    property bool textBold: true

    property int symbolSize: 10

    property color valueColor: 'white'
    property color cpuColor: cpuText.text > 80 ? "#F88DAD" : cpuText.text > 50 ? "#7CE577" : '#ccccccff'

    property color memoryColor: '#ccccccff'
    property string textColor: "lightgray"

    RowLayout {
        id: resourcesRow
        anchors.centerIn: parent
        spacing: 10
        uniformCellSizes: true

        RowLayout {
            id: memoryIcon
            spacing: 6
            BarText {
                font.pointSize: root.symbolSize
                symbolText: "🧠"
                Layout.alignment: Qt.AlignCenter
            }
            BarText {
                id: memoryText
                color: memoryColor
                font { pointSize: root.textSize; family: root.textFont; bold: root.textBold}
                text: ResourcesState.mem_percent
                Layout.alignment: Qt.AlignCenter
            }
        }

        RowLayout {
            id: cpuColumn
            spacing: 6
            BarText {
                id: cpuIcon
                //color: 'white'
                font.pointSize: root.symbolSize
                symbolText: "🤖"
                Layout.alignment: Qt.AlignCenter
            }
            BarText {
                id: cpuText
                //color: 'white'
                font { pointSize: root.textSize; family: root.textFont; bold: root.textBold}
                //text: ResourcesState.cpu_percent + "%"
                text: ResourcesState.cpu_percent
                Layout.alignment: Qt.AlignCenter
                color: root.cpuColor
            }
        }

    }
}
