import QtQuick 2.0
import QtMultimedia 5.12
import ZoolText 1.1
import ZoolButton 1.2

Item{
    id: r
    width: parent.width
    //height: parent.height
    height: col.height
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    property int count: col.children.length
    onCountChanged: updateHeight()
    Rectangle{
        anchors.fill: parent
        color: 'redΩ'
    }
    Flickable{
        id: flk
        width: parent.width
        //height: r.height
        height: col.height
        contentWidth: r.width
        contentHeight: col.height+app.fs
        anchors.bottom: parent.bottom
        //rotation: 180
        Column{
            id: col
            //rotation: 180
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
        }
        //        Rectangle{
        //            anchors.fill: col
        //            color: 'red'
        //            opacity: 0.65
        //            border.width: 10
        //            border.color: 'yellow'
        //        }
    }
    //    Rectangle{
    //        anchors.fill: flk
    //        color: 'red'
    //        opacity: 0.65
    //        border.width: 10
    //        border.color: 'yellow'
    //    }
    Component{
        id: compNot
        Rectangle{
            id: xTxt
            width: r.width//-app.fs
            height: colNot.height+app.fs*0.5
            color: apps.backgroundColor
            border.width: 1//jsonNot.id!==undefined?10:1//1
            border.color: apps.fontColor
            radius: app.fs*0.25
            property var jsonNot
            property bool ad: false
            property int adTimerInterval: 10000

//            MouseArea{
//                anchors.fill: parent
//                //                onDoubleClicked: {
//                //                    addNot('Not agregado n°'+col.children.length+' ', false, 3500)
//                //                }
//            }

            Timer{
                running: parent.ad
                repeat: false
                interval: parent.adTimerInterval
                onTriggered: parent.destroy(0)
            }
            Audio{
                source: 'beep.wav'
                autoPlay: true
            }
            Text{
                //Invisible solo para calcular el ancho del texto
                id: txt0
                text: xTxt.jsonNot.text
                width: parent.width-app.fs
                font.pixelSize: app.fs*0.5
                color: apps.fontColor
                anchors.centerIn: parent
                opacity: 0.0
            }
            Column{
                id: colNot
                spacing: app.fs*0.1
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: 0-app.fs*0.25
                Text{
                    id: txt
                    text: xTxt.jsonNot.text
                    width: xTxt.width-app.fs
                    font.pixelSize: app.fs*0.5
                    color: apps.fontColor
                    wrapMode: txt0.contentWidth>=xTxt.width-app.fs?Text.WrapAnywhere:Text.WordWrap
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                ZoolButton{
                    text: 'Abrir'
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: xTxt.jsonNot.url!==undefined
                    onClicked: {
                        Qt.openUrlExternally(xTxt.jsonNot.url)
                    }
                }
            }
            ZoolButton{
                text: 'X'
                anchors.right: parent.right
                anchors.rightMargin: app.fs*0.25
                anchors.top: parent.top
                anchors.topMargin: app.fs*0.25
                onClicked: {
                    xTxt.destroy(0)
                }
            }
            Component.onCompleted: {
                updateHeight()
            }
        }
    }
    //    Component.onCompleted: {
    //        for(var i=0;i<16;i++){
    //        addNot('Not '+i+' ñalk ñaslkf ñaslfkj añsldfkjañ lñdks ñalskfd jñdalksdfj ñalkdfj ñalkfj ñalkfj ñalkjfñlsakj', false, 3500)
    //        }
    //    }
    function updateHeight(){
        let h=0
        for(var i=0;i<col.children.length;i++){
            h+=col.children[i].height
        }
        col.height=h
        if(h<r.parent.height){
            r.height=h
            flk.height=h
            flk.contentHeight=h

        }else{
            r.height=r.parent.height
            flk.height=r.height
            flk.contentHeight=h
        }

    }
    function addNot(jsonNot, ad, adti){
        let existeItemConId=false
        let itemConId
        if(jsonNot.id!==undefined){
            for(var i=0;i<col.children.length;i++){
                if(col.children[i].jsonNot.id === jsonNot.id){
                    itemConId=col.children[i]
                    existeItemConId=true
                    break
                }
            }
        }
        if(existeItemConId){
            itemConId.jsonNot=jsonNot
        }else{
            //t=Text Message
            //ad=Auto Destroy
            //adti=Auto Destroy Time
            let vAD=false
            let vADTI=10000
            if((''+ad).indexOf('undefined')<0)vAD=ad
            if((''+adti).indexOf('undefined')<0)vADTI=adti
            let obj=compNot.createObject(col, {jsonNot: jsonNot, ad: vAD, adTimerInterval: vADTI})
        }
    }
}