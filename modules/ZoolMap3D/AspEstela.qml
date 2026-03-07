import QtQuick 2.14
import QtQuick3D 1.14

Node {
    id: root

    // ── Parámetros que ya usabas desde JS ───────────────────────────────
    property vector3d startPos:   Qt.vector3d(0, 0, 0)
    property vector3d endPos:     Qt.vector3d(0, 0, 0)
    property int    durationMs:   5000
    property color  cubeColor:    "red"

    // ── Ajustes de la estela (podés cambiarlos desde afuera) ────────────
    property real   trailScale:    0.35     // tamaño de cada punto
    property real   trailOpacity:  0.75     // opacidad máxima
    property int    trailUpdateMs: 45       // cada cuántos ms se agrega un punto
    property int    maxTrailPoints: 65      // límite para no saturar (ajusta si querés más larga)

    // === CUBO PRINCIPAL (ahora hijo del Node) ===
    Model {
        id: cube

        source: "#Sphere"
        scale: Qt.vector3d(0.25, 0.25, 0.25)

        materials: DefaultMaterial {
            diffuseColor: root.cubeColor
        }

        // Posición inicial
        Component.onCompleted: position = root.startPos

        // Animación de vuelo
        Vector3dAnimation on position {
            from: root.startPos
            to:   root.endPos
            duration: root.durationMs
            easing.type: Easing.InOutCubic
            running: true
        }
    }

    // === ESTELA ===
    ListModel { id: trailModel }

    Repeater3D {
        model: trailModel

        delegate: Model {
            source: "#Sphere"                 // cambiá a "#Cube" si preferís cubitos
            scale: Qt.vector3d(root.trailScale, root.trailScale, root.trailScale)

            // ¡Posición absoluta! (aquí estaba el error)
            position: Qt.vector3d(model.x, model.y, model.z)

            materials: DefaultMaterial {
                diffuseColor: root.cubeColor
                opacity: root.trailOpacity
            }

            // Cada punto se desvanece solo
            OpacityAnimator on opacity {
                from: 1.0
                to:   0.0
                duration: 1400
                running: true
            }

            // Se borra automáticamente cuando termina el fade
            Timer {
                interval: 1500
                running: true
                onTriggered: trailModel.remove(index, 1)
            }
        }
    }

    // === Generador de puntos de la estela ===
    Timer {
        interval: root.trailUpdateMs
        repeat: true
        running: true

        property real startTime: Date.now()

        onTriggered: {
            var t = (Date.now() - startTime) / root.durationMs

            // No generamos al principio ni al final
            if (t < 0.03 || t >= 1.0) {
                if (t >= 1.0) running = false
                return
            }

            // Limitamos la longitud máxima
            if (trailModel.count >= root.maxTrailPoints)
                trailModel.remove(0, 1)

            // Agregamos punto en la posición EXACTA del cubo
            trailModel.append({
                x: cube.position.x,
                y: cube.position.y,
                z: cube.position.z
            })
        }
    }

    // Destrucción automática del Node completo (incluye estela)
    Timer {
        interval: root.durationMs + 1800
        running: true
        onTriggered: root.destroy()
    }
}
