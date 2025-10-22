import QtQuick 2.0

Rectangle{
    id: r
    width: app.fs*10
    height: col.height+app.fs
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor
    property int fs: app.fs
    Column{
        id: col
        anchors.centerIn: parent
        Rectangle{
            width: r.width
            height: r.fs*1.2
            color: apps.backgroundColor
            border.width: 2
            border.color: apps.fontColor
            clip: true
            Text{
                text: '<b>Tabla Alfanumérica Numerológica</b>'
                font.pixelSize: r.fs*0.5
                color: apps.fontColor
                anchors.centerIn: parent
            }
        }
    }
    Component{
        id: comp
        Item{
            id: xItem
            width: r.width
            height: r.fs*1.2
            property var aData: ['a', '2']
            Row{
                spacing: r.fs/8
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: r.fs/16
                Repeater{
                    model: xItem.aData
                    Rectangle{
                        width: (r.width/9-r.fs/8)//-(r.width/9/)
                        height: width
                        color: apps.backgroundColor
                        border.color: apps.fontColor
                        border.width: 1
                        visible: txt.text!==''
                        Text{
                            id: txt
                            text: modelData
                            font.pixelSize: r.fs
                            color: apps.fontColor
                            anchors.centerIn: parent
                        }
                    }
                }
            }
        }
    }
    Component.onCompleted: {
        let obj1=comp.createObject(col, {aData:['1', '2', '3', '4', '5', '6', '7', '8', '9']})
        let obj2=comp.createObject(col, {aData:['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I']})
        let obj3=comp.createObject(col, {aData:['J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R']})
        let obj4=comp.createObject(col, {aData:['S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '']})
    }
}
