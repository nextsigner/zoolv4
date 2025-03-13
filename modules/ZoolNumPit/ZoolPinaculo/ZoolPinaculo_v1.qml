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
    property int vF: -2
    property int vG: -3
    property int vH: -4
    property int vI: -5
    property int vJ: -6
    property int vK: -7
    property int vL: -8
    property int vM: -9
    property int vN: -10
    property int vO: -11

    Column{
        id: col
        spacing: r.spacing*0.75
        Rectangle{
            id:xH
            width: (r.width-r.spacing*3)/4
            height: width
            radius: width*0.5
            color: apps.backgroundColor
            border.width: 0
            border.color: apps.fontColor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 0-width*0.5-rowCentral.spacing*0.5
            property int rot: 22
            property int hl: height*4
            Rectangle{
                width: parent.width*0.75
                height: width
                radius: width*0.5
                color: apps.backgroundColor
                border.width: 1
                border.color: apps.fontColor
                anchors.centerIn: parent

                Text{
                    text: 'H'
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
                    rotation: parent.parent.rot
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: parent.width*0.25
                    anchors.horizontalCenterOffset: 0-parent.width*0.25
                    z: parent.z-1
                    Rectangle{
                        width: 1
                        height: parent.parent.parent.hl
                    }
                }
                Item{
                    width: 1
                    height: 1
                    rotation: 0-parent.parent.rot
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: parent.width*0.25
                    anchors.horizontalCenterOffset: parent.width*0.25
                    z: parent.z-2
                    Rectangle{
                        width: 1
                        height: parent.parent.parent.hl
                    }
                }
                Text{
                    text: r.vH
                    font.pixelSize: parent.width*0.5
                    color: apps.fontColor
                    anchors.centerIn: parent
                }
            }
        }
        Rectangle{
            id:xG
            width: (r.width-r.spacing*3)/4
            height: width
            radius: width*0.5
            color: apps.backgroundColor
            border.width: 0
            border.color: apps.fontColor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 0-width*0.5-rowCentral.spacing*0.5
            property int rot: 30
            property int hl: height+app.fs*0.3
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
                    rotation: parent.parent.rot
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: parent.width*0.25
                    anchors.horizontalCenterOffset: 0-parent.width*0.25
                    z: parent.z-1
                    Rectangle{
                        width: 1
                        height: parent.parent.parent.hl
                    }
                }
                Item{
                    width: 1
                    height: 1
                    rotation: 0-parent.parent.rot
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: parent.width*0.25
                    anchors.horizontalCenterOffset: parent.width*0.25
                    z: parent.z-2
                    Rectangle{
                        width: 1
                        height: parent.parent.parent.hl
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
        Rectangle{
            id:xI
            width: (r.width-r.spacing*3)/4
            height: width*0.1
            radius: width*0.5
            color: apps.backgroundColor
            border.width: 0
            border.color: apps.fontColor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 0-width*0.5-rowCentral.spacing*0.5
            Rectangle{
                width: parent.width*0.75
                height: width
                radius: width*0.5
                color: apps.backgroundColor
                border.width: 1
                border.color: apps.fontColor
                anchors.centerIn: parent
                anchors.verticalCenterOffset: width*0.25
                Text{
                    text: 'I'
                    font.pixelSize: parent.width*0.25
                    color: apps.fontColor
                    anchors.top:  parent.top
                    anchors.topMargin: 0-parent.width*0.075
                    anchors.left: parent.left
                    anchors.leftMargin: 0-parent.width*0.075
                }
                Text{
                    text: r.vI
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
                    color: 'transparent'
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
                            anchors.horizontalCenterOffset: 0-parent.width*0.2
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
                            anchors.horizontalCenterOffset: parent.width*0.2
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
        Row{
            id: rowKL
            spacing: r.spacing
            //z:rowCentral.z+1
            Repeater{
                id: repKL
                model: 4
                Rectangle{
                    width: (r.width-r.spacing*3)/4
                    height: width
                    radius: width*0.5
                    color: 'transparent'
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
                        rotation: 180
                        Text{
                            text: index===1?'K':'L'
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
                            anchors.horizontalCenterOffset: 0-parent.width*0.2
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
                            anchors.horizontalCenterOffset: parent.width*0.2
                            z: parent.z-2
                            Rectangle{
                                width: 1
                                height: parent.parent.height
                            }
                        }
                        Text{
                            text: index===1?r.vK:r.vL
                            font.pixelSize: parent.width*0.5
                            color: apps.fontColor
                            rotation: 180
                            anchors.centerIn: parent
                        }
                    }
                }
            }
        }
        Rectangle{
            id:xO
            width: (r.width-r.spacing*3)/4
            height: width*0.1
            radius: width*0.5
            color: apps.backgroundColor
            border.width: 0
            border.color: apps.fontColor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 0-width*0.5-rowCentral.spacing*0.5
            Rectangle{
                width: parent.width*0.75
                height: width
                radius: width*0.5
                color: apps.backgroundColor
                border.width: 1
                border.color: apps.fontColor
                anchors.centerIn: parent
                anchors.verticalCenterOffset: 0-width*0.25
                Text{
                    text: 'O'
                    font.pixelSize: parent.width*0.25
                    color: apps.fontColor
                    anchors.top:  parent.top
                    anchors.topMargin: 0-parent.width*0.075
                    anchors.left: parent.left
                    anchors.leftMargin: 0-parent.width*0.075
                }
                Text{
                    text: r.vO
                    font.pixelSize: parent.width*0.5
                    color: apps.fontColor
                    anchors.centerIn: parent
                }
            }
        }
        Rectangle{
            id:xM
            width: (r.width-r.spacing*3)/4
            height: width
            radius: width*0.5
            color: apps.backgroundColor
            border.width: 0
            border.color: apps.fontColor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 0-width*0.5-rowCentral.spacing*0.5
            property int rot: 30
            property int hl: height+app.fs*0.3
            Rectangle{
                width: parent.width*0.75
                height: width
                radius: width*0.5
                color: apps.backgroundColor
                border.width: 1
                border.color: apps.fontColor
                rotation: 180
                anchors.centerIn: parent

                Text{
                    text: 'M'
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
                    rotation: parent.parent.rot
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: parent.width*0.25
                    anchors.horizontalCenterOffset: 0-parent.width*0.25
                    z: parent.z-1
                    Rectangle{
                        width: 1
                        height: parent.parent.parent.hl
                    }
                }
                Item{
                    width: 1
                    height: 1
                    rotation: 0-parent.parent.rot
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: parent.width*0.25
                    anchors.horizontalCenterOffset: parent.width*0.25
                    z: parent.z-2
                    Rectangle{
                        width: 1
                        height: parent.parent.parent.hl
                    }
                }
                Text{
                    text: r.vM
                    font.pixelSize: parent.width*0.5
                    color: apps.fontColor
                    rotation: 180
                    anchors.centerIn: parent
                }
            }
        }
        Rectangle{
            id:xN
            width: (r.width-r.spacing*3)/4
            height: width
            radius: width*0.5
            color: apps.backgroundColor
            border.width: 0
            border.color: apps.fontColor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 0-width*0.5-rowCentral.spacing*0.5
            z:rowCentral.z-1
            property int rot: 22
            property int hl: height*4
            Rectangle{
                width: parent.width*0.75
                height: width
                radius: width*0.5
                color: apps.backgroundColor
                border.width: 1
                border.color: apps.fontColor
                rotation: 180
                anchors.centerIn: parent

                Text{
                    text: 'N'
                    font.pixelSize: parent.width*0.25
                    color: apps.fontColor
                    rotation: 180
                    anchors.top:  parent.top
                    anchors.topMargin: 0-parent.width*0.075
                    anchors.left: parent.left
                    anchors.leftMargin: 0-parent.width*0.075
                }
                Item{
                    width: 1
                    height: 1
                    rotation: parent.parent.rot
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: parent.width*0.25
                    anchors.horizontalCenterOffset: 0-parent.width*0.25
                    z: parent.z-1
                    Rectangle{
                        width: 1
                        height: parent.parent.parent.hl
                    }
                }
                Item{
                    width: 1
                    height: 1
                    rotation: 0-parent.parent.rot
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: parent.width*0.25
                    anchors.horizontalCenterOffset: parent.width*0.25
                    z: parent.z-2
                    Rectangle{
                        width: 1
                        height: parent.parent.parent.hl
                    }
                }
                Text{
                    text: r.vN
                    font.pixelSize: parent.width*0.5
                    color: apps.fontColor
                    rotation: 180
                    anchors.centerIn: parent
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
        r.vH=modNumPit.bigNumToPitNum(m+a)
        r.vI=modNumPit.bigNumToPitNum(r.vE+r.vF+r.vG)
        r.vK=Math.abs(modNumPit.bigNumToPitNumNeg(m-d))
        let n2=Math.abs(modNumPit.bigNumToPitNumNeg(a))
        r.vL=Math.abs(d-n2)
        r.vM=Math.abs(r.vK-r.vL)

        n2=Math.abs(modNumPit.bigNumToPitNumNeg(m))-Math.abs(modNumPit.bigNumToPitNumNeg(a))
        r.vN=n2

        r.vO=modNumPit.bigNumToPitNum(r.vK+r.vL+r.vM)

    }
}
