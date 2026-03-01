import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: r
    property bool isBack: false
    property bool selected: false
    property int pos: -1
    property int numAstro: -1
    property int is: -1
    property var objData
    property alias objImg: imgGlifoPlanets
    property color c: !r.isBack ? zm.bodieColor : zm.bodieColorBack

    property real porcIncrement: 1.0

    onCChanged: {
        if(r.numAstro === 0){
            coGlifoPlanets.color = zm.bodieColor
        }
    }

    property string folderImgs: '../../../imgs/imgs_v2'
    property color bgColor: !r.isBack ? zm.bodieBgColor : zm.bodieBgColorBack

    width: zm.bodieSize
    height: width
    anchors.left: parent.left
    anchors.leftMargin: 0 - xIconPlanetSmall.width
    anchors.verticalCenter: parent.verticalCenter

    // --- IMAGEN FUENTE (Siempre invisible, solo sirve de máscara para el ColorOverlay) ---
    Image {
        id: imgGlifoPlanets
        // Si numAstro >= 10 o xAsShowIcon es false, usamos el tamaño completo o el incremento
        width: r.width * (apps.xAsShowIcon && r.numAstro < 10 ? r.porcIncrement * 0.5 : apps.xAsShowIcon?0.5:1.0)
        height: width
        anchors.centerIn: parent
        source: r.folderImgs + '/glifos/' + app.planetasRes[r.numAstro] + '.svg'
        visible: false
        antialiasing: true
        rotation: !r.isBack ?
                  0 - parent.parent.rotation :
                  0 - parent.parent.rotation + zm.dir_prim_rot // Corregido posible typo de zm.dirPrimRot
    }

    // --- EL GLIFO COLOREADO ---
    ColorOverlay {
        id: coGlifoPlanets
        anchors.fill: imgGlifoPlanets
        source: imgGlifoPlanets
        color: r.c
        rotation: imgGlifoPlanets.rotation
        // VISIBILIDAD:
        // Se ve si NO está activo el modo icono O si es un cuerpo superior a Plutón (>=10)
        visible: !apps.xAsShowIcon || r.numAstro >= 10
    }

    // --- ESFERA GENÉRICA (Solo para cuerpos >= 10 si se desea fondo, si no, puedes poner visible: false) ---
    Image {
        id: imgEsfera
        source: r.folderImgs + '/bodies/esfera.png'
        width: r.width * r.porcIncrement * 0.5
        height: width
        anchors.centerIn: parent
        rotation: imgGlifoPlanets.rotation
        z: imgGlifoPlanets.z-1
        antialiasing: true
        // Solo visible si es cuerpo extra Y el usuario quiere ver iconos
        visible: r.numAstro >= 10 && apps.xAsShowIcon
    }

    // --- IMAGEN DE PLANETA REAL (Solo del 0 al 9) ---
    Image {
        id: imgEsferaPlanets
        source: r.numAstro <= 9 ? r.folderImgs + '/bodies/' + app.planetasRes[r.numAstro] + '.png' : ''
        width: r.width * r.porcIncrement
        height: width
        anchors.centerIn: parent
        rotation: imgGlifoPlanets.rotation
        antialiasing: true
        // Solo visible para los 10 primeros cuerpos y si xAsShowIcon está activo
        visible: apps.xAsShowIcon && r.numAstro <= 9
    }

    // --- SISTEMA DE PUNTERO (Nombres y líneas) ---
    Rectangle {
        id: nodoCenPointer
        width: r.width * 0.5
        height: width
        radius: width * 0.5
        color: 'transparent'
        rotation: 180
        visible: apps.xAsShowIcon && !r.selected
        anchors.centerIn: parent

        Rectangle {
            id: ejePointer
            width: !r.isBack ? zm.planetSizeInt * f : zm.planetSizeExt * f
            height: 1
            color: 'transparent'
            anchors.left: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            property real f: 1.0

            Rectangle {
                // Ajuste de la línea para que no pise el glifo/imagen
                width: parent.width - (r.numAstro >= 10 ? imgEsfera.width * 0.5 : imgEsferaPlanets.width * 0.5)
                height: 1
                color: apps.fontColor
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
            }

            Rectangle {
                id: boxName
                width: txtBodieName.contentWidth + app.fs * 0.25
                height: txtBodieName.contentHeight + app.fs * 0.25
                color: apps.backgroundColor
                border.width: 1
                border.color: apps.fontColor
                radius: app.fs * 0.15
                anchors.horizontalCenter: parent.right
                anchors.verticalCenter: parent.verticalCenter
                rotation: imgGlifoPlanets.rotation - nodoCenPointer.rotation

                MouseArea {
                    acceptedButtons: Qt.AllButtons
                    anchors.fill: parent
                    onClicked: {
                        if (mouse.button === Qt.RightButton) nodoCenPointer.rotation -= 10
                        else nodoCenPointer.rotation += 10
                    }
                    onWheel: {
                        if(wheel.angleDelta.y >= 0) {
                            if(ejePointer.f < 4.0) ejePointer.f += 0.1
                        } else {
                            if(ejePointer.f > 1.0) ejePointer.f -= 0.1
                        }
                    }
                }

                Text {
                    id: txtBodieName
                    text: zm.aBodies[r.numAstro] ? zm.aBodies[r.numAstro] : ""
                    font.pixelSize: app.fs * 0.35
                    color: apps.fontColor
                    anchors.centerIn: parent
                }
            }
        }
    }

    onPosChanged: setPointerRot()

    Component.onCompleted: {
        // Optimización de escalas iniciales
        var scales = {1:0.5, 2:0.5, 3:0.65, 4:0.65, 8:0.65, 9:0.5}
        if (scales[numAstro] !== undefined) {
            r.porcIncrement = scales[numAstro]
        } else {
            r.porcIncrement = 1.0
        }
    }

    function setPointerRot() {
        var rots = {0: 45, 1: -45, 2: 70, 3: 90}
        nodoCenPointer.rotation = rots[r.pos] !== undefined ? rots[r.pos] : 180
    }
}
