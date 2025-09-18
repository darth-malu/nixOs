//convert Type to singleton(Only one instance and accessible from any scope)
//singletons always have Singleton as the type
pragma Singleton

import Quickshell
/* import Quickshell.Io */
/* import QtQuick */

Singleton {
    id: root

    readonly property string time: {
        Qt.formatDateTime(clock.date, "ddd MMM,dd h:mm") //ddd MMM d hh:mm:ss AP t yyyy
    }

    SystemClock {
        id: clock                      // use in id:root to format date
        precision: SystemClock.Minutes //Seconds::, Minutes
    }
}
