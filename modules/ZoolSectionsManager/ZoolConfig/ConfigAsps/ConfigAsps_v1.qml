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
    border.width: 0
    //border.color: apps.fontColor
    //radius: app.fs*0.25
    color: 'transparent'
    anchors.horizontalCenter: parent.horizontalCenter
    Settings{
        id: s
        fileName: u.getPath(4)+'/zool_asps.cfg'
        property int asp1
        property int asp2
        property int asp3
        property int asp4
        property int asp5
        property int asp6
        property int asp7
    }
    Column{
        id: col
        anchors.centerIn: parent
        spacing: app.fs*0.5
        //Item{width: 1; height: app.fs*0.5}
        Text{
            text:'<b>Configurar Aspectos</b>'
            font.pixelSize: app.fs*0.5
            color: apps.fontColor
        }
        Item{width: 1; height: app.fs*0.5}
        Text{
            text:'Seleccionar qué Aspectos se visualizan'
            width: r.width-app.fs
            wrapMode: Text.WordWrap
            font.pixelSize: app.fs*0.5
            color: apps.fontColor
        }
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
                            spacing: 0//app.fs*0.25
                            anchors.centerIn: parent
                            Rectangle{
                                width: app.fs*0.5
                                height: width
                                color: zm.objAspsCircle.aAspsColors[index]
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Text{
                                id: l
                                text: modelData
                                width: contentWidth+app.fs*0.5
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: app.fs*0.5
                                color: apps.fontColor
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            CheckBox{
                                //checked: getCheckedAsps(index)//s.sAsps.split('.')[index]==='1'
                                checked: index===0?s.asp1:(index===1?s.asp2:(index===2?s.asp3:(index===3?s.asp4:(index===4?s.asp5:(index===5?s.asp6:index===6?s.asp7:0)))))
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
        if(index===0)s.asp1=checked?1:0
        if(index===1)s.asp2=checked?1:0
        if(index===2)s.asp3=checked?1:0
        if(index===3)s.asp4=checked?1:0
        if(index===4)s.asp5=checked?1:0
        if(index===5)s.asp6=checked?1:0
        if(index===6)s.asp7=checked?1:0
        zm.objAspsCircle.updateAllAsps()
        if(zm.ev)zm.objAspsCircleBack.updateAllAsps()

        let jsonAsps=zm.objAspsCircle.getAsps(zm.currentJson)
        zm.objZoolAspectsView.load(jsonAsps)
        if(zm.ev && zm.currentJsonBack){
            let jsonAspsExt=zm.objAspsCircleBack.getAsps(zm.currentJsonBack)
            zm.objZoolAspectsViewBack.load(jsonAsps)
        }
    }
    function getCheckedAsps(index){
        let ret=0
        if(index===0)return s.asp1?s.asp1:1
        if(index===1)return s.asp2?s.asp2:1
        if(index===2)return s.asp3?s.asp3:1
        if(index===3)return s.asp4?s.asp4:1
        if(index===4)return s.asp5?s.asp5:0
        if(index===5)return s.asp6?s.asp6:0
        if(index===6)return s.asp7?s.asp7:0
        return ret===1?true:false
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
        //tiJsonsFolder.text=apps.workSpace
        //tiJsonsFolder.t.focus=false
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
