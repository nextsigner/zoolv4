import QtQuick 2.14
import QtQuick3D 1.14
import QtQuick3D.Materials 1.14


Model {
    id: r
    source: "#Cylinder"
    scale: Qt.vector3d(1.0, 1.0, 1.0)
    position: Qt.vector3d(0, 0, 0)
    rotation: Qt.vector3d(90, 0, 0)
    property int ci: zoolMap3D.zm3d.cbi
    //property color c: parent.colors[ci]
    property var aBdiesColors: ["#00ff00", "#33ff51", "#00ff88", "#ff8833", "#0f00ff", "#88ddff", "#0ff08d", "#ff5133", "#ff51dd", "#3f313f", "#ddff00", "#ff3838", "#ffff38", "#38ffcc", "#cc3838", "#ac38ff", "#afafaf", "#f8f838", "#ff38ff", "#ffccaa"]
    property var aBodies: ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Júpiter', 'Saturno', 'Urano', 'Neptuno', 'Plutón', 'N.Norte', 'N.Sur', 'Quirón', 'Selena', 'Lilith', 'Pholus', 'Ceres', 'Pallas', 'Juno', 'Vesta']

    property var aD: [120, 60, 70, 85, 80, 80, 80, 80, 80] //Array Distancias
    property var aA: [0, 100, 120] //Array Alturas
    Node{
        id: nb
    }
    Component{
        id: compBodie
        Model {
            id: xModel
            source: "#Sphere"
            scale: Qt.vector3d(1.0, 1.0, 1.0)
            property int bi
            property int hi
            property var aIHs: []
            property real gdec: 0.0
            property bool selected: zoolMap3D.zm3d.cbi===bi
            onSelectedChanged: {
                if(selected){
                    zoolMap3D.setRotCamSen(-90-zoolMap3D.zm3d.currentSignRot-1+parseInt(xModel.gdec))
                }
            }
            Component.onCompleted: {
                let i=xModel.bi
                if(i<=19){
                    let s
                    let aS
                    let objName=''
                    let drz=0
                    let altBase=100
                    let tipo=''
                    if(i===0){//Sol
                        s=1.5
                        altBase=0-(100*s*1.5)
                        objName='Sol'
                        tipo='personal'
                        aS=["imgs/sol/basecolor2.jpg", "imgs/sol/metallic.jpg", "maps/metallic/roughness.jpg", "imgs/sol/metallic.jpg"]
                    }else if(i===1){//Luna
                        s=0.8
                        altBase=0-(100*s*1.8)
                        drz=r.aD[0]
                        objName='Luna'
                        tipo='personal'
                        aS=["imgs/luna/basecolor2.jpg", "imgs/luna/metallic.jpg", "maps/metallic/roughness.jpg", "imgs/luna/basecolor1.jpg", "imgs/luna/metallic.jpg"]
                    }else if(i===2){//Mercurio
                        s=0.6
                        altBase=0-(100*s*2.5)
                        drz=r.aD[0]+r.aD[1]
                        objName='Mercurio'
                        tipo='personal'
                        aS=["imgs/mercurio/basecolor2.jpg", "imgs/mercurio/metallic.jpg", "maps/metallic/roughness.jpg", "imgs/mercurio/basecolor2.jpg", "imgs/mercurio/metallic.jpg"]
                    }else if(i===3){//Venus
                        s=1.0
                        altBase=0-(100*s*1.5)
                        drz=r.aD[0]+r.aD[1]+r.aD[2]
                        objName='Venus'
                        tipo='personal'
                        aS=["imgs/venus/basecolor2.jpg", "imgs/venus/metallic.jpg", "maps/metallic/roughness.jpg", "imgs/venus/basecolor1.jpg", "imgs/venus/basecolor2.jpg"]
                    }else if(i===4){//Marte
                        s=0.75
                        altBase=0-(100*s*2.0)
                        drz=r.aD[0]+r.aD[1]+r.aD[2]+r.aD[3]
                        objName='Marte'
                        tipo='personal'
                        aS=["imgs/marte/basecolor2.jpg", "imgs/marte/metallic.jpg", "maps/metallic/roughness.jpg", "imgs/marte/basecolor2.jpg", "imgs/marte/metallic.jpg"]
                    }else if(i===5){//Jupiter
                        s=1.0
                        altBase=0-(100*s*1.5)
                        drz=r.aD[4]
                        objName='Jupiter'
                        tipo='social'
                        aS=["imgs/jupiter/basecolor2.jpg", "imgs/jupiter/metallic.jpg", "maps/metallic/roughness.jpg", "imgs/jupiter/basecolor2.jpg", "imgs/jupiter/metallic.jpg"]
                    }else if(i===6){//Saturno
                        s=0.8
                        altBase=0-(100*s*2.0)
                        drz=r.aD[4]+r.aD[5]
                        objName='Saturno'
                        tipo='social'
                        aS=["imgs/saturno/basecolor1.jpg", "imgs/saturno/basecolor2.jpg", "imgs/saturno/metallic.jpg", "imgs/saturno/basecolor2.jpg", "imgs/saturno/basecolor2.jpg"]
                    }else if(i===7){//Urano
                        s=0.8
                        altBase=0-(100*s*2.0)
                        drz=r.aD[4]+r.aD[5]+r.aD[6]
                        objName='Urano'
                        tipo='tranpersonal'
                        aS=["imgs/urano/basecolor1.jpg", "imgs/urano/basecolor2.jpg", "imgs/urano/metallic.jpg", "imgs/urano/basecolor2.jpg", "imgs/urano/basecolor2.jpg"]
                    }else if(i===8){//Neptuno
                        s=0.8
                        altBase=0-(100*s*2.0)
                        drz=r.aD[4]+r.aD[5]+r.aD[6]+r.aD[7]
                        objName='Urano'
                        tipo='tranpersonal'
                        aS=["imgs/neptuno/basecolor1.jpg", "imgs/neptuno/basecolor2.jpg", "imgs/neptuno/metallic.jpg", "imgs/neptuno/basecolor2.jpg", "imgs/neptuno/basecolor2.jpg"]
                    }else if(i===9){//Plutón
                        s=0.6
                        altBase=0-(100*s*2.5)
                        drz=r.aD[4]+r.aD[5]+r.aD[6]+r.aD[7]+r.aD[8]
                        objName='Plutón'
                        tipo='tranpersonal'
                        aS=["imgs/pluton/basecolor1.jpg", "imgs/pluton/basecolor2.jpg", "imgs/pluton/metallic.jpg", "imgs/pluton/basecolor2.jpg", "imgs/pluton/basecolor2.jpg"]
                    }else if(i===10){//Nodo Norte
                        drz=50
                        altBase=0-(100*1.5)
                        let obj=compExtraBodie.createObject(xModel, {drz: drz, extraBodie: 'nn', bi: xModel.bi, hi: xModel.hi, altBase: altBase})
                        return
                    }else if(i===11){//Nodo Sur
                        drz=50
                        altBase=0-(100*1.5)
                        let obj=compExtraBodie.createObject(xModel, {drz: drz, extraBodie: 'ns', bi: xModel.bi, hi: xModel.hi, altBase: altBase})
                        return
                    }else if(i===12){//Quirón
                        drz=0
                        altBase=0-(100*1.5)
                        let obj=compExtraBodie.createObject(xModel, {drz: drz, bi: xModel.bi, hi: xModel.hi, altBase: altBase})
                        return
                    }else if(i===13){//Selena
                        drz=50
                        altBase=0-(100*1.5)
                        let obj=compExtraBodie.createObject(xModel, {drz: drz, extraBodie: 'selena', bi: xModel.bi, hi: xModel.hi, altBase: altBase})
                        return
                    }else if(i===14){//Lilith
                        drz=100
                        altBase=0-(100*1.5)
                        let obj=compExtraBodie.createObject(xModel, {drz: drz, extraBodie: 'lilith', bi: xModel.bi, hi: xModel.hi, altBase: altBase})
                        return
                    }else if(i===15){//Pholus
                        drz=150
                        altBase=0-(100*1.5)
                        let obj=compExtraBodie.createObject(xModel, {drz: drz, extraBodie: 'pholus', bi: xModel.bi, hi: xModel.hi, altBase: altBase})
                        return
                    }else if(i===16){//Ceres
                        drz=200
                        altBase=0-(100*1.5)
                        let obj=compExtraBodie.createObject(xModel, {drz: drz, extraBodie: 'ceres', bi: xModel.bi, hi: xModel.hi, altBase: altBase})
                        return
                    }else if(i===17){//Pallas
                        drz=250
                        altBase=0-(100*1.5)
                        let obj=compExtraBodie.createObject(xModel, {drz: drz, extraBodie: 'pallas', bi: xModel.bi, hi: xModel.hi, altBase: altBase})
                        return
                    }else if(i===18){//Juno
                        drz=300
                        altBase=0-(100*1.5)
                        let obj=compExtraBodie.createObject(xModel, {drz: drz, extraBodie: 'juno', bi: xModel.bi, hi: xModel.hi, altBase: altBase})
                        return
                    }else if(i===19){//Vesta
                        drz=350
                        altBase=0-(100*1.5)
                        let obj=compExtraBodie.createObject(xModel, {drz: drz, extraBodie: 'vesta', bi: xModel.bi, hi: xModel.hi, altBase: altBase})
                        return
                    }else{
                        s=0.4
                    }
                    let obj=c1.createObject(xModel, {tipo: tipo, aIHs: xModel.aIHs, gdec: xModel.gdec, objName: objName, drz: drz, s: s, altBase: altBase, bi: i, hi: xModel.hi, aSources: aS})
                }else{
                    let obj=c2.createObject(xModel, {hi: xModel.hi})
                }
            }
        }
    }
    Component{
        id: c1
        Node{
            id: n
            rotation: Qt.vector3d(0, 0, 0)
            property var aIHs: []
            property real gdec: 0.0
            property string objName: 'sin_nombre'
            property string tipo: 'ninguno'
            property int hi
            property var aSources: ["ZM3D/ZM3DBodiesCircle/imgs/sol/basecolor2.jpg", "ZM3D/ZM3DBodiesCircle/imgs/sol/metallic.jpg", "ZM3D/ZM3DBodiesCircle/maps/metallic/roughness.jpg", "ZM3D/ZM3DBodiesCircle/imgs/sol/basecolor1.jpg", "ZM3D/ZM3DBodiesCircle/imgs/sol/metallic.jpg"]
            property real s: 1.5
            property bool selected: parent.selected
            //property bool selected: zoolMap3D.zm3d.cbi===n.bi
            property int bi: -1
            property int drz: 0 //Distancia de la rueda zodiacal
            property int alt: 0
            property int hBase: 0
            property int altBase: 0
            onSelectedChanged: {
                //                if(selected){
                //                    n.position=Qt.vector3d(0-zoolMap3D.zm3d.d+150+80, 0, -50)
                //                }else{
                //                    n.position=Qt.vector3d(0-zoolMap3D.zm3d.d+150+drz, 0, n.alt)
                //                }
            }
            Model {
                source: "#Sphere"
                scale: Qt.vector3d(n.s-0.06, n.s-0.06, n.s-0.06)
                materials:DefaultMaterial{
                    diffuseColor: 'yellow'
                }
            }
            Model {
                id: m
                source: "#Sphere"
                scale: Qt.vector3d(n.s-0.05, n.s-0.05, n.s-0.05)

                pickable: true
                property bool isPicked: false
                objectName: n.objName
                onIsPickedChanged: {
                    if(view.camera===cameraGiro)return
                    if(isPicked){
                        zoolMap3D.zm3d.chi=n.hi
                        zoolMap3D.zm3d.cbi=n.bi
                        /*camera.visible=false
                        cameraLocal.visible=true*/
                        //view.cCam=cameraLocal
                        let nz=zoolMap3D.zm3d.getObjZGdec(n.rotation.z)
                        //log.lv('nz:'+nz)
                        ncg.gdec=nz
                        //app.setRotCamSen(-90-zoolMap3D.zm3d.currentSignRot-1+parseInt(n.gdec))
                    }else{
                        zoolMap3D.zm3d.chi=-1
                        zoolMap3D.zm3d.cbi=-4
                        camera.visible=true
                        cameraLocal.visible=false
                        view.cCam=camera
                    }
                }
                materials: [
                    PrincipledMaterial {
                        specularAmount: 0.0 //De 0.0 a 1.0
                        indexOfRefraction: 0.0//De 1.0 3.0
                        opacity: 0.5
                        baseColorMap: Texture {source: n.aSources[3]}
                        //Metalizar
                        metalness: 0.1 //De 0.0 a 1.0
                        metalnessMap: Texture { source: n.aSources[3]}//Metalicidad
                        //Arrugar
                        roughnessMap: Texture { source: "maps/metallic/roughness.jpg" }//Rugosidad
                        roughness: 0.0 //De 0.0 a 1.0

                        //normalMap: Texture { source: "imgs/sol/normal.jpg" }//Piel de fondo
                    }
                ]
                SequentialAnimation on rotation {
                    loops: Animation.Infinite
                    running: true
                    PropertyAnimation {
                        duration: 30000
                        to: Qt.vector3d(0, 360, 0)
                        from: Qt.vector3d(360, 0, 0)
                    }
                }
            }
            Node{
                id: rootNodeBase
                scale: Qt.vector3d(0.2, n.s, 0.2)
                rotation: Qt.vector3d(0, 90, 90)
                //position: Qt.vector3d(0, 0, 0+(100*n.s*0.5))
                position: Qt.vector3d(0, 0, 0+(100*n.s*0.5))
                visible: n.selected
                Model {
                    id: baseEjeVertical
                    scale: Qt.vector3d(3.0, 0.2, 3.0)
                    source: "#Cylinder"
                    materials: DefaultMaterial{
                        diffuseColor: 'white'
                    }
                }
                Model {
                    id: ejeVertical
                    source: "#Cylinder"
                    materials: baseEjeVertical.materials
                    SequentialAnimation on position {
                        loops: Animation.Infinite
                        running: false//true
                        PropertyAnimation {
                            duration: 3000
                            to: Qt.vector3d(0, 0, 0)
                            from: Qt.vector3d(0, 0, 0-(100*n.s))
                        }
                        PropertyAnimation {
                            duration: 3000
                            to: Qt.vector3d(0, 0, 0-(100*n.s))
                            from: Qt.vector3d(0, 0, 0)
                        }
                    }
                }
            }
            Model {
                source: "#Sphere"
                scale: Qt.vector3d(n.s, n.s, n.s)
                materials: [
                    PrincipledMaterial {
                        id: matc1
                        specularAmount: 0.0 //De 0.0 a 1.0
                        indexOfRefraction: 0.0//De 1.0 3.0
                        opacity: 0.5
                        baseColorMap: Texture {id: s1matc1; source: n.aSources[0]}
                        //Metalizar
                        metalness: 0.1 //De 0.0 a 1.0
                        metalnessMap: Texture {id: s2matc1;  source: n.aSources[1] }//Metalicidad
                        //Arrugar
                        roughnessMap: Texture {id: s3matc1;  source: n.aSources[2] }//Rugosidad
                        roughness: 0.0 //De 0.0 a 1.0

                        //normalMap: Texture { source: "imgs/sol/normal.jpg" }

                    }
                ]
                Model {
                    id: anillo1
                    source: "#Cylinder"
                    scale: Qt.vector3d(1.25, 0.05, 1.25)
                    position: Qt.vector3d(0, 0, 0)
                    rotation: Qt.vector3d(0, 90, 0)
                    visible: n.bi===6 || n.bi===7
                    materials: [
                        PrincipledMaterial {
                            specularAmount: 0.0 //De 0.0 a 1.0
                            indexOfRefraction: 0.0//De 1.0 3.0
                            opacity: 1.0
                            baseColorMap: Texture {source: n.aSources[3]}
                            //Metalizar
                            metalness: 0.1 //De 0.0 a 1.0
                            metalnessMap: Texture { source: n.aSources[4]}//Metalicidad
                            //Arrugar
                            roughnessMap: Texture { source: "maps/metallic/roughness.jpg" }//Rugosidad
                            roughness: 0.0 //De 0.0 a 1.0

                            //normalMap: Texture { source: "imgs/sol/normal.jpg" }//Piel de fondo
                        }
                    ]
                }
                SequentialAnimation on rotation {
                    loops: Animation.Infinite
                    running: true
                    PropertyAnimation {
                        duration: 30000
                        to: Qt.vector3d(360, 0, 0)
                        from: Qt.vector3d(0, 360, 0)
                    }
                }
            }
            Node{
                rotation: Qt.vector3d(-45, 0, 0)
                PerspectiveCamera {
                    id: cameraLocal
                    objectName: 'bodie_cam'
                    property string nom: 'bodie_cam'
                    position: Qt.vector3d(0, 0, 0-1000)
                    rotation: Qt.vector3d(0, 0, 360-n.parent.rotation.z-sc.rotation.z)
                    visible: false
                    //rotation.y: 30 //Con eje y rota/gira hacia los costados.
                    //Behavior on rotation.x{NumberAnimation{duration: 2000}}
                    //Behavior on rotation.y{NumberAnimation{duration: 2000}}
                    //Behavior on rotation.z{NumberAnimation{duration: 2000}}
                }
                SequentialAnimation{
                    running: false//n.selected
                    loops: Animation.Infinite
                    PropertyAnimation {
                        target: n
                        property: "rotation"
                        duration: 6000
                        to: Qt.vector3d(0, 45, 0)
                        from: Qt.vector3d(0, 45, 360)
                    }
                }
            }
            SequentialAnimation on position{
                running: !n.selected
                PropertyAnimation {
                    duration: 500
                    to: Qt.vector3d(0-zoolMap3D.zm3d.d+150+drz, 0, n.alt)
                    from: Qt.vector3d(0-zoolMap3D.zm3d.d+150-140, 0, n.altBase)
                }
            }
            SequentialAnimation on position{
                running: n.selected
                PropertyAnimation {
                    duration: 500
                    from: Qt.vector3d(0-zoolMap3D.zm3d.d+150+drz, 0, n.alt)
                    to: Qt.vector3d(0-zoolMap3D.zm3d.d+150-140, 0, n.altBase)
                }
            }
            Component.onCompleted:{
                let vh1=n.aIHs[n.bi]
                let vh2=n.aIHs[n.bi+1]
                let b=estanA2OMasCasaDeDiferencia(vh1, vh2)
                if(n.tipo==='personal'){
                    n.alt=0
                }
                if(n.tipo==='social'){
                    n.alt=80
                }
                if(n.tipo==='transpersonal'){
                    n.alt=160
                }
                position=Qt.vector3d(0-zoolMap3D.zm3d.d+150+drz, 0, n.alt)
            }
        }
    }
    Component{
        id: compExtraBodie
        Node{
            id: n
            //position: Qt.vector3d(0-zoolMap3D.zm3d.d+130+n.drz, 0, -100)
            //rotation: Qt.vector3d(0, 90, 0)
            property string extraBodie: 'hiron'
            property int bi: -1
            property int drz: 0
            property int alt: 0
            property int hBase: 0
            property int altBase: 0
            property real s: 0.5
            property bool selected: zoolMap3D.zm3d.cbi===n.bi
            property var aSources: ["ZM3D/ZM3DBodiesCircle/imgs/sol/basecolor2.jpg", "ZM3D/ZM3DBodiesCircle/imgs/sol/metallic.jpg", "ZM3D/ZM3DBodiesCircle/maps/metallic/roughness.jpg", "ZM3D/ZM3DBodiesCircle/imgs/sol/basecolor1.jpg", "ZM3D/ZM3DBodiesCircle/imgs/sol/metallic.jpg"]
            Model {
                id: m
                source: "#Cube"
                //scale: Qt.vector3d(0.5, 0.5, 0.5)
                scale: Qt.vector3d(n.s, n.s, n.s)
                rotation.z:-90
                position: Qt.vector3d(0-zoolMap3D.zm3d.d+130+n.drz, 0, -100)
//                rotation: Qt.vector3d(0, 90, 0)
                materials: [
                    DefaultMaterial {
                        id: cubeMaterial
                        diffuseColor: 'white'
                        diffuseMap: Texture {
                            source: "../../ZM3D/ZM3DBodiesCircle/imgs_white_trans/"+n.extraBodie+".png"
                            scaleU: 1.0
                            scaleV: 1.0
                            //rotationUV: -90
                            //positionU: 0.1
                            //positionV: -0.9
                        }
                    }
                ]
                SequentialAnimation on position{
                    running: !n.selected
                    PropertyAnimation {
                        duration: 500
                        //to: Qt.vector3d(0-zoolMap3D.zm3d.d+150+drz, 0, n.alt)
                        to: Qt.vector3d(0-zoolMap3D.zm3d.d+130+n.drz, 0, -100)
                        from: Qt.vector3d(0-zoolMap3D.zm3d.d+150-140, 0, n.altBase)
                    }
                }
                SequentialAnimation on position{
                    running: n.selected
                    PropertyAnimation {
                        duration: 500
                        //from: Qt.vector3d(0-zoolMap3D.zm3d.d+150+drz, 0, n.alt)
                        from: Qt.vector3d(0-zoolMap3D.zm3d.d+130+n.drz, 0, -100)
                        to: Qt.vector3d(0-zoolMap3D.zm3d.d+150-140, 0, n.altBase)
                    }
                }
                Node{
                    id: rootNodeBase
                    //scale: Qt.vector3d(3.2, 3.2, 3.2)
                    scale: Qt.vector3d(0.4, n.s*4, 0.4)
                    rotation.x:90
                    position.z:100*n.s+10
                    visible: n.selected
                    Model {
                        id: baseEjeVertical
                        scale: Qt.vector3d(3.0, 0.1, 3.0)
                        source: "#Cylinder"
                        materials: DefaultMaterial{
                            diffuseColor: 'white'
                            SequentialAnimation on diffuseColor{
                                loops: Animation.Infinite
                                //running: false
                                PropertyAnimation{
                                    duration: 200
                                    from: 'white'
                                    to: 'red'
                                }
                                PropertyAnimation{
                                    duration: 200
                                    from: 'red'
                                    to: 'yellow'
                                }
                                PropertyAnimation{
                                    duration: 200
                                    from: 'yellow'
                                    to: 'white'
                                }
                            }
                        }
                    }
                    Model {
                        id: ejeVertical
                        source: "#Cylinder"
                        materials: baseEjeVertical.materials
                        SequentialAnimation on position {
                            loops: Animation.Infinite
                            running: false//true
                            PropertyAnimation {
                                duration: 3000
                                to: Qt.vector3d(0, 0, 0)
                                from: Qt.vector3d(0, 0, 0-(100*n.s))
                            }
                            PropertyAnimation {
                                duration: 3000
                                to: Qt.vector3d(0, 0, 0-(100*n.s))
                                from: Qt.vector3d(0, 0, 0)
                            }
                        }
                    }
                }
            }
        }
    }
    Component{
        id: c2
        Model {
            source: "#Cube"
            scale: Qt.vector3d(0.5, 0.5, 0.5)
            position: Qt.vector3d(0-zoolMap3D.zm3d.d+150, 0, 0)
            rotation: Qt.vector3d(0, 90, 0)
            materials: [
                DefaultMaterial {
                    id: cubeMaterial
                    diffuseColor: 'white'
                }
            ]
            SequentialAnimation on rotation {
                loops: Animation.Infinite
                running: false//true
                PropertyAnimation {
                    duration: 2000
                    to: Qt.vector3d(0, 0, 0)
                    from: Qt.vector3d(0, 360, 360)
                }
            }
        }
    }
    Component{
        id: cNodosNS
        Model {
            id: m
            source: "#Cone"
            scale: Qt.vector3d(1.0, 1.0, 1.0)
            position: Qt.vector3d(0-zoolMap3D.zm3d.d+80, 0, -50)
            rotation: Qt.vector3d(-90, 90, 0)
            property int t: 0
            materials:DefaultMaterial {
                diffuseColor: m.t===0?"red":"blue"
                specularAmount: 0.0
                indexOfRefraction:0.1
            }
        }
    }

    function load(j){
        for(var i=0;i<nb.children.length;i++){
            nb.children[i].destroy(0)
        }
        let aDegs=[]
        let aIHs=[]

        //Estas variables p1 y p2 son para probar las distancias
        //Para desactivarlas hay que poner p2=-1
        let p1=12
        let p2=-14

        for(i=0;i<20;i++){
            let jb=j['c'+parseInt(i)]
            if(i===p2){
                aDegs.push(aDegs[p1]+0)
            }else{
                aDegs.push(jb.gdec)
            }


            aIHs.push(jb.ih)
        }
        for(i=0;i<20;i++){
            let obj=compBodie.createObject(nb, {bi: i, hi: aIHs[i], aIHs: aIHs, gdec: aDegs[i]})
            obj.rotation=Qt.vector3d(0, 0, parseInt(aDegs[i])-1)
        }
    }
    function estanA2OMasCasaDeDiferencia(h1, h2) {
        if (h1 < 1 || h1 > 12 || h2 < 1 || h2 > 12) {
            return false
        }
        let difference = Math.abs(h1 - h2);
        let cyclicDifference = Math.min(difference, 12 - difference);
        return cyclicDifference >= 2;
    }
}
