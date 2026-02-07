import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick3D 1.14
import ZoolLogView 1.0
import ZM3D 1.0
import Luces 1.0
import Sen 1.0


ApplicationWindow {
    id: app
    visible: true
    width: 800
    height: 500
    title: 'Zool 3D'
    color: "#848895"
    visibility: 'Maximized'
    property int fs: 50
    property color c: 'white'





    Row {
        anchors.left: parent.left
        anchors.leftMargin: 8
        spacing: 10
        Column {
            Label {
                color: app.c
                font.pointSize: 14
                text: "Last Pick:"
            }
            Label {
                color: app.c
                font.pointSize: 14
                text: "Screen Position:"
            }
            Label {
                color: app.c
                font.pointSize: 14
                text: "UV Position:"
            }
            Label {
                color: app.c
                font.pointSize: 14
                text: "Distance:"
            }
            Label {
                color: app.c
                font.pointSize: 14
                text: "World Position:"
            }
            Label {
                color: app.c
                font.pointSize: 14
                text: "Local Position:"
            }

            Label {
                color: app.c
                font.pointSize: 14
                text: "World Normal:"
            }
            Label {
                color: app.c
                font.pointSize: 14
                text: "Local Normal:"
            }
        }
        Column {
            Label {
                id: pickName
                color: app.c
                font.pointSize: 14
            }
            Label {
                id: pickPosition
                color: app.c
                font.pointSize: 14
            }
            Label {
                id: uvPosition
                color: app.c
                font.pointSize: 14
            }
            Label {
                id: distance
                color: app.c
                font.pointSize: 14
            }
            Label {
                id: scenePosition
                color: app.c
                font.pointSize: 14
            }
            Label {
                id: localPosition
                color: app.c
                font.pointSize: 14
            }
            Label {
                id: worldNormal
                color: app.c
                font.pointSize: 14
            }
            Label {
                id: localNormal
                color: app.c
                font.pointSize: 14
            }

        }
    }

    Row{
        anchors.right: parent.right
        Column{
            Label {
                text: "rot:"+parseFloat(zm.currentSignRot).toFixed(2)
                font.pointSize: 14
                color: app.c
            }
            Label {
                text: "cbi:"+zm.cbi
                font.pointSize: 14
                color: app.c
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
                text:'<b>'+zm.aBodies[zm.cbi]+' en '+zm.aSigns[zm.cbis]+' en casa '+zm.cbih+'</b><br><b>en el grado °'+zm.cbRsgdeg+' \''+zm.cbmdeg+' \'\''+zm.cbsdeg+'</b>'
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
                text:'<b>Ascendente °'+zm.cAscRsDeg+' de '+zm.aSigns[zm.cAscIs]+'</b>'
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
                    text:'<b>°'+sen.ciDegSen+' '+zm.aSigns[sen.ciSignSen]+'</b>'
                    font.pixelSize: parent.parent.width*0.2
                    anchors.verticalCenter: parent.verticalCenter
                }
                Image{
                    width: itemSen1.height*0.1
                    height: width
                    //rotation: 90
                    //source: "imgs/"+sen.ciSignSen+".png"
                    source: "modules/ZM3D/ZM3DSignCircle/ZM3DSignArc/imgs/"+sen.ciSignSen+".png"
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
        renderMode: View3D.Underlay
        property var cCam: camera//Giro
        camera: cCam
        environment: SceneEnvironment {
            probeBrightness: 0//250
            //clearColor: "#848895"
            clearColor: "#000"

            backgroundMode: SceneEnvironment.Color
            lightProbe: Texture {
                source: "maps-/OpenfootageNET_garage-1024.hdr"
            }
        }


        //        DirectionalLight {
        //            rotation: Qt.vector3d(0, 100, 0)
        //            brightness: 100
        //            SequentialAnimation on rotation {
        //                loops: Animation.Infinite
        //                PropertyAnimation {
        //                    duration: 5000
        //                    to: Qt.vector3d(0, 360, 0)
        //                    from: Qt.vector3d(0, 0, 0)
        //                }
        //            }
        //        }

        Luces{id: luces}

        //        PointLight {
        //            x: 0
        //            y: 0
        //            z: 0
        //            quadraticFade: 0
        //            brightness: 10.5
        //            //visible: false
        //        }

        ZM3D{id: zm}


        Node{
            id: ncg
            rotation.z: gdec
            property real gdec: -90-zm.currentSignRot
            onGdecChanged: rotation.z=gdec
            //rotation.y:90
            Behavior on rotation.z{NumberAnimation{duration: 2000}}
            Node{
                //position: Qt.vector3d(0, 0, ((0-zm.d)*2)+2000)
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
                    duration: 12000
                    to: Qt.vector3d(0, 0, 0)
                    from: Qt.vector3d(0, 0, 360)
                }
            }
        }

        PerspectiveCamera {
            id: camera
            position: Qt.vector3d(0, 0, ((0-zm.d)*2)-400)
            //Behavior on rotation.x{NumberAnimation{duration: 2000}}
            //Behavior on rotation.y{NumberAnimation{duration: 2000}}
            //Behavior on rotation.z{NumberAnimation{duration: 2000}}
        }
        PerspectiveCamera {
            id: cameraLeft
            position: Qt.vector3d(((0-zm.d)*2)-400, 0, 0)
            rotation.y: 90
            //Behavior on rotation.x{NumberAnimation{duration: 2000}}
            //Behavior on rotation.y{NumberAnimation{duration: 2000}}
            //Behavior on rotation.z{NumberAnimation{duration: 2000}}
        }
        Model {
            visible: false
            id: centro
            source: "#Sphere"
            pickable: true
            property bool isPicked: false

            scale.x: 1.0
            scale.y: 1.0
            scale.z: 1.0
            materials: DefaultMaterial {
                diffuseColor: centro.isPicked ? "red" : "#00FF00"
                specularAmount: 0.4
                specularRoughness: 0.4
            }

            //            SequentialAnimation on rotation {
            //                running: !cubeModel.isPicked
            //                loops: Animation.Infinite
            //                PropertyAnimation {
            //                    duration: 2500
            //                    from: Qt.vector3d(0, 0, 0)
            //                    to: Qt.vector3d(360, 360, 360)
            //                }
            //            }

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
                    baseColorMap: Texture { source: "modules/ZM3D/ZM3DBodiesCircle/imgs/mundo.jpg" }
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
        anchors.fill: view

        //onClicked: (mouse) => {
        onClicked: {
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
        onDoubleClicked: {
            view.cCam.position=Qt.vector3d(0, 0, (0-zm.d)*2)
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
    ZoolLogView{
        id: log
        width: app.fs*20
    }
    //MaterialControl{id:materialCtrl}

    //    Rectangle{
    //        anchors.fill: parent
    //        color: 'red'
    //        Repeater{
    //            model: 12
    //            Rectangle{
    //                id: rect
    //                width: 1000
    //                height: 1000
    //                color: 'transparent'
    //                Text{
    //                    text: '<b>'+parseInt(index + 1)+'</b>'
    //                    font.pixelSize: parent.width*0.6
    //                    color: 'white'
    //                    anchors.centerIn: parent
    //                }
    //                Timer{
    //                    running: true
    //                    repeat: false
    //                    interval: 3000
    //                    onTriggered: {
    //                        rect.grabToImage(function(result) {
    //                            result.saveToFile("/home/ns/nsp/zool3d/modules/ZM3D/ZM3DHousesCircle/ZM3DHouse/imgs/h_"+parseInt(index + 1)+".png")
    //                        });
    //                    }
    //                }
    //            }
    //        }
    //    }
    Timer{
        id: tAutomatic
        running: false
        repeat: true
        interval: 5000
        property int ci: -2
        onTriggered: {
            if(ci<19){
                ci++
            }else{
                ci=-1
            }
            zm.cbi=ci
        }
    }
    Shortcut{
        sequence: 'Esc'
        onActivated: {
            if(log.visible){
                log.visible=false
                return
            }
            Qt.quit()
        }
    }
    Shortcut{
        sequence: 'Ctrl+Esc'
        onActivated: {
            view.cCam.position=Qt.vector3d(0, 0, (0-zm.d)*2)
            view.cCam.rotation=Qt.vector3d(0, 0, 0)
        }
    }
    Shortcut{
        sequence: 'Left'
        onActivated: {
            zm.cbi=-4
            rotCam(5, 'l')
        }
    }
    Shortcut{
        sequence: 'Right'
        onActivated: {
            zm.cbi=-4
            rotCam(5, 'r')
        }
    }
    Shortcut{
        sequence: 'Ctrl+Left'
        onActivated: {
            zm.cbi=-4
            rotCam(1, 'l')
        }
    }
    Shortcut{
        sequence: 'Ctrl+Right'
        onActivated: {
            zm.cbi=-4
            rotCam(1, 'r')
        }
    }
    Shortcut{
        sequence: 'Up'
        onActivated: {
            if(view.camera===cameraGiro){
                if(zm.cbi<zm.aBodies.length-1){
                    zm.cbi++
                }else{
                    zm.cbi=-1
                }

            }else{
                if(view.cCam.position.y<2000){
                    let cr=view.cCam.rotation.x
                    cr+=5
                    view.cCam.rotation.x=cr

                    let cp=view.cCam.position.y
                    cp+=200
                    view.cCam.position.y=cp
                }
            }
        }
    }
    Shortcut{
        sequence: 'Down'
        onActivated: {
            if(view.camera===cameraGiro){
                if(zm.cbi>-1){
                    zm.cbi--
                }else{
                    zm.cbi=zm.aBodies.length-1
                }
            }else{
                if(view.cCam.position.y>-2000){
                    let cr=view.cCam.rotation.x
                    cr-=5
                    view.cCam.rotation.x=cr

                    let cp=view.cCam.position.y
                    cp-=200
                    view.cCam.position.y=cp
                }
            }
        }
    }
    Shortcut{
        sequence: 'Shift+Up'
        onActivated: {
            view.cCam.position.z+=50.0
        }
    }
    Shortcut{
        sequence: 'Shift+Down'
        onActivated: {
            view.cCam.position.z-=50.0
        }
    }
    Shortcut{
        sequence: 'a'
        onActivated: {
            if(!tAutomatic.running){
                zm.cbi=-1
                tAutomatic.running=true
                tAutomatic.start()
            }else{
                tAutomatic.running=false
                zm.cbi=-4
            }

        }
    }

    Shortcut{
        sequence: 'c'
        onActivated: {
            if(view.camera===cameraGiro){
                view.camera=camera
                view.cCam=camera
            }else if(view.camera===camera){
                view.camera=cameraLeft
                view.cCam=cameraLeft
            }else{
                view.camera=cameraGiro
                view.cCam=cameraGiro
            }
        }
    }
    Shortcut{
        sequence: '*'
        onActivated: {
            zm.cbi=-1
            //app.setRotCamSen(-90-zm.currentSignRot-1+parseInt(zm.cAscDeg))
        }
    }
    Shortcut{
        sequence: '0'
        onActivated: {
            zm.cbi=zm.cbi===-1?0:-1
        }
    }
    Shortcut{
        sequence: '1'
        onActivated: {
            zm.cbi=zm.cbi===-1?1:-1
        }
    }
    Shortcut{
        sequence: '2'
        onActivated: {
            zm.cbi=zm.cbi===-1?2:-1
        }
    }
    Shortcut{
        sequence: '3'
        onActivated: {
            zm.cbi=zm.cbi===-1?3:-1
        }
    }
    Shortcut{
        sequence: '4'
        onActivated: {
            zm.cbi=zm.cbi===-1?4:-1
        }
    }
    Shortcut{
        sequence: '5'
        onActivated: {
            zm.cbi=zm.cbi===-1?5:-1
        }
    }
    Shortcut{
        sequence: '6'
        onActivated: {
            zm.cbi=zm.cbi===-1?6:-1
        }
    }
    Shortcut{
        sequence: '7'
        onActivated: {
            zm.cbi=zm.cbi===-1?7:-1
        }
    }
    Shortcut{
        sequence: '8'
        onActivated: {
            zm.cbi=zm.cbi===-1?8:-1
        }
    }
    Shortcut{
        sequence: '9'
        onActivated: {
            zm.cbi=zm.cbi===-1?9:-1
        }
    }
    Shortcut{
        sequence: 'Shift+1'
        onActivated: {
            zm.cbi=zm.cbi===-1?10:-1
        }
    }
    QtObject{
        id: setZoolData
        function setData(data){
            let json=JSON.parse(data)
            console.log('DATA::: '+data)
            zm.loadData(json.data)
        }
    }
    Component.onCompleted: {
        //log.lv('JSON:\n'+JSON.stringify(json, null, 2))
        let args=Qt.application.arguments
        let url=""
        for(var i=0;i<args.length;i++){
            let arg=args[i]
            let m0
            if(arg.indexOf('-urlZool=')===0){
                m0=arg.split('-urlZool=')
                url=""+m0[1]
            }
        }
        if(url===""){
            let js=unik.getFile('/home/ns/j.json')
            //console.log('JSON:\n'+js)
            js=js.replace(/\n/g, '')
            let json=JSON.parse(js)
            zm.loadData(json)
        }else{
            //Ejemplo
            //getRD("http://www.zool.ar/zool/getZoolData?n=Ricardo&d=20&m=6&a=1975&h=23&min=4&gmt=-3&lugarNacimiento=Malargue%20Mendoza&lat=-35.4752134&lon=-69.585934&alt=0&ciudad=Malargue+Mendoza&ms=0&msReq=0&adminId=formwebzoolar&onlyJson=true", setZoolData)
            getRD(url, setZoolData)
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
        sen.rot=deg
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
        let gcRZ=gradoCamaraAPartirDeCasa1+zm.currentSignRot
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

    function getRD(url, item){//Remote Data
        var request = new XMLHttpRequest()
        request.open('GET', url, true);
        request.onreadystatechange = function() {
            if (request.readyState === XMLHttpRequest.DONE) {
                if (request.status && request.status === 200) {
                    item.setData(request.responseText)
                } else {
                    item.setData("Url: "+url+" Status:"+request.status+" HTTP: "+request.statusText, false)
                }
            }
        }
        request.send()
    }
}
