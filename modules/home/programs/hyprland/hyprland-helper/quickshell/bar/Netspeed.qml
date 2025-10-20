import QtQuick
import QtQuick.Controls

Item {
    id: root
    property int refreshInterval: 500
    property string iface: ""
    property int rxMin: 200 * 1024
    property int rxMax: 12 * 1024 * 1024
    property int txMin: 200 * 1024
    property int txMax: 5 * 1024 * 1024
    property string rxColor: "#0080c0"
    property string txColor: "#fa7070"

    property int rxPrev: 0
    property int txPrev: 0
    property string rxBar: ""
    property string txBar: ""

    // helper function to get the default interface
    function getDefaultInterface() {
        const p = ShellCommand.runSync("ip route")
        const lines = p.stdout.split("\n")
        for (let line of lines) {
            if (line.startsWith("default via")) {
                return line.split(/\s+/)[4]
            }
        }
        return ""
    }

    // get rx and tx bytes for a given interface
    function getRxTxBytes(iface) {
        const p = ShellCommand.runSync("cat /proc/net/dev")
        const lines = p.stdout.split("\n")
        for (let line of lines) {
            line = line.trim()
            if (line.startsWith(iface + ":")) {
                const parts = line.split(/\s+/)
                const rx = parseInt(parts[1])
                const tx = parseInt(parts[9])
                return [rx, tx]
            }
        }
        return [0, 0]
    }

    function bar(current, min, max, color) {
        if (current < min)
            return " "

        const labels = ["▁", "▂", "▄", "▅", "▆", "▇", "█"]
        const levels = labels.length
        const levelSize = max / levels
        let level = Math.floor(current / levelSize)
        if (level >= levels)
            level = levels - 1
        return `<span color='${color}'>${labels[level]}</span>`
    }

    Timer {
        id: timer
        interval: root.refreshInterval
        repeat: true
        running: true
        onTriggered: {
            if (root.iface === "")
                root.iface = root.getDefaultInterface()

            const [rx, tx] = root.getRxTxBytes(root.iface)
            if (root.rxPrev === 0) {
                root.rxPrev = rx
                root.txPrev = tx
                return
            }

            const rxRate = (rx - root.rxPrev) * 1000 / root.refreshInterval
            const txRate = (tx - root.txPrev) * 1000 / root.refreshInterval

            root.rxBar = root.bar(rxRate, root.rxMin, root.rxMax, root.rxColor)
            root.txBar = root.bar(txRate, root.txMin, root.txMax, root.txColor)

            root.rxPrev = rx
            root.txPrev = tx
        }
    }

    Text {
        textFormat: Text.RichText
        text: `${root.rxBar} ${root.txBar}`
        font.family: "monospace"
        color: 'white'
    }
}
