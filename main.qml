import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.3
import QtQuick.Window 2.0
import QtMultimedia 5.12
import Qt.labs.folderlistmodel 2.12

import unik.UnikQProcess 1.0
import UniKey 1.0


import "./js/Funcs_v2.js" as JS
import "./js/Capture.js" as CAP
import "./comps" as Comps

//Default Modules
import comps.ZoolAppSettings 1.0
import comps.FocusSen 1.0
import ZoolNewsAndUpdates 3.4
import ZoolMainWindow 1.0

import ZoolText 1.4
import ZoolDataBar 3.1
import ZoolDataView 1.2
import ZoolEvolutionView 1.0
import ZoolLogView 1.0

import ZoolFileDataManager 1.0
import ZoolDataSheet 1.0
import web.ZoolServerFileDataManager 1.0

//import ZoolBodies 1.10
import ZoolMap 7.0
import ZoolBodiesGuiTools 1.0

//-->Menus
import ZoolMenus.ZoolTopMenuBar 1.1
import ZoolMenus.ZoolMenuCtxAs 1.0
import ZoolMenus.ZoolMapMenuCtx 1.0
import ZoolMenuCtxPlanetsAsc 1.0
import ZoolMenuCtxHouses 1.0
import ZoolMenus.ZoolMenuCtxView3D 1.0
//<--Menus


import ZoolControlsTime 1.0

import ZoolSectionsManager 1.2

import gui.ZoolDataBodies 3.3

import comps.ZoolPanelNotifications 1.1
import web.ZoolWebStatusManager 1.0
import comps.ZoolIntSplash 1.0
//import MinymaClient 1.0

import ZoolDataManager 1.0
import ZoolDataEditor 1.0
import ZoolInfoDataView 1.0
import ZoolBottomBar 1.0

import NodeIOQml 1.1

import ZoolRemoteDataManager 1.0

import comps.PushOver 1.0

import comps.ZoolMultiOSUpdate 1.0

import swe 1.0


//--3D
import ZoolMap3D 1.0


import QtQuick3D 1.14
import ZoolLogView 1.0
import ZM3D 1.0
import Luces 1.0
import Sen 1.0


