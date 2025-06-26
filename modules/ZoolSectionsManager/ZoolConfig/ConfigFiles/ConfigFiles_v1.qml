import QtQuick 2.0
import QtQuick.Controls 2.0

import comps.FocusSen 1.0
import ZoolButton 1.0
import ZoolText 1.1
import ZoolTextInput 1.0

Rectangle{
    id: r
    width: parent.width-app.fs*0.5
    height: col.height+app.fs*0.5
    border.width: 1
    border.color: apps.fontColor
    radius: app.fs*0.25
    color: 'transparent'
    Column{
        id: col
        anchors.centerIn: parent
        spacing: app.fs*0.5
        ZoolText{
            text:'<b>Carpeta de Archivos</b>'
            fs: app.fs*0.5
        }
        ZoolText{
            text:apps.workSpace
            fs: app.fs*0.5
        }
        Row{
            spacing: app.fs*0.25
            anchors.horizontalCenter: parent.horizontalCenter
            ZoolText{
                text:'Usar Carpeta Temporal:'
                fs: app.fs*0.5
                anchors.verticalCenter: parent.verticalCenter
            }
            CheckBox{
                width: app.fs*0.5
                checked: apps.isJsonsFolderTemp
                anchors.verticalCenter: parent.verticalCenter
                onCheckedChanged:app.cmd.runCmd('temp-silent')
            }
        }
        ZoolTextInput{
            id: tiJsonsFolder
            text: apps.workSpace
            width: r.width-app.fs*0.5
            t.font.pixelSize: app.fs*0.65
            t.parent.width: r.width-app.fs*0.5
            anchors.horizontalCenter: parent.horizontalCenter
            //KeyNavigation.tab: cbGenero//controlTimeFecha
            t.maximumLength: 200
            borderColor:apps.fontColor
            borderRadius: app.fs*0.25
            padding: app.fs*0.25
            horizontalAlignment: TextInput.AlignLeft
            onTextChanged: if(cbPreview.checked)loadTemp()
            onEnterPressed: {
                apps.workSpace=text
            }
            FocusSen{
                width: parent.r.width
                height: parent.r.height
                radius: parent.r.radius
                border.width:2
                anchors.centerIn: parent
                visible: parent.t.focus
            }
            Text {
                text: 'Cambiar a carpeta'
                font.pixelSize: app.fs*0.5
                color: 'white'
                //anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
            }
        }



    }
    //-->Teclado
    function toEnter(ctrl){
        //log.lv('ConfigFiles.toEnter('+ctrl+')')
        apps.workSpace=tiJsonsFolder.text
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
        log.lv('ConfigFiles.toTab()')
        tiJsonsFolder.t.focus=true
        tiJsonsFolder.t.selectAll()
    }
    function toEscape(){
        tiJsonsFolder.t.focus=false
    }
    function isFocus(){
        return tiJsonsFolder.t.focus
    }
    function toHelp(){

    }
    //<--Teclado
}
