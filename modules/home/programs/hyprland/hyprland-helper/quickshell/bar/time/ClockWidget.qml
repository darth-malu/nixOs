import QtQuick
import Quickshell

import qs.customItems

BarBlock {
  id: masaa
  content: BarText {
    symbolText: Time.time
    //font.family: "viktormono nerd font"
    font.pixelSize: 13
    //anchors.verticalCenter: parent.verticalCenter 
    font.bold: true
    //color: Qt.rgba( 7/255 , 177/255 , 169/255, 0.89)
    //color: '#ccccccff'
    //baseColor: Qt.rgba(171 / 255, 141 / 255, 237 / 255, 0.70)
    rightPadding: 5
  }
}
