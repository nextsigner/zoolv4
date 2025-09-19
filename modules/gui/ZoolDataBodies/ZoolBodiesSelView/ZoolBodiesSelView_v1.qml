import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle{
    id: r
    width: app.fs*6
    height: asContainer.height+app.fs*0.2
    color: apps.backgroundColor
    border.width: 1
    border.color: apps.fontColor
    radius: app.fs*0.1
    property int xAsWidth: !zm.ev?r.width/(parseInt(zm.aBodies.length/2))-1:(r.width/(parseInt(zm.aBodies.length/2))-1)*2
    property bool isExt: false
    property string folderImg: '../../../../modules/ZoolMap/imgs/imgs_v1'
    Flow{
        id: asContainer
        spacing: 0//app.fs*0.1
        width: r.width-app.fs*0.2
        anchors.centerIn: parent
    }
    Component{
        id: compAs
        Item{
            id: xa
            width: r.xAsWidth
            height: width
            property int numAstro: -1
            property bool selected: false
            onSelectedChanged: {
                if(selected){
                    zm.objAspsCircle.showOneBodieAsp(numAstro)
                }else{
                    zm.objAspsCircle.showOneBodieAsp(-1)
                }
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    xa.selected=!xa.selected
                }
            }
            Rectangle{
                width: parent.width-app.fs*0.1
                height: width
                radius: app.fs*0.1
                color: apps.backgroundColor
                border.width: xa.selected?2:1
                border.color: apps.fontColor
                anchors.centerIn: parent
                Rectangle{
                    color: apps.fontColor
                    radius: parent.radius
                    opacity: xa.selected?0.35:0.0
                    anchors.fill: parent
                }

                Image{
                    id: img
                    width: xa.selected?parent.width*0.65:xa.width*0.4
                    height: width
                    source: r.folderImg+'/'+app.planetasRes[numAstro]+'.svg'
                    anchors.centerIn: parent
                    visible: false
                }
                ColorOverlay{
                    source: img
                    color: apps.fontColor
                    anchors.fill: img
                }
            }
        }
    }
    Component.onCompleted: {
        updateAsSelList()
    }

    function updateAsSelList(){
        for(var i=0;i<asContainer.children.length;i++){
            asContainer.children[i].destroy(0)
        }
        var aSel=zm.aBodies//[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
        for(i=0;i<aSel.length;i++){
            let obj=compAs.createObject(asContainer, {numAstro: i})
        }
    }
    function selBodie(numAstro){
        for(var i=0;i<asContainer.children.length;i++){
            asContainer.children[i].selected=false
        }
        if(numAstro>=0){
            asContainer.children[numAstro].selected=true
        }
    }
}
