import QtQuick 2.0
import QtGraphicalEffects 1.0
import "../"
import "../../../comps" as Comps

import ZoolBodies.ZoolBodie 1.0
//import ZoolBodies.ZoolAsCotaDeg 1.0
//import ZoolBodies.ZoolAsCotaText 1.0

Item{
    id: r
//    width: apps.xAsShowIcon?
//               /*Mostrando Imagen*/
//               (parent.width-(r.fs*objData.p)-sweg.objSignsCircle.w-(!apps.showNumberLines?0:r.fs*2)-widthRestDec):
//               /*Mostrando Símbolo de Planeta*/
//               (parent.width-(sweg.objPlanetsCircle.planetSize*2*objData.p)-sweg.objSignsCircle.w-(!apps.showNumberLines?0:sweg.objPlanetsCircle.planetSize*2)-widthRestDec)
    //width: parent.width-((zm.planetsPadding/40)*numAstro)
    width: parent.width-((zm.planetSize*pos*2))-(zm.planetsMargin*2)//-(zm.planetsMargin*2)
    height: 10
    anchors.centerIn: parent
    z: !selected?numAstro:15

    property string folderImg: '../../../modules/ZoolBodies/ZoolAs/imgs_v1'

    property bool isHovered: false

    //property bool isPron: JSON.parse(app.currentData).params.t==='pron'
    property bool isPron: JSON.parse(app.fileData).params.t==='pron'
    property bool isBack: false
    property int widthRestDec:apps.showDec?zm.objSignsCircle.w*2:0
    property bool selected: numAstro === app.currentPlanetIndex//panelDataBodies.currentIndex
    property string astro
    property int fs
    property var objData: ({g:0, m:0,s:0,ih:0,is:0, rsgdeg:0,rsg:0, gdec:0.000})
    property int pos: 0
    property int g: -1
    property int m: -1
    property int ih: -1
    property int is: -1
    property int numAstro: 0

    property string text: numAstro>=0&&numAstro<=19?zm.aTexts[numAstro]:'Text As Indefinido'

    property var aIcons: [0,1,2,3,4,5,6,7,8,9,12,13,14,15,16,17]

    property color colorCuerpo: '#ff3300'

    property int uRot: 0

    property bool isZoomAndPosSeted: false
    //property alias objOointerPlanet: pointerPlanet
    //property alias img: bodie.objImg
    //property alias img0: bodie.objImg0
    onSelectedChanged: {
        if(selected)app.uSon=''+app.planetasRes[r.numAstro]+'_'+app.objSignsNames[r.is]+'_'+objData.ih
        if(selected){
            //bodie.objOointerPlanet.setPointerFs()
            housesCircle.currentHouse=objData.ih
            app.currentHouseIndex=objData.ih
            app.currentXAs=r
            setRot()
            setZoomAndPos()
            app.showPointerXAs=true
        }
    }
    onWidthChanged: {
        if(numAstro===19 && app.ev && r.isBack){
            log.lv('Resize...')
            tResizezm.restart()
        }
    }
    Timer{
        id: tResizeZoolMap
        running: false//numAstro===20
        repeat: false
        interval: 3000
        onTriggered: {
            //zm.resizeAspsCircle()
        }
    }
    Rectangle{
        anchors.fill: parent
        color: '#ff8833'
        visible: false
    }
    Rectangle{
        id: ejePos
        width: zm.width*3
        height: 1
        anchors.centerIn: parent
        color: apps.fontColor
        visible: app.t==='dirprim'
    }
    Rectangle{
        width: r.width*4
        height: 4
        x:0-r.width*2
        anchors.verticalCenter: parent.verticalCenter
        color: apps.xAsLineCenterColor
        visible: r.selected && (apps.showXAsLineCenter || apps.showDec)
    }
    ZoolBodie{
        id: bodie
        numAstro: r.numAstro
        is: r.is
        width: zm.planetSize
//        width:
//            !apps.xAsShowIcon||aIcons.indexOf(r.numAstro)<0?
//                (!app.ev?r.fs*0.85:/*Tam glifo interior*/r.fs*0.85):
//                (!app.ev?r.fs*2:r.fs)
        objData: r.objData
        anchors.left: parent.left
        anchors.leftMargin: 0//!r.selected?0:width*0.5
        anchors.verticalCenter: parent.verticalCenter

        /*PointerPlanet{
            id: pointerPlanet
            is:r.is
            gdeg: objData.g
            mdeg: objData.m
            rsgdeg:objData.rsg
            ih:objData.ih
            expand: r.selected
            iconoSignRot: parent.objImg.rotation
            p: r.numAstro
            opacity: r.selected&&app.showPointerXAs?1.0:0.0// && JSON.parse(app.currentData).params.t!=='pron'
            onPointerRotChanged: {
                r.uRot=pointerRot
                //saveRot()
                //setRot()
            }
        }*/
        MouseArea{
            id: maSig
            property int vClick: 0
            anchors.fill: parent
            acceptedButtons: Qt.AllButtons;
            hoverEnabled: true
            onWheel: {
                //apps.enableFullAnimation=false
                if (wheel.modifiers & Qt.ControlModifier) {
                    if(wheel.angleDelta.y>=0){
                        pointerPlanet.pointerRot+=5
                    }else{
                        pointerPlanet.pointerRot-=5
                    }
                }else if (wheel.modifiers & Qt.ShiftModifier){
                    if(wheel.angleDelta.y>=0){
                        xTextData.rot+=5
                    }else{
                        xTextData.rot-=5
                    }
                    r.isHovered=true
                    tWaitHovered.restart()
                }else{
                    if(wheel.angleDelta.y>=0){
                        //                    if(reSizeAppsFs.fs<app.fs*2){
                        //                        reSizeAppsFs.fs+=reSizeAppsFs.fs*0.1
                        //                    }else{
                        //                        reSizeAppsFs.fs=app.fs
                        //                    }
                        pointerPlanet.pointerRot+=45
                    }else{
                        //                    if(reSizeAppsFs.fs>app.fs){
                        //                        reSizeAppsFs.fs-=reSizeAppsFs.fs*0.1
                        //                    }else{
                        //                        reSizeAppsFs.fs=app.fs*2
                        //                    }
                        pointerPlanet.pointerRot-=45
                    }
                }
                //reSizeAppsFs.restart()
            }
            onEntered: {
                r.isHovered=true
                vClick=0
                r.parent.cAs=r
            }
            onMouseXChanged:{
                r.isHovered=true
                tWaitHovered.restart()
            }
            onMouseYChanged:{
                r.isHovered=true
                tWaitHovered.restart()
            }
            onExited: {
                tWaitHovered.restart()
                vClick=0
                //r.parent.cAs=r.parent
            }
            onClicked: {
                //apps.sweFs=app.fs
                if (mouse.button === Qt.RightButton) { // 'mouse' is a MouseEvent argument passed into the onClicked signal handler
                    app.uSonFCMB=''+app.planetasRes[r.numAstro]+'_'+app.objSignsNames[r.is]+'_'+objData.ih

                    menuPlanets.isBack=false
                    menuPlanets.currentIndexPlanet=r.numAstro
                    menuPlanets.popup()
                } else if (mouse.button === Qt.LeftButton) {
                    vClick++
                    tClick.restart()
                }
            }
            onDoubleClicked: {
                tClick.stop()
                r.parent.doublePressed(r)
            }
            Timer{
                id: tClick
                running: false
                repeat: false
                interval: 500
                onTriggered: {
                    if(maSig.vClick<=1){
                        if(!r.selected){

                            let msg='Mostrando '+app.planetasReferencia[r.numAstro]
                            msg+=' en el signo '+app.signos[r.is]
                            msg+=' en el grado '+r.objData.rsg+' '+r.objData.m+' minutos '+r.objData.s+' segundos. Casa '+r.ih
                            zoolVoicePlayer.speak(msg, true)
                        }
                        r.parent.pressed(r)
                    }else{
                        r.parent.doublePressed(r)
                    }
                }
            }
        }
        /*Text{
            text:'<b>'+r.pos+'</b>'
            font.pixelSize: 30
            color: 'white'
            rotation: 360-parent.parent.rotation
            anchors.left: parent.right
            anchors.leftMargin: 3
        }*/
    }

    /*
    ZoolAsCotaDeg{
        id: xDegData
        width: bodie.width*2
        anchors.centerIn: bodie
        z: bodie.z-1
        isBack: false
        distancia: bodie.width
        gdec: objData.gdec
        g: objData.rsg
        m:objData.m
        s:objData.s
        ih:objData.ih
        is:objData.is
        cotaColor: apps.fontColor
        cotaOpacity: 1.0//xIconPlanetSmall.opacity
        //rot: -270
        visible: sweg.listCotasShowing.indexOf(r.numAstro)>=0
        Timer{
            running: true
            repeat: true
            interval: 250
            onTriggered: {
                parent.visible=sweg.listCotasShowing.indexOf(r.numAstro)>=0
            }
        }
    }
    ZoolAsCotaText{
        id: xTextData
        width: bodie.width*2
        anchors.centerIn: bodie
        z: bodie.z-1
        widthObjectAcoted: width*0.25
        isBack: false
        distancia: bodie.width*3
        text: r.text
        cotaColor: apps.fontColor
        cotaOpacity: 1.0
        opacity: r.isHovered||isPinched?1.0:0.0
        onOpacityChanged: r.text = sweg.aTexts[numAstro]?sweg.aTexts[numAstro]:''
        visible: r.text!==''
        onClicked: r.isHovered=false
    }*/

    Image {
        id: imgEarth
        source: r.folderImg+"/earth.png"
        width: zm.width*0.05
        height: width
        rotation: -45
        antialiasing: true
        anchors.centerIn: parent
        visible: r.numAstro===0&&apps.xAsShowIcon
    }
    Rectangle{
        width: r.width*0.5-bodie.width
        height: app.fs*0.25
        color: 'transparent'
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        visible: apps.xAsShowIcon
        anchors.leftMargin: bodie.width*0.5
        Comps.XSignal{
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
            height: app.fs*6
            numAstro: r.numAstro
            //visible: r.numAstro===0
            visible: r.selected
        }
    }
    Comps.XCircleSignal{
        id: xCircleSignal
        width: app.fs*16
        height: width
        anchors.centerIn: bodie
        visible: apps.dev && r.selected && !r.isZoomAndPosSeted && JSON.parse(app.currentData).params.t!=='pron'
    }
    Timer{
        running: !r.isZoomAndPosSeted && r.selected
        repeat: true
        interval: 1000
        onTriggered: setZoomAndPos()
    }
    Timer{
        id: tWaitHovered
        running: false
        repeat: false
        interval: 5000
        onTriggered: {
            r.isHovered=false
        }
    }
    function rot(d){
        if(d){
            pointerPlanet.pointerRot+=5
        }else{
            pointerPlanet.pointerRot-=5
        }
        saveRot(parseInt(pointerPlanet.pointerRot))
    }
    function saveRot(rot){
        let json=zfdm.getJson()
        if(!json.rots){
            json.rots={}
        }
        json.rots['rc'+r.numAstro]=rot
        if(unik.fileExist(apps.url.replace('file://', ''))){
            let dataModNow=new Date(Date.now())
            json.params.msmod=dataModNow.getTime()
        }
        zfdm.saveJson(json)
    }

    //Rot
    function setRot(){
        if(!r.isPron){
            let json=JSON.parse(app.fileData)
            if(json.rots&&json.rots['rc'+r.numAstro]){
                r.uRot=json.rots['rc'+r.numAstro]
                pointerPlanet.pointerRot=r.uRot
            }
        }else{
            pointerPlanet.pointerRot=180
        }
    }
    function restoreRot(){
        pointerPlanet.pointerRot=r.uRot
    }

    //Zoom And Pos
    function saveZoomAndPos(){
        let json=zfdm.getJson()
        if(!json[app.stringRes+'zoompos']){
            json[app.stringRes+'zoompos']={}
        }
        json[app.stringRes+'zoompos']['zpc'+r.numAstro]=zm.getZoomAndPos()
        if(apps.dev){
            //log.ls('xAs'+r.numAstro+': saveZoomAndPos()'+JSON.stringify(json, null, 2), 0, log.width)
            //log.ls('json['+app.stringRes+'zoompos][zpc'+r.numAstro+']=sweg.getZoomAndPos()'+JSON.stringify(json[app.stringRes+'zoompos']['zpc'+r.numAstro], null, 2), 0, log.width)
        }
        if(unik.fileExist(apps.url.replace('file://', ''))){
            let dataModNow=new Date(Date.now())
            json.params.msmod=dataModNow.getTime()
        }
        zfdm.saveJson(json)
    }
    function setZoomAndPos(){
        let json=JSON.parse(app.fileData)
        if(json[app.stringRes+'zoompos']&&json[app.stringRes+'zoompos']['zpc'+r.numAstro]){
            zm.setZoomAndPos(json[app.stringRes+'zoompos']['zpc'+r.numAstro])
            r.isZoomAndPosSeted=true
        }else{
            r.isZoomAndPosSeted=false
        }
    }
}
