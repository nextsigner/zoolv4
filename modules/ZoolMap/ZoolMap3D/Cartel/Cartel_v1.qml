import QtQuick 2.14
import QtQuick3D 1.14
import QtQuick3D.Materials 1.14

Model{
    rotation.y:45.0
    source: '#Sphere'
    scale: Qt.vector3d(0.1, 0.1, 0.1)
    property alias itemTexture: texture.sourceItem
    materials: [
        DefaultMaterial{
            diffuseColor: 'red'
        }
    ]
    Node{
        scale: Qt.vector3d(2.0, 50.0, 12.0)
        Model {
            source: "#Cube"
            //scale: Qt.vector3d(0.2, 1.0, 1.0)
            //position.x:-200
            materials: [
                DefaultMaterial {
                    diffuseColor: 'blue'
                }
            ]
        }
        Model {
            source: "#Cube"
            //scale: Qt.vector3d(1.0, 1.0, 1.0)
            position.x:50
            materials: [
                DefaultMaterial {
                    id: mat
                    diffuseMap: Texture {
                        id: texture
                        sourceItem: itemSen1
                    }
                }
            ]
        }
    }
}
