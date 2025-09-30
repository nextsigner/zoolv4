import QtQuick 2.0
import QtQuick.Controls 2.0

import comps.FocusSen 1.0
import ZoolButton 1.0
import ZoolText 1.3
import ZoolTextInput 1.0
import Qt.labs.settings 1.1

Rectangle{
    id: r
    width: parent.width-app.fs*0.5
    height: col.height+app.fs*0.5
    border.width: 1
    border.color: apps.fontColor
    radius: app.fs*0.25
    color: 'transparent'
    Settings{
        id: s
        fileName: u.getPath(4)+'/zool_asps.cfg'
        //property var aAsps: [1, 1, 1, 1, 1, 1, 1]
        property var sAsps: '1.1.1.1.1.1.1'
    }
    Column{
        id: col
        anchors.centerIn: parent
        spacing: app.fs*0.5
        Text{
            text:'<b>Configurar Aspectos</b>'
            font.pixelSize: app.fs*0.5
            color: apps.fontColor
        }
        Item{width: 1; height: app.fs*0.5}
        Rectangle{
            width: r.width-app.fs*0.25
            height: flow1.height+app.fs//*0.25
            color: 'transparent'
            border.width: 1
            border.color: apps.fontColor
            anchors.horizontalCenter: parent.horizontalCenter
            // -1 = no hay aspectos. 0 = oposición. 1 = cuadratura. 2 = trígono. 3 = conjunción. 4 = sextil. 5 = semicuadratura. 6 = quincuncio
            Flow{
                id: flow1
                spacing: app.fs*0.5
                width: parent.width-app.fs*0.5
                anchors.centerIn: parent
                Repeater{
                    model: ['Oposición', 'Cuadratura', 'Trígono', 'Conjunción', 'Sextil', 'Semicuadratura', 'Quincuncio']
                    Rectangle{
                        width: row1.width+app.fs*0.5
                        height: l.contentHeight+app.fs*0.5
                        color: 'transparent'
                        border.width: 1
                        border.color: apps.fontColor
                        Row{
                            id: row1
                            anchors.centerIn: parent
                            Text{
                                id: l
                                text: modelData
                                font.pixelSize: app.fs*0.5
                                color: apps.fontColor
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            CheckBox{
                                checked: s.sAsps.split('.')[index]==='1'
                                anchors.verticalCenter: parent.verticalCenter
                                onCheckedChanged: setCheckedAsps(index, checked)
                            }
                        }
                    }
                }
            }
        }
    }

    function setCheckedAsps(index, checked){
        //zpn.log('index= '+index+' checked: '+checked)
        let aS=s.sAsps.split('.')
        let nS=''
        for(var i=0;i<aS.length;i++){
            //s.sAsps.split('.')[index]
            let num='2'
            if(i!==index){
                num=aS[i]
            }else{
                num=checked?'1':'0'
            }
            if(i===0){
                nS+=num
            }else{
                nS+='.'+num
            }

        }
        s.sAsps=nS
        zpn.log('s.sAsps = '+s.sAsps)
        //s.aAsps[index]=checked?0:1
        //zpn.log('-> s.aAsps['+index+'] = '+s.aAsps[index])
    }

    //-->Teclado
    function toEnter(ctrl){
        //log.lv('ConfigFiles.toEnter('+ctrl+')')
        if(!u.folderExist(tiJsonsFolder.text)){
            u.mkdir(tiJsonsFolder.text)
            if(!u.folderExist(tiJsonsFolder.text)){
                tiJsonsFolder.t.color='red'
            }else{
                tiJsonsFolder.t.color=apps.fontColor
                apps.workSpace=tiJsonsFolder.text
                status.s=s+'\n\nLa carpeta no existía y se ha creado correctamente.'
            }
        }else{
            t.color=apps.fontColor
            apps.workSpace=tiJsonsFolder.text
        }
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
        //zpn.log('ConfigFiles.toTab()')
        tiJsonsFolder.t.focus=true
        tiJsonsFolder.t.selectAll()
    }
    function toEscape(){
        tiJsonsFolder.text=apps.workSpace
        tiJsonsFolder.t.focus=false
    }
    function isFocus(){
        return false
    }
    function toHelp(){
        let itemHelpExist=zsm.cleanOneDinamicItems("ItemHelp_"+app.j.qmltypeof(r))
        if(!itemHelpExist){
            let text='<h2>Ayuda para realizar ajustes en Archivos</h2><br><br><b>Presionar TAB: </b>Para saltar de un campo de introducción de datos a otro.<br><br><b>Presionar CTRL+ENTER: </b>Se graba o define el dato y se salta hacia el otro campo de introducción de datos.<br><br><b>Presionar F1: </b>Para ver u ocultar esta ayuda.'

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
}
