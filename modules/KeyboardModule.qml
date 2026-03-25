import QtQuick

import qs.components
import qs.services

ModuleText {
    id: root

    property string keymap: HyprlandService.keymap
    property string layout: HyprlandService.layout
    property string variant: HyprlandService.variant

    property string fullText: "  " + keymap + "-" + layout + " " + variant
    property string noVariantText: "  " + keymap + "-" + layout

    text: variant != "" ? fullText : noVariantText
}
