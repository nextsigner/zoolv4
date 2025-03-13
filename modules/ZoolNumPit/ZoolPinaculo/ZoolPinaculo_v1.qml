import QtQuick 2.0

Item{
    id: r
    width: w//rowCentral.width
    height: col.height

    property var modNumPit

    property int w: app.fs*8
    property int spacing: app.fs*0.5



    property var aKAVPM: []
    property var aKAVPMLetras: ['A', 'B', 'C', 'D']

    property int vE: -1
    property int vF: -1
    property int vG: -1

    Column{
        id: col
        spacing: app.fs*0.5
        Rectangle{
            id:xG
            width: (r.width-r.spacing*3)/4
            height: width
            radius: width*0.5
            color: apps.backgroundColor
            border.width: 1
            border.color: apps.fontColor
            anchors.horizontalCenter: parent.horizontalCenter
            //anchors.horizontalCenterOffset: 0-rowCentral.spacing-width*0.5
            anchors.horizontalCenterOffset: 0-width*0.5-rowCentral.spacing*0.5
            Rectangle{
                width: parent.width*0.75
                height: width
                radius: width*0.5
                color: apps.backgroundColor
                border.width: 1
                border.color: apps.fontColor
                anchors.centerIn: parent

                Text{
                    text: 'G'
                    font.pixelSize: parent.width*0.25
                    color: apps.fontColor
                    anchors.top:  parent.top
                    anchors.topMargin: 0-parent.width*0.075
                    anchors.left: parent.left
                    anchors.leftMargin: 0-parent.width*0.075
                }
                Item{
                    width: 1
                    height: 1
                    rotation: 45
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: parent.width*0.25
                    anchors.horizontalCenterOffset: 0-parent.width*0.25
                    z: parent.z-1
                    Rectangle{
                        width: 1
                        height: parent.parent.height
                    }
                }
                Item{
                    width: 1
                    height: 1
                    rotation: -45
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: parent.width*0.25
                    anchors.horizontalCenterOffset: parent.width*0.25
                    z: parent.z-2
                    Rectangle{
                        width: 1
                        height: parent.parent.height
                    }
                }
                Text{
                    text: r.vG
                    font.pixelSize: parent.width*0.5
                    color: apps.fontColor
                    anchors.centerIn: parent
                }
            }
        }
        Row{
            id: rowEF
            spacing: r.spacing
            //z:rowCentral.z+1
            Repeater{
                id: repEF
                model: 4
                Rectangle{
                    width: (r.width-r.spacing*3)/4
                    height: width
                    radius: width*0.5
                    color: apps.backgroundColor
                    border.width: 0
                    border.color: apps.fontColor
                    Rectangle{
                        width: parent.width*0.75
                        height: width
                        radius: width*0.5
                        color: apps.backgroundColor
                        border.width: 1
                        border.color: apps.fontColor
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 0-(width*0.5)-(parent.parent.spacing*0.5)
                        visible: index===1 || index===2
                        Text{
                            text: index===1?'E':'F'
                            font.pixelSize: parent.width*0.25
                            color: apps.fontColor
                            anchors.top:  parent.top
                            anchors.topMargin: 0-parent.width*0.075
                            anchors.left: parent.left
                            anchors.leftMargin: 0-parent.width*0.075
                        }
                        Item{
                            width: 1
                            height: 1
                            rotation: 45
                            anchors.centerIn: parent
                            anchors.verticalCenterOffset: parent.width*0.25
                            anchors.horizontalCenterOffset: 0-parent.width*0.25
                            z: parent.z-1
                            Rectangle{
                                width: 1
                                height: parent.parent.height
                            }
                        }
                        Item{
                            width: 1
                            height: 1
                            rotation: -45
                            anchors.centerIn: parent
                            anchors.verticalCenterOffset: parent.width*0.25
                            anchors.horizontalCenterOffset: parent.width*0.25
                            z: parent.z-2
                            Rectangle{
                                width: 1
                                height: parent.parent.height
                            }
                        }
                        Text{
                            text: index===1?r.vE:r.vF
                            font.pixelSize: parent.width*0.5
                            color: apps.fontColor
                            anchors.centerIn: parent
                        }
                    }
                }
            }
        }
        Row{
            id: rowCentral
            spacing: r.spacing
            Repeater{
                id: repKAVPM
                //model: ['KARMA', 'ALMA', 'VIDA PASADA', 'MISIÓN']
                Rectangle{
                    width: (r.width-r.spacing*3)/4
                    height: width
                    radius: width*0.2
                    color: apps.backgroundColor
                    border.width: 1
                    border.color: apps.fontColor
                    clip: true
                    Text{
                        text: r.aKAVPMLetras[index]
                        font.pixelSize: parent.width*0.25
                        color: apps.fontColor
                        anchors.top:  parent.top
                        anchors.topMargin: parent.width*0.075
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width*0.075
                    }
                    Text{
                        text: modelData
                        font.pixelSize: parent.width*0.5
                        color: apps.fontColor
                        anchors.centerIn: parent
                    }
                }
            }
        }


    }
    function load(m, d, a, mision){
        let aKAVPM = []
        aKAVPM.push(m)
        aKAVPM.push(d)
        aKAVPM.push(a)
        aKAVPM.push(mision)
        repKAVPM.model=aKAVPM

        r.vE=modNumPit.bigNumToPitNum(m+d)
        r.vF=modNumPit.bigNumToPitNum(d+a)
        r.vG=modNumPit.bigNumToPitNum(r.vE+r.vF)

    }
}
