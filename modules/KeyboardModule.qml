import QtQuick

import qs.components
import qs.services
import qs.dropdowns

ModuleBackground {
    ModuleText {
        id: root

        property string keymap: HyprlandService.keymap
        property string layout: HyprlandService.layout
        property string variant: HyprlandService.variant

        property string fullText: "  " + keymap + "-" + layout + " " + variant
        property string noVariantText: "  " + keymap + "-" + layout

        text: variant != "" ? fullText : noVariantText

        KeyboardDropdown {
            id: dropdown

            anchor.item: root
            anchor.rect.x: root.width / 2 - width / 2
            anchor.rect.y: root.height + padding

            visible: false
        }
    }
    onClicked: {
        dropdown.isOpen = !dropdown.isOpen;
    }
}
