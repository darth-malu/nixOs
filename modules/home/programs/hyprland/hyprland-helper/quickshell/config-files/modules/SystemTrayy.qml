// Tray.qml
import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.SystemTray
import Quickshell.Widgets

RowLayout {
    id: trayList
    Repeater {
        model: SystemTray.items

        MouseArea {
          id: delegate
          required property SystemTrayItem modelData
          property alias item: delegate.modelData

          Layout.fillHeight: true
          implicitWidth: icon.implicitWidth + 5

          acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
          hoverEnabled: true

          onClicked: event => {
            if (event.button == Qt.LeftButton) {
              item.activate();
            } else if (event.button == Qt.MiddleButton) {
              item.secondaryActivate();
            } else if (event.button == Qt.RightButton) {
              menuAnchor.open();
            }
          }

          /* onWheel: event => { */
          /*   event.accepted = true; */
          /*   const points = event.angleDelta.y / 120 */
          /*   item.scroll(points, false); */
          /* } */

          IconImage {
            id: icon
            anchors {
                verticalCenter: parent.verticalCenter
            }
            source: modelData.icon
            /* source: { */
            /*   let appId = modelData.wayland?.appId; */
            /*   if(appId=="Spotify") appId="spotify-launcher"; */
            /*   return Quickshell.iconPath(DesktopEntries.byId(appId).icon); */
            /* } */

    /*       source: { */
    /*           let appId = item.title; */

    /*           if (appId === "Spotify") */
    /*               appId = "spotify"; */
    /* else if (/Discord/i.test(appId)) */
    /*               appId = "discord"; */
    /*           else if (appId === "blueman") */
    /*               appId = "Blueman"; */
    /*           else if (appId === "Steam") */
    /*               appId = "steam"; */

    /*           return Quickshell.iconPath(DesktopEntries.byId(appId).icon); */
    /*       } */
            implicitSize: 12
            asynchronous: true
          }

          QsMenuAnchor {
            id: menuAnchor
            menu: modelData.menu

            anchor.window: delegate.QsWindow.window
            anchor.adjustment: PopupAdjustment.Flip

            anchor.onAnchoring: {
              const window = delegate.QsWindow.window;
              const widgetRect = window.contentItem.mapFromItem(delegate, 0, delegate.height, delegate.width, delegate.height);

              menuAnchor.anchor.rect = widgetRect;
            }
          }

          Tooltip {
            relativeItem: delegate.containsMouse ? delegate : null

            Label {
              text: delegate.item.tooltipTitle || delegate.item.id
            }
          }
        }
    }
}
