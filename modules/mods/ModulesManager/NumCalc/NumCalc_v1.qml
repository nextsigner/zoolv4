import QtQuick 2.0
import QtQuick.Controls 2.0
import Qt.labs.settings 1.1
import QtGraphicalEffects 1.0

import comps.FocusSen 1.0
import ZoolButton 1.2
import ZoolText 1.4
import ZoolTextInput 1.1

//import ZoolLogView 1.0

import mods.ModulesManager.NumCalc.NumCalcLog 1.0

Item{
    id: rMod
    width: 1
    height: 1
    objectName: 'NumCalc'
    property string moduleName: 'NumCalc'
    property var aParents: [capa101]
    property bool enableChangeArea: false

    property int senLineWidth: app.fs*0.25
    property color cLineColor: 'red'

    Settings{
        id: s
        fileName: u.getPath(4)+'/module_'+r.moduleName+'.cfg'        
    }
    Rectangle{
        id: r
        width: parent.width
        height: parent.parent.height
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
        Column{
            id: col
            anchors.centerIn: parent
            spacing: app.fs*0.25
            Item{width: 1; height: app.fs*0.25}
            Text{
                id: txtTit
                text:'<b>NumCalc</b> Ingresa una fecha de nacimiento bajo el siguiente formato: 20.6.1975'
                font.pixelSize: app.fs*0.5
                color: apps.fontColor
                anchors.horizontalCenter: parent.horizontalCenter
                //visible: false
            }
            ZoolTextInput{
                id: tiSearch
                width: r.width-app.fs*0.5
                t.font.pixelSize: app.fs*0.65
                t.parent.width: r.width-app.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                //KeyNavigation.tab: cbGenero//controlTimeFecha
                t.maximumLength: 100
                borderColor:apps.fontColor
                borderRadius: app.fs*0.25
                padding: app.fs*0.25
                t.horizontalAlignment: TextInput.AlignLeft
                onTextChanged: printNumMision()
                onEnterPressed: {
                    //printNumMision()
                }
                FocusSen{
                    width: parent.rx.width
                    height: parent.rx.height
                    radius: parent.rx.radius
                    border.width:2
                    anchors.centerIn: parent
                    visible: parent.t.focus
                }
                Text {
                    text: 'Calcular'
                    font.pixelSize: app.fs*0.5
                    color: 'white'
                    //anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                }
            }

            NumCalcLog{
                id: log
                width: r.width
                height: r.height-app.fs*3
                visible: true
            }

        }
        ZoolButton{
            id: botChangeArea
            text:'Cerrar'
            fs: app.fs*0.35
            colorInverted: true
            anchors.right: parent.right
            anchors.rightMargin: app.fs*0.1
            anchors.top: parent.top
            anchors.topMargin: app.fs*0.1
            onClicked: {
                zsm.getPanel('ModulesManager').loadModule('ModulesLoader', '1.0')
            }
        }
    }
    Component.onCompleted: {
        app.ci=rMod
        r.parent=capa101
        tiSearch.t.focus=true
    }
    function printNumMision(){
        var finalText=''
        let mfecha=tiSearch.t.text.split('.')
        let sformula=''
        if(!mfecha[0]||!mfecha[1]||!mfecha[2]||mfecha[2].length<4){
            log.clear()
            log.setText('Esperando que escribas la fecha completa.')
            return
        }
        let d=mfecha[0]
        let m=mfecha[1]
        let a = mfecha[2]
        let sf=''+d+'/'+m+'/'+a
        let aGetNums=app.j.getNums(sf)
        //currentNumNacimiento=aGetNums[0]
        finalText+='Número de Sendero/Camino de Vida: '+aGetNums[0]+'\n'
        if(parseInt(aGetNums[3])>0){
            finalText+='Número Karmaico: '+aGetNums[3]+'\n'
        }

        let msfd=(''+d).split('')
        let sfd=''+msfd[0]
        if(msfd.length>1){
            sfd +='+'+msfd[1]
        }
        let msfm=(''+m).split('')
        let sfm=''+msfm[0]
        if(msfm.length>1){
            sfm +='+'+msfm[1]
        }
        //let msform=(''+a).split('')
        let msfa=(''+a).split('')
        let sfa=''+msfa[0]
        if(msfa.length>1){
            sfa +='+'+msfa[1]
        }
        if(msfa.length>2){
            sfa +='+'+msfa[2]
        }
        if(msfa.length>3){
            sfa +='+'+msfa[3]
        }
        let sform= sfd + '+' + sfm + '+' + sfa//msform[0] + '+' + msform[1] + '+'  + msform[2]+ '+'  + msform[3]
        let sum=0
        let mSum=sform.split('+')
        for(var i=0;i<mSum.length;i++){
            sum+=parseInt(mSum[i])
        }
        let mCheckSum=(''+sum).split('')
        if(mCheckSum.length>1){
            if(sum===11||sum===22||sum===33){
                //r.esMaestro=true
            }
            let dobleDigSum=parseInt(mCheckSum[0])+parseInt(mCheckSum[1])
            sform+='='+sum+'='+dobleDigSum
            let mCheckSum2=(''+dobleDigSum).split('')
            if(mCheckSum2.length>1){
                let dobleDigSum2=parseInt(mCheckSum2[0])+parseInt(mCheckSum2[1])
                sform+='='+dobleDigSum2
                //currentNumNacimiento=dobleDigSum2
            }else{
                //currentNumNacimiento=dobleDigSum
            }
        }else{
            //currentNumNacimiento=sum
        }
        finalText+=sform+'\n'
        log.setText(finalText)
    }

    //-->Teclado
    function toEnter(ctrl){
        if(!tiSearch.t.focus){
            tiSearch.t.focus=true
            return
        }
        printNumMision()

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
    function toUp(ctrl){

    }
    function toDown(ctrl){

    }
    function toTab(){

    }
    function toEscape(){
        if(tiSearch.t.focus){
            tiSearch.t.focus=false
            return
        }
        zsm.getPanel('ModulesManager').loadModule('ModulesLoader', '1.0')
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

    //-->Funciones de NumCalc
    //<--Funciones de NumCalc

}
