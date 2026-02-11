import QtQuick 2.14
import QtQuick.Controls 2.12
import QtQuick.Window 2.14
import QtQuick3D 1.14

import Cartel 1.0
import Sen 1.0
import Luces 1.0
import ZM3D 1.0

Item {
    id: r
    width: Screen.width
    height: Screen.height
    visible: app.show3D
    property color c: 'white'
    property alias zm3d: zm3d
    property alias view: view0

    Row {
        anchors.left: parent.left
        anchors.leftMargin: 8
        spacing: 10
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
    Row{
        anchors.right: parent.right
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
                    source: "ZM3D/ZM3DSignCircle/ZM3DSignArc/imgs/"+sen.ciSignSen+".png"
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
        id: view0
        anchors.fill: parent

        // IMPORTANTE: En 5.14, esto suele ser obligatorio
        // para que el View3D sepa qué renderizar.
        importScene: rootNode

        // ASIGNACIÓN DE CÁMARA: Sin esto, la pantalla suele quedarse negra.
        //camera: camera0
        camera: cameraGiro

        environment: SceneEnvironment {
            clearColor: "black"
            backgroundMode: SceneEnvironment.Color
            //antialiasingMode: SceneEnvironment.SSAA
            //antialiasingQuality: SceneEnvironment.High
        }

        Node {
            id: rootNode
            Luces{}
            ZM3D{id: zm3d}

            PerspectiveCamera {
                id: camera0
                z: -6000
            }
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

            // Esfera Roja
            Model {
                id: sphere
                position: Qt.vector3d(-150, 0, 0)
                source: "#Sphere"
                materials: [
                    DefaultMaterial {
                        diffuseColor: "red"
                    }
                ]
            }

            // Cubo Azul
            Model {
                id: cube
                position: Qt.vector3d(150, 0, 0)
                source: "#Cube"
                // Si eulerRotation falla, usa 'rotation' con Quaternion
                // o déjalo sin rotar para probar.
                materials: [
                    DefaultMaterial {
                        diffuseColor: "blue"
                    }
                ]
            }
        }
        Sen{id: sen}
    }
    Component.onCompleted: zoolMap3D=r
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
}
