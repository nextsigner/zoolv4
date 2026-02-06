import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
ApplicationWindow{
    id: app
    visible: true
    width: 800
    height: width
    color: 'black'
    Item{
        id: xApp
        anchors.fill: parent
        Rectangle{
            anchors.fill: parent
            border.width: 50
            border.color: 'white'
            color: 'black'
        }
        Image{
            id: img
            width: 600
            height: width
            anchors.centerIn: parent
            visible: false
        }
        ColorOverlay{
            anchors.fill: img
            source: img
            color: 'white'
        }
        Shortcut{
            sequence: 'Esc'
            onActivated: Qt.quit()
        }
    }
    Timer{
        id: t1
        running: false
        repeat: false
        interval: 3000
        property string fu: ''
        onTriggered: {
            savePng(fu, xApp)
        }
    }
    Component.onCompleted: {
        let b='ns'
        let s1='/home/ns/nsp/zool3d/modules/ZM3D/ZM3DBodiesCircle/imgs_v1/'+b+'.svg'
        img.source=s1
        let d1='/home/ns/nsp/zool3d/modules/ZM3D/ZM3DBodiesCircle/imgs_white_trans/'+b+'.png'
        t1.fu=d1
        t1.start()

    }
    function savePng(fileUrl, itemCap){
        itemCap.grabToImage(function(result) {
            let fn=fileUrl
            fn=fn.replace('file://', '')
            result.saveToFile(fn);
            Qt.quit()
        });
    }
}

