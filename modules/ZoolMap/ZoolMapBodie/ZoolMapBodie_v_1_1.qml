import QtQuick 2.0
import QtGraphicalEffects 1.0

Item{
    id: r
    property bool isBack: false
    property bool selected: false
    property int pos: -1
    property int numAstro: -1
    property int is: -1
    property var objData
    property alias objImg: imgGlifoPlanets
    property color c: !r.isBack?zm.bodieColor:zm.bodieColorBack

    property real porcIncrement: 1.0

    onCChanged: {
        if(r.numAstro===0){
            //log.lv('Themes r.bodieColor: '+zm.bodieColor)
            co.color=zm.bodieColor
        }
        //saAsColor.running=true
    }
    property alias objImg0: imgGlifoPlanets
    property string folderImgs: '../../../imgs/imgs_v2'
    property var aIcons: [0,1,2,3,4,5,6,7,8,9,12,13,14,15,16,17,18,19]
    property color bgColor: !r.isBack?zm.bodieBgColor:zm.bodieBgColorBack
    width: zm.bodieSize
    height: width
    anchors.left: parent.left
    anchors.leftMargin: 0-xIconPlanetSmall.width
    anchors.verticalCenter: parent.verticalCenter
    Image{
        id: imgEsfera
        source: r.folderImgs+'/bodies/esfera.png'
        width: r.width*r.porcIncrement*(0.5)
        height: width
        anchors.centerIn: parent
        rotation: imgGlifoPlanets.rotation
        antialiasing: true
        visible: r.numAstro>=10 && apps.xAsShowIcon
    }
    Image{
        id: imgEsferaPlanets
        source: numAstro<=9?r.folderImgs+'/bodies/'+app.planetasRes[r.numAstro]+'.png':r.folderImgs+'/bodies/esfera.png'
        width: r.width*r.porcIncrement//*0.75:r.width*0.35
        height: width
        anchors.centerIn: parent
        rotation: imgGlifoPlanets.rotation
        antialiasing: true
        visible: apps.xAsShowIcon && r.numAstro<10
    }
    Image{
        id: imgGlifoPlanets
        width: r.width*(apps.xAsShowIcon?r.porcIncrement*(0.5):1.0)//!apps.xAsShowIcon||r.numAstro<10?r.width*0.75:r.width*0.35
        height: width
        anchors.centerIn: parent
        source: r.folderImgs+"/glifos/"+app.planetasRes[r.numAstro]+".svg"
        visible: !apps.xAsShowIcon
        rotation: !r.isBack?
                      0-parent.parent.rotation
                    :
                      0-parent.parent.rotation+zm.dirPrimRot
    }
    ColorOverlay {
        id: coGlifoPlanets
        //anchors.fill: imgGlifoPlanets
        width: !apps.xAsShowIcon || (r.numAstro>=10)?imgGlifoPlanets.width*0.75:imgGlifoPlanets.width
        height: width
        anchors.centerIn: imgGlifoPlanets
        source: imgGlifoPlanets
        color: r.c//apps.houseLineColorBack
        rotation: imgGlifoPlanets.rotation
        visible: !apps.xAsShowIcon || (r.numAstro>=10)
    }
    Rectangle{
        id: nodoCenPointer
        width: r.width*0.5
        height: width
        radius: width*0.5
        color: 'transparent'
        rotation: 180
        visible: apps.xAsShowIcon && !r.selected
        anchors.centerIn: parent
        Rectangle{
            id: ejePointer
            width: !r.isBack?zm.planetSizeInt*f:zm.planetSizeExt*f
            height: 1
            color: 'transparent'
            anchors.left: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            property real f: 1.0
            Rectangle{
                width: parent.width-(numAstro>=10?imgEsfera.width*0.5:imgEsferaPlanets.width*0.5)
                height: parent.height//*4
                color: apps.fontColor
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
            }
            Rectangle{
                width: txtBodieName.contentWidth+app.fs*0.25
                height: txtBodieName.contentHeight+app.fs*0.25
                color: apps.backgroundColor
                border.width: 1
                border.color: apps.fontColor
                radius: app.fs*0.15
                anchors.horizontalCenter: parent.right
                anchors.verticalCenter: parent.verticalCenter
                rotation: imgGlifoPlanets.rotation-nodoCenPointer.rotation
                //opacity: 0.5
                MouseArea{
                    acceptedButtons: Qt.AllButtons;
                    anchors.fill: parent
                    onClicked: {
                        if (mouse.button === Qt.RightButton) {
                            nodoCenPointer.rotation-=10
                        }else{
                            nodoCenPointer.rotation+=10
                        }
                    }
                    onWheel: {
                        if(wheel.angleDelta.y>=0){
                            if(ejePointer.f<4.0)ejePointer.f+=0.1
                        }else{
                            if(ejePointer.f>1.0)ejePointer.f-=0.1
                        }
                    }

                }
                Text{
                    id: txtBodieName
                    text: zm.aBodies[r.numAstro]//+' '+r.pos
                    font.pixelSize: app.fs*0.35
                    color: apps.fontColor
                    anchors.centerIn: parent
                }
            }
        }
    }
    onPosChanged: setPointerRot()
    Component.onCompleted: {
        if(numAstro===1 || numAstro===2){
            r.porcIncrement=0.5
        }
        if(numAstro===3 || numAstro===4){
            r.porcIncrement=0.65
        }
        if(numAstro===6 || numAstro===7){
            r.porcIncrement=1.0
        }
        if(numAstro===8){
            r.porcIncrement=0.65
        }
        if(numAstro===9){
            r.porcIncrement=0.5
        }
    }
    function setPointerRot(){
        if(r.pos===0)nodoCenPointer.rotation=45
        if(r.pos===1)nodoCenPointer.rotation=-45
        if(r.pos===2)nodoCenPointer.rotation=70
        if(r.pos===3)nodoCenPointer.rotation=90
        if(r.pos>3)nodoCenPointer.rotation=180
    }

}
