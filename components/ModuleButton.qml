import QtQuick

import qs.components
import qs.globals

ModuleBackground {
    id: root

    property int buttonState: buttonInactive

    property var textColorActive: Colors.fgSelected
    property var textColorInactive: Colors.fg

    property var bgColorInactive: "transparent"
    property var bgColorActive: Colors.fg
    property var bgColorHover: Colors.bgModule

    property var text: "TEXT"

    // ButtonStates
    property int buttonInactive: 0
    property int buttonActive: 1
    property int buttonHover: 2

    color: {
        switch (root.buttonState) {
            case root.buttonActive: return root.bgColorActive;
            case root.buttonHover:  return root.bgColorHover;
            default:                return root.bgColorInactive;
        }
    }

    hoverEnabled: true

    ModuleText {
        id: innerText

        anchors.centerIn: root

        color: root.buttonState == root.buttonActive ? root.textColorActive : root.textColorInactive
        text: root.text
        horizontalAlignment: Text.AlignHCenter
    }
}
