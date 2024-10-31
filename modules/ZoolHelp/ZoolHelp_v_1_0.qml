import QtQuick 2.12
import ZoolButton 1.2

Rectangle{
    id: r
    width: parent.width
    height: parent.height
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor
    property int svIndex: zsm.currentIndex
    property int itemIndex: -1
    property int fs: app.fs*0.75
    property var aAsuntos: ['Inicio', 'Teclado', 'Mouse', 'Mapa Astrológico', 'Panel Cuerpos', 'Panel Secciones', 'Advertencias', 'Agradecimientos', 'Sobre Qt']
    property string uAsunto: 'Inicio'
    Column{
        id: col0
        spacing: app.fs*0.25
        anchors.centerIn: parent
        Rectangle{
            id: xCab
            width: r.width
            height: flow.height
            color: apps.backgroundColor
            border.width: 1
            border.color: apps.fontColor
            clip: true
            Flow{
                id: flow
                spacing: app.fs*0.1
                width: r.width-app.fs
                anchors.centerIn: parent
                Repeater{
                    model: r.aAsuntos
                    ZoolButton{
                        text: modelData
                        colorInverted: r.uAsunto===modelData
                        onClicked:{
                            r.uAsunto=modelData
                            getData(index)
                        }
                    }
                }
            }
        }
        Rectangle{
            id: xTxtData
            width: r.width
            height: r.height-xCab.height-app.fs*0.5
            color: apps.backgroundColor
            border.width: 1
            border.color: apps.fontColor
            clip: true
            Flickable{
                id: flk
                anchors.fill: parent
                contentWidth: parent.width
                contentHeight: txtData.contentHeight+app.fs
                Text{
                    id: txtData
                    text: '<b>Ayuda (Area en construcción)</b>'
                    font.pixelSize: r.fs*0.65
                    color: apps.fontColor
                    textFormat: Text.MarkdownText
                    width: xTxtData.width-app.fs
                    anchors.horizontalCenter: parent.horizontalCenter
                    //anchors.centerIn: parent
                    //textFormat: Text.MarkdownText
                    wrapMode: Text.WordWrap
                }
            }
        }

        //        ZoolButton{
        //            text: 'Activar Chat de Twitch'
        //            anchors.horizontalCenter: parent.horizontalCenter
        //            onClicked:{
        //                mkTwichChat()
        //            }
        //        }

        //        TwitchChat_v_1_0{
        //            width: r.width
        //            height: app.fs*30
        //            anchors.horizontalCenter: parent.horizontalCenter
        //        }
    }

    Component.onCompleted: {
        zsm.aPanelsIds.push(app.j.qmltypeof(r))
        zsm.aPanelesTits.push('Ayuda')
        getData(0)
    }
    function getData(index){
        let fn='./modules/ZoolHelp/'+(r.aAsuntos[index]).replace(/ /g, '_')+'.md'
        if(!unik.fileExist(fn)){
            let data='## '+r.aAsuntos[index]
            unik.setFile(fn, data)
            txtData.text='Archivo creado: '+fn
            return
        }
        let fd=unik.getFile(fn)
        txtData.text=fd
    }
    function mkTwichChat(){

    }
}
