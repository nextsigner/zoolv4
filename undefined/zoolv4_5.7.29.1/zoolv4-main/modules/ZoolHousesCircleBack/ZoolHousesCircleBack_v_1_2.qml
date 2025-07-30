import QtQuick 2.0
//import "./comps" as Comps
Item {
    id: r
    width: sweg.parent.height*apps.sweMargin//-apps.*16
    visible: false
//    Rectangle{
//        anchors.fill: r
//        color: '#ff8833'
//    }
    property int currentHouse: app.currentHouseIndexBack
    property int w: sweg.fs*3
    property int wb: 1//sweg.fs*0.15
    property int f: 0
    property bool v: false
    property var arrayWg: []
    property string extraObjectName: ''
    property var swegParent//: value
    property int widthAspCircle: 10
    property int extraWidth: 0
    property var aWs: []
//    state: r.parent.state
//    states: [
//        State {
//            name: r.parent.aStates[0]
//            PropertyChanges {
//                target: r
//                //width: housesCircle.parent.objectName==='sweg'?(r.parent.width-sweg.fs-sweg.fs):(r.parent.width-sweg.fs)
//                width: r.parent.width-sweg.fs-sweg.fs
//            }
//        },
//        State {
//            name: r.parent.aStates[1]
//            PropertyChanges {
//                target: r
//                //width: housesCircle.parent.objectName==='sweg'?(r.parent.width-sweg.fs*5-sweg.fs):(r.parent.width-sweg.fs*2.5-sweg.fs*0.5)
//                width: r.parent.width-sweg.fs*5-sweg.fs
//            }
//        },
//        State {
//            name: r.parent.aStates[2]
//            PropertyChanges {
//                target: r
//                //width: housesCircle.parent.objectName==='sweg'?(r.parent.width-sweg.fs-sweg.fs):(r.parent.width)
//                width: r.parent.width-sweg.fs-sweg.fs
//            }
//        }
//    ]
//    Behavior on rotation{
//        enabled: apps.enableFullAnimation;
//        NumberAnimation{duration:2000;easing.type: Easing.InOutQuad}
//    }

    Item{
        id: xHomeArcsBack
        anchors.fill: r
        Item{
            id:xArcsBack
            anchors.fill: parent
            Repeater{
                model: 12
                HouseArcBack{
                    objectName: 'HomeArcBack'+index+'_'+r.extraObjectName
                    n: index+1
                    c: index
                }
            }
        }
    }
    Text{
        text: 'RHC:'+r.rotation
        font.pixelSize: 40
        color: 'blue'
        //x: 300
        visible: false
    }
    function loadHouses(jsonData) {
        r.arrayWg=[]
        xArcsBack.rotation=360-jsonData.ph.h1.gdec+signCircle.rot//+1
        if(app.t==='dirprim'){
            xArcsBack.rotation-=sweg.dirPrimRot
        }
        var h
        let aDegs=[]
        let resta=0.000000
        let nh=0
        let o1
        let o2
        let indexSign1
        let p1
        let indexSign2
        let p2
        let gp=[]
        var i=0
        var degRet=0.0
        for(i=0;i<12;i++){
            if(i===0){
                zm.uAscDegreeTotal=jsonData.ph.h1.gdec
            }
            nh=i
            let h=xArcsBack.children[i]
            h.op=0.0
            let sh1=''
            let sh2=''
            if(i===11){
                sh1='h'+parseInt(nh + 1)
                sh2='h1'
                //console.log('Ob1: '+sh1+ ' '+sh2)
                o1=jsonData.ph[sh1]
                o2=jsonData.ph[sh2]
            }else{
                sh1='h'+parseInt(nh + 1)
                sh2='h'+parseInt(nh + 2)
                o1=jsonData.ph[sh1]
                o2=jsonData.ph[sh2]
            }
            indexSign1=o1.is
            if(i!==0&&i!==6){
                p1=indexSign1*30+parseInt(o1.rsgdeg)+(o1.mdeg/60)
            }else{
                p1=indexSign1*30+parseInt(o1.rsgdeg)+(o1.mdeg/60)
            }

            indexSign2=o2.is//app.objSignsNames.indexOf(o2.s)
            if(i!==0&&i!==6){
                p2=0.0000+indexSign2*30+o2.rsgdeg+(o2.mdeg/60)
            }else{
                p2=0.0000+indexSign2*30+o2.rsgdeg+(o2.mdeg/60)
            }
            //p2=0.0000+indexSign2*30+parseInt(o2.rsgdeg)
            //let wgf=parseInt(p2)-parseInt(p1)+(o1.mdeg/60)
            let wgf=p2-p1+(o1.mdeg/60)
            let degRed=0.0
            if(wgf<0){
                h.wg=360+p2-p1+(o1.mdeg/60)
            }else{
                h.wg=p2-p1+(o1.mdeg/60)
            }
            //h.wg=1
            if(i===0){
                h.rotation=0
            }else{
                if(i===1){
                    h.rotation=360-gp[i-1]
                    //housesAxis.reload(i, 360-gp[i-1])
                }
                if(i===2){
                    h.rotation=360-(gp[i-1]+gp[i-2])
                    //housesAxis.reload(i, 360-(gp[i-1]+gp[i-2]))
                }
                if(i===3){
                    h.rotation=360-(gp[i-1]+gp[i-2]+gp[i-3])
                    //housesAxis.reload(i, 360-(gp[i-1]+gp[i-2]+gp[i-3]))
                }
                if(i===4){
                    h.rotation=360-(gp[i-1]+gp[i-2]+gp[i-3]+gp[i-4])
                    //housesAxis.reload(i, 360-(gp[i-1]+gp[i-2]+gp[i-3]+gp[i-4]))
                }
                if(i===5){
                    h.rotation=360-(gp[i-1]+gp[i-2]+gp[i-3]+gp[i-4]+gp[i-5])
                    //housesAxis.reload(i, 360-(gp[i-1]+gp[i-2]+gp[i-3]+gp[i-4]+gp[i-5]))
                }
                if(i===6){
                    h.rotation=h.rotation=180
                    //h.rotation=h.rotation=360-(gp[i-1]+gp[i-2]+gp[i-3]+gp[i-4]+gp[i-5]+gp[i-6])
                    //housesAxis.reload(i, 360-(gp[i-1]+gp[i-2]+gp[i-3]+gp[i-4]+gp[i-5]+gp[i-6]))
                }
                if(i===7){
                    h.rotation=h.rotation=360-(gp[i-1]+gp[i-2]+gp[i-3]+gp[i-4]+gp[i-5]+gp[i-6]+gp[i-7])
                    //housesAxis.reload(i, h.rotation=360-(gp[i-1]+gp[i-2]+gp[i-3]+gp[i-4]+gp[i-5]+gp[i-6]+gp[i-7]))
                }
                if(i===8){
                    h.rotation=h.rotation=360-(gp[i-1]+gp[i-2]+gp[i-3]+gp[i-4]+gp[i-5]+gp[i-6]+gp[i-7]+gp[i-8])
                    //housesAxis.reload(i, h.rotation=360-(gp[i-1]+gp[i-2]+gp[i-3]+gp[i-4]+gp[i-5]+gp[i-6]+gp[i-7]+gp[i-8]))
                }
                if(i===9){
                    h.rotation=h.rotation=360-(gp[i-1]+gp[i-2]+gp[i-3]+gp[i-4]+gp[i-5]+gp[i-6]+gp[i-7]+gp[i-8]+gp[i-9])
                    //housesAxis.reload(i, h.rotation=360-(gp[i-1]+gp[i-2]+gp[i-3]+gp[i-4]+gp[i-5]+gp[i-6]+gp[i-7]+gp[i-8]+gp[i-9]))
                }
                if(i===10){
                    h.rotation=h.rotation=360-(gp[i-1]+gp[i-2]+gp[i-3]+gp[i-4]+gp[i-5]+gp[i-6]+gp[i-7]+gp[i-8]+gp[i-9]+gp[i-10])
                }
                if(i===11){
                    h.rotation=h.rotation=360-(gp[i-1]+gp[i-2]+gp[i-3]+gp[i-4]+gp[i-5]+gp[i-6]+gp[i-7]+gp[i-8]+gp[i-9]+gp[i-10]+gp[i-11])
                }
                //if(i!==0&&i!==6&&Qt.platform.os==='windows'){
                if(i!==0&&i!==6){
                    //h.rotation+=1.5
                }
                if(o1.mdeg>=10&&o1.mdeg<=20){
                    degRed=0.2
                }
                if(o1.mdeg>=20&&o1.mdeg<=30){
                    degRed=0.4
                }
                if(o1.mdeg>=30&&o1.mdeg<=40){
                    degRed=0.6
                }
                if(o1.mdeg>=40&&o1.mdeg<=50){
                    degRed=0.8
                }
                if(o1.mdeg>=50){
                    degRed=1.0
                }
                degRet+=degRed
                if(i!==0&&i!==6){
                    h.rotation+=degRet
                }else{
                    h.rotation+=degRed
                }
            }
            gp.push(wgf)
            resta+=xArcsBack.children[nh].wg-(o1.mdeg/60)-(o2.mdeg/60)-degRed
            r.arrayWg.push(h.wg)
        }
        let nawgs=0.0
        r.aWs=[]
        for(i=0;i<12;i++){
            h=xArcsBack.children[i]
            let g1=0.000
            let g2=0.000
            g1=xArcsBack.children[i].rotation
            g2=xArcsBack.children[i +1].rotation
            let nwg=g1-g2
            if(nwg<0){
                nwg=360+nwg
            }else{
                if(nwg>360){
                    nwg=nwg-360
                }
            }
            if(nwg>=360){
                nwg=nwg-360
            }
            h.wg=nwg
            r.aWs.push(nwg)
            nawgs+=Math.abs(nwg)
            //console.log('nwg: '+nwg)
            //console.log('nawgs: '+nawgs)
        }
    }
    function getHousePos(g, rot, ip, defaultRet){
        let rotDiff=360-rot
        let initdeg=0-rotDiff
        var findeg
        if(initdeg+180<g){
            initdeg+=360
        }
        for(var i=0;i<12;i++){
            findeg=initdeg+housesCircleBack.aWs[i]//-rotDiff
            if(g>initdeg&&g<findeg){
                return i + 1
            }
            initdeg+=housesCircleBack.aWs[i]
        }
        initdeg=0-rotDiff
        for(i=0;i<12;i++){
            findeg=initdeg+housesCircleBack.aWs[i]
            if(g>initdeg&&g<findeg){
                return i + 1
            }
            initdeg+=housesCircleBack.aWs[i]
        }
        return defaultRet
    }
}
