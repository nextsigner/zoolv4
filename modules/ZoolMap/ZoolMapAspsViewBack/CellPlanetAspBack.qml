import QtQuick 2.0

Rectangle {
    id: r
    border.width: 0
    border.color: 'gray'
    height: width
    antialiasing: true
    property string folderImgs: '../../../imgs/'+app.folderImgsName
    property bool isExt: true
    property int yIndex: -1
    property int indexPlanet: -1
    property int bodie: -1
    property string folderImg: '../../../modules/ZoolMap/imgs/imgs_v1'
    property bool selected: false
    MouseArea{
        anchors.fill: parent
        onClicked: {
            if(!r.selected){
                r.selected=true
                zm.objAspsCircleBack.showOneBodieAsp(r.indexPlanet, true)
            }else{
                r.selected=false
                zm.objAspsCircleBack.showOneBodieAsp(-1, true)
            }

        }
    }
    Image {
        id: img
        source: folderImgs+'/glifos/'+app.planetasRes[r.indexPlanet]+'.svg'
        width: parent.width*0.8
        height: width
        anchors.centerIn: parent
        antialiasing: true
        mirror: true
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
}
