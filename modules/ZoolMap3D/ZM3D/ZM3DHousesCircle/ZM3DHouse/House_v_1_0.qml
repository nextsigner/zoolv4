import QtQuick 2.14
import QtQuick3D 1.14

Model {
    id: r
    source: "#Sphere"
    pickable: true
    property bool isPicked: false
    property real rot: 0
    property int ih: 12
    property real anchoProfundoLineaHouse: zoolMap3D.zm3d.anchoProfundoBandaSign
    property var aColors: ['red', 'green']
    property bool selected: ih===zoolMap3D.zm3d.chi || ih===zoolMap3D.zm3d.chi+1
    scale.x: 1.0
    scale.y: 1.0
    scale.z: 1.0
    rotation.z:r.rot
    materials: DefaultMaterial {
        diffuseColor: "yellow"
    }

//    Timer{
//        running: true
//        repeat: true
//        interval: 1000
//        onTriggered: r.selected=!r.selected
//    }

    Model {
        id: eje
        source: "#Cube"
        pickable: true
        property bool isPicked: false

        scale.x: 0.18
        scale.y: 11.0
        scale.z: r.anchoProfundoLineaHouse
        position.x: -580
        rotation.z: 90
        materials: DefaultMaterial {
            diffuseColor: r.selected?aColors[0]:aColors[1]
            opacity: r.selected?1.0:0.65
            //specularAmount: 0.4
            //specularRoughness: 0.4
            //roughnessMap: Texture { source: "maps/roughness.jpg" }
        }
    }
    Node{
        //position: num.position
        position.x: eje.position.x*2-16
        rotation.x:0
        rotation.y:0
        rotation.z:360-r.rotation.z-hc.rotation.z //Rotación para la imagen del número
        Model {
            id: num2
            source: "#Cylinder"
            scale: Qt.vector3d(1.0, r.anchoProfundoLineaHouse, 1.0)
            rotation.x:90
            rotation.y:90
            rotation.z:90
            materials: DefaultMaterial {
                diffuseColor: r.selected?aColors[0]:aColors[1]
                specularAmount: 100
                specularRoughness: 100
                roughnessMap: Texture {
                    source: "imgs/h_"+r.ih+".png"
                    scaleU: 1.8
                    scaleV: 1.8
                    positionU: 0.1
                    positionV: -0.9
                    //rotationUV: 10


                }
            }
        }
        Model {
            source: "#Cube"
            scale: Qt.vector3d(0.2, 0.2, 2.0)
            rotation: num2.rotation
            visible: false
            materials: DefaultMaterial {
                diffuseColor: "yellow"
                specularAmount: 0
                specularRoughness: 00
            }
        }
    }
    //    SequentialAnimation on rotation {
    //        running: !cubeModel.isPicked
    //        loops: Animation.Infinite
    //        PropertyAnimation {
    //            duration: 2500
    //            from: Qt.vector3d(0, 0, 0)
    //            to: Qt.vector3d(360, 360, 360)
    //        }
    //    }
}
