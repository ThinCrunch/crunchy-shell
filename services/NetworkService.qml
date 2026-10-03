pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Networking

Singleton {
    id: root

    property bool notConnected: Networking.connectivity == NetworkConnectivity.None
    property bool noInternet: Networking.connectivity == NetworkConnectivity.Limited
    property bool wifiEnabled: Networking.wifiEnabled

    property string wifiDeviceName: internal.activeWifiDevice?.name ?? "no active wifi device"
    property int wifiDeviceConnectionStatus: internal.wifiDeviceConnectionStatus
    property bool wifiDeviceConnectionInactive: internal.stateInactive(wifiDeviceConnectionStatus)
    property string wifiConnectedNetworkName: internal.wifiConnectedNetworkName

    property string wiredDeviceName: internal.activeWiredDevice?.name ?? "no active wired device"
    property int wiredDeviceConnectionStatus: internal.wiredDeviceConnectionStatus
    property bool wiredDeviceConnectionInactive: internal.stateInactive(wiredDeviceConnectionStatus)

    // DeviceConnectionStatus
    readonly property int statusDisconnected:  0
    readonly property int statusConnected:     1
    readonly property int statusConnecting:    2
    readonly property int statusDisconnecting: 3
    readonly property int statusUnknown:      -1

    QtObject {
        id: internal

        property NetworkDevice activeWifiDevice: getActiveDeviceByType(DeviceType.Wifi)
        property int wifiDeviceConnectionStatus: translateConnectionStatus(activeWifiDevice?.state)
        property Network connectedNetwork: {
            if (!activeWifiDevice) {
                return null;
            }

            let connectedNetwork = [...activeWifiDevice?.networks.values].find(n => !stateInactive(n.state))
            return connectedNetwork ?? null
        }
        property string wifiConnectedNetworkName: connectedNetwork?.name ?? "no active network"

        property NetworkDevice activeWiredDevice: getActiveDeviceByType(DeviceType.Wired)
        property int wiredDeviceConnectionStatus: translateConnectionStatus(activeWiredDevice?.state)

        function getActiveDeviceByType(type: int): NetworkDevice {
            let devices = [...Networking.devices.values].filter(d => d.type == type);
            return devices.find(d => !stateInactive(d.state));
        }

        function stateInactive(state: int): bool {
            return translateConnectionStatus(state) == root.statusDisconnected ||
                   translateConnectionStatus(state) == root.statusUnknown;
        }

        function translateConnectionStatus(c: int): int {
            switch (c) {
                case ConnectionState.Disconnected:  return root.statusDisconnected;
                case ConnectionState.Connected:     return root.statusConnected;
                case ConnectionState.Connecting:    return root.statusConnecting;
                case ConnectionState.Disconnecting: return root.statusDisconnecting;
                default: return -1
            }
        }
    }
}
