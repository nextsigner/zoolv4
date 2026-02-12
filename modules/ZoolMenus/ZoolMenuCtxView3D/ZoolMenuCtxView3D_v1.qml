import QtQuick 2.12
import QtQuick.Controls 2.12
import ZoolMenus 1.0
ZoolMenus {
    id: r
    property int currentIndexPlanet: -1
    property int currentIndexSign: -1
    property int currentIndexHouse: -1
    property var aMI: []
    property bool isBack: false
    title: 'Menu '+zm.aBodies[r.currentIndexPlanet]
    Action {
        text: qsTr("Ver como 2D")
        onTriggered: {
            zoolMap3D.view.camera=zoolMap3D.camera
        }
    }
    Action {
        text: qsTr("Salir de 3D")
        onTriggered: {
            app.show3D=false
        }
    }
    Action {
        text: qsTr("Salir")
        onTriggered: {
            Qt.quit()
        }
    }
}
