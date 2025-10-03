//@ pragma UseQApplication
import Quickshell // core shell types like PanelWindow, Scope
//import Quickshell.Io // process execution
import QtQuick //for Text

import "./modules/" // volume
import "./modules/bar" //for bar etc in modules dir

ShellRoot {
    //TODO scope vs shellroot
    Bar {}   //Any qml file that starts with an uppercase can be referenced this way
    Volume {}
    //Hyprland {}
    // Mpris {}
}
