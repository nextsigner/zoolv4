import QtQuick 2.0

Rectangle {
    id: r
    height: width
    color: indexAsp!==-1?arrColors[indexAsp]:(!apps.panelAspShowBg?'transparent':apps.backgroundColor)
    //color: indexAsp!==-1?arrColors[indexAsp]:(!apps.panelAspShowBg?'blue':'red')
    property var arrColors: ['red','#ff8833',  'green', '#124cb1']
    property int indexAsp: -1
    property int indexPosAsp: -1
    property int bodie: -1
    SequentialAnimation{
        running: indexPosAsp===zm.objAspsCircle.currentAspSelected&&zm.objAspsCircle.currentAspSelected!==-1
        loops: Animation.Infinite
        onRunningChanged: {
            if(!running){
                r.border.width=1
                r.border.color='gray'
            }
        }
        ParallelAnimation{
            PropertyAnimation{
                target: r
                property: "border.width"
                from: 2; to: 4
            }
            PropertyAnimation{
                target: r
                property: "border.color"
                from: "#ffffff"; to: "red"
            }
        }

        PauseAnimation {
            duration: 500
        }
        ParallelAnimation{
            PropertyAnimation{
                target: r
                property: "border.width"
                from: 4; to: 2
            }
            PropertyAnimation{
                target: r
                property: "border.color"
                from: "red"; to: "#ffffff"
            }
        }
    }
//    Rectangle {
//        anchors.fill: parent
//        border.width: 2
//        border.color: 'red'
//        color: 'transparent'
//        //visible: indexPosAsp===zm.objAspsCircle.currentAspSelected&&zm.objAspsCircle.currentAspSelected!==-1
//    }
    MouseArea{
        id: ma
        anchors.fill: parent
        property int uCurrentPlanetIndex: -1
        //enabled: false
        onClicked: {
            if(zm.objAspsCircle.currentAspSelected!==r.indexPosAsp){
                zm.objAspsCircle.currentAspSelected=r.indexPosAsp
                //swegz.zm.objAspsCircle.currentAspSelected=r.indexPosAsp
                ma.uCurrentPlanetIndex=zm.currentPlanetIndex
                zm.currentPlanetIndex=-1
                zm.currentHouseIndex=-1
                //apps.showAspCircle=true
                zm.lastAspShowed='int'
                zm.uAspShow='int_'+arrColors[indexAsp]+'_bodie_'+r.bodie+'_'+r.objectName
            }else{
                zm.objAspsCircle.currentAspSelected=-1
                //swegz.zm.objAspsCircle.currentAspSelected=-1
                zm.currentPlanetIndex=ma.uCurrentPlanetIndex
                zm.lastAspShowed='ext'
                zm.uAspShow=''
            }
            //zm.uAspShow='int_'+arrColors[indexAsp]+'_bodie_'+r.bodie+'_'+r.objectName
            //log.lv('Bodie: '+r.bodie+ ' Col: '+r.objectName)
        }
    }
    Rectangle{
        width: 1
        height: r.height
        color: apps.fontColor
    }
    Rectangle{
        width: r.width
        height: 1
        color: apps.fontColor
        anchors.bottom: parent.bottom
    }
    Text{
        text:'<b>'+r.indexPosAsp+'</b>'
        font.pixelSize: 10
        anchors.centerIn: parent
        color: 'white'
        visible: false//r.indexPosAsp!==-1
    }
}
