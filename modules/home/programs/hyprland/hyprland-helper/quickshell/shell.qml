//@ pragma UseQApplication
import Quickshell
import QtQuick
import qs.bar
import qs.notBar

//Scope {
  ShellRoot {
      //TODO: scope vs shellroot
      //FollowBar {}   //Any qml file that starts with an uppercase can be referenced this way
      Bar {}
      Volume {}
      IpcHandler {}
  }
//}
