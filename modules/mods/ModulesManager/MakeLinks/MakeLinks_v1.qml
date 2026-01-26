import QtQuick 2.0
import QtQuick.Controls 2.0
import Qt.labs.settings 1.1

import ZoolButton 1.2
import comps.FocusSen 1.0
import ZoolButton 1.2
import ZoolText 1.4
import ZoolTextInput 1.1

import "../../../../comps" as Comps

Item{
    id: rMod
    width: 1
    height: 1
    property string moduleName: 'MakeLinks'
    property var aParents: [xMed, xLatIzq, xLatDer, capa101]
    Settings{
        id: s
        fileName: u.getPath(4)+'/module_'+r.moduleName+'.cfg'
        property int typeShow: 0
        onTypeShowChanged: {
            r.parent=rMod.aParents[s.typeShow]
        }
    }
    Rectangle{
        id: r
        width: parent.width
        height: parent.height
        border.width: 1
        border.color: apps.fontColor
        radius: app.fs*0.25
        color: apps.backgroundColor
        parent: zsm.getPanel('ModulesManager')
        MouseArea{
            anchors.fill: parent
            onDoubleClicked: {
                toNextArea()
            }
        }
//        Text{
//            text:'Presionar Escape para salir\no cerrar esta ventana'
//            font.pixelSize: app.fs*0.5
//            color: apps.fontColor
//            visible: rMod.parent===capa101
//        }
        Column{
            id: col
            anchors.centerIn: parent
            spacing: app.fs*0.5
            Item{width: 1; height: app.fs*0.5}
            Text{
                id: txtTit
                text:'<b>MakeLinks (Creador de enlaces)</b>'
                font.pixelSize: app.fs*0.5
                color: apps.fontColor
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Item{width: 1; height: app.fs*0.5}
            Comps.XMarco{
                width: r.width-app.fs
                Column{
                    spacing: app.fs*0.5
                    anchors.centerIn: parent
                    Row{
                        spacing: app.fs*0.5
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text{
                            text: 'Gemini: '
                            font.pixelSize: app.fs*0.5
                            color: apps.fontColor
                        }
                        ZoolButton{
                            text: 'Google Modo IA'
                            onClicked:{
                                //log.lv(getConsCarta())
                                let cons=getConsCarta()
                                //log.lv(cons)
                                //return
                                let url = getGeminiGoogleUrl(cons)
                                Qt.openUrlExternally(url);
                            }
                        }
                        ZoolButton{
                            text: 'Gemini (Experimental)'
                            onClicked:{
                                let cons=getConsCarta()
                                let url = getGeminiUrl(cons)
                                Qt.openUrlExternally(url);
                            }
                        }
                    }
                    Row{
                        spacing: app.fs*0.5
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text{
                            text: 'ChatGPT: '
                            font.pixelSize: app.fs*0.5
                            color: apps.fontColor
                        }
                        ZoolButton{
                            text: 'Ir a ChatGPT'
                            onClicked:{
                                //log.lv(getConsCarta())
                                let cons=getConsCarta()
                                //log.lv(cons)
                                //return
                                let url = getChatGptUrl(cons)
                                Qt.openUrlExternally(url);
                            }
                        }
                    }
                    ZoolButton{
                        text: 'Copiar Consulta'
                        anchors.horizontalCenter: parent.horizontalCenter
                        onClicked:{
                            let cons=getConsCarta()
                            clipboard.setText(cons)
                            zpn.logTemp('Se ha copiado la consulta en el portapapeles.', 5000)
                        }
                    }
                }
            }

        }
        Row{
            spacing: app.fs*0.1
            anchors.right: parent.right
            anchors.rightMargin: app.fs*0.1
            anchors.top: parent.top
            anchors.topMargin: app.fs*0.1
            ZoolButton{
                id: botChangeArea
                text:'Cambiar de Area'
                fs: app.fs*0.35
                colorInverted: true
                onClicked: {
                    toNextArea()
                }
            }
            ZoolButton{
                text:'X'
                fs: app.fs*0.35
                colorInverted: true
                onClicked: {
                    zsm.getPanel('ModulesManager').loadModule('ModulesLoader', '1.0')
                    rMod.destroy(0)
                }
            }
        }
    }
    Component.onCompleted: {
        app.ciPrev=app.ci
        app.ci=rMod
        r.parent=capa101

    }
    function getGeminiUrl(consulta) {
        let queryEncoded = encodeURIComponent(consulta);
        let url = "https://gemini.google.com/app?q=" + queryEncoded;
        return url
    }
    function getGeminiGoogleUrl(consulta) {
        let queryEncoded = encodeURIComponent(consulta);
        let url = "https://www.google.com/search?q=" + queryEncoded + "&udm=50";
        return  url
    }
    function getChatGptUrl(consulta) {
        let queryEncoded = encodeURIComponent(consulta);
        let url = "https://chatgpt.com/?q=" + queryEncoded;
        return url
    }
    function getConsCarta(){
        let ret='Consulta Astrológica. Dime cómo se manifiesta las siguientes influencias astrológicas de una persona nacida con la siguiente carta natal. De momento solo dime sobre el sol y al final recuerdame que debo escribir siguiente o s para ir interpretando las manifestaciones de los demás cuerpos astrológicos listados. Sobre cada cuerpo debes decirme 10 manifestaciones positivas y 10 negativas. Enfócate en interpretarlo desde un punto de vista psicológico y de evolución espiritual. Lista: '
        var i=0
        let j=zm.currentJson
        //log.lv(JSON.stringify(j, null, 2))
        for(i=0;i<zm.aBodies.length;i++){
            ret+=zm.aBodies[i]+' en '+zm.aSigns[j.pc['c'+i].is]+' en el grado '+j.pc['c'+i].rsgdeg+',\n'
        }
        ret+='Ascendente en '+zm.aSigns[j.ph['h1'].is]+' °'+j.ph['h1'].rsgdeg+',\n'
        ret+='Medio cielo en '+zm.aSigns[j.ph['h10'].is]+' °'+j.ph['h10'].rsgdeg+',\n'

        return ret
    }

    //-->Teclado
    function toEnter(ctrl){

    }
    function clear(){

    }
    function toLeft(ctrl){
        if(!ctrl){

        }else{

        }
    }
    function toRight(ctrl){
        if(!ctrl){

        }else{

        }
    }
    function toUp(){

    }
    function toDown(){

    }
    function toTab(){

    }
    function toEscape(){
        zsm.getPanel('ModulesManager').loadModule('ModulesLoader', '1.0')
        rMod.destroy(0)
    }
    function isFocus(){
        return false
    }
    function toHelp(){
        let itemHelpExist=zsm.cleanOneDinamicItems("ItemHelp_"+app.j.qmltypeof(r))
        if(!itemHelpExist){
            let text='<h2>Ayuda en Construcción</h2><br><br><b><b>Presionar F1: </b>Para ver u ocultar esta ayuda.'

            let c='import comps.ItemHelp 1.0\n'
            c+='ItemHelp{\n'
            c+='    text:"'+text+'"\n'
            c+='    ctx: "'+zsm.cPanelName+'"\n'
            c+='    objectName: "ItemHelp_'+app.j.qmltypeof(r)+'"\n'
            c+='}\n'
            let comp=Qt.createQmlObject(c, zsm, 'itemhelpcode')
        }
    }
    //<--Teclado

    //-->Funciones ModulesTemplate
    function toNextArea(){
        if(s.typeShow<rMod.aParents.length-1){
            s.typeShow++
        }else{
            s.typeShow=0
        }
        //zpn.log('s.fileName: '+s.fileName)
    }
    //<--Funciones ModulesTemplate
}
