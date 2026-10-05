import QtQuick
import QtQuick.Layouts

import qs.components
import qs.services

Dropdown {
    id: root

    showHeader: true
    headerText: "Keyboard Layouts"

    ColumnLayout {
        id: content

        anchors.centerIn: parent

        width: Math.max(implicitWidth, root.minimumWindowWidth)

        Repeater {
            model: HyprlandService.usedLayouts

            ModuleButton {
                id: mBackground
                required property var modelData
    
                Layout.fillWidth: true

                buttonState: {
                    if (HyprlandService.activeLayoutIdx == modelData.idx) {
                        return buttonActive;
                    }

                    return containsMouse ? buttonHover : buttonInactive;
                }

                text: { 
                    let variant = modelData.variant != "" ? modelData.variant : "vanilla" 
                    return modelData.layout + "-" + variant + "\n" + modelData.description;
                }

                onClicked: {
                    HyprlandService.setActiveLayout(modelData.idx)
                    root.isOpen = false;
                }
            }
        }
    }
}
