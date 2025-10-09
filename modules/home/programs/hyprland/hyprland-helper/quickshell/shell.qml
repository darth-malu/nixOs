//@ pragma UseQApplication
import Quickshell
import QtQuick
import qs.bar

//Scope {
  ShellRoot {
      //TODO: scope vs shellroot
      Bar {}   //Any qml file that starts with an uppercase can be referenced this way
      Volume {}
  }
//}