ZoolMainWindow{
    id: app
    visible: true
    visibility: "Maximized"
    width: Screen.width
    height: Screen.height
    minimumWidth: Screen.desktopAvailableWidth-app.fs*4
    minimumHeight: Screen.desktopAvailableHeight-app.fs*4
    color: apps.enableBackgroundColor?apps.backgroundColor:'black'
    title: 'Zool '+version
    property bool dev: Qt.application.arguments.indexOf('-dev')>=0
    //property var qmlListErrors: qmlErrorLogger.messages
    property string version: '0.0.-1'
    property string folderImgsName: 'imgs_v2'
    //property string sweBodiesPythonFile: Qt.platform.os==='linux'?'astrologica_swe_v4.py':'astrologica_swe.py'


    property bool sweFromCpp: true
    //Python
    property string sweFolder: Qt.platform.os==='windows'?'"'+u.getPath(1)+'/swe"':'/usr/share/ephe/swe'
    property string sweBodiesPythonFile: Qt.platform.os==='windows'?'astrologica_swe_v4.py':'zool_swe_portable_2.10.3.2_v2.py'
    property string pythonLocation: !sweFromCpp?(Qt.platform.os==='windows'?'"'+u.getPath(1).replace(/\"/g, '')+'/Python/python.exe"':'python3'):''

    property var j: JS
    //property var c: CAP

    property string mainLocation: ''
    //property string pythonLocation: Qt.platform.os==='linux'?'python3':pythonLocationSeted?'"'+pythonLocationSeted+'"':'"'+u.getPath(4)+'/Python/python.exe'+'"'

    //property string pythonLocation: Qt.platform.os==='linux'?'python3':'python'

    property int fs: apps.fs//Qt.platform.os==='linux'?width*0.02:width*0.02
    property string stringRes: 'Screen'+Screen.width+'x'+Screen.height
    property string url
    property string t: 'vn'

    property bool backIsSaved: false

    property var objInFullWin
    //property bool capturing: false

    property bool showCenterLine: false
    property bool enableAn: false
    property int msDesDuration: 500

    property var minymaClient2
    property var objZoolFileExtDataManager
    property var aExtsIds: []

    //    property string fileData: ''
    //    property string fileDataBack: ''
    //    property string currentData: ''
    //    property string currentDataBack: ''
    //    property var currentJson
    //    property var currentJsonBack
    property bool setFromFile: false

    //Para analizar signos y ascendentes por región
    property int currentIndexSignData: 0
    property var currentJsonSignData: ''


    property date currentDateBack
    property string currentNomBack: ''
    property string currentFechaBack: ''
    property string currentLugarBack: ''
    property int currentAbsolutoGradoSolarBack: -1
    property int currentGradoSolarBack: -1
    property int currentMinutoSolarBack: -1
    property int currentSegundoSolarBack: -1
    property real currentGmtBack: 0
    property real currentLonBack: 0.0
    property real currentLatBack: 0.0


    property bool lock: false


    property var signos: ['Aries', 'Tauro', 'Géminis', 'Cáncer', 'Leo', 'Virgo', 'Libra', 'Escorpio', 'Sagitario', 'Capricornio', 'Acuario', 'Piscis']
    property var planetas: ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Júpiter', 'Saturno', 'Urano', 'Neptuno', 'Plutón', 'N.Sur', 'N.Norte', 'Quirón', 'Selena', 'Lilith', 'Pholus', 'Ceres', 'Pallas', 'Juno', 'Vesta']
    property var planetasArchivos: ['sol', 'luna', 'mercurio', 'venus', 'marte', 'jupiter', 'saturno', 'urano', 'neptuno', 'pluton', 'nodo_norte', 'nodo_sur', 'quiron', 'selena', 'lilith', 'pholus', 'ceres', 'pallas', 'juno', 'vesta', 'asc', 'mc']
    property var planetasReferencia: ['el sol', 'la luna', 'el planeta mercurio', 'el planeta venus', 'el planeta marte', 'el planeta jupiter', 'el planeta saturno', 'el planeta urano', 'el planeta neptuno', 'pluton', 'el nodo sur', 'el nodo norte', 'el asteroide quiron', 'la luna blanca selena', 'la luna negra lilith', 'el ascendente', 'el medio cielo']
    property var planetasRes: ['sun', 'moon', 'mercury', 'venus', 'mars', 'jupiter', 'saturn', 'uranus', 'neptune', 'pluto', 's', 'n', 'hiron', 'selena', 'lilith', 'pholus', 'ceres', 'pallas', 'juno', 'vesta']
    property var objSignsNames: ['ari', 'tau', 'gem', 'cnc', 'leo', 'vir', 'lib', 'sco', 'sgr', 'cap', 'aqr', 'psc']
    property var signColors: ['red', '#FBE103', '#09F4E2', '#0D9FD6','red', '#FBE103', '#09F4E2', '#0D9FD6','red', '#FBE103', '#09F4E2', '#0D9FD6']
    property var meses: ['enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', 'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre']

    //Asp Astrolog Search
    property var planetasAS: ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Júpiter', 'Saturno', 'Urano', 'Neptuno', 'Plutón', 'N.Sur']
    //property var planetasResAS: ['sun', 'moon', 'mercury', 'venus', 'mars', 'jupiter', 'saturn', 'uranus', 'neptune', 'pluto', 'North Node']

    property var arbolGenealogico: ['Raíz', 'Portal', 'Ala', 'Integrador']

    //property var ahys: ['P', 'K', 'O', 'R', 'C', 'A', 'V', 'X', 'H', 'T', 'B', 'G', 'M']
    property var ahys: ['P', 'K', 'O', 'R', 'C', 'A', 'V', 'X', 'H', 'T', 'B', 'M']
    property var ahysNames: ['Placidus', 'Koch', 'Porphyrius', 'Regiomontanus', 'Campanus', 'Iguales', 'Vehlow', 'Sistema de Rotación Axial', 'Azimuthal', 'Topocéntrico', 'Alcabitus', 'Morinus']
    /*
                ‘P’     Placidus
                ‘K’     Koch
                ‘O’     Porphyrius
                ‘R’     Regiomontanus
                ‘C’     Campanus
                ‘A’ or ‘E’     Equal (cusp 1 is Ascendant)
                ‘V’     Vehlow equal (Asc. in middle of house 1)
                ‘X’     axial rotation system
                ‘H’     azimuthal or horizontal system
                ‘T’     Polich/Page (“topocentric” system)
                ‘B’     Alcabitus
                ‘G’     Gauquelin sectors
                ‘M’     Morinus
*/



    property var cmd

    //XAs
    property var currentXAs
    property bool showPointerXAs: true
    property var currentXAsBack
    property bool showPointerXAsBack: true

    property var ci: xApp
    property var ciPrev

    property bool sspEnabled: false

    property bool show3D: false

    //Del main de zool3d
    property color c: 'white'

    menuBar: ZoolTopMenuBar {
        id: menuBar
    }
    onDevChanged: {
        if(dev){
            let c=u.getFile('./dev.qml')
            let comp=Qt.createQmlObject(c, xApp, 'devqmlcode')
        }
    }
    Connections {
        target: qmlErrorLogger
        onMessagesChanged: {
            if(apps.showQmlErrors)log.lv(qmlErrorLogger.messages[qmlErrorLogger.messages.length-1]);
        }
    }
    FontLoader {name: "fa-brands-400";source: "./fonts/fa-brands-400.ttf";}
    FontLoader {name: "FontAwesome";source: "./fonts/fontawesome-webfont.ttf";}
    FontLoader {name: "ArialMdm";source: "./fonts/ArialMdm.ttf";}
    FontLoader {name: "TypeWriter";source: "./fonts/typewriter.ttf";}
    UniKey{id: u}
    Swe{
        id: swe
        Component.onCompleted: {
            //QString getBodiePosJson(int bi, int a, int m, int d, int h, int min, int gmt, double lon, double lat, double alt);
            /*log.lv('')
            log.lv('Calculando posición actual de sol...')
            let jb=swe.getBodiePosJson(0, 1975, 6, 20, 23, 4, -3, -69.59, -35.48, 1440);
            log.lv('Posición: '+JSON.stringify(JSON.parse(jb), null, 2))

            //QString getHousesPos(int a, int m, int d, int h, int min, int gmt, double lon, double lat, QString hsys);
            */
            zm.getSweJson(1975, 6, 20, 23, 4, -3, -69.59, -35.48, 1440)
        }
    }
    ZoolAppSettings{id: apps}
    ZoolRemoteDataManager{id: zrdm}
    ZoolFileDataManager{id: zfdm}
    ZoolDataSheet{id: zds}
    ZoolServerFileDataManager{id: zsfdm}
    Rectangle{
        id: xVisibleItems
        color: apps.backgroundColor
        anchors.fill: parent
        visible: !app.show3D
        Item{
            id: xApp
            objectName: 'xApp'
            anchors.fill: parent
            Rectangle{
                id: xZoolMap
                width: xMed.width
                height: xMed.height
                border.width: xZoolMap.showDevLines?10:0
                border.color: '#ff8833'
                color: xZoolMap.showDevLines?'gray':'transparent'
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                property bool showDevLines: false
                Rectangle{
                    id: xSwe1
                    width: parent.width
                    height: parent.height
                    transform: Scale{ xScale: xZoolMap.showDevLines?0.25:1.0; yScale: xZoolMap.showDevLines?0.25:1.0 }
                    color: apps.backgroundColor
                    x: (xZoolMap.showDevLines?(parent.width*0.5)-width*0.25*0.5:0)-(xLatIzq.visible?0:xLatIzq.width*0.5)
                    y: xZoolMap.showDevLines?(parent.height*0.5)-height*0.25*0.5:0
                    clip: xLatIzq.visible//?true
                    //ZoolBodies{id: sweg;objectName: 'sweg'; visible: !apps.dev}
                    ZoolMap{
                        id: zm;
                        rectXBackItems.width: xMed.width
                        rectXBackItems.height: xMed.height
                    }
                    Image {
                        id: xDataBarUItemGrabber
                        //source: xDataBar.uItemGrabber
                        source: zoolDataView.uItemGrabber
                        width: parent.width
                        fillMode: Image.PreserveAspectCrop
                        visible: zm.capturing
                    }
                    /*
                    Image{
                        id: xAspsUItemGrabber
                        source: zm.objZoolAspectsView.uItemGrabber
                        width: parent.width*0.2
                        height: parent.width*0.2
                        fillMode: Image.PreserveAspectCrop
                        anchors.bottom: parent.bottom
                        visible: zm.capturing
                        Rectangle{
                            anchors.fill: parent
                            color: 'transparent'
                            border.width: 1
                            border.color: 'red'
                            visible: apps.dev
                        }
                    }
                    Image{
                        id: xAspsUItemGrabberBack
                        source: zm.objZoolAspectsViewBack.uItemGrabber
                        width: parent.width*0.2
                        height: parent.width*0.2
                        fillMode: Image.PreserveAspectCrop
                        anchors.top: parent.top
                        visible: zm.capturing && zm.ev
                        Rectangle{
                            anchors.fill: parent
                            color: 'transparent'
                            border.width: 1
                            border.color: 'red'
                            visible: apps.dev
                        }
                    }
                    Image {
                        id: xElementsUItemGrabber
                        //source: panelElements.uItemGrabber
                        //source: zoolElementsView.uItemGrabber
                        //width: panelElements.width
                        //fillMode: Image.PreserveAspectFit
                        fillMode: Image.PreserveAspectCrop
                        anchors.top: xDataBarUItemGrabber.bottom
                        anchors.right: parent.right
                        anchors.rightMargin: 0-width*0.75
                        transform: Scale {
                            xScale: 0.25
                            yScale: 0.25
                        }
                        visible: zm.capturing
                    }
                    */
                    Rectangle{
                        anchors.fill: parent
                        color: 'transparent'
                        border.width: 1
                        border.color: 'yellow'
                        visible: apps.dev
                    }
                    Rectangle{
                        width: 6
                        height: xApp.height*2
                        color: 'transparent'//apps.fontColor
                        border.width: 1
                        border.color: 'red'
                        anchors.centerIn: parent
                        visible: app.showCenterLine
                    }
                    Rectangle{
                        width: xApp.height*2
                        height: 6
                        color: 'transparent'//apps.fontColor
                        border.width: 1
                        border.color: 'red'
                        anchors.centerIn: parent
                        visible: app.showCenterLine
                    }
                    ZoolText{
                        id: capDate
                        text: 'Imagen creada por Zool'
                        tf: Text.PlainText
                        w: app.fs*6
                        font.pixelSize: app.fs*0.5
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        visible: zm.capturing
                    }
                }
                Rectangle{
                    id: xDevLines
                    width: 4
                    height: parent.height*4
                    anchors.centerIn: parent
                    visible: xZoolMap.showDevLines
                    Rectangle{
                        width: parent.parent.width*4
                        height: 4
                        anchors.centerIn: parent
                    }
                }
            }
            Rectangle{
                id: xMsgProcDatos
                width: txtPD.contentWidth+app.fs
                height: app.fs*4
                color: 'black'
                border.width: 2
                border.color: 'white'
                visible: false
                anchors.centerIn: parent
                ZoolText {
                    id: txtPD
                    text: 'Procesando datos...'
                    w: app.fs*6
                    //font.pixelSize: app.fs
                    //color: 'white'
                    anchors.centerIn: parent
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: parent.visible=false
                }
            }
            //Keys.onDownPressed: Qt.quit()
        }
        Item{
            id: capa101
            anchors.fill: xApp
            ZoolDataView{id: zoolDataView;}
            Row{
                anchors.top: zoolDataView.bottom
                anchors.bottom: xBottomBar.top
                Rectangle{
                    id: xLatIzq
                    width: xApp.width*0.2
                    height: parent.height
                    color: apps.backgroundColor
                    visible: apps.showLatIzq
                    ZoolSectionsManager{id: zsm}

                    FocusSen{visible: apps.zFocus==='xLatIzq'}
                }
                Item{
                    width: xLatIzq.width;
                    height: 1;
                    visible: !xLatIzq.visible


                }
                Item{
                    id: xMed
                    width: xApp.width-xLatIzq.width-xLatDer.width
                    height: parent.height


                    //ZoolElementsView{id: zoolElementsView}
                    //ExtId
                    Text{
                        text: '<b>uExtId: '+zoolDataView.uExtIdLoaded+'</b>'
                        font.pixelSize: app.fs*0.5
                        color: apps.fontColor
                        anchors.horizontalCenter: parent.horizontalCenter
                        visible: apps.dev
                    }
                    /*
                    Item{
                        id: xControlsTime
                        width: controlsTime.width
                        height: controlsTime.height
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        property bool showCT: false
                        MouseArea{
                            anchors.fill: parent
                            onClicked: xControlsTime.showCT=!xControlsTime.showCT
                        }
                        Item{
                            id:xIconClock
                            width: app.fs
                            height: width
                            //anchors.horizontalCenter: parent.horizontalCenter
                            anchors.right: parent.left
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: app.fs*0.1
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    xControlsTime.showCT=!xControlsTime.showCT
                                    xControlsTimeBack.showCT=false
                                }
                            }
                            Text{
                                id:ccinit
                                text:'\uf017'
                                font.family: 'FontAwesome'
                                font.pixelSize: app.fs*0.75
                                color: apps.houseColor
                                anchors.centerIn: parent
                            }
                        }
                        //Comps.ControlsTime{
                        ZoolControlsTime{
                            id: controlsTime
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: h
                            property int h: parent.showCT?0:0-height
                            setAppTime: true
                            onGmtChanged: zm.currentGmt=gmt
                            Behavior on h{NumberAnimation{duration: 250; easing.type: Easing.InOutQuad}}
                        }

                    }
                    Item{
                        id: xControlsTimeBack
                        width: controlsTimeBack.width
                        height: controlsTimeBack.height
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        visible: zm.ev
                        property bool showCT: false
                        MouseArea{
                            anchors.fill: parent
                            onClicked: xControlsTimeBack.showCT=!xControlsTimeBack.showCT
                        }
                        Item{
                            id:xIconClockBack
                            width: app.fs
                            height: width
                            //anchors.horizontalCenter: parent.horizontalCenter
                            //anchors.horizontalCenterOffset: width+app.fs*0.5
                            anchors.left: parent.right
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: app.fs*0.1
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    xControlsTimeBack.showCT=!xControlsTimeBack.showCT
                                    xControlsTime.showCT=false
                                }
                            }
                            Text{
                                id:ccinitBack
                                text:'\uf017'
                                font.family: 'FontAwesome'
                                font.pixelSize: app.fs*0.75
                                color: apps.houseColorBack//apps.fontColor
                                anchors.centerIn: parent
                            }
                        }
                        ZoolControlsTime{
                            id: controlsTimeBack
                            isBack: true
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: h
                            property int h: parent.showCT?0:0-height
                            setAppTime: true
                            onGmtChanged: zm.currentGmtBack=gmt
                            Behavior on h{NumberAnimation{duration: 250; easing.type: Easing.InOutQuad}}
                        }
                    }
                    */
                    FocusSen{
                        width: xLatIzq.visible?parent.width:parent.width+xLatIzq.width
                        //anchors.horizontalCenterOffset: 800//xLatIzq.visible?0:500
                        anchors.left: parent.left
                        anchors.leftMargin: xLatIzq.visible?0:0-xLatIzq.width
                        visible: apps.zFocus==='xMed'
                    }
                    Rectangle{
                        id: centro
                        width: 10
                        height: 5000
                        anchors.centerIn: parent
                        visible: false
                        Rectangle{
                            width: pppText.contentWidth+10
                            height: app.fs
                            anchors.centerIn: parent
                            Text{
                                id: pppText
                                font.pixelSize: app.fs*0.5
                                anchors.centerIn: parent
                            }
                        }
                    }
                    ZoolBodiesGuiTools{
                        id: xTools
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        //anchors.rightMargin: app.width*0.2
                    }
                }
                Item{
                    id: xLatDer
                    width: xApp.width*0.2
                    height: parent.height

                    //Chat{id: chat; z: onTop?panelPronEdit.z+1:panelControlsSign.z-1}
                    //PanelControlsSign{id: panelControlsSign}
                    ZoolDataBodies{id: zoolDataBodies}
                    //PanelPronEdit{id: panelPronEdit;}
                    FocusSen{visible: apps.zFocus==='xLatDer'}
                    ZoolPanelNotifications{
                        id: zpn
                        anchors.right: parent.right
                        anchors.rightMargin: apps.zFocus==='xLatDer'?xLatDer.width:0
                    }
                }
            }
            //Comps.XDataStatusBar{id: xDataStatusBar}

            ZoolBottomBar{
                id: xBottomBar
                //clip: true

            }
            ZoolInfoDataView{id: xInfoData}
            ZoolDataEditor{id: xEditor}
            ZoolEvolutionView{id: zev}
            ZoolIntSplash{id: zis}
        }
        Comps.XSelectColor{
            id: xSelectColor
            width: app.fs*8
            height: app.fs*8
            c: 'backgroundColor'
        }
        ZoolLogView{
            id: log;
            width: xLatIzq.width
            height: xLatIzq.height
            anchors.bottom: parent.bottom
            anchors.bottomMargin:apps.zFocus!=='cmd'?0:xBottomBar.height
        }
        ZoolWebStatusManager{id: zwsm}
        ZoolDataManager{id: zdm}
    }






    //--->3D

//    Item{
//        id: x3D
//        anchors.fill: parent
//        visible: app.show3D
//        Row {
//            anchors.left: parent.left
//            anchors.leftMargin: 8
//            spacing: 10
//            Column {
//                Label {
//                    color: app.c
//                    font.pointSize: 14
//                    text: "Last Pick:"
//                }
//                Label {
//                    color: app.c
//                    font.pointSize: 14
//                    text: "Screen Position:"
//                }
//                Label {
//                    color: app.c
//                    font.pointSize: 14
//                    text: "UV Position:"
//                }
//                Label {
//                    color: app.c
//                    font.pointSize: 14
//                    text: "Distance:"
//                }
//                Label {
//                    color: app.c
//                    font.pointSize: 14
//                    text: "World Position:"
//                }
//                Label {
//                    color: app.c
//                    font.pointSize: 14
//                    text: "Local Position:"
//                }

//                Label {
//                    color: app.c
//                    font.pointSize: 14
//                    text: "World Normal:"
//                }
//                Label {
//                    color: app.c
//                    font.pointSize: 14
//                    text: "Local Normal:"
//                }
//            }
//            Column {
//                Label {
//                    id: pickName
//                    color: app.c
//                    font.pointSize: 14
//                }
//                Label {
//                    id: pickPosition
//                    color: app.c
//                    font.pointSize: 14
//                }
//                Label {
//                    id: uvPosition
//                    color: app.c
//                    font.pointSize: 14
//                }
//                Label {
//                    id: distance
//                    color: app.c
//                    font.pointSize: 14
//                }
//                Label {
//                    id: scenePosition
//                    color: app.c
//                    font.pointSize: 14
//                }
//                Label {
//                    id: localPosition
//                    color: app.c
//                    font.pointSize: 14
//                }
//                Label {
//                    id: worldNormal
//                    color: app.c
//                    font.pointSize: 14
//                }
//                Label {
//                    id: localNormal
//                    color: app.c
//                    font.pointSize: 14
//                }

//            }
//        }
//        Row{
//            anchors.right: parent.right
//            Column{
//                Label {
//                    text: "rot:"+parseFloat(zm3d.currentSignRot).toFixed(2)
//                    font.pointSize: 14
//                    color: app.c
//                }
//                Label {
//                    text: "cbi:"+zm3d.cbi
//                    font.pointSize: 14
//                    color: app.c
//                }
//            }
//        }
//        Rectangle {
//            id: itemBodieSen
//            layer.enabled: true
//            width: height/4
//            height: 1000
//            border.width: 0
//            border.color: 'red'
//            color: 'white'
//            x:0-(width*8)
//            rotation: 90
//            Rectangle{
//                width: parent.width
//                height: parent.height
//                x: parent.width
//                transform: Scale{ xScale: -1 }
//                border.width: 4
//                border.color: 'red'

//                Text{
//                    text:'<b>'+zm3d.aBodies[zm3d.cbi]+' en '+zm3d.aSigns[zm3d.cbis]+' en casa '+zm3d.cbih+'</b><br><b>en el grado °'+zm3d.cbRsgdeg+' \''+zm3d.cbmdeg+' \'\''+zm3d.cbsdeg+'</b>'
//                    font.pixelSize: parent.parent.width*0.2
//                    rotation: 90
//                    //color: 'white'

//                    anchors.centerIn: parent
//                    Timer{
//                        running: true
//                        repeat: false//true
//                        interval: 200
//                        onTriggered:  {
//                            setCDS()
//                        }
//                    }

//                }
//            }
//        }
//        Rectangle {
//            id: itemAscSen
//            layer.enabled: true
//            width: height/4
//            height: 1000
//            border.width: 0
//            border.color: 'red'
//            color: 'white'
//            x:0-(width*8)
//            rotation: 90
//            Rectangle{
//                width: parent.width
//                height: parent.height
//                x: parent.width
//                transform: Scale{ xScale: -1 }
//                border.width: 4
//                border.color: 'red'

//                Text{
//                    text:'<b>Ascendente °'+zm3d.cAscRsDeg+' de '+zm3d.aSigns[zm3d.cAscIs]+'</b>'
//                    font.pixelSize: parent.parent.width*0.2
//                    rotation: 90
//                    //color: 'white'

//                    anchors.centerIn: parent
//                    Timer{
//                        running: true
//                        repeat: false//true
//                        interval: 200
//                        onTriggered:  {
//                            setCDS()
//                        }
//                    }

//                }
//            }
//        }
//        Rectangle {
//            id: itemSen1
//            layer.enabled: true
//            width: height/4
//            height: 1000
//            border.width: 0
//            border.color: 'red'
//            color: 'white'
//            x:0-(width*8)
//            rotation: 90
//            Rectangle{
//                width: parent.width
//                height: parent.height
//                x: parent.width
//                transform: Scale{ xScale: -1 }
//                border.width: 0
//                border.color: 'red'
//                Row{
//                    spacing: itemSen1.height*0.05
//                    rotation: 90
//                    anchors.centerIn: parent
//                    Text{
//                        id: txtSen1
//                        text:'<b>°'+parseInt(sen.ciDegSen-1)+' '+zm3d.aSigns[sen.ciSignSen]+'</b>'
//                        font.pixelSize: parent.parent.width*0.2
//                        anchors.verticalCenter: parent.verticalCenter
//                    }
//                    Image{
//                        width: itemSen1.height*0.1
//                        height: width
//                        //rotation: 90
//                        //source: "imgs/"+sen.ciSignSen+".png"
//                        source: "modules/ZM3D/ZM3DSignCircle/ZM3DSignArc/imgs/"+sen.ciSignSen+".png"
//                        anchors.verticalCenter: parent.verticalCenter
//                    }
//                    Text{
//                        text:'<b>°'+sen.currentDegSen+'</b>'
//                        font.pixelSize: parent.parent.width*0.2
//                        anchors.verticalCenter: parent.verticalCenter
//                    }
//                }
//            }
//        }
//        View3D {
//            id: view
//            anchors.fill: parent
//            renderMode: View3D.Underlay
//            property var cCam: camera//Giro
//            camera: cCam
//            environment: SceneEnvironment {
//                probeBrightness: 0//250
//                //clearColor: "#848895"
//                clearColor: "#000"

//                backgroundMode: SceneEnvironment.Color
//                lightProbe: Texture {
//                    source: "maps-/OpenfootageNET_garage-1024.hdr"
//                }
//            }
//            Luces{id: luces}
//            ZM3D{id: zm3d}
//            Node{
//                id: ncg
//                rotation.z: gdec
//                property real gdec: -90-zm3d.currentSignRot
//                onGdecChanged: rotation.z=gdec
//                //rotation.y:90
//                Behavior on rotation.z{NumberAnimation{duration: 2000}}
//                Node{
//                    //position: Qt.vector3d(0, 0, ((0-zm3d.d)*2)+2000)
//                    position: Qt.vector3d(0, -1600, -600)
//                    rotation.x: -90
//                    PerspectiveCamera {
//                        id: cameraGiro
//                        rotation.x: 40
//                        Behavior on rotation.x{NumberAnimation{duration: 2000}}
//                        Behavior on rotation.y{NumberAnimation{duration: 2000}}
//                        Behavior on rotation.z{NumberAnimation{duration: 2000}}
//                    }
//                    Node{
//                        position: cameraGiro.position
//                        rotation: cameraGiro.rotation
//                        //visible: r.verPosicionDeCamara
//                        Model {
//                            id: esferaFoco
//                            source: "#Sphere"
//                            pickable: true
//                            scale.x: 0.5
//                            scale.y: 0.5
//                            scale.z: 0.5
//                            materials: DefaultMaterial {
//                                diffuseColor: 'red'
//                            }
//                        }
//                        Model {
//                            source: "#Cube"
//                            pickable: true
//                            scale.x: 0.1
//                            scale.y: 1.0
//                            scale.z: 0.1
//                            materials: DefaultMaterial {
//                                diffuseColor: 'blue'
//                            }
//                        }
//                        Model {
//                            source: "#Cube"
//                            pickable: true
//                            scale.x: 0.1
//                            scale.y: 0.1
//                            scale.z: 1.0
//                            materials: DefaultMaterial {
//                                diffuseColor: 'yellow'
//                            }
//                        }
//                        Model {
//                            source: "#Cube"
//                            pickable: true
//                            scale.x: 1.0
//                            scale.y: 0.1
//                            scale.z: 0.1
//                            materials: DefaultMaterial {
//                                diffuseColor: 'white'
//                            }
//                        }
//                    }
//                }
//                SequentialAnimation on rotation {
//                    //enabled: false
//                    loops: Animation.Infinite
//                    running: false
//                    PropertyAnimation {
//                        duration: 12000
//                        to: Qt.vector3d(0, 0, 0)
//                        from: Qt.vector3d(0, 0, 360)
//                    }
//                }
//            }
//            PerspectiveCamera {
//                id: camera
//                position: Qt.vector3d(0, 0, ((0-zm3d.d)*2)-400)
//                //Behavior on rotation.x{NumberAnimation{duration: 2000}}
//                //Behavior on rotation.y{NumberAnimation{duration: 2000}}
//                //Behavior on rotation.z{NumberAnimation{duration: 2000}}
//            }
//            PerspectiveCamera {
//                id: cameraLeft
//                position: Qt.vector3d(((0-zm3d.d)*2)-400, 0, 0)
//                rotation.y: 90
//                //Behavior on rotation.x{NumberAnimation{duration: 2000}}
//                //Behavior on rotation.y{NumberAnimation{duration: 2000}}
//                //Behavior on rotation.z{NumberAnimation{duration: 2000}}
//            }
//            Model {
//                visible: false
//                id: centro3D
//                source: "#Sphere"
//                pickable: true
//                property bool isPicked: false

//                scale.x: 1.0
//                scale.y: 1.0
//                scale.z: 1.0
//                materials: DefaultMaterial {
//                    diffuseColor: centro.isPicked ? "red" : "#00FF00"
//                    specularAmount: 0.4
//                    specularRoughness: 0.4
//                }

//                //            SequentialAnimation on rotation {
//                //                running: !cubeModel.isPicked
//                //                loops: Animation.Infinite
//                //                PropertyAnimation {
//                //                    duration: 2500
//                //                    from: Qt.vector3d(0, 0, 0)
//                //                    to: Qt.vector3d(360, 360, 360)
//                //                }
//                //            }

//            }
//            Model {
//                source: "#Sphere"
//                scale: Qt.vector3d(2.0, 2.0, 2.0)
//                position: Qt.vector3d(0, 0, -100)
//                rotation: Qt.vector3d(0, 0, 0)
//                materials: [ PrincipledMaterial {
//                        metalness: 0.0
//                        roughness: 0.0
//                        specularAmount: 0.0
//                        indexOfRefraction: 1.0
//                        opacity: 1.0
//                        baseColorMap: Texture { source: "modules/ZM3D/ZM3DBodiesCircle/imgs/mundo.jpg" }
//                    }
//                ]
//                SequentialAnimation on rotation {
//                    loops: Animation.Infinite
//                    running: true
//                    PropertyAnimation {
//                        duration: 5000
//                        to: Qt.vector3d(0, 90, 0)
//                        from: Qt.vector3d(360, 90, 0)
//                    }
//                }
//            }

//            Sen{id: sen}
//        }
//        MouseArea {
//            acceptedButtons: Qt.AllButtons;
//            anchors.fill: view
//            onClicked: {
//                if (mouse.button === Qt.RightButton) {
//                    menuView3D.popup()
//                }else{
//                    // Get screen coordinates of the click
//                    pickPosition.text = "(" + mouse.x + ", " + mouse.y + ")"
//                    var result = view.pick(mouse.x, mouse.y);
//                    if (result.objectHit) {
//                        var pickedObject = result.objectHit;
//                        // Toggle the isPicked property for the model
//                        pickedObject.isPicked = !pickedObject.isPicked;
//                        // Get picked model name
//                        pickName.text = pickedObject.objectName;
//                        //                var object = result.node;
//                        //                if (object) {
//                        //                    log.lv("Posición absoluta del objeto seleccionado:", object.position);
//                        //                }
//                        //                log.lv('result.position: '+pickedObject.parent.position)
//                        //                log.lv('result.position: '+pickedObject.node)
//                        //view.cCam.position=result.position
//                        // Get other pick specifics
//                        uvPosition.text = "("
//                                + result.uvPosition.x.toFixed(2) + ", "
//                                + result.uvPosition.y.toFixed(2) + ")";
//                        //view.cCam.position.x=result.uvPosition.x
//                        distance.text = result.distance.toFixed(2);
//                        scenePosition.text = "("
//                                + result.scenePosition.x.toFixed(2) + ", "
//                                + result.scenePosition.y.toFixed(2) + ", "
//                                + result.scenePosition.z.toFixed(2) + ")";
//                        localPosition.text = "("
//                                + result.position.x.toFixed(2) + ", "
//                                + result.position.y.toFixed(2) + ", "
//                                + result.position.z.toFixed(2) + ")";
//                        worldNormal.text = "("
//                                + result.sceneNormal.x.toFixed(2) + ", "
//                                + result.sceneNormal.y.toFixed(2) + ", "
//                                + result.sceneNormal.z.toFixed(2) + ")";
//                        localNormal.text = "("
//                                + result.normal.x.toFixed(2) + ", "
//                                + result.normal.y.toFixed(2) + ", "
//                                + result.normal.z.toFixed(2) + ")";
//                    } else {
//                        pickName.text = "None";
//                        uvPosition.text = "";
//                        distance.text = "";
//                        scenePosition.text = "";
//                        localPosition.text = "";
//                        worldNormal.text = "";
//                        localNormal.text = "";
//                    }
//                }
//            }
//            onDoubleClicked: {
//                view.cCam.position=Qt.vector3d(0, 0, (0-zm3d.d)*2)
//                view.cCam.rotation=Qt.vector3d(0, 0, 0)
//            }
//            onWheel: {
//                let cz=view.cCam.position.z
//                if (wheel.modifiers & Qt.ControlModifier) {
//                    if(wheel.angleDelta.y>=0){
//                        cz+=40
//                    }else{
//                        cz-=40
//                    }
//                }else if (wheel.modifiers & Qt.ShiftModifier){

//                }else{
//                    if(wheel.angleDelta.y>=0){
//                        //                    if(reSizeAppsFs.fs<app.fs*2){
//                        //                        reSizeAppsFs.fs+=reSizeAppsFs.fs*0.1
//                        //                    }else{
//                        //                        reSizeAppsFs.fs=app.fs
//                        //                    }
//                        pointerPlanet.pointerRot+=45
//                    }else{
//                        //                    if(reSizeAppsFs.fs>app.fs){
//                        //                        reSizeAppsFs.fs-=reSizeAppsFs.fs*0.1
//                        //                    }else{
//                        //                        reSizeAppsFs.fs=app.fs*2
//                        //                    }
//                        //pointerPlanet.pointerRot-=45
//                    }
//                }
//                //reSizeAppsFs.restart()
//                view.cCam.position.z=cz
//            }
//        }
//    }


    property var zoolMap3D
    ZoolMap3D{}
    //<---3D

    Item{id: xuqps}
    QtObject{
        id: setHost
        function setData(data, isData){
            if(isData){
                console.log('Host: '+data)
                let h=(''+data).replace(/\n/g, '')
                apps.host=h
                let ms=new Date(Date.now()).getTime()
                if(!apps.newClosed){
                    JS.getRD('https://github.com/nextsigner/nextsigner.github.io/raw/master/zool/windowstart/main.qml?r='+ms, setZoolStart)
                }
            }else{
                console.log('Data '+isData+': '+data)
                JS.showMsgDialog('Error! - Zool Informa', 'Problemas de conexión a internet', 'Por alguna razón, la aplicación no está pudiendo acceder a internet para obtener los datos requeridos. Error: '+data)
            }
        }
    }
    QtObject{
        id: setZoolStart
        function setData(data, isData){
            if(isData){
                console.log('Host: '+data)
                let comp=Qt.createQmlObject(data, app, 'xzoolstart')
            }else{
                console.log('setXZoolStart Data '+isData+': '+data)
                app.j.showMsgDialog('Error! - Zool Informa', 'Problemas de conexión a internet', 'Por alguna razón, la aplicación no está pudiendo acceder a internet para obtener los datos requeridos. Error: '+data)
            }
        }
    }
    PushOver{id: pushOver}
    //    Text{
    //        text: '->'+menuBar.expanded
    //        font.pixelSize: app.fs*3
    //        color: 'red'
    //    }
    //Comps.MenuPlanets{id: menuPlanets}
    ZoolMenuCtxAs{id: menuPlanets}
    ZoolMapMenuCtx{id: menuRuedaZodiacal}
    ZoolMenuPlanetsCtxAsc{id: menuPlanetsCtxAsc}
    ZoolMenuCtxHouses{id: menuCtxHouses}
    ZoolMenuCtxView3D{id: menuView3D}
    //ZoolMediaLive{id: zoolMediaLive;parent: zoolDataBodies}

    //Este esta en el centro
    Rectangle{
        id: centroideXMed
        visible: apps.dev
        width: 6
        height: width
        color: 'transparent'
        border.width: 1
        border.color: apps.fontColor
        anchors.centerIn: parent
    }

    //Linea vertical medio
    Rectangle{
        width: 2
        height: xApp.height*2
        anchors.centerIn: parent
        visible: apps.dev
    }
    //    Timer{
    //        id: tLoadModules
    //        running: false
    //        repeat: false
    //        interval: 5000
    //        onTriggered: JS.loadModules()
    //    }

    ZoolMultiOSUpdate{id: zmu}
    Component.onCompleted: {
        let c=''
        //c='import QtQuick 2.0\n'
        c+='import ZoolMap3D 1.0\n'
        c+='ZoolMap3D{}\n'
        //zoolMap3D = Qt.createQmlObject(cZM3D, capa101, 'code-ZM3D');
        //let objZM3D=Qt.createQmlObject(c, capa101, 'zm3dcode')
        if(Qt.platform.os==='linux' && !u.folderExist(app.sweFolder)){
            log.lv('Error de instalación de Zool para GNU/Linux.\nSwe no está instalado.')
            return

        }
        c='import ZoolDataManager 1.0\n'
        c+='ZoolDataManager{}'
        let obj=Qt.createQmlObject(c, capa101, 'ziscode')
        menuBar.aMenuItems.push(menuRuedaZodiacal)


        if(apps.workSpace==='')apps.workSpace=u.getPath(3)+'/Zool'
        if(!u.folderExist(u.getPath(3)+'/Zool')){
            u.mkdir(u.getPath(3)+'/Zool')
        }
        if(apps.dev)log.lv('Ultimo archivo cargado con anterioridad: '+apps.url)
        let args=Qt.application.arguments
        JS.setFs()
        zm.setTheme(apps.currentThemeIndex)
        //Check is dev with the arg -dev
        if(args.indexOf('-dev')>=0){
            apps.dev=true
        }





        let v=u.getFile('./version')
        app.version=v.replace(/\n/g, '')
        /*if(app.version!==apps.lastVersion || apps.dev){
            apps.lastVersion=app.version
            let c='import QtQuick 2.0\n'
            c+='import ZoolNewsAndUpdates 3.4\n'
            c+='ZoolNewsAndUpdates{}\n'
            let obj=Qt.createQmlObject(c, xLatIzq, 'znaucode')
            obj.z=log.z+1
        }*/
        //if(Qt.platform.os==='linux'){
        /*if(Qt.platform.os==='windows'){
            let c='import QtQuick 2.0\n'
            c+='import comps.ZoolWinUpdate 1.0\n'
            c+='ZoolWinUpdate{}\n'
            let obj=Qt.createQmlObject(c, xLatIzq, 'zoolwinupdatecode')
            obj.z=log.z+1
        }else{
            let c='import QtQuick 2.0\n'
            c+='import comps.ZoolMultiOSUpdate 1.0\n'
            c+='ZoolMultiOSUpdate{}\n'
            let obj=Qt.createQmlObject(c, xLatIzq, 'zoolwinupdatecode')
            obj.z=log.z-1
        }*/


        //Argumentos
        var i=0
        for(i=0;i<args.length;i++){
            let a=args[i]
            if(a.indexOf('-title=')>=0){
                let mt=a.split('-title=')
                app.title=mt[1]
            }
        }

        //Check apps.workSpaceTemp
        if(apps.workSpace===''){
            let jft=u.getPath(3)+'/Zool/Temp'
            u.mkdir(jft)
            apps.workSpaceTemp=jft
        }
        if(apps.isJsonsFolderTemp){
            let jsonF=apps.workSpace
            let jsonFT=apps.workSpaceTemp
            apps.workSpace=jsonFT
            apps.workSpaceTemp=jsonF
        }

        if(apps.dev){
            log.ls('\nRunning as Dev', 0, xLatIzq.width)
            //log.ls('\nVersion:\n'+version, log.x,
            log.ls('\nu.currentFolderPath():\n'+u.currentFolderPath(), log.x, log.width)
            log.ls('\nu.getPath(4):\n'+u.getPath(4), log.x, log.width)
            log.ls('\napps.workSpace:\n'+apps.workSpace, log.x, log.width)
            log.ls('\nDocumentPath:\n'+documentsPath, log.x, log.width)
        }

        app.mainLocation=u.getPath(5)
        if(Qt.platform.os==='windows'){
            app.mainLocation="\""+app.mainLocation+"\""
        }
        console.log('app.mainLocation: '+app.mainLocation)
        console.log('documentsPath: '+documentsPath)
        console.log('Init app.url: '+app.url)
        let fileLoaded=false
        let appArgs=Qt.application.arguments
        let arg=''
        for(i=0;i<appArgs.length;i++){
            let a=appArgs[i]
            if(a.indexOf('file=')>=0){
                let ma=a.split('=')
                if(ma.length>1){
                    arg=ma[1]
                    //log.ls('File: '+arg, 0, xApp.width*0.5)
                    if(apps.dev)log.lv('Cargando '+arg)
                    zm.loadJsonFromFilePath(arg, false)
                    fileLoaded=true
                }
            }
        }
        if(!fileLoaded){
            //let fp=
            if(apps.url!==''&&u.fileExist(apps.url)&&apps.workSpace!==''){
                console.log('Cargando al iniciar: '+apps.url)
                //Detalles Técnicos extras
                if(apps.dev){
                    log.visible=true
                    log.l('\nEl módulo Python SwissEph se encuentra instalado en '+app.pythonLocation)
                }
                if(apps.dev)log.lv('Cargando en modo desarrollo: '+apps.url)
                zm.loadJsonFromFilePath(apps.url)
                return
            }else{
                if(apps.url===''){
                    zdm.firstRunTime()
                }else{
                    if(!u.fileExist(apps.url)){
                        log.lv('El archivo '+apps.url+' que se intenta cargar, no existe o ha sido eliminado. Se procede a cargar los tránsitos actuales.')
                        zm.loadNow(false)
                        /*let sep='Sinastría'
                    let aL=[]
                    aL.push('Trásitos de Ahora')
                    let aR=[]
                    zoolDataView.setDataView(sep, aL, aR)*/
                    }
                    if(apps.dev){
                        log.visible=true
                        log.l('\nEl módulo Python SwissEph se encuentra instalado en '+app.pythonLocation)
                        log.l('\nEl módulo MinymaClient se conecta mediante el host: '+minymaClient.host)
                        log.l('\napp.url: '+app.url)
                        log.l('\napp.url exist: '+u.fileExist(apps.url))
                    }
                }

            }
        }
        //JS.getRD('https://github.com/nextsigner/nextsigner.github.io/raw/master/zool/zool', setHost)
        apps.host='https://zool.loca.lt'
        //app.j.loadModules()
        app.requestActivate()
        //log.focus=true
    }
    function isCiActive(){
        return app.ci && app.ci.objectName.indexOf('mm_ModulesLoader')<0 && app.j.qmltypeof(app.ci)!=='ModulesLoader' && app.ci.objectName!=='xApp'
    }

}

