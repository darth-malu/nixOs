import QtQuick
import Quickshell

import qs.customItems

BarBlock {
  id: masaa
  content: BarText {
    symbolText: Time.time
    /* color: '#0A8681' */
    //color: '#ccccccff'
    /* anchors { */
    /*   centerIn: parent */
    /*   verticalCenter: parent.verticalCenter */
    /* } */
    //font.family: "VictorMono Nerd Font"
    //font.family: "Mononoki Nerd Font"
    font.family: "inter"
    font.pixelSize: 12
    font.bold: true
    //color: Qt.rgba( 7/255 , 177/255 , 169/255, 0.91)
    color: '#ccccccff'
    rightPadding: 5
  }
}
