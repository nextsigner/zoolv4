import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    id: r

    property alias rx: xText

    // Propiedades de dimensiones
    property int w: 200 // Un valor por defecto evita errores
    width: w
    height: col.height

    // Propiedades de Texto
    property alias text: txt.text
    property alias t: txt
    property alias font: txt.font
    property alias color: txt.color
    property int fs: typeof app !== 'undefined' ? app.fs : 16

    // Estilo del Fondo
    property color textBackgroundColor: 'transparent'
    property int padding: 8
    property int borderWidth: 1
    property color borderColor: 'red'
    property real borderRadius: 10.0

    // Label
    property string labelText: ''
    property bool labelInTop: true

    // Señales
    signal enterPressed()

    Column {
        id: col
        width: parent.width
        spacing: 4 // Espacio entre label y input

        // Label superior
        Text {
            id: labelTopTextInput
            text: r.labelText
            width: parent.width
            font.pixelSize: r.fs * 0.7
            color: r.borderColor
            visible: r.labelInTop && r.labelText !== ""
        }

        // Contenedor del Input
        Rectangle {
            id: xText
            width: parent.width
            height: Math.max(r.fs + r.padding * 2, txt.contentHeight + r.padding * 2)
            color: r.textBackgroundColor
            border.width: r.borderWidth
            border.color: r.borderColor
            radius: r.borderRadius
            clip: true

            TextInput {
                id: txt
                width: parent.width - (r.padding * 2)
                anchors.centerIn: parent
                font.pixelSize: r.fs
                color: 'white'
                wrapMode: TextInput.WordWrap
                horizontalAlignment: TextInput.AlignHCenter
                verticalAlignment: TextInput.AlignVCenter

                // Al presionar Enter
                Keys.onReturnPressed: r.enterPressed()
                Keys.onEnterPressed: r.enterPressed()

                // Selección automática al ganar foco (opcional, mejora UX)
                onFocusChanged: if(focus) selectAll()
            }
        }
    }
}
