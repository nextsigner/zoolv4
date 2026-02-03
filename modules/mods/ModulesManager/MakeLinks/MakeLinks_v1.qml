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
        property var aCriterios: []
        property var aCriteriosCb: []
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
                    Rectangle{
                        id: xRow1
                        width: row1.width+app.fs*0.5
                        height: cbCriterio.height+app.fs*0.5
                        color: 'transparent'
                        border.width: 0
                        border.color: 'red'
                        anchors.horizontalCenter: parent.horizontalCenter
                        Row{
                            id: row1
                            height: app.fs*2
                            spacing: app.fs*0.5
                            //anchors.horizontalCenter: parent.horizontalCenter
                            anchors.centerIn: parent
                            Text{
                                text: 'Contexto o Criterio de Consulta: '
                                font.pixelSize: app.fs*0.5
                                color: apps.fontColor
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            ComboBox{
                                id: cbCriterio
                                width: r.width*0.3
                                height: app.fs
                                font.pixelSize: app.fs*0.5
                                anchors.verticalCenter: parent.verticalCenter
                                onCurrentIndexChanged: {
                                    txtDesCriterio.text=r.aCriteriosCb[currentIndex]
                                }
                            }
                        }
                    }
                    Rectangle{
                        width: xRow1.width
                        height: txtDesCriterio.contentHeight+app.fs*0.5
                        color: 'transparent'
                        border.width: 1
                        border.color: apps.fontColor
                        radius: app.fs*0.25
                        Text{
                            id: txtDesCriterio
                            text: ''
                            width: parent.width-app.fs*0.5
                            //height: contentHeight+app.fs*0.5
                            font.pixelSize: app.fs*0.5
                            color: apps.fontColor
                            wrapMode: Text.WordWrap
                            anchors.centerIn: parent
                        }
                    }
                    Item{width: 1; height: app.fs*0.5}
                    Row{
                        spacing: app.fs*0.5
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text{
                            text: 'Gemini: '
                            font.pixelSize: app.fs*0.5
                            color: apps.fontColor
                        }
                        ZoolButton{
                            text: 'Abrir Navegador Google Modo IA'
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
                            text: 'Abrir Navegador Gemini (Experimental)'
                            onClicked:{
                                let cons=getConsCarta()
                                let url = getGeminiUrl(cons)
                                Qt.openUrlExternally(url);
                            }
                        }
                        ZoolButton{
                            text: 'Copiar Link de Consulta'
                            anchors.verticalCenter: parent.horizontalCenter
                            onClicked:{
                                let cons=getConsCarta()
                                clipboard.setText(getGeminiUrl(cons))
                                zpn.logTemp('Se ha copiado la consulta en el portapapeles.', 5000)
                            }
                        }
                    }
                    Item{width: 1; height: app.fs*0.5}
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
                        ZoolButton{
                            text: 'Copiar Link de Consulta'
                            anchors.verticalCenter: parent.horizontalCenter
                            onClicked:{
                                let cons=getConsCarta()
                                clipboard.setText(getChatGptUrl(cons))
                                zpn.logTemp('Se ha copiado la consulta en el portapapeles.', 5000)
                            }
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

        r.aCriterios.push('Solo Psicológico (Freudiano)')
        r.aCriteriosCb.push('solo psicológico y no espiritual  desde la perspectiva de Freudiano')

        r.aCriterios.push('Psicológico / Espiritual (Junguiano)')
        r.aCriteriosCb.push('psicológico y de evolución espiritual desde la perspectiva de Carl. G. Jung')

        r.aCriterios.push('Antropológico, Social y Cultural')
        r.aCriteriosCb.push('antropológico, social y cultural')

        r.aCriterios.push('Kármica / Evolutiva')
        r.aCriteriosCb.push('Kármica / Evolutiva, desde la perspectiva del viaje del alma, lecciones de vidas pasadas (nodos lunares) y el propósito de crecimiento espiritual')

        r.aCriterios.push('Psicológica Humanista')
        r.aCriteriosCb.push('psicológica humanista, enfoque en el libre albedrío y el crecimiento personal. Evita el determinismo; los planetas son funciones psicológicas para la autorrealización')

        r.aCriterios.push('Tradicional / Helenística')
        r.aCriteriosCb.push('tradicional, Helenística, usando un enfoque técnico y predictivo basado en dignidades esenciales, regencias y el estado cósmico de los planetas. Sé concreto y directo')

        r.aCriterios.push('Transgeneracional / Sistémica')
        r.aCriteriosCb.push('transgeneracional, sistémica, analizando la carta como un mapa de herencias familiares, buscando patrones de ancestros, lealtades invisibles y sanación del árbol genealógico')

        r.aCriterios.push('Vocacional / Económica')
        r.aCriteriosCb.push('vocacional, económica, céntrate exclusivamente en el potencial profesional, la generación de recursos, talentos innatos para el trabajo y el éxito material')

        r.aCriterios.push('Arquetípica / Mitológica')
        r.aCriteriosCb.push('arquetípica, mitológica, usa un lenguaje poético y profundo. Relaciona las posiciones planetarias con mitos griegos y figuras arquetípicas de la psique colectiva')

        r.aCriterios.push('Alquímica / Transmutación')
        r.aCriteriosCb.push('alquímica, transmutación, interpreta los aspectos como procesos de transformación de la materia interna, enfocándote en la transmutación de sombras en virtudes')

        r.aCriterios.push('Socio-Cultural')
        r.aCriteriosCb.push('socio-Cultural, analiza cómo el individuo se inserta en el colectivo actual, sus desafíos ante las estructuras de poder y su rol en los movimientos sociales')

        r.aCriterios.push('Médica / Holística')
        r.aCriteriosCb.push('médica, holística, relaciona los elementos y signos con el equilibrio energético del cuerpo, tendencias somáticas y sugerencias de bienestar integral')

        r.aCriterios.push('Relacional / Sinastría')
        r.aCriteriosCb.push('relacional, sinastría, enfocado en el -yo frente al otro-. Cómo el individuo proyecta su energía en pareja, socios y vínculos estrechos')

        cbCriterio.model=r.aCriterios
        txtDesCriterio.text=r.aCriteriosCb[0]
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
        let ret='Consulta Astrológica. Dime cómo se manifiesta las siguientes influencias astrológicas de una persona nacida con la siguiente carta natal. De momento solo dime sobre el sol y al final recuerdame que debo escribir siguiente o s para ir interpretando las manifestaciones de los demás cuerpos astrológicos listados. Sobre cada cuerpo debes decirme 10 manifestaciones positivas y 10 negativas. Enfócate en interpretarlo desde el siguiente punto de vista,  '+r.aCriteriosCb[cbCriterio.currentIndex]+'. Lista: '
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
