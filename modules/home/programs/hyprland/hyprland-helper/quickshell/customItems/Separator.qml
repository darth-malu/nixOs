import QtQuick
import QtQuick.Layouts


Rectangle {
    //Layout.preferredWidth: 2        // Width of the separator line
    //Layout.fillHeight: true         // Make it fill the height of the row
    //Layout.fillWidth: true         // Make it fill the height of the row
    color: 'red'
    // add padding on the sides for visual spacing
    //Layout.leftMargin: 2
    //Layout.rightMargin: 2
    implicitHeight: 6
    implicitWidth: parent.width
    //height: 6
    //radius: 18
    anchors.bottom: parent.bottom
}
