import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: r
    width: parent.width//sweg.fs*4
    height: width
    anchors.centerIn: parent
    z:r.parent.z-1
    rotation: 0-signCircle.rotation
    property string folderImg: '../../../modules/ZoolMap/imgs/imgs_v1'
    property int iconoSignRot: 0
    property int is: -1
    property int gdeg: -1
    property int mdeg: -1
    property int sdeg: -1
    property int rsgdeg: -1
    property int ih: -1
    property int wtc: (zm.fs*0.5)/(zm.xs*0.5) //width of each circle de triple circle
    property int p: -1
    property alias pointerRot: eje.rotation
    property int pointerFs: app.fs*5.5
    property int cotaLong: r.pointerFs*4
    property color bc: 'red'
    property real xs: zm.xs
    property var aMargins: [0.5, 0.3, 0.4, 0.4, 0.4, 0.5, 0.5, 0.5, 0.4, 0.3, 0.5, 0.5, 0.3, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5]

    property bool isExt: false
    property string status: zm.getBodieStatus(zm.aBodies[r.p], zm.aSignsLowerStyle[r.is])

    onOpacityChanged: {
        if(opacity===1.0){
            if(status!=='normal'){
                let jsonNot={}
                jsonNot.text='Estado de '+zm.aBodies[r.p]+': '+r.status
                //jsonNot.bot1Text='Ver Repositorio GitHub'
                zpn.addNot(jsonNot, true, 20000)
            }
            setPointerFs()
        }
    }
    onXsChanged: {
        setPointerFs()
    }
    onVisibleChanged: {


    }
    Rectangle{
        id: eje
        width: r.width
        height: width
        color: 'transparent'
        //color: 'red'
        anchors.centerIn: parent
        Rectangle{
            width: r.cotaLong
            height: apps.pointerLineWidth*2
            color: !zm.capturing?rectData.border.color:r.bc
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: apps.xAsShowIcon?r.width*(r.aMargins[r.p]):r.width*0.5//+zm.fs*0.25
            Rectangle{
                id: rectData
                width: col.width+r.pointerFs*0.5
                height: col.height+r.pointerFs*0.5
                //color: !isCapturing?zm.pointerBgColor:zm.pointerBgColor
                color: zm.pointerBgColor//!isCapturing?zm.pointerBgColor:r.bc
                border.width: 3
                border.color: !zm.capturing?zm.pointerBorderColor:r.bc
                radius: r.pointerFs*0.25
                //rotation: r.iconoSignRot-eje.rotation
                rotation: !r.isExt?
                              r.iconoSignRot-eje.rotation
                            :
                              r.iconoSignRot-eje.rotation-zm.objPlanetsCircleBack.rotation
                anchors.horizontalCenter: parent.left
                anchors.verticalCenter: parent.top
                property bool isCapturing: zm.capturing
                MouseArea{
                    anchors.fill: parent
                    onClicked: zm.pointerRotToCenter=!zm.pointerRotToCenter
                }
                SequentialAnimation on border.color {
                    running: !zm.capturing
                    loops: Animation.Infinite
                    onRunningChanged: {
                        if(!running)rectData.border.color=r.bc//zm.pointerBorderColor
                    }
                    ColorAnimation { from: zm.pointerBorderColor; to: zm.pointerBgColor; duration: 400 }
                    ColorAnimation { from: zm.pointerBgColor; to: zm.pointerBorderColor; duration: 400 }
                    ColorAnimation { from: zm.pointerBorderColor; to: zm.pointerFontColor; duration: 400 }
                    ColorAnimation { from: zm.pointerFontColor; to: zm.pointerBorderColor; duration: 400 }
                }
                Column{
                    id: col
                    spacing: r.pointerFs*0.25
                    anchors.centerIn: parent
                    Row{
                        spacing: r.pointerFs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Rectangle{
                            width: r.pointerFs//*0.8
                            height: width
                            radius: width*0.5
                            color: zm.pointerBgColor
                            border.width: 2
                            border.color: zm.pointerFontColor
                            anchors.verticalCenter: parent.verticalCenter
                            Image {
                                id: img0
                                //source: "../../imgs/planetas/"+app.planetasRes[r.p]+".svg"
                                source: r.folderImg+"/"+app.planetasRes[r.p]+".svg"
                                width: parent.width*0.8
                                height: width
                                anchors.centerIn: parent
                                antialiasing: true
                                visible: false
                            }
                            ColorOverlay {
                                id: co0
                                anchors.fill: img0
                                source: img0
                                color: zm.pointerFontColor
                                //rotation: img1.rotation
                                antialiasing: true
                            }
                            //                            MouseArea{
                            //                                anchors.fill: parent
                            //                                onClicked: apps.xAsShowIcon=!apps.xAsShowIcon
                            //                            }
                        }
                        Rectangle{
                            width: r.pointerFs//*0.8
                            height: width
                            radius: width*0.5
                            color: zm.pointerBgColor
                            border.width: 2
                            border.color: zm.pointerFontColor
                            anchors.verticalCenter: parent.verticalCenter
                            Image {
                                id: img1
                                source: r.is>=0?"../../../imgs/signos/"+r.is+".svg":""
                                width: parent.width*0.8
                                height: width
                                anchors.centerIn: parent
                                antialiasing: true
                                visible: false
                            }
                            ColorOverlay {
                                id: co1
                                anchors.fill: img1
                                source: img1
                                color: zm.pointerFontColor
                                //rotation: img1.rotation
                                antialiasing: true
                            }
                        }

                    }
                    Row{
                        spacing: r.pointerFs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text{
                            text: app.planetas[r.p]+' en '+app.signos[r.is]
                            font.pixelSize: r.pointerFs*0.5
                            color: zm.pointerFontColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                    Row{
                        spacing: r.pointerFs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text{
                            text: '<b>Nakshatra:</b> '+(
                                      !r.isExt?zm.currentNakshatra:zm.currentNakshatraBack
                                      )
                            font.pixelSize: r.pointerFs*0.35
                            color: zm.pointerFontColor
                            anchors.verticalCenter: parent.verticalCenter
                            visible: r.p===1
                        }
                    }
                    Row{
                        spacing: r.pointerFs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        visible: r.status!=='normal'
                        Text{
                            text: '<b>Estado:</b> '
                            font.pixelSize: r.pointerFs*0.35
                            color: zm.pointerFontColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text{
                            text: r.status
                            font.pixelSize: r.pointerFs*0.35
                            color: zm.pointerFontColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                    Row{
                        spacing: r.pointerFs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text{
                            text: 'En el grado °'+r.rsgdeg+'\''+r.mdeg
                            font.pixelSize: r.pointerFs*0.5
                            color: zm.pointerFontColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                    Row{
                        spacing: r.pointerFs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text{
                            text: 'Casa '
                            font.pixelSize: r.pointerFs*0.5
                            color: zm.pointerFontColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Rectangle{
                            width: r.pointerFs*0.8
                            height: width
                            radius: width*0.5
                            color: zm.pointerBgColor
                            border.width: 2
                            border.color: zm.pointerFontColor
                            anchors.verticalCenter: parent.verticalCenter
                            Image {
                                id: img2
                                source: "../../../imgs/casa.svg"
                                width: parent.width*0.8
                                height: width
                                rotation: r.iconoSignRot + 180 - r.rotation
                                antialiasing: true
                                visible: false
                                anchors.centerIn: parent
                            }
                            ColorOverlay {
                                id: co2
                                anchors.fill: img2
                                source: img2
                                color: zm.pointerFontColor
                                //rotation: img1.rotation
                                antialiasing: true
                            }
                            Text{
                                font.pixelSize: r.ih<=9?parent.width*0.6:parent.width*0.4
                                text: '<b>'+r.ih+'</b>'
                                color: zm.pointerBgColor
                                anchors.centerIn: parent
                            }
                        }
                    }
                }
                Rectangle{
                    anchors.fill: parent
                    radius: parent.radius
                    color: 'transparent'
                    border.width: 1
                    border.color: zm.pointerBgColor
                    visible: zm.capturing
                }
            }
            Item{
                width: apps.pointerLineWidth*4*2
                height: width
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 0-width*0.3
                rotation: 90
                Image{
                    id: imgFlecha
                    source: '../../../imgs/flecha.svg'
                    width: parent.width
                    height: width
                    anchors.centerIn: parent
                    visible: false
                }
                ColorOverlay {
                    id: co33
                    width: imgFlecha.width+2
                    height: imgFlecha.height+2
                    anchors.centerIn: imgFlecha
                    source: imgFlecha
                    color: r.bc
                    antialiasing: true
                    visible: zm.capturing
                }
                ColorOverlay {
                    id: co3
                    anchors.fill: imgFlecha
                    source: imgFlecha
                    color: !zm.capturing?rectData.border.color:r.bc
                    antialiasing: true
                }
            }
        }
    }
    function setPointerFs(){
        let f1=0.4
        let f2=0.5
        let f3=2.0
        for(var i=0;i<46;i++){
            f1+=0.1
            f2+=0.1
            f3+=0.25
            if(r.xs>=f1&&r.xs<f2){
                pointerFs=app.fs*4.5/f3
                break
            }
        }
    }
}
