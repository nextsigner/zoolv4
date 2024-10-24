import QtQuick 2.0
import QtGraphicalEffects 1.0

import "../"

Item{
    id: r
    //width: !selected?(planetsCircle.expand?parent.width-(r.fs*2*objData.p)-r.fs:parent.width-(r.fs*1.5*objData.p))-r.fs:parent.width//-sweg.fs*2-(r.fs*1.5*(planetsCircle.totalPosX-1))
    width: (signCircle.width+sweg.fs*0.25)+(r.fs*2*objData.p)+sweg.fs*2
    height: 1
    anchors.centerIn: parent
    //z: !selected?numAstro:15

    property string folderImg: '../../../modules/ZoolBodies/ZoolAs/imgs_v1'

    property bool selected: numAstro === app.currentPlanetIndexBack
    property string astro
    property int is
    property int fs:planetsCircleBack.planetSize
    property var objData: ({g:0, m:0,ih:0,rsgdeg:0,rsg:0})
    property int pos: 1
    property int g: -1
    property int m: -1
    property int numAstro: 0

    property color colorCuerpo: '#ff3300'

    property var aIcons: [0,1,2,3,4,5,6,7,8,9,12]

    property int uRot: 0

    onSelectedChanged: {
        if(selected)housesCircleBack.currentHouse=objData.ih
        if(selected)app.uSon=''+app.planetasRes[r.numAstro]+'_'+app.objSignsNames[r.is]+'_'+objData.ih
        if(selected){
            pointerPlanet.setPointerFs()
            housesCircleBack.currentHouse=objData.ih
            app.currentHouseIndexBack=objData.ih
            app.currentXAsBack=r
            setRot()
            setZoomAndPos()
            app.showPointerXAsBack=true
        }
    }

    //Probando/Visualizando rotación
    Rectangle{
        width: r.width
        height: apps.widthHousesAxis
        anchors.centerIn: parent
        //color: apps.fontColor
        //visible: apps.showHousesAxis
        //y: lineaEje2.y
        visible: false
        color: 'yellow'
        antialiasing: true
    }
    Rectangle{
        width: (r.width-signCircle.width)*0.5+signCircle.w*0.5//+r.fs*0.25//r.fs+r.fs*objData.p-1
        height: 1//apps.widthHousesAxis
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 0//-r.fs*0.25
        //anchors.centerIn: parent
        color: apps.fontColor
        antialiasing: true
        Canvas {
            id:canvasSen
            width: sweg.fs*0.2
            height: width
            //rotation: 180
            anchors.verticalCenter: parent.verticalCenter
            //anchors.left: parent.left
            anchors.right: parent.right
            anchors.rightMargin: 0-width
            antialiasing: true
            onPaint:{
                var ctx = canvasSen.getContext('2d');
                ctx.clearRect(0, 0, canvasSen.width, canvasSen.height);
                ctx.beginPath();
                ctx.moveTo(0, canvasSen.width*0.5);
                ctx.lineTo(canvasSen.width, 0);
                ctx.lineTo(canvasSen.width, canvasSen.width);
                ctx.lineTo(0, canvasSen.width*0.5);
                ctx.strokeStyle = canvasSen.parent.color
                ctx.lineWidth = 1;
                ctx.fillStyle = canvasSen.parent.color
                ctx.fill();
                ctx.stroke();
            }
        }
    }
    Item{
        id: xIcon
        width: r.fs*0.85
        height: width
        anchors.left: parent.left
        anchors.leftMargin: 0-xIconPlanetSmall.width
        //anchors.leftMargin: !r.selected?0:width*0.5
        anchors.verticalCenter: parent.verticalCenter
        PointerPlanet{
            id: pointerPlanet
            is:r.is
            gdeg: objData.g
            mdeg: objData.m
            rsgdeg:objData.rsg
            ih:objData.ih
            expand: r.selected
            iconoSignRot: img0.rotation
            p: r.numAstro
            opacity: r.selected&&app.showPointerXAs?1.0:0.0
            isBack: true
        }
        Rectangle{
            //Circulo prueba/ocultar.
            width: parent.width+sweg.fs*0.1
            height: width
            anchors.centerIn: parent
            radius: width*0.5
            border.width: 1
            border.color: "yellow"//apps.backgroundColor
            color: apps.xAsBackgroundColorBack
            antialiasing: true
            visible: false
        }
        Rectangle{
            //Circulo que queda mostrando el cuerpo chico.
            id: xIconPlanetSmall
            width: parent.width+sweg.fs*0.1
            height: width
            anchors.centerIn: parent
            radius: width*0.5
            border.width: 0
            border.color: apps.backgroundColor
            opacity: apps.xAsBackgroundOpacityBack
            color: apps.xAsBackgroundColorBack
            antialiasing: true
            visible: co.visible
        }

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
                vClick=0
                r.parent.cAs=r
            }
            onExited: {
                vClick=0
                //r.parent.cAs=r.parent
            }
            onClicked: {
                //apps.sweFs=app.fs
                if (mouse.button === Qt.RightButton) { // 'mouse' is a MouseEvent argument passed into the onClicked signal handler
                    app.uSonFCMB=''+app.planetasRes[r.numAstro]+'_'+app.objSignsNames[r.is]+'_'+objData.ih
                    menuPlanets.isBack=true
                    menuPlanets.currentIndexPlanet=r.numAstro
                    menuPlanets.popup()
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
                        r.parent.pressed(r)
                    }else{
                        r.parent.doublePressed(r)
                    }
                }
            }
        }
        Image{
            id: img0
            //source: app.planetasRes[r.numAstro]?"./resources/imgs/planetas/"+app.planetasRes[r.numAstro]+".svg":""
            source: app.planetasRes[r.numAstro]?r.folderImg+"/"+app.planetasRes[r.numAstro]+(apps.xAsShowIcon&&r.aIcons.indexOf(r.numAstro)>=0?"_i.png":".svg"):""
            width: parent.width*0.9
            height: width
            //x:!r.selected?0:r.parent.width*0.5-img0.width*0.5//+sweg.fs*2
            //y: (parent.width-width)/2
            anchors.centerIn: parent
            //rotation: 0-parent.parent.rotation
            rotation: app.t!=='dirprim'?0-parent.parent.rotation:0-parent.parent.rotation-sweg.objPlanetsCircleBack.rotation
            antialiasing: true
            visible: !co.visible
        }

        ColorOverlay {
            id: co
            anchors.fill: img0
            source: img0
            color: 'yellow'
            rotation: img0.rotation
            visible: !apps.xAsShowIcon||r.aIcons.indexOf(r.numAstro)<0
            antialiasing: true
            SequentialAnimation{
                running: !r.selected//!apps.anColorXAs
                loops: 3//Animation.Infinite
                PropertyAnimation {
                    target: co
                    properties: "color"
                    from: co.color
                    to: apps.xAsColorBack
                    duration: 500
                }
            }
            SequentialAnimation{
                running: r.selected && !zm.capturing//apps.anColorXAs
                loops: Animation.Infinite
                onRunningChanged: {
                    if(!running&&zm.capturing){
                        co.color=apps.xAsColorBack
                    }
                }
                PropertyAnimation {
                    target: co
                    properties: "color"
                    from: 'red'
                    to: 'white'
                    duration: 500
                }
                PropertyAnimation {
                    target: co
                    properties: "color"
                    from: 'red'
                    to: 'red'
                    duration: 500
                }
            }
            Rectangle{
                width: parent.width*0.35
                height: width
                radius: width*0.5
                //anchors.verticalCenter: parent.verticalCenter
                anchors.bottom: parent.bottom
                anchors.left: parent.right
                anchors.leftMargin: 0-width
                visible: r.objData.retro===0
                Text{
                    text: '<b>R</b>'
                    font.pixelSize: parent.width*0.8
                    anchors.centerIn: parent
                }
            }
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
        let json=JSON.parse(app.fileData)
        if(!json.rots){
            json.rots={}
        }
        json.rots['rcBack'+r.numAstro]=rot
        if(unik.fileExist(apps.url.replace('file://', ''))){
            let dataModNow=new Date(Date.now())
            json.params.msmod=dataModNow.getTime()
        }
        let njson=JSON.stringify(json)
        app.fileData=njson
        app.currentData=app.fileData
        unik.setFile(apps.url.replace('file://', ''), JSON.stringify(json))
    }

    //Rot
    function setRot(){
        let json=JSON.parse(app.fileData)
        if(json.rots&&json.rots['rcBack'+r.numAstro]){
            r.uRot=json.rots['rcBack'+r.numAstro]
            pointerPlanet.pointerRot=r.uRot
        }
    }
    function restoreRot(){
        pointerPlanet.pointerRot=r.uRot
    }

    //Zoom And Pos
    function saveZoomAndPos(){
        let json=JSON.parse(app.fileData)
        if(!json[app.stringRes+'zoompos']){
            json[app.stringRes+'zoompos']={}
        }
        json[app.stringRes+'zoompos']['zpcBack'+r.numAstro]=sweg.getZoomAndPos()
        if(unik.fileExist(apps.url.replace('file://', ''))){
            let dataModNow=new Date(Date.now())
            json.params.msmod=dataModNow.getTime()
        }
        let njson=JSON.stringify(json)
        app.fileData=njson
        app.currentData=app.fileData
        unik.setFile(apps.url.replace('file://', ''), JSON.stringify(json))
    }
    function setZoomAndPos(){
        let json=JSON.parse(app.fileData)
        if(json[app.stringRes+'zoompos']&&json[app.stringRes+'zoompos']['zpcBack'+r.numAstro]){
            sweg.setZoomAndPos(json[app.stringRes+'zoompos']['zpcBack'+r.numAstro])
        }
    }
}
