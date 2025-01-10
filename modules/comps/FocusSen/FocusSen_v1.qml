import QtQuick 2.0

Rectangle{
    id: r
    width: parent.width
    height: parent.height
    color: 'transparent'
    border.width: 4
    anchors.bottom: parent.bottom
    visible: apps.zFocus==='xLatIzq'
    SequentialAnimation on border.color{
        running: r.visible
        loops: Animation.Infinite
        ColorAnimation {
            from: "red"
            to: "yellow"
            duration: 300
        }
        ColorAnimation {
            from: "yellow"
            to: "red"
            duration: 300
        }
    }
}
