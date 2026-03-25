import Quickshell
import QtQuick

import qs.components

ModuleText {
    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    // https://doc.qt.io/qt-6/qml-qtqml-qt.html#formatDateTime-method
    property string dateTime: Qt.formatDateTime(clock.date, "ddd MMM dd hh:mm:ss")
    property string icon: " "

    text: icon + " " + dateTime
}
