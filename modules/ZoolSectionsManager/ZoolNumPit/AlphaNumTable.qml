import QtQuick 2.0
import "../../../comps" as Comps

Rectangle{
    id: r
    width: app.fs*10
    height: col.height+r.spacing/4
    color: apps.backgroundColor
    border.width: !isDinObject?2:0
    border.color: apps.fontColor
    property int spacing: app.fs
    property int bw: 1
    property bool isDinObject: false
    MouseArea{
        anchors.fill: parent
        onClicked: console.log('Se hizo click en AlphaNumTable...')
    }
    Column{
        id: col
        spacing: r.spacing/8
        anchors.centerIn: parent
        Rectangle{
            width: r.width
            height: txtLabel.contentHeight+r.spacing*0.5
            color: apps.backgroundColor
            border.width: 2
            border.color: apps.fontColor
            clip: true
            Text{
                id: txtLabel
                text: '<b>Tabla Alfanumérica Numerológica</b>'
                font.pixelSize: r.width*0.05
                color: apps.fontColor
                anchors.centerIn: parent
            }
        }
    }
    Rectangle{
        width: app.fs*0.5
        height: width
        color: apps.fontColor
        anchors.right: parent.right
        anchors.rightMargin: app.fs*0.1
        anchors.top: parent.top
        anchors.topMargin: app.fs*0.1
        parent: !isDinObject?r:r.parent.parent
        MouseArea{
            anchors.fill: parent
            onClicked: {
                if(isDinObject){
                    toEscape(false)
                }else{
                    r.visible=false
                }
            }
        }
        Text{
            text: 'X'
            font.pixelSize: parent.width*0.8
            color: apps.backgroundColor
            anchors.centerIn: parent
        }
    }
    Component{
        id: comp
        Item{
            id: xItem
            width: r.width-r.spacing
            height: (xItem.width/9-r.spacing/8)+r.spacing/8//r.spacing*1.2
            property var aData: ['a', '2']
            property int rowIndex: -1
            Row{
                spacing: r.spacing/8
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: r.spacing*0.5///16
                Repeater{
                    model: xItem.aData
                    Rectangle{
                        width: (xItem.width/9-r.spacing/8)//-(r.width/9/)
                        height: width
                        color: xItem.rowIndex===0?apps.fontColor:apps.backgroundColor
                        border.color: apps.fontColor
                        border.width: txt.text!==''?r.bw:0
                        Comps.ButtonIcon{
                            text: '\uf065'
                            width: parent.width
                            height: width
                            anchors.centerIn: parent
                            visible: !txt.visible && !r.isDinObject
                            onClicked: {
                                let comp=Qt.createComponent('WindowTANN.qml')
                                let obj=comp.createObject(capa101, {})
                            }
                        }
                        Text{
                            id: txt
                            text: xItem.rowIndex===0?'<b>'+modelData+'</b>':modelData
                            font.pixelSize: parent.width*0.8
                            color: xItem.rowIndex===0?apps.backgroundColor:apps.fontColor
                            anchors.centerIn: parent
                            visible: txt.text!==''
                        }
                        Rectangle{
                            width: r.bw
                            height: r.spacing/4
                            color: apps.fontColor
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.bottom
                            visible: xItem.rowIndex!==3 && txt.text!=='R'
                        }
                    }
                }
            }
        }
    }
    Component.onCompleted: {
        if(isDinObject){
            app.ciPrev=app.ci
            app.ci=r
        }else{
            //let comp=Qt.createComponent('WindowTANN.qml')
            //let obj=comp.createObject(capa101, {})
        }
        let obj1=comp.createObject(col, {aData:['1', '2', '3', '4', '5', '6', '7', '8', '9'], rowIndex: 0})
        let obj2=comp.createObject(col, {aData:['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I']})
        let obj3=comp.createObject(col, {aData:['J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R']})
        let obj4=comp.createObject(col, {aData:['S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', ''], rowIndex: 3})
    }

    //-->Teclado
    function toEnter(ctrl){}
    function toTab(ctrl){}
    function toUp(ctrl){}
    function toDown(ctrl){}
    function toLeft(ctrl){}
    function toRight(ctrl){}
    function toEscape(ctrl){
        app.ci=app.ciPrev
        r.parent.parent.destroy(0)
    }
    function isFocus(){return false}
    //<--Teclado
}
