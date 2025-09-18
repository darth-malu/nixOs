//@ pragma UseQApplication
import Quickshell // core shell types like PanelWindow, Scope
import Quickshell.Io // process execution
import QtQuick //for Text
import "./modules" //for bar etc in modules dir
/* import "PoachingArea/activate_linux" */

ShellRoot { //TODO scope vs shellroot
  Bar {}   //Any qml file that starts with an uppercase can be referenced this way
  //Activate {}
  //Pipewire {}
  //Mpris {}
  //Hyprland {}
  // Mpris {}
}
