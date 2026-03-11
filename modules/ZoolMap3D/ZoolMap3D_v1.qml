import QtQuick 2.14
import QtQuick.Controls 2.12
import QtQuick.Window 2.14
import QtQuick3D 1.14
import Qt.labs.settings 1.1
import ZoolMenus.ZoolMenuCtxView3D 1.0

import "../../comps" as Comps

import ZoolMap3D.Cartel 1.0
import ZoolMap3D.Sen 1.0
import ZoolMap3D.Luces 1.0
import ZoolMap3D.ZM3D 1.0

Item {
    id: r
    //width: cfg.showFullWindow?Screen.width:xMed.width
    width: Screen.width
    height: xApp.height
    //parent: cfg.showFullWindow?app:xMed
    visible: app.show3D
    property color c: 'white'
    property alias zm3d: zm3d
    property alias cfg: cfg
    property alias view: view
    property alias cameraGiro: cameraGiro
    property alias camera: camera
    property alias cameraLeft: cameraLeft

    property alias mat1: mat1

    property var model1
    property var model2

    Component.onDestruction: {
        console.log("El objeto está siendo destruido, realizando limpieza...");
        //zoolMap3D = null;
        // Forzar repintado de la ventana padre
        //app.update();
    }
    onVisibleChanged: {
        if(visible){
            //let j=zm.currentJson
            //zoolMap3D.zm3d.loadData(j)
            //setMapData()
        }
    }
    Settings{
        id: cfg
        fileName: u.currentFolderPath()+'/zoolMap3D.cfg'
        property bool showFullWindow: true
        property bool showAsps: false
        property bool soloLuzDelSol: false
        property int v1: 100
        property int intensidadDeLasLuces: 40
        property int intensidadBrilloSolar: 25000
    }
    Column{
        Label {
            text: '<b>Zool 3D</b>'
            color: r.c
            font.pointSize: app.fs*0.5
        }
        Label {
            text: '<b>Creado por: </b>Ricardo M. Pizarro'
            color: r.c
            font.pointSize: app.fs*0.25
        }
        Item{width: 1; height: app.fs*0.5}
        Label {
            id: txtMapData
            text: ''
            color: r.c
            font.pointSize: app.fs*0.25
        }
        Row {
            anchors.left: parent.left
            anchors.leftMargin: 8
            spacing: 10
            visible: app.dev
            Column {
                Label {
                    color: r.c
                    font.pointSize: 14
                    text: "Last Pick:"
                }
                Label {
                    color: r.c
                    font.pointSize: 14
                    text: "Screen Position:"
                }
                Label {
                    color: r.c
                    font.pointSize: 14
                    text: "UV Position:"
                }
                Label {
                    color: r.c
                    font.pointSize: 14
                    text: "Distance:"
                }
                Label {
                    color: r.c
                    font.pointSize: 14
                    text: "World Position:"
                }
                Label {
                    color: r.c
                    font.pointSize: 14
                    text: "Local Position:"
                }

                Label {
                    color: r.c
                    font.pointSize: 14
                    text: "World Normal:"
                }
                Label {
                    color: r.c
                    font.pointSize: 14
                    text: "Local Normal:"
                }
            }
            Column {
                Label {
                    id: pickName
                    color: r.c
                    font.pointSize: 14
                }
                Label {
                    id: pickPosition
                    color: r.c
                    font.pointSize: 14
                }
                Label {
                    id: uvPosition
                    color: r.c
                    font.pointSize: 14
                }
                Label {
                    id: distance
                    color: r.c
                    font.pointSize: 14
                }
                Label {
                    id: scenePosition
                    color: r.c
                    font.pointSize: 14
                }
                Label {
                    id: localPosition
                    color: r.c
                    font.pointSize: 14
                }
                Label {
                    id: worldNormal
                    color: r.c
                    font.pointSize: 14
                }
                Label {
                    id: localNormal
                    color: r.c
                    font.pointSize: 14
                }

            }
        }
    }

    DefaultMaterial{id: mat1; diffuseColor: 'red'}

    Row{
        anchors.right: parent.right
        visible: app.dev
        Column{
            Label {
                text: "rot:"+parseFloat(zm3d.currentSignRot).toFixed(2)
                font.pointSize: 14
                color: r.c
            }
            Label {
                text: "cbi:"+zm3d.cbi
                font.pointSize: 14
                color: r.c
            }
        }
    }
    Rectangle {
        id: itemBodieSen
        layer.enabled: true
        width: height/4
        height: 1000
        border.width: 0
        border.color: 'red'
        color: 'white'
        x:0-(width*8)
        rotation: 90
        Rectangle{
            width: parent.width
            height: parent.height
            x: parent.width
            transform: Scale{ xScale: -1 }
            border.width: 4
            border.color: 'red'

            Text{
                text:'<b>'+zm3d.aBodies[zm3d.cbi]+' en '+zm3d.aSigns[zm3d.cbis]+' en casa '+zm3d.cbih+'</b><br><b>en el grado °'+zm3d.cbRsgdeg+' \''+zm3d.cbmdeg+' \'\''+zm3d.cbsdeg+'</b>'
                font.pixelSize: parent.parent.width*0.2
                rotation: 90
                //color: 'white'

                anchors.centerIn: parent
                Timer{
                    running: true
                    repeat: false//true
                    interval: 200
                    onTriggered:  {
                        setCDS()
                    }
                }

            }
        }
    }
    Rectangle {
        id: itemAscSen
        layer.enabled: true
        width: height/4
        height: 1000
        border.width: 0
        border.color: 'red'
        color: 'white'
        x:0-(width*8)
        rotation: 90
        Rectangle{
            width: parent.width
            height: parent.height
            x: parent.width
            transform: Scale{ xScale: -1 }
            border.width: 4
            border.color: 'red'

            Text{
                text:'<b>Ascendente °'+zm3d.cAscRsDeg+' de '+zm3d.aSigns[zm3d.cAscIs]+'</b>'
                font.pixelSize: parent.parent.width*0.2
                rotation: 90
                //color: 'white'

                anchors.centerIn: parent
                Timer{
                    running: true
                    repeat: false//true
                    interval: 200
                    onTriggered:  {
                        setCDS()
                    }
                }

            }
        }
    }
    Rectangle {
        id: itemSen1
        layer.enabled: true
        width: height/4
        height: 1000
        border.width: 0
        border.color: 'red'
        color: 'white'
        x:0-(width*8)
        rotation: 90
        Rectangle{
            width: parent.width
            height: parent.height
            x: parent.width
            transform: Scale{ xScale: -1 }
            border.width: 0
            border.color: 'red'
            Row{
                spacing: itemSen1.height*0.05
                rotation: 90
                anchors.centerIn: parent
                Text{
                    id: txtSen1
                    text:'<b>°'+parseInt(sen.ciDegSen-1)+' '+zm3d.aSigns[sen.ciSignSen]+'</b>'
                    font.pixelSize: parent.parent.width*0.2
                    anchors.verticalCenter: parent.verticalCenter
                }
                Image{
                    width: itemSen1.height*0.1
                    height: width
                    //rotation: 90
                    //source: "imgs/"+sen.ciSignSen+".png"
                    source: sen.ciSignSen>=0?"../ZoolMap3D/ZM3D/ZM3DSignCircle/ZM3DSignArc/imgs/"+sen.ciSignSen+".png":""
                    anchors.verticalCenter: parent.verticalCenter
                }
                Text{
                    text:'<b>°'+sen.currentDegSen+'</b>'
                    font.pixelSize: parent.parent.width*0.2
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }
    View3D {
        id: view
        anchors.fill: parent
        readonly property real ringRadius: zm3d.d*2//*0.5
        // IMPORTANTE: En 5.14, esto suele ser obligatorio
        // para que el View3D sepa qué renderizar.
        importScene: rootNode
        renderMode: View3D.Underlay
        property var cCam: camera//Giro
        camera: cCam
        environment: SceneEnvironment {
            probeBrightness: 0//250
            //clearColor: "#848895"
            clearColor: "#000"

            backgroundMode: SceneEnvironment.Color
            lightProbe: Texture {
                source: "maps/OpenfootageNET_garage-1024.hdr"
            }
        }
        /*environment: SceneEnvironment {
            clearColor: "black"
            backgroundMode: SceneEnvironment.Color
            //antialiasingMode: SceneEnvironment.SSAA
            //antialiasingQuality: SceneEnvironment.High
        }*/

        Node {
            id: rootNode
            Luces{visible: !cfg.soloLuzDelSol}
            ZM3D{id: zm3d}
            Node{
                id: ncg
                rotation.z: gdec
                property real gdec: -90-zm3d.currentSignRot
                onGdecChanged: rotation.z=gdec
                //rotation.y:90
                Behavior on rotation.z{NumberAnimation{duration: 2000}}
                Node{
                    //position: Qt.vector3d(0, 0, ((0-zm3d.d)*2)+2000)
                    position: Qt.vector3d(0, -1600, -600)
                    rotation.x: -90
                    PerspectiveCamera {
                        id: cameraGiro
                        rotation.x: 40
                        Behavior on rotation.x{NumberAnimation{duration: 2000}}
                        Behavior on rotation.y{NumberAnimation{duration: 2000}}
                        Behavior on rotation.z{NumberAnimation{duration: 2000}}
                    }
                    Node{
                        position: cameraGiro.position
                        rotation: cameraGiro.rotation
                        //visible: r.verPosicionDeCamara
                        Model {
                            id: esferaFoco
                            source: "#Sphere"
                            pickable: true
                            scale.x: 0.5
                            scale.y: 0.5
                            scale.z: 0.5
                            materials: DefaultMaterial {
                                diffuseColor: 'red'
                            }
                        }
                        Model {
                            source: "#Cube"
                            pickable: true
                            scale.x: 0.1
                            scale.y: 1.0
                            scale.z: 0.1
                            materials: DefaultMaterial {
                                diffuseColor: 'blue'
                            }
                        }
                        Model {
                            source: "#Cube"
                            pickable: true
                            scale.x: 0.1
                            scale.y: 0.1
                            scale.z: 1.0
                            materials: DefaultMaterial {
                                diffuseColor: 'yellow'
                            }
                        }
                        Model {
                            source: "#Cube"
                            pickable: true
                            scale.x: 1.0
                            scale.y: 0.1
                            scale.z: 0.1
                            materials: DefaultMaterial {
                                diffuseColor: 'white'
                            }
                        }
                    }
                }
                SequentialAnimation on rotation {
                    //enabled: false
                    loops: Animation.Infinite
                    running: false
                    PropertyAnimation {
                        duration: 6000
                        to: Qt.vector3d(0, 0, 0)
                        from: Qt.vector3d(0, 0, 360)
                    }
                }
            }
            PerspectiveCamera {
                id: camera
                position: Qt.vector3d(0, 0, ((0-zm3d.d)*2)-400)
                //Behavior on rotation.x{NumberAnimation{duration: 2000}}
                //Behavior on rotation.y{NumberAnimation{duration: 2000}}
                //Behavior on rotation.z{NumberAnimation{duration: 2000}}
            }
            PerspectiveCamera {
                id: cameraLeft
                position: Qt.vector3d(((0-zm3d.d)*2)-400, 0, 0)
                rotation.y: 90
                //Behavior on rotation.x{NumberAnimation{duration: 2000}}
                //Behavior on rotation.y{NumberAnimation{duration: 2000}}
                //Behavior on rotation.z{NumberAnimation{duration: 2000}}
            }

        }
        Model {
            source: "#Sphere"
            scale: Qt.vector3d(2.0, 2.0, 2.0)
            position: Qt.vector3d(0, 0, -100)
            rotation: Qt.vector3d(0, 0, 0)
            materials: [ PrincipledMaterial {
                    metalness: 0.0
                    roughness: 0.0
                    specularAmount: 0.0
                    indexOfRefraction: 1.0
                    opacity: 1.0
                    //baseColorMap: Texture { source: "ZM3D/ZM3DBodiesCircle/imgs/mundo.jpg" }
                    baseColorMap: Texture { source: u.currentFolderPath()+"/modules/ZoolMap3D/ZM3D/ZM3DBodiesCircle/imgs/mundo.jpg" }
                }
            ]
            SequentialAnimation on rotation {
                loops: Animation.Infinite
                running: true
                PropertyAnimation {
                    duration: 5000
                    to: Qt.vector3d(0, 90, 0)
                    from: Qt.vector3d(360, 90, 0)
                }
            }
        }
        Sen{id: sen}
    }
    MouseArea {
        acceptedButtons: Qt.AllButtons;
        anchors.fill: view
        onClicked: {
            if (mouse.button === Qt.RightButton) {
                menuView3D.popup()
            }else{
                // Get screen coordinates of the click
                pickPosition.text = "(" + mouse.x + ", " + mouse.y + ")"
                var result = view.pick(mouse.x, mouse.y);
                if (result.objectHit) {
                    var pickedObject = result.objectHit;
                    // Toggle the isPicked property for the model
                    pickedObject.isPicked = !pickedObject.isPicked;
                    // Get picked model name
                    pickName.text = pickedObject.objectName;
                    //                var object = result.node;
                    //                if (object) {
                    //                    log.lv("Posición absoluta del objeto seleccionado:", object.position);
                    //                }
                    //                log.lv('result.position: '+pickedObject.parent.position)
                    //                log.lv('result.position: '+pickedObject.node)
                    //view.cCam.position=result.position
                    // Get other pick specifics
                    uvPosition.text = "("
                            + result.uvPosition.x.toFixed(2) + ", "
                            + result.uvPosition.y.toFixed(2) + ")";
                    //view.cCam.position.x=result.uvPosition.x
                    distance.text = result.distance.toFixed(2);
                    scenePosition.text = "("
                            + result.scenePosition.x.toFixed(2) + ", "
                            + result.scenePosition.y.toFixed(2) + ", "
                            + result.scenePosition.z.toFixed(2) + ")";
                    localPosition.text = "("
                            + result.position.x.toFixed(2) + ", "
                            + result.position.y.toFixed(2) + ", "
                            + result.position.z.toFixed(2) + ")";
                    worldNormal.text = "("
                            + result.sceneNormal.x.toFixed(2) + ", "
                            + result.sceneNormal.y.toFixed(2) + ", "
                            + result.sceneNormal.z.toFixed(2) + ")";
                    localNormal.text = "("
                            + result.normal.x.toFixed(2) + ", "
                            + result.normal.y.toFixed(2) + ", "
                            + result.normal.z.toFixed(2) + ")";
                } else {
                    pickName.text = "None";
                    uvPosition.text = "";
                    distance.text = "";
                    scenePosition.text = "";
                    localPosition.text = "";
                    worldNormal.text = "";
                    localNormal.text = "";
                }
            }
        }
        onDoubleClicked: {
            view.cCam.position=Qt.vector3d(0, 0, (0-zm3d.d)*2)
            view.cCam.rotation=Qt.vector3d(0, 0, 0)
        }
        onWheel: {
            let cz=view.cCam.position.z
            if (wheel.modifiers & Qt.ControlModifier) {
                if(wheel.angleDelta.y>=0){
                    cz+=40
                }else{
                    cz-=40
                }
            }else if (wheel.modifiers & Qt.ShiftModifier){

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
                    //pointerPlanet.pointerRot-=45
                }
            }
            //reSizeAppsFs.restart()
            view.cCam.position.z=cz
        }
    }
    Column{
        id: colBtns
        spacing: app.fs*0.25
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        /*Comps.ButtonIcon{
            id: botSearchCoords
            text: cfg.showFullWindow?"\uf066":"\uf065"
            width: app.fs
            height: width
            //anchors.centerIn: parent
            //anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                cfg.showFullWindow=!cfg.showFullWindow
            }
        }*/
        Comps.ButtonIcon{
            text: "\uf030"
            width: app.fs
            height: width
            onClicked: {
                if(zoolMap3D.view.camera===zoolMap3D.cameraGiro){
                    zoolMap3D.view.camera=zoolMap3D.camera
                    zoolMap3D.view.cCam=zoolMap3D.camera
                }else if(zoolMap3D.view.camera===zoolMap3D.camera){
                    zoolMap3D.view.camera=zoolMap3D.cameraLeft
                    zoolMap3D.view.cCam=zoolMap3D.cameraLeft
                }else{
                    zoolMap3D.view.camera=zoolMap3D.cameraGiro
                    zoolMap3D.view.cCam=zoolMap3D.cameraGiro
                }
            }
        }
        Comps.ButtonIcon{
            text: "\uf185"
            width: app.fs
            height: width
            //anchors.centerIn: parent
            //anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                cfg.soloLuzDelSol=!cfg.soloLuzDelSol
            }
            Rectangle{
                width: parent.width*0.9
                height: width
                radius: width*0.5
                color: 'transparent'
                border.color: 'red'
                border.width: 4
                anchors.centerIn: parent
                visible: !cfg.soloLuzDelSol
                Rectangle{
                    width: parent.width
                    height: parent.border.width
                    color: parent.border.color
                    rotation: -45
                    anchors.centerIn: parent
                }
            }

        }
        Comps.ButtonIcon{
            text: "A"
            width: app.fs
            height: width
            onClicked: {
                cfg.showAsps=!cfg.showAsps
            }
            Rectangle{
                width: parent.width*0.9
                height: width
                radius: width*0.5
                color: 'transparent'
                border.color: 'red'
                border.width: 4
                anchors.centerIn: parent
                visible: cfg.showAsps
                Rectangle{
                    width: parent.width
                    height: parent.border.width
                    color: parent.border.color
                    rotation: -45
                    anchors.centerIn: parent
                }
            }
        }
        Comps.ButtonIcon{
            text: "\uf0d8"
            width: app.fs
            height: width
            onClicked: {
                if(zm3d.cbi<zm.aBodies.length){
                    zm3d.cbi++
                }else{
                    zm3d.cbi=0
                }
            }
        }
        Comps.ButtonIcon{
            text: "\uf0d8"
            width: app.fs
            height: width
            rotation: 180
            onClicked: {
                if(zm3d.cbi>0){
                    zm3d.cbi--
                }else{
                    zm3d.cbi=zm.aBodies.length-1
                }
            }
        }
        Comps.ButtonIcon{
            text: "Asc"
            fontSize: app.fs*0.5
            width: app.fs
            height: width
            onClicked: {
                toHouse(1)
            }
        }
        Comps.ButtonIcon{
            text: "Fc"
            fontSize: app.fs*0.5
            width: app.fs
            height: width
            onClicked: {
                toHouse(4)
            }
        }
        Comps.ButtonIcon{
            text: "Desc"
            fontSize: app.fs*0.4
            width: app.fs
            height: width
            onClicked: {
                toHouse(7)
            }
        }
        Comps.ButtonIcon{
            text: "Mc"
            fontSize: app.fs*0.5
            width: app.fs
            height: width
            onClicked: {
                toHouse(10)
            }
        }
        Comps.ButtonIcon{
            text: "\uf013"
            fontSize: app.fs*0.5
            width: app.fs
            height: width
            onClicked: {
                let c='import QtQuick 2.0\n'
                c+='import ZoolMap3D.Config 1.0\n'
                c+='Config{}\n'
                let obj=Qt.createQmlObject(c, r, 'config3d-code')
            }
        }
        Comps.ButtonIcon{
            text: "X"
            fontSize: app.fs*0.5
            width: app.fs
            height: width
            onClicked: {
                app.show3D=false
            }
        }
    }
    ZoolMenuCtxView3D{id: menuView3D}
    Component.onCompleted: {
        app.zoolMap3D=r
        let j=zm.currentJson
        zoolMap3D.zm3d.loadData(j)
        setMapData()

        //createAspect(0, 90, "green");

        if(false){
            log.parent=r
            log.anchors.bottomMargin=app.fs*3
            log.lv('LogView en 3D')
        }
    }
    function rotCam(stepSize, dir){
        if(dir==='l'){
            if(view.camera===cameraGiro){
                let cr=ncg.gdec
                cr-=stepSize
                ncg.gdec=cr
                sen.rot=cr
            }else{
                if(view.cCam.position.x<2000){
                    let cr=view.cCam.rotation.y
                    cr-=stepSize
                    view.cCam.rotation.y=cr

                    let cp=view.cCam.position.x
                    cp+=200
                    view.cCam.position.x=cp
                }
            }
        }
        if(dir==='r'){
            if(view.camera===cameraGiro){
                let cr=ncg.gdec
                cr+=stepSize
                ncg.gdec=cr
                sen.rot=cr
            }else{
                if(view.cCam.position.x>-2000){
                    let cr=view.cCam.rotation.y
                    cr+=stepSize
                    view.cCam.rotation.y=cr

                    let cp=view.cCam.position.x
                    cp-=200
                    view.cCam.position.x=cp
                }
            }
        }
        setCDS()
    }
    function setRotCamSen(deg){
        view.camera=cameraGiro
        ncg.gdec=deg
        sen.rot=deg//-1
        setCDS()
    }
    function setCDS(){
        //let gc=ncg.rotation.z-270+1
        let gc=ncg.gdec-270
        if(gc<0){
            gc=gc+360
        }
        if(gc<0){
            gc=360+gc
        }
        let gradoCamaraAPartirDeCasa1=gc
        let gcRZ=gradoCamaraAPartirDeCasa1+zm3d.currentSignRot
        if(gcRZ<0){
            gcRZ=360-gcRZ
        }
        if(gcRZ>=360){
            gcRZ=360-(gcRZ-360)
        }
        if(gcRZ>360){
            gcRZ=0
        }
        gcRZ=parseInt(gcRZ + 1)
        sen.currentDegSen=gcRZ
    }
    function setMapData(){
        let p=zfdm.getJsonAbs().params
        let s=''
        s+='<b>'+p.n+'</b>'
        s+='<br><b>Fecha: </b>'+p.d+'/'+p.m+'/'+p.a+' '+p.h+':'+p.min+'hs <b>GMT: </b>'+p.gmt
        s+='<br><b>Lugar: </b>'+p.c
        s+='<br><b>Ubicación: </b> <b>Lat. </b>'+parseFloat(p.lat).toFixed(2)+' <b>Lon. </b>'+parseFloat(p.lon).toFixed(2)+' <b>Alt. </b>'+p.alt
        txtMapData.text=s
    }
    function crearAspEstela(scene, modelOrigen, modelDestino, colorAsp) {
        if (!scene || !modelOrigen || !modelDestino) {
            console.error("crearCuboVolador: faltan parámetros");
            return;
        }

        var component = Qt.createComponent("AspEstela.qml");

        if (component.status !== Component.Ready) {
            console.error("Error cargando CuboVolador.qml:", component.errorString());
            return;
        }

        // === CÁLCULO DE POSICIÓN ABSOLUTA EN LA ESCENA ===
        // Esto funciona aunque las esferas estén dentro de otros Model{} o Node{}
        var posOrigen  = scene.mapPositionFromNode(modelOrigen,  Qt.vector3d(0, 0, 0));
        var posDestino = scene.mapPositionFromNode(modelDestino, Qt.vector3d(0, 0, 0));

        // Creamos el cubo como hijo del nodo raíz de la escena
        var cubo = component.createObject(scene, {
                                              startPos:   posOrigen,
                                              endPos:     posDestino,
                                              // Puedes sobreescribir valores si quieres:
                                              // durationMs: 2500,
                                              cubeColor:  colorAsp
                                          });

        if (cubo) {
            //console.log("Cubo volador creado → desde", posOrigen, "hasta", posDestino);
        }
    }
    function toHouse(h){
        zoolMap3D.zm3d.cbi=0-h
        zoolMap3D.setRotCamSen(-90-zoolMap3D.zm3d.currentSignRot-1+parseInt(zm.currentJson.ph['h'+h].gdec))
    }
}


