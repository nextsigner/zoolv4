import QtQuick 2.0

Rectangle {
    id: r
    border.width: 0
    border.color: 'gray'
    height: width
    antialiasing: true
    property bool isExt: false
    property int yIndex: -1
    property int indexPlanet: -1
    property string folderImg: '../../../modules/ZoolMap/imgs/imgs_v1'
    property bool selected: false
    MouseArea{
        anchors.fill: parent
        onClicked: {
            if(!r.selected){
                r.selected=true
                zm.objAspsCircle.showOneBodieAsp(r.indexPlanet, false)
            }else{
                r.selected=false
                zm.objAspsCircle.showOneBodieAsp(-1, false)
            }

        }
    }
    Image {
        id: img
        source: r.folderImg+"/"+app.planetasRes[r.indexPlanet]+".svg"
        width: parent.width*0.8
        height: width
        anchors.centerIn: parent
        antialiasing: true
    }
    Rectangle{
        width: parent.width
        height: parent.height
        color: 'transparent'
        border.width: 2
        border.color: 'red'
        anchors.centerIn: parent
        visible: r.selected
    }
    //Component.onCompleted: log.lv('r.indexPlanet: '+r.indexPlanet)
}
