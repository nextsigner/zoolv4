import QtQuick 2.0
import QtQuick.Window 2.0
import Qt.labs.settings 1.1

Settings{
    id: r
    //fileName:'zool_'+Qt.platform.os+'.cfg'
    fileName: u.getPath(4)+'/zool.cfg'

    property string mainFolder: u.getPath(4)
    property string lastVersion: '3.14.0'

    property bool dev: false
    property bool dep: false

    property string appId: ''
    onAppIdChanged: {
        u.setFile('appid', appId)
        u.setFile(u.getPath(4)+'/appid', appId)
    }


    //GUI
    property bool showCmd: false
    property bool showQmlErrors: false


    property string zoolUser: ''
    property string zoolUserId: ''
    property string zoolKey: ''
    property bool enableShareInServer: false

    //Minyma
    property string minymaClientHost: 'ws://192.168.1.51'
    property int minymaClientPort: 12345
    property bool showLog: false
    property int fs: app.width*0.02
    property int fsSbValue: 50
    property string host: 'http://localhost'
    property string hostQuiron: 'https://github.com/nextsigner/quiron/raw/master/data'
    property bool newClosed: false

    property string url: ''
    property string urlBack: ''
    property bool showLatIzq: true
    property bool showTimes: false
    property bool showLupa: false
    property bool showSWEZ: true

    //Paneles
    property string panelRemotoState: 'show'
    property int currentSwipeViewIndex: 0
    property int currentZoolTextRectCamHeight: app.fs*6

    //Houses
    property string defaultHsys: 'T'
    property string currentHsys: 'T'
    property string houseColor: "#2CB5F9"
    property string houseColorBack: 'red'
    property bool showHousesAxis: false
    property int widthHousesAxis: 3.0
    property string houseLineColor: 'white'
    property string houseLineColorBack: 'red'
    property int houseLineWidth: 2
    property int houseLineWidthBack: 2

    //XAs
    property color xAsColor: 'white'
    property color xAsColorBack: 'black'
    property color xAsBackgroundColorBack: 'white'
    property real xAsBackgroundOpacityBack: 0.5
    property bool anColorXAs: false
    property bool anRotation3CXAs: false
    property color pointerLineColor: 'red'
    property int pointerLineWidth: 2
    property bool xAsShowIcon: false

    //Asp
    property int aspLineWidth: 2
    property bool panelAspShowBg: true

    //ZoolMap
    property bool previewEnabled: true
    property int zmCurrenThemeIndex: 0
    property string swegMod: 'vn'

    //NumberLines{}
    property bool showNumberLines: true
    property int numberLinesMode: 0

    property bool showDec: false
    property bool showXAsLineCenter: false
    property color xAsLineCenterColor: 'red'
    property real sweMargin: 1.8
    property real signCircleWidth: Screen.width*0.02
    property real signCircleWidthSbValue: 8000
    property int sweFs: Screen.width*0.020
    property bool showAspCircle: true
    property bool showAspCircleBack: true
    property bool showAspPanel: true
    property bool showAspPanelBack: true
    property bool enableWheelAspCircle: true

    //GUI
    property string zFocus: 'xLatIzq'
    property bool speakEnabled: false

    //property bool showLog: false
    property bool showMenuBar: false
    property int currentThemeIndex: 0
    property bool enableBackgroundColor: false
    property string backgroundColor: "black"
    property string fontFamily: "ArialMdm"
    property string fontColor: "white"
    property int fontSize: app.fs*0.5
    property int botSize: app.fs*0.5
    property int botSizeSpinBoxValue: 50
    property real elementsFs: Screen.width*0.02
    property bool xToolEnableHide: true

    //Reproductor de Lectura
    property bool repLectVisible: false
    property url repLectCurrentFolder: documentsPath
    property int repLectX: 0
    property int repLectY: Screen.height*0.7
    property int repLectW: Screen.width*0.21
    property int repLectH: Screen.width*0.15

    property string repLectCurrentVidIntro: ''
    property string repLectCurrentVidClose: ''

    //Reproductor Audio Texto a Voz
    property url repAudioTAVCurrentFolder: documentsPath+'/audio'


    property int lupaMod: 2
    property int lupaBorderWidth: 3
    property string lupaColor: "white"
    property real lupaOpacity: 0.5
    property int lupaRot: 0
    property int lupaX: Screen.width*0.5
    property int lupaY: Screen.height*0.5
    property int lupaAxisWidth: 1
    property int lupaCenterWidth: 20

    //IW
    property int iwFs: Screen.width*0.02
    property int iwWidth: Screen.width*0.5

    property int editorFs: Screen.width*0.025*0.5
    property bool editorShowNumberLines: false
    property int editorTextFormat: 0

    //Panel Sabianos
    property real panelSabianosFz: 1.0
    property bool sabianosAutoShow: false

    //Panel AspTrans
    property int currentIndexP1: 0
    property int currentIndexP2: 0
    property int currentIndexAsp: 0
    property int currentAspCantAniosSearch: 20
    property bool autoShow: false

    property bool chat: false

    property bool backgroundImagesVisible: false
    property bool lt:false
    property bool enableFullAnimation: false

    property string workSpace: ''
    property string jsonsFolderTemp: ''
    property bool isJsonsFolderTemp: false

    //Num
    property string numCurrentFolder: u.getPath(3)
    property string numUFecha
    property string numUNom
    property string numUFirma
    property bool numShowFormula: false
    property int numPanelLogFs: app.width*0.02
    onCurrentThemeIndexChanged:zm.setTheme(currentThemeIndex)
    onIsJsonsFolderTempChanged: {
        let jf=jsonsFolder
        let jft=jsonsFolderTemp
        if(isJsonsFolderTemp){
            jsonsFolder=jft
            jsonsFolderTemp=jf
        }else{
            jsonsFolder=jft
            jsonsFolderTemp=jf
        }
    }
    onZFocusChanged: {
        if(zFocus==='xMed'||zFocus==='xLatDer'){
            zsm.allToEscape()
            //zoolFileManager.ti.focus=false
            //panelRsList.desactivar()
        }else{
            if(zsm.currentIndex===2){
                //zoolFileManager.ti.focus=true
            }
        }
    }
    onShowLupaChanged: sweg.centerZoomAndPos()
    onEnableBackgroundColorChanged: {
        if(enableBackgroundColor){
            ip.hideSS()
        }else{
            ip.showSS()
        }
    }
    Component.onCompleted: {
        let fe1=u.fileExist('appid')
        let fe2=u.fileExist(u.getPath(4)+'/appid')
        if(appId==='' && (fe1 || fe2)){
            if(fe1){
                appId=u.getFile('appid').replace(/\n/g, '')
            }else{
                appId=u.getFile(u.getPath(4)+'/appid').replace(/\n/g, '')
            }
        }
    }
}
