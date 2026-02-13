import QtQuick 2.0
import QtQuick 2.14
import QtQuick3D 1.14
import ZM3D.ZM3DSignCircle 1.0
import ZM3D.ZM3DHousesCircle 1.0
import ZM3D.ZM3DBodiesCircle 1.0

Node{
    id: r
    //Tamaños
    property int d: 1000
    property real anchoProfundoBandaSign: 0.15
    property real anchoProfundoLineaHouse: 2.5

    property var aSigns: ['Aries', 'Tauro', 'Géminis', 'Cáncer', 'Leo', 'Virgo', 'Libra', 'Escorpio', 'Sagitario', 'Capricornio', 'Acuario', 'Piscis']
    property var aSignsLowerStyle: ['aries', 'tauro', 'geminis', 'cancer', 'leo', 'virgo', 'libra', 'escorpio', 'sagitario', 'capricornio', 'acuario', 'piscis']
    property var aBodies: zm.aBodies//['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Júpiter', 'Saturno', 'Urano', 'Neptuno', 'Plutón', 'N.Norte', 'N.Sur', 'Quirón', 'Selena', 'Lilith', 'Pholus', 'Ceres', 'Pallas', 'Juno', 'Vesta']
    property var aBodiesFiles: ['sol', 'luna', 'mercurio', 'venus', 'marte', 'jupiter', 'saturno', 'urano', 'neptuno', 'pluton', 'nodo_norte', 'nodo_sur', 'quiron', 'selena', 'lilith', 'pholus', 'ceres', 'pallas', 'juno', 'vesta']
    property var objSignsNames: ['ari', 'tau', 'gem', 'cnc', 'leo', 'vir', 'lib', 'sco', 'sgr', 'cap', 'aqr', 'psc']

    //Current Json Data
    property var cJson: {}

    //Current Bodies and Houses Indexs
    property int cbi: -2
    property int chi: -1

    property int cAscDeg: 0
    property int cAscRsDeg: 0
    property int cAscIs: -1

    property int cbRsgdeg: 0
    property int cbmdeg: 0
    property int cbsdeg: 0
    property int cbis: -1
    property int cbih: -1

    property real currentSignRot: 0

    onCbiChanged: {
        if(r.cbi>=0){
            let ic=r.cJson.pc['c'+r.cbi]
            if(!ic)return
            r.cbRsgdeg=ic.rsgdeg
            r.cbmdeg=ic.mdeg
            r.cbsdeg=ic.sdeg
            r.cbis=ic.is
            r.cbih=getIndexHouse(ic.gdec, r.cJson)
        }else{
            zoolMap3D.setRotCamSen(-90-zoolMap3D.zm3d.currentSignRot-1+parseInt(zoolMap3D.zm3d.cAscDeg))
        }
    }
    onChiChanged: {
        //log.lv('zoolMap3D.zm3d.chi: '+chi)
    }

    ZM3DSignCircle{
        id: sc
        rotation.z:0-currentSignRot
        //visible: false
    }
    ZM3DHousesCircle{
        id: hc
        rotation.z:0-currentSignRot
        //visible: false
    }
    ZM3DBodiesCircle{
        id: bc
        rotation.z:0-currentSignRot
        //visible: false
    }

    function loadData(j){
        r.cJson=j
        //log.lv('j:'+JSON.stringify(j, null, 2))
        //log.lv('Deg Casa 1:'+j.ph.h1.gdec)
        let rot=360-j.ph.h1.gdec
        //log.lv('Rot:'+rot)
        r.currentSignRot=0-rot
        hc.load(j.ph)
        bc.load(j.pc)
        //view.cCam.rotation.y=30
        view.camera=cameraGiro
        //view.cCam.rotation.x=30
        let grado=parseInt(j.ph.h1.gdec)
        r.cbi=0
    }

    function getObjZGdec(gdec){
        let nz=-90-zoolMap3D.zm3d.currentSignRot-gdec+90
        if(nz>360.00)nz=360.00-nz
        return nz
    }
    function getIndexSign(gdec){
        let index=0
        let g=0.0
        for(var i=0;i<12+5;i++){
            g = g + 30.00
            if (g > parseFloat(gdec)){
                break
            }
            index = index + 1
        }
        if(index===12)index--
        return index
    }
    function getIndexHouse(gdec, json){
        let index=0
        let g=0.0
        for(var i=0;i<12;i++){
            let iseg=json.ph['h'+parseInt(i+1)].gdec
            let fseg
            if(i!==11){
                fseg=json.ph['h'+parseInt(i+2)].gdec
            }else{
                fseg=json.ph['h1'].gdec
            }
            if(fseg<iseg)fseg=fseg+360
            if(gdec>=iseg && gdec<=fseg){
                index=i
                break
            }
        }
        return parseInt(index + 1)
    }
}
