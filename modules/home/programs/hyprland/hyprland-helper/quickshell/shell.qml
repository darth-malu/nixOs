import Quickshell
import QtQuick

import "./modules/" // volume
import "./modules/bar" //for bar etc in modules dir
import qs.bar
import "./customItems"

//Scope {
  ShellRoot {
      //TODO: scope vs shellroot
      Bar {}   //Any qml file that starts with an uppercase can be referenced this way
      Volume {}
  }
//}
