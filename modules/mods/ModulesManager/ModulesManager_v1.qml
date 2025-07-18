import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt.labs.settings 1.1

import ZoolButton 1.0
import ZoolText 1.1

//import mods.ModulesManager.ModulesLoader 1.0

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor

    property int hp: r.parent.height//-app.fs

    property var panelActive
    property alias s: settings
    property int currentIndex: -1

    visible: zsm.aPanelsIds.indexOf(app.j.qmltypeof(r))===zsm.currentIndex

    Settings{
        id: settings
        fileName: unik.getPath(4)+'/ModulesManager.cfg'
        property string currentQmlTypeShowed: 'ModulesLoader'//'Intelink'
    }

    Item{
        id: xSections
        width: r.width
        height: r.hp
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Component.onCompleted: {
        zsm.aPanelsIds.push(app.j.qmltypeof(r))
        zsm.aPanelesTits.push('Extras')
        r.showSection(s.currentQmlTypeShowed)
        r.panelActive=r.getSection(s.currentQmlTypeShowed)

        loadCurrentModule()
    }

    function showSection(qmltype){
        let newCi=-1
        for(var i=0;i<xSections.children.length;i++){
            let o=xSections.children[i]
            o.visible=false
        }
        for(i=0;i<xSections.children.length;i++){
            let o=xSections.children[i]
            if(app.j.qmltypeof(o)!==qmltype){
                o.visible=false
            }else{
                o.visible=true
                newCi=i
            }
        }
        s.currentQmlTypeShowed=qmltype
        if(newCi)r.currentIndex=newCi
        //zsm.currentSectionFocused=r
        apps.zFocus='xLatIzq'
    }
    function getSection(typeOfSection){
        let obj
        for(var i=0;i<xSections.children.length;i++){
            let o=xSections.children[i]//.children[0]
            //if(apps.dev)log.lv('getPanel( '+typeOfSection+' ): ' +app.j.qmltypeof(o))
            if(''+app.j.qmltypeof(o)===''+typeOfSection){
                obj=o
                break
            }
        }
        return obj
    }
    function getSectionVisible(){
        let obj=xSections.children[0]
        for(var i=0;i<xSections.children.length;i++){
            let o=xSections.children[i]//.children[0]
            //if(apps.dev)log.lv('getPanel( '+typeOfSection+' ): ' +app.j.qmltypeof(o))
            if(o.visible){
                obj=o
                break
            }
        }
        return obj
    }

    //-->Teclado
    function toEnter(ctrl){
        getSectionVisible().toEnter(ctrl)
    }
    function clear(){
        getSectionVisible().clear()
    }
    function toLeft(ctrl){
        if(!ctrl){
            getSectionVisible().toLeft()
        }else{
            if(r.currentIndex>0){
                r.currentIndex--
            }else{
                r.currentIndex=1
            }
            if(r.currentIndex===0){
                showSection('ZoolFileMaker')
            }else{
                showSection('ZoolFileLoader')
            }
        }
    }
    function toRight(ctrl){
        if(!ctrl){
            getSectionVisible().toRight()
        }else{
            if(r.currentIndex===0){
                r.currentIndex=1
            }else{
                r.currentIndex=0
            }
            if(r.currentIndex===0){
                showSection('ZoolFileMaker')
            }else{
                showSection('ZoolFileLoader')
            }
        }
    }
    function toUp(){
        getSectionVisible().toUp()
    }
    function toDown(){
        getSectionVisible().toDown()
    }
    function toTab(){
        getSectionVisible().toTab()
    }
    function toEscape(){
        let i=getSectionVisible()
        if(i)getSectionVisible().toEscape()
    }
    function isFocus(){
        let i=getSectionVisible()
        return i?i.isFocus():false
    }
    function toHelp(){
        getSectionVisible().toHelp()
    }
    //<--Teclado

    property bool hasUnUsedFunction: true
    function unUsed(){
        for(var i=0;i<xSections.children.length;i++){
            let o=xSections.children[i]
            if(o.hasUnUsedFunction){
                o.unUsed();
                //log.lv('Panel Anterior con unUsed(): '+panelType)
            }else{
                //log.lv('Panel Anterior sin unUsed(): '+panelType)
            }
        }
    }

    //-->Funciones de Panel de Herramientas Extras
    function loadCurrentModule(){
        //zpn.log('uModule: '+s.currentQmlTypeShowed)
        for(var i=0;i<xSections.children.length; i++){
            xSections.children[0].destroy(0)
        }
        //let extrasModsPath=unik.getPath(5)+'/modules/mods/ModulesManager'
        let c='import mods.ModulesManager.'+s.currentQmlTypeShowed+' 1.0\n'
        c+=''+s.currentQmlTypeShowed+'{}\n'
        let comp=Qt.createQmlObject(c, xSections, 'loadcurrentmodules-code')
    }
    function loadModule(moduleName, version){
        //zpn.log('Loading '+moduleName+' version '+version)
        for(var i=0;i<xSections.children.length; i++){
            xSections.children[0].destroy(0)
        }
        //let extrasModsPath=unik.getPath(5)+'/modules/mods/ModulesManager'
        let c='import mods.ModulesManager.'+moduleName+' '+version+'\n'
        c+=''+moduleName+'{}\n'
        let comp=Qt.createQmlObject(c, xSections, 'loadcurrentmodules-code')
    }
    //<--Funciones de Panel de Herramientas Extras
}
