import QtQuick 2.12
import QtQuick.Controls 2.12
import '../../comps' as Comps

import ZoolDataText 1.0
import ZoolFileExtDataManager 1.2
import ZoolFileManager 1.3
import ZoolListLunar 1.0
import ZoolSabianos 1.1
import ZoolRevolutionList 1.5
import ZoolNumPit 1.1
import ZoolModulesManager 1.0
import ZoolHelp 1.0

import ZoolButton 1.2

import web.ZoolUserManager 1.0

Item{
    id: r
    width: xLatIzq.width
    height: xLatIzq.height//-indicatorSV.height-xPanelesTits.height
    clip: true
    property int currentIndex: count-1//apps.currentSwipeViewIndex
    property int count: indicatorSV.count
    property var aPanelsIds: []
    property var currentSectionFocused
    property var aPanelesTits: []
    property string uPanelIdHovered: ''
    onAPanelsIdsChanged: {
        indicatorSV.count=aPanelsIds.length
    }
    onCurrentIndexChanged:{
        apps.currentSwipeViewIndex=currentIndex
        r.showPanel(r.aPanelsIds[zsm.currentIndex])
        zsm.getPanel('ZoolRevolutionList').desactivar()
    }
    MouseArea{
        anchors.fill: parent
    }
    Column{
        width: r.width
        anchors.centerIn: parent
        Rectangle{
            id: xPanelesTits
            width: xLatIzq.width
            height: r.aPanelesTits[zsm.currentIndex]?app.fs*0.6:0
            color: apps.fontColor
            anchors.horizontalCenter: parent.horizontalCenter

            Text{
                text: parseInt(zsm.currentIndex + 1)+': '+r.aPanelesTits[zsm.currentIndex]
                color: apps.backgroundColor
                font.pixelSize: app.fs*0.5
                anchors.centerIn: parent
            }
        }

        Item{
            id: xPanels
            width: r.width
            height: r.height-xPanelesTits.height-xIndicadorSV.height

            //10
            Comps.XPaneles{ZoolHelp{id: zoolHelp;}}

            //9
            Comps.XPaneles{ZoolDataText{id: panelZoolText;}}

            //8
            Comps.XPaneles{Comps.PanelZoolData{id: panelZoolData}}

            //6
            Comps.XPaneles{ZoolSabianos{id: panelSabianos}}

            //5
            Comps.XPaneles{ZoolNumPit{id: ncv}}

            //4
            Comps.XPaneles{ZoolRevolutionList{id: panelRsList}}

            //3
            Comps.XPaneles{ZoolListLunar{id: zoolListLunar;}}

            //2
            Comps.XPaneles{ZoolFileExtDataManager{id: zoolFileExtDataManager;}}


            //1
            Comps.XPaneles{ZoolFileManager{id: zoolFileManager}}
        }
        Rectangle{
            id: xIndicadorSV
            width: xLatIzq.width
            height: indicatorSV.height
            color: 'transparent'
            anchors.horizontalCenter: parent.horizontalCenter
            Rectangle{
                id: container
                width: r.width-app.fs
                height: txtUPanelIdHovered.contentHeight+app.fs*0.25
                color: apps.fontColor
                border.width: 2
                border.color: 'blue'
                radius: app.fs*0.25
                anchors.bottom: parent.top
                anchors.bottomMargin: app.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                visible: r.uPanelIdHovered!==''
                property int minFontSize: 10 // Tamaño mínimo de fuente permitido
                property int maxFontSize: app.fs

                Text{}
                Text{
                    id: txtUPanelIdHovered
                    text: r.uPanelIdHovered
                    //width: contentWidth
                    font.pixelSize: app.fs
                    color: apps.backgroundColor
                    anchors.centerIn: parent
                    onTextChanged: ajustarTamanioFuente()
                    function ajustarTamanioFuente() {
                                    var newFontSize = container.maxFontSize;
                                    txtUPanelIdHovered.font.pixelSize = newFontSize;
                                    while (txtUPanelIdHovered.contentWidth > container.width-app.fs && newFontSize > container.minFontSize) {
                                        newFontSize -= 1;
                                        txtUPanelIdHovered.font.pixelSize = newFontSize;
                                    }
                                    tHideTxtUPanelId.restart()
                                }
                }
                Timer{
                    id: tHideTxtUPanelId
                    running: false
                    repeat: false
                    interval: 5000
                    onTriggered: r.uPanelIdHovered=''
                }

            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    apps.zFocus='xLatIzq'
                }
            }
            PageIndicator {
                id: indicatorSV
                interactive: true
                count: 0//zsm.aPanelsIds.length
                currentIndex: apps.currentSwipeViewIndex//zsm.currentIndex
                anchors.centerIn: parent
                onCurrentIndexChanged: zsm.currentIndex=currentIndex
                delegate: Rectangle{
                    width: app.fs*0.5
                    height: width
                    radius: width / 2
                    color: apps.fontColor
                    opacity: index === indicatorSV.currentIndex?0.95: pressed ? 0.7: 0.45
                    Text{
                        text:'\uf26c'
                        font.family: "FontAwesome"
                        font.pixelSize: parent.width*0.6
                        color: apps.backgroundColor
                        anchors.centerIn: parent
                        visible: index===0&&apps.repLectVisible
                    }
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onPositionChanged: r.uPanelIdHovered=r.aPanelesTits[index]
                        onEntered: {
                            //log.lv('PageIndicator: '+r.aPanelsIds[index])
                            r.uPanelIdHovered=r.aPanelesTits[index]
                        }
                        onExited: {
                            //log.lv('PageIndicator exited... ')
                            r.uPanelIdHovered=''
                        }
                        onClicked: {
                            zsm.currentIndex=index
                            if (mouse.modifiers) {
                                apps.repLectVisible=!apps.repLectVisible
                            }
                        }
                    }
                }
                Timer{
                    running: parent.count===0
                    repeat: true
                    interval: 1000
                    onTriggered: parent.count=zsm.aPanelsIds.length
                }
            }
            ZoolButton{
                text:'\uf0ab'
                width: parent.height-4
                height: width
                rotation: 90
                borderWidth: 0
                borderColor: 'transparent'
                colorInverted: true
                anchors.verticalCenter: xIndicadorSV.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 2
                onClicked: {
                    if(r.currentIndex>0)r.currentIndex--
                }
            }
            ZoolButton{
                text:'\uf0ab'
                width: parent.height-4
                height: width
                rotation: -90
                colorInverted: true
                anchors.verticalCenter: xIndicadorSV.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 2
                onClicked: {
                    if(r.currentIndex<r.count)r.currentIndex++
                }
            }
        }

    }
    Timer{
        running: true
        repeat: false
        interval: 2000
        onTriggered: {
            showPanel(r.aPanelsIds[apps.currentSwipeViewIndex])
            //r.currentIndex=apps.currentSwipeViewIndex
        }
    }
    function getPanel(typeOfSection){
        let obj
        for(var i=0;i<xPanels.children.length;i++){
            let o=xPanels.children[i].children[0]
            //if(apps.dev)log.lv('getPanel( '+typeOfSection+' ): ' +app.j.qmltypeof(o))
            if(''+app.j.qmltypeof(o)===''+typeOfSection){
                obj=o
                break
            }
        }
        return obj
    }
    function showPanel(typeOfSection){
        //let newCi=-1
        for(var i=0;i<xPanels.children.length;i++){
            let o=xPanels.children[i].children[0]
            //if(apps.dev)log.lv('getPanel( '+typeOfSection+' ): ' +app.j.qmltypeof(o))
            if(''+app.j.qmltypeof(o)===''+typeOfSection){
                o.visible=true
                //newCi=i
                r.currentSectionFocused=o
            }else{
                o.visible=false
            }
        }
        //r.currentIndex=newCi
    }
    function getPanelIndex(typeOfSection){
        let ci=-1
        let obj
        for(var i=0;i<xPanels.children.length;i++){
            let o=xPanels.children[i].children[0]
            if(apps.dev)log.lv('getPanel( '+typeOfSection+' ): ' +app.j.qmltypeof(o))
            if(''+app.j.qmltypeof(o)===''+typeOfSection){
                obj=o
                ci=zsm.aPanelsIds.indexOf(app.j.qmltypeof(o))
                break
            }
        }

        return ci
    }
}
