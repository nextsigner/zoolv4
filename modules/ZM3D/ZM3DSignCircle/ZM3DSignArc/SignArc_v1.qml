import QtQuick 2.14
import QtQuick3D 1.14


Model {
    id: r
    source: "#Cylinder"
    scale: Qt.vector3d(1.0, 1.0, 1.0)
    position: Qt.vector3d(0, 0, 0)
    rotation: Qt.vector3d(90, 0, 0)
    property int ci: 0
    property color c: parent.colors[ci]
    Node{
        id: ns
    }
    //    SequentialAnimation on rotation {
    //        //enabled: false
    //        loops: Animation.Infinite
    //        running: false
    //        PropertyAnimation {
    //            duration: 5000
    //            to: Qt.vector3d(360, 0, 0)
    //            from: Qt.vector3d(0, 0, 0)
    //        }
    //    }
    Component{
        id: compDeg
        Model {
            id: xModel
            source: "#Sphere"
            scale: Qt.vector3d(1.0, 1.0, 1.0)
            position: Qt.vector3d(0, 0, 0)
            rotation: Qt.vector3d(0, 0, 0)
            property bool selected: sen.currentDegSen-1===grado
            property int deg: -1
            property int grado: -1
            Model {
                id: m1
                source: "#Cube"
                scale: Qt.vector3d(r.parent.wAlt, r.parent.wProf, r.parent.wAnc)
                position: Qt.vector3d(0-r.parent.radio, 0, 0)
                rotation: Qt.vector3d(0, 90, 0)
                materials: DefaultMaterial {
                    id: matGrado
                    diffuseColor: r.c
                    specularAmount: 0.0
                    opacity: 1.0
                    SequentialAnimation on diffuseColor{
                        running: xModel.selected
                        loops: Animation.Infinite
                        PropertyAnimation{
                            duration: 200
                            from: 'white'
                            to: 'red'
                        }
                        PropertyAnimation{
                            duration: 200
                            from: 'red'
                            to: 'yellow'
                        }
                        PropertyAnimation{
                            duration: 200
                            from: 'yellow'
                            to: 'white'
                        }
                    }
                    SequentialAnimation on diffuseColor{
                        running: !xModel.selected
                        PropertyAnimation{
                            duration: 500
                            from: matGrado.diffuseColor
                            to: r.c
                        }
                    }
                }
                pickable: true
                property bool isPicked: false                
                SequentialAnimation on scale {
                    running: xModel.selected
                    //loops: Animation.Infinite
                    PropertyAnimation {
                        duration: 500
                        from: Qt.vector3d(r.parent.wAlt, r.parent.wProf, r.parent.wAnc)
                        to: Qt.vector3d(r.parent.wAlt, r.parent.wProf+1, r.parent.wAnc)
                    }
                }
                SequentialAnimation on scale {
                    running: !xModel.selected
                    //loops: Animation.Infinite
                    PropertyAnimation {
                        duration: 500
                        from: Qt.vector3d(r.parent.wAlt, r.parent.wProf+1, r.parent.wAnc)
                        to: Qt.vector3d(r.parent.wAlt, r.parent.wProf, r.parent.wAnc)
                    }
                }
            }

        }
    }
    Model {
        id: xModelIcon
        source: "#Sphere"
        scale: Qt.vector3d(1.0, 1.0, 1.0)
        position: Qt.vector3d(0, 0, 0)
        //rotation: Qt.vector3d(0, 0, 0)
        rotation: Qt.vector3d(0, (r.ci*30)+15, 0)
        property int deg: -1
        Model {
            id: m2
            source: "#Cylinder"
            scale: Qt.vector3d(0.8, r.parent.wProf+0.1, 0.8)
            position: Qt.vector3d(0-r.parent.radio, 0, 0)
            rotation: Qt.vector3d(0, (sc.rotation.z-r.ci*30)-90, 0)
            materials: DefaultMaterial {
                diffuseColor: 'red'//r.selected?aColors[0]:aColors[1]
                specularAmount: 100
                specularRoughness: 100
                roughnessMap: Texture {
                    source: "imgs/"+r.ci+".png"
                    //source: "/home/ns/nsp/zool-release/resources/imgs/signos/1.svg"
                    scaleU: 2.3
                    scaleV: 2.3
                    positionU: -0.05
                    positionV: -1.2
                    //rotationUV: 10


                }
            }
            pickable: true
            property bool isPicked: false
        }

    }
    Component.onCompleted: {
        let r1=r.ci*30
        console.log(''+r.ci+' grado: '+r1)
        //for(let i=r.ci*30;i<(r.ci*30)+30;i++){
        for(let i=0;i<30;i++){
            let grado=r1+i
            console.log('grado: '+grado)
            let obj=compDeg.createObject(ns, {grado: grado})
            //obj.rotation=Qt.vector3d(0, parseFloat(i), 0)
            obj.rotation=Qt.vector3d(0, parseFloat(grado), 0)
        }
    }
}
