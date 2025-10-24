import QtQuick 2.0

Rectangle{
    id: r
    border.width: 1
    border.color: apps.fontColor
    anchors.fill: parent
    color: apps.backgroundColor
    Column{
        anchors.centerIn: parent
        AlphaNumTable{
            id: ant
            width: r.width*0.6
            isDinObject: true
            spacing: app.fs*3
            anchors.horizontalCenter: parent.horizontalCenter
            //anchors.centerIn: parent
        }
        CalcNum{
            id: calcNum
            width: ant.width
        }
    }
}
