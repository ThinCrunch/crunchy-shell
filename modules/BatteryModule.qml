import QtQuick
import Quickshell.Services.UPower

import qs.globals

Text {
    id: root

    font.family: Style.fontFamily
    font.pixelSize: Style.fontPixelSize
    color: Colors.fg

    property var batteryDevice: UPower.devices.values.find(d => d.type == UPowerDeviceType.Battery)
    property int capacity: batteryDevice.percentage * 100
    property string energyRate: batteryDevice.changeRate.toFixed(1)

    property string icon: "? "
    property string dischargingText: icon + capacity + " (" + energyRate + ")"
    property string pluggedText: icon + capacity
    text: pluggedText

    states: [
        State {
            name: "Charging"
            PropertyChanges { root.icon: " " }
            PropertyChanges { root.color: Colors.notifyGreen }
            PropertyChanges { root.text: pluggedText }
        },
        State {
            name: "CapacityFull"
            PropertyChanges { root.icon: "  " }
            PropertyChanges { root.color: Colors.fg }
            PropertyChanges { root.text: pluggedText }
        },
        State {
            name: "Capacity4"
            PropertyChanges { root.icon: "  " }
            PropertyChanges { root.color: Colors.fg }
            PropertyChanges { root.text: dischargingText }
        },
        State {
            name: "Capacity3"
            PropertyChanges { root.icon: "  " }
            PropertyChanges { root.color: Colors.fg }
            PropertyChanges { root.text: dischargingText }
        },
        State {
            name: "Capacity2"
            PropertyChanges { root.icon: "  " }
            PropertyChanges { root.color: Colors.fg }
            PropertyChanges { root.text: dischargingText }
        },
        State {
            name: "Capacity1"
            PropertyChanges { root.icon: "  " }
            PropertyChanges { root.color: Colors.fg }
            PropertyChanges { root.text: dischargingText }
        },
        State {
            name: "CapacityWarning"
            PropertyChanges { root.icon: " " }
            PropertyChanges { root.color: Colors.alertMedium }
            PropertyChanges { root.text: dischargingText }
        },
        State {
            name: "CapacityCritical"
            PropertyChanges { root.text: " " }
            PropertyChanges { root.color: Colors.alertHigh }
            PropertyChanges { root.text: dischargingText }
        }
    ]

    Component.onCompleted: {
        root.batteryDevice.stateChanged.connect(updateState)
        root.batteryDevice.percentageChanged.connect(updateState)
        updateState()

        function updateState() {
            const state = root.batteryDevice.state

            if (state == UPowerDeviceState.Charging) {
                root.state = "Charging"
                return
            }

            if (state == UPowerDeviceState.FullyCharged || state == UPowerDeviceState.PendingCharge) {
                root.state = "CapacityFull"
                return
            }

            root.state = "Capacity4"
            if (root.capacity <= 75) { root.state = "Capacity3" }
            if (root.capacity <= 50) { root.State = "Capacity2" }
            if (root.capacity <= 25) { root.state = "Capacity1" }
            if (root.capacity <= 15) { root.state = "CapacityWarning" }
            if (root.capacity <= 5)  { root.state = "CapacityCritical" }
        }
    }
}
