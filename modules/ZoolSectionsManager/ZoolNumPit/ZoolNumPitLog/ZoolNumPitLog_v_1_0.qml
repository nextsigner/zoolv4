import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle{
    id: r
    width: parent.width
    height: parent.height
    color: apps.backgroundColor
    visible: false
    border.width: 2
    border.color: apps.fontColor
    clip: true
    property alias flk: flLog
    property alias text: taLog.text
    property bool ww: true
    onVisibleChanged: {
        if(visible){
            app.ciPrev=app.ci
            app.ci=r
        }else{
            app.ci=app.ciPrev
        }
    }

    Flickable{
        id: flLog
        width: parent.width
        height: parent.height
        contentWidth: parent.width
        contentHeight: taLog.contentHeight
        clip: true
        //Behavior on contentY{NumberAnimation{duration: 250}}
        TextEdit{
            id: taLog
            width: r.width-app.fs//*0.5
            //wrapMode: r.ww?Text.WordWrap:Text.WrapAnywhere
            wrapMode: Text.WordWrap
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: apps.numPanelLogFs
            color: apps.fontColor

            //background: Rectangle{color: 'transparent'}
            //enabled: false
        }
        MouseArea{
            anchors.fill: parent
            onClicked: r.visible=false
            onWheel: {
                if (wheel.modifiers & Qt.ControlModifier) {
                    if(wheel.angleDelta.y>=0){
                        if(apps.numPanelLogFs<app.fs*2){
                            apps.numPanelLogFs+=1
                        }else{
                            apps.numPanelLogFs=app.fs*2
                        }
                    }else{
                        if(apps.numPanelLogFs>app.fs*0.5){
                            apps.numPanelLogFs-=1
                        }else{
                            apps.numPanelLogFs=app.fs*0.5
                        }
                    }
                }else{
                    if(wheel.angleDelta.y>=0){
                        toUp(false)
//                        if(flLog.contentY>0){
//                            flLog.contentY-=apps.numPanelLogFs*2
//                        }
                    }else{
                        toDown(false)
                        //flLog.contentY+=apps.numPanelLogFs*2
                    }
                }
            }
        }
    }
    Rectangle{
        width: app.fs*0.5
        height: width
        anchors.right: parent.right
        anchors.rightMargin: app.fs*0.1
        anchors.top: parent.top
        anchors.topMargin: app.fs*0.1
        color: apps.fontColor
        Text{text: 'X';anchors.centerIn: parent;color: apps.backgroundColor}
        MouseArea{
            anchors.fill: parent
            onClicked: {
                r.visible=false
                r.visible=apps.showLog
            }
        }
    }
    function l(d){
        taLog.text+=d+'\n'
        flLog.contentY=taLog.contentHeight-r.height
    }
    function clear(){
        taLog.text=''
        //taLog.clear()
    }
    function cp(){
        taLog.selectAll()
        taLog.copy()
    }
    function scrollToTop(){
        flLog.contentY=0
    }

    //-->Teclado
    function toEnter(ctrl){}
    function toTab(ctrl){}
    function toUp(ctrl){
        let y=0
        if(!ctrl){
            y=flk.contentY-app.fs
            if(y>0){
                flk.contentY=y
            }else{
                flk.contentY=0
            }
        }else{
            y=flk.contentY-app.fs*0.25
            if(y>0){
                flk.contentY=y
            }else{
                flk.contentY=0
            }
        }
    }
    function toDown(ctrl){
        let y=taLog.contentHeight+app.fs*3
        if(!ctrl){
            y=flk.contentY+app.fs
            if(y<flk.contentHeight-flk.height*0.5){
                flk.contentY=y
            }else{
                flk.contentY=flk.contentHeight-flk.height*0.5
            }
        }else{
            y=flk.contentY+app.fs*0.25
            if(y<flk.contentHeight-flk.height*0.5){
                flk.contentY=y
            }else{
                flk.contentY=flk.contentHeight-flk.height*0.5
            }
        }
    }
    function toLeft(ctrl){}
    function toRight(ctrl){}
    function toEscape(ctrl){
        r.visible=false
    }
    function isFocus(){return false}
    //<--Teclado
}
