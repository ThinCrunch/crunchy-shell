import Quickshell
import QtQuick

Text {
    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    color: "white"

    // https://doc.qt.io/qt-6/qml-qtqml-qt.html#formatDateTime-method
    property string dateTime: Qt.formatDateTime(clock.date, "ddd MMM dd hh:mm:ss")
    property string icon: " "

    text: icon + " " + dateTime

    font.family: "FantasqueSansM Nerd Font"
    font.pixelSize: 14
}
