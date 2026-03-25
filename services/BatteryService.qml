pragma Singleton

import Quickshell
import Quickshell.Services.UPower
import QtQuick

Singleton {
    id: root

    property bool ready: !!batteryDevice

    property var batteryDevice: UPower.devices.values.find(d => d.type == UPowerDeviceType.Battery)
    property int capacity: batteryDevice ? batteryDevice.percentage * 100 : -1
    property string energyRate: batteryDevice ? batteryDevice.changeRate.toFixed(1) : "0.0"

    property var state: batteryDevice?.state
    property bool charging: state == UPowerDeviceState.Charging
    property bool maxCapacity: state == UPowerDeviceState.FullyCharged || state == UPowerDeviceState.PendingCharge
}
