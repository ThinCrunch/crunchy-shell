import QtQuick

import qs.components
import qs.globals
import qs.services

ModuleText {
    id: root

    property int capacity: BatteryService.capacity
    property string energyRate: BatteryService.energyRate

    property string icon: "? "
    property string dischargingText: icon + capacity + "(" + energyRate + ")"
    property string pluggedText: icon + capacity
    text: pluggedText

    states: [
        State {
            name: "Charging"
            PropertyChanges { 
                root.icon: " ";
                root.color: Colors.notifyGreen;
                root.text: pluggedText;
            }
        },
        State {
            name: "CapacityFull"
            PropertyChanges { 
                root.icon: "  ";
                root.color: Colors.fg;
                root.text: pluggedText;
            }
        },
        State {
            name: "Capacity4"
            PropertyChanges {
                root.icon: "  ";
                root.color: Colors.fg;
                root.text: dischargingText
            }
        },
        State {
            name: "Capacity3"
            PropertyChanges {
                root.icon: "  ";
                root.color: Colors.fg;
                root.text: dischargingText
            }
        },
        State {
            name: "Capacity2"
            PropertyChanges {
                root.icon: "  ";
                root.color: Colors.fg;
                root.text: dischargingText;
            }
        },
        State {
            name: "Capacity1"
            PropertyChanges {
                root.icon: "  ";
                root.color: Colors.fg;
                root.text: dischargingText;
            }
        },
        State {
            name: "CapacityWarning"
            PropertyChanges {
                root.icon: " ";
                root.color: Colors.alertMedium;
                root.text: dischargingText;
            }
        },
        State {
            name: "CapacityCritical"
            PropertyChanges {
                root.icon: " ";
                root.color: Colors.alertHigh;
                root.text: dischargingText;
            }
        }
    ]

    Component.onCompleted: {
        if (!BatteryService.ready) {
            return
        }
        BatteryService.stateChanged.connect(updateState)
        BatteryService.capacityChanged.connect(updateState)
        root.updateState()
    }

    Connections {
        target: BatteryService

        function onReadyChanged() {
            BatteryService.stateChanged.connect(root.updateState)
            BatteryService.capacityChanged.connect(root.updateState)
            root.updateState()
        }
    }

    function updateState() {
        if (BatteryService.charging) {
            root.state = "Charging"
            return
        }

        if (BatteryService.maxCapacity) {
            root.state = "CapacityFull"
            return
        }

        root.state = "Capacity4"
        if (root.capacity <= 75) { root.state = "Capacity3" }
        if (root.capacity <= 50) { root.state = "Capacity2" }
        if (root.capacity <= 25) { root.state = "Capacity1" }
        if (root.capacity <= 15) { root.state = "CapacityWarning" }
        if (root.capacity <= 5)  { root.state = "CapacityCritical" }
    }
}
