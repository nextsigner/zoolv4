import QtQuick 2.14
import QtQuick3D 1.14


Model {
    id: r
    source: "#Cylinder"
    scale: Qt.vector3d(1.0, 1.0, 1.0)
    position: Qt.vector3d(0, 0, 0)
    rotation: Qt.vector3d(90, 0, 0)
    materials: [ PrincipledMaterial {
            metalness: materialCtrl.metalness
            roughness: materialCtrl.roughness
            specularAmount: materialCtrl.specular
            indexOfRefraction: materialCtrl.ior
            opacity: materialCtrl.opacityValue
            baseColorMap: Texture { source: "maps/metallic/basecolor.jpg" }
            metalnessMap: Texture { source: "maps/metallic/metallic.jpg" }
            //roughnessMap: Texture { source: "maps/metallic/roughness.jpg" }
            normalMap: Texture { source: "maps/metallic/normal.jpg" }
        }
    ]
    property var colors: ['red', '#FBE103', '#09F4E2', '#0D9FD6', 'red', '#FBE103', '#09F4E2', '#0D9FD6', 'red', '#FBE103', '#09F4E2', '#0D9FD6', 'red', '#FBE103', '#09F4E2', '#0D9FD6']
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
            property int deg: -1
            materials: [ PrincipledMaterial {
                    metalness: materialCtrl.metalness
                    roughness: materialCtrl.roughness
                    specularAmount: materialCtrl.specular
                    indexOfRefraction: materialCtrl.ior
                    opacity: materialCtrl.opacityValue
                    baseColorMap: Texture { source: "maps/metallic/basecolor.jpg" }
                    metalnessMap: Texture { source: "maps/metallic/metallic.jpg" }
                    //roughnessMap: Texture { source: "maps/metallic/roughness.jpg" }
                    normalMap: Texture { source: "maps/metallic/normal.jpg" }
                }
            ]
            //            SequentialAnimation on rotation {
            //                //enabled: false
            //                loops: Animation.Infinite
            //                //running: false
            //                PropertyAnimation {
            //                    duration: 5000
            //                    to: Qt.vector3d(0, 360, 0)
            //                    from: Qt.vector3d(0, 0, 0)
            //                }
            //            }
            Model {
                id: m1
                source: "#Cube" // Identificador para la primitiva de cilindro
                scale: Qt.vector3d(0.1, 0.1, 0.1) // Escalar según sea necesario
                position: Qt.vector3d(-600, 0, 0)
                rotation: Qt.vector3d(0, 90, 0)
//                materials: [ PrincipledMaterial {
//                        metalness: materialCtrl.metalness
//                        roughness: materialCtrl.roughness
//                        specularAmount: materialCtrl.specular
//                        indexOfRefraction: materialCtrl.ior
//                        opacity: materialCtrl.opacityValue
//                        baseColorMap: Texture { source: "maps/metallic/basecolor.jpg" }
//                        metalnessMap: Texture { source: "maps/metallic/metallic.jpg" }
//                        //roughnessMap: Texture { source: "maps/metallic/roughness.jpg" }
//                        normalMap: Texture { source: "maps/metallic/normal.jpg" }
//                    }

//                ]
                materials: DefaultMaterial {
                    diffuseColor: m1.isPicked ? "red" : "yellow"
                    specularAmount: 0.4
                    specularRoughness: 0.4
                    //roughnessMap: Texture { source: "maps/roughness.jpg" }
                    Component.onCompleted: {
                        if(deg>=0 && deg<=29){
                            diffuseColor=r.colors[0]
                        }else if(deg>=30 && deg<=59){
                            diffuseColor=r.colors[1]
                        }else if(deg>=60 && deg<=89){
                            diffuseColor=r.colors[2]
                        }else if(deg>=90 && deg<=119){
                            diffuseColor=r.colors[3]
                        }else if(deg>=120 && deg<=149){
                            diffuseColor=r.colors[4]
                        }else if(deg>=150 && deg<=179){
                            diffuseColor=r.colors[5]
                        }else if(deg>=180 && deg<=209){
                            diffuseColor=r.colors[6]
                        }else if(deg>=210 && deg<=239){
                            diffuseColor=r.colors[7]
                        }else if(deg>=240 && deg<=269){
                            diffuseColor=r.colors[8]
                        }else if(deg>=270 && deg<=299){
                            diffuseColor=r.colors[9]
                        }else if(deg>=300 && deg<=329){
                            diffuseColor=r.colors[10]
                        }else if(deg>=330 && deg<=359){
                            diffuseColor=r.colors[11]
                        }else{
                            diffuseColor='blue'
                        }
                    }
                }
                pickable: true
                property bool isPicked: false
                SequentialAnimation on scale {
                    running: m1.isPicked
                    //loops: Animation.Infinite
                    PropertyAnimation {
                        duration: 2500
                        from: Qt.vector3d(0.1, 0.1, 0.1)
                        to: Qt.vector3d(0.1, 2.5, 0.1)
                    }
                }
                SequentialAnimation on rotation {
                    running: m1.isPicked
                    //loops: Animation.Infinite
                    PropertyAnimation {
                        duration: 2500
                        from: Qt.vector3d(0, 0, 0)
                        to: Qt.vector3d(0, 180, 0)
                    }
                }
            }

        }
    }
    Component.onCompleted: {
        for(var i=0;i<360;i++){
            let obj=compDeg.createObject(r, {deg: i+1})
            obj.rotation=Qt.vector3d(0, parseFloat(i*1), 0)
        }
    }
}

