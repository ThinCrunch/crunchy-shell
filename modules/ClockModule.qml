import Quickshell
import QtQuick

import qs.globals

Text {
    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    color: Colors.fg

    // https://doc.qt.io/qt-6/qml-qtqml-qt.html#formatDateTime-method
    property string dateTime: Qt.formatDateTime(clock.date, "ddd MMM dd hh:mm:ss")
    property string icon: " "

    text: icon + " " + dateTime

    font.family: Style.fontFamily
    font.pixelSize: Style.fontPixelSize
    font.weight: Style.fontWeight
}
