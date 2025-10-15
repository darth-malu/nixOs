import QtQuick
import Quickshell

import qs.customItems

BarBlock {
  id: masaa

  underline: false

  content: BarText {
      symbolText: Time.time
      font {pixelSize: 13; family: 'quicksand medium'; bold: true}
      baseColor: '#ff79c6'
      // rightPadding: 5
  }
}
