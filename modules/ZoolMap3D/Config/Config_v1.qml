import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Window 2.14
import "../../../comps" as Comps

Rectangle{
    id: r
    width: parent.width*0.2
    height: xApp.height
    color: apps.backgroundColor
    border.width: 1
    border.color: apps.fontColor

    Flickable{
        anchors.fill: parent
        contentWidth: parent.width
        contentHeight: col.height+app.fs*5
        Column{
            id: col
            spacing: app.fs
            anchors.horizontalCenter: parent.horizontalCenter
            Text{
                text: '<b>Configurar</b>'
                width: contentWidth
                font.pixelSize: app.fs
                color: 'white'
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Row{
                visible: false
                Text{
                    text: 'Altura Solar: '+slider1.value
                    font.pixelSize: app.fs*0.5
                    color: 'white'
                }
                Slider{
                    id: slider1
                    width: app.fs*5
                    value: cfg.v1
                    from: 100
                    to: 500
                    stepSize: 10
                    onValueChanged: cfg.v1=value
                }
            }
            Row{
                spacing: app.fs*0.25
                anchors.horizontalCenter: parent.horizontalCenter
                Text{
                    id: txt1
                    text: 'Brillo General: '+sliderBrilloGeneral.value
                    width: contentWidth
                    font.pixelSize: app.fs*0.5
                    color: 'white'
                }
                Slider{
                    id: sliderBrilloGeneral
                    width: r.width-txt1.width-parent.spacing-app.fs*0.5
                    value: cfg.intensidadDeLasLuces
                    from: 5
                    to: 50
                    stepSize: 1
                    onValueChanged: {
                        cfg.soloLuzDelSol=false
                        cfg.intensidadDeLasLuces=value
                    }
                }
            }
            Row{
                spacing: app.fs*0.25
                Text{
                    id: txt2
                    text: 'Brillo Solar: '+slider2.value
                    width: contentWidth
                    font.pixelSize: app.fs*0.5
                    color: 'white'
                }
                Slider{
                    id: slider2
                    width: r.width-txt2.width-parent.spacing-app.fs*0.5
                    value: cfg.intensidadBrilloSolar
                    from: 100
                    to: 4000
                    stepSize: 100
                    onValueChanged: {
                        cfg.soloLuzDelSol=true
                        cfg.intensidadBrilloSolar=value
                    }
                }
            }


        }
    }

    Comps.ButtonIcon{
        text: "X"
        width: app.fs*0.5
        height: width
        anchors.right: parent.right
        anchors.rightMargin: app.fs*0.1
        anchors.top: parent.top
        anchors.topMargin: app.fs*0.1
        onClicked: {
            r.destroy(0)
        }
    }
    Component.onCompleted: {
        //height = Screen.desktopAvailableHeight
        //console.log("El alto real es: " + Screen.desktopAvailableHeight)
    }
}
