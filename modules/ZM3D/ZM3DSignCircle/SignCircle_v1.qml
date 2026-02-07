import QtQuick 2.14
import QtQuick3D 1.14

import ZM3D.ZM3DSignCircle.ZM3DSignArc 1.0


Node {
    id: r
    //rotation.z:100
    //property var colors: ['red', '#FBE103', '#09F4E2', '#0D9FD6', 'red', '#FBE103', '#09F4E2', '#0D9FD6', 'red', '#FBE103', '#09F4E2', '#0D9FD6', 'red', '#FBE103', '#09F4E2', '#0D9FD6']
    property var colors: ['red', '#FBE103', '#09F4E2', '#1976D2', 'red', '#FBE103', '#09F4E2', '#1976D2', 'red', '#FBE103', '#09F4E2', '#1976D2', 'red', '#FBE103', '#09F4E2', '#1976D2']
    property int radio: parent.d
    property int diam: radio*2
    property real wAnc: 1.0
    //property real wAlt: 0.18
    property real wAlt: 0.18
    property real wProf: zm3d.anchoProfundoBandaSign

    ZM3DSignArc{ci:0}
    ZM3DSignArc{ci:1}
    ZM3DSignArc{ci:2}
    ZM3DSignArc{ci:3}
    ZM3DSignArc{ci:4}
    ZM3DSignArc{ci:5}
    ZM3DSignArc{ci:6}
    ZM3DSignArc{ci:7}
    ZM3DSignArc{ci:8}
    ZM3DSignArc{ci:9}
    ZM3DSignArc{ci:10}
    ZM3DSignArc{ci:11}



}
