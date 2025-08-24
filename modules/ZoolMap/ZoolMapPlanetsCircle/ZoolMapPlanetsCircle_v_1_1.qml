import QtQuick 2.0
import ZoolMap.ZoolMapAs 1.1

Item{
    id: r
    width: parent.width
    height: 10
    anchors.centerIn: parent
    property bool isBack: false
    property var cAs: r
    property int planetSize: zm.fs*0.75

    property int totalPosX: 0

    property var objSignsNames: ['ari', 'tau', 'gem', 'cnc', 'leo', 'vir', 'lib', 'sco', 'sgr', 'cap', 'aqr', 'psc']
    property var objSigns: [0,0,0,0,0,0,0,0,0,0,0,0]

    signal cnLoaded(string nombre, string dia, string mes, string anio, string hora, string minuto, string lon, string lat, string ciudad)
    signal doubleClick
    signal posChanged(int px, int py)
    Repeater{
        model: app.planetasRes
        ZoolMapAs{fs:r.planetSize;astro:modelData;numAstro: index; isBack: r.isBack}
    }
    function pressed(o){
        if(!o.isBack){
            if(zm.currentPlanetIndex!==o.numAstro){
                zm.currentPlanetIndex=o.numAstro
                zm.currentHouseIndex=o.ih
            }else{
                zm.currentPlanetIndex=-1
                zm.currentHouseIndex=-1
            }
        }else{
            if(zm.currentPlanetIndexBack!==o.numAstro){
                zm.currentPlanetIndexBack=o.numAstro
                zm.currentHouseIndexBack=o.ih
            }else{
                zm.currentPlanetIndexBack=-1
                zm.currentHouseIndexBack=-1
            }
        }
        //u.speak(''+app.planetas[o.numAstro]+' en '+app.signos[o.objData.ns]+' en el grado '+o.objData.g+' en la casa '+o.objData.h)
    }
    function doublePressed(o){

    }

    function loadJson(json){
        r.totalPosX=-1
        r.objSigns = [0,0,0,0,0,0,0,0,0,0,0,0]
        let jo
        let o
        var houseSun=-1
        //for(var i=0;i<15;i++){
        for(var i=0;i<zm.aBodies.length;i++){
            var objAs=r.children[i]
            jo=json.pc['c'+i]
            let degRed=0.0
            if(jo.mdeg>=10&&jo.mdeg<=20){
                degRed=0.2
            }
            if(jo.mdeg>=20&&jo.mdeg<=30){
                degRed=0.4
            }
            if(jo.mdeg>=30&&jo.mdeg<=40){
                degRed=0.6
            }
            if(jo.mdeg>=40&&jo.mdeg<=50){
                degRed=0.8
            }
            if(jo.mdeg>=50){
                degRed=1.0
            }
            objAs.pos=1
            objAs.rotation=signCircle.rot-jo.gdeg-(jo.mdeg/60)//+degRed
            if(r.isBack && app.t==='dirprim'){
                //objAs.rotation-=zm.dirPrimRot
                //objAs.rotation-=zm.dirPrimRot
            }
            if(i===0)zm.currentRotationxAsSol=objAs.rotation
            o={}
            o.p=objSigns[jo.is]
            if(r.totalPosX<o.p){
                r.totalPosX=o.p
            }
            o.ns=objSignsNames.indexOf(jo.is)
            o.ih=!r.isBack?
                        zm.objHousesCircle.getHousePos(jo.gdec, json.ph.h1.gdec, i, jo.ih)
                      :
                        zm.objHousesCircleBack.getHousePos(jo.gdec, json.ph.h1.gdec, i, jo.ih)

            o.rsg=jo.rsgdeg
            o.g=jo.gdeg
            o.m=jo.mdeg
            //o.h=jo.h
            o.ih=zm.objHousesCircle.getHousePos(jo.gdec, json.ph.h1.gdec, i, jo.ih)
            o.rsg=jo.rsgdeg
            o.gdec=jo.gdec

            if(r.isBack && app.t==='dirprim'){
                o.gdec+=zm.dirPrimRot
            }

            if(o.gdec>=360.000)o.gdec-=360.000
            o.g=jo.gdeg
            o.m=jo.mdeg
            o.s=jo.sdeg
            o.ih=zm.objHousesCircle.getHousePos(o.gdec, json.ph.h1.gdec, i, jo.ih)
            o.is=jo.is

            if(r.isBack && app.t!=='dirprim'){
                o.g=jo.gdeg
                o.m=jo.mdeg
                o.s=jo.sdeg
                o.ih=zm.objHousesCircleBack.getHousePos(o.gdec, json.ph.h1.gdec, i, jo.ih)
                o.is=jo.is
                //o.rsg=jo.gdec-(30*(parseInt(jo.gdec/30)))
                o.rsg=10//jo.gdec-(30*(o.ih))
                objAs.is=jo.is
            }else{
                let intJson=zm.currentJson//JSON.parse(app.fileData)
                o.ih=!r.isBack?zm.objHousesCircleBack.getHousePos(o.gdec, intJson.ph.h1.gdec, i, jo.ih):zm.objHousesCircle.getHousePos(o.gdec, intJson.ph.h1.gdec, i, jo.ih)
                if(i===9){
                    //log.lv('sweg.dirPrimRot:'+sweg.dirPrimRot)
                    //log.lv('o.is:'+o.is)
                    //log.lv('o.gdec:'+o.gdec)
                    //log.lv('o.g:'+o.g)
                    //log.lv('o.m:'+o.m)
                    //log.lv('o.s:'+o.s)
                }
                let nDMS=zm.getDDToDMS(o.gdec)
                o.rsg=o.gdec-(30*(parseInt(o.gdec/30)))
                o.g=nDMS.deg
                o.m=nDMS.min
                o.s=nDMS.sec
                o.is=zm.getIndexSign(o.gdec)
                objAs.is=o.is

                if(i===9){
                    //log.lv('n o.g:'+o.g)
                    //log.lv('n o.m:'+o.m)
                    //log.lv('n o.s:'+o.s)
                    //log.lv('n o.is:'+o.is)
                }

                //let nGDec=
                //let nIs=o.gdec/30
                //o.is=nIs
            }


            if(app.t==='dirprim'){
                o.is=zm.getIndexSign(o.gdec)
            }

            if(i!==10&&i!==11)o.retro=jo.retro
            objAs.is=jo.is
            objAs.ih=o.ih
            objAs.objData=o
            objSigns[jo.is]++
            if(i===0){
                zm.currentAbsolutoGradoSolar=jo.rsgdeg
                zm.currentGradoSolar=jo.gdeg
                zm.currentMinutoSolar=jo.mdeg
                zm.currentSegundoSolar=jo.sdeg
                houseSun=jo.ih
            }
        }

        let mDegs=[]
        /*for(i=0;i<20;i++){
            objAs=r.children[i]

        }*/
        for(i=0;i<zm.aBodies.length;i++){
            objAs=r.children[i]
            mDegs.push(parseInt(objAs.objData.gdec))
            objAs.vr=0
            objAs.widhCAChecked=false
            objAs.revPos()
        }
        //log.lv('mDegs: '+mDegs)
        //let numAsRev=1
        let anchoLongArc=72//Calcula cada °5 grados
        let div=360/anchoLongArc
        let cn=0
        let mPos=[]
        for(i=0;i<20;i++){
            mPos.push(0)
            objAs=r.children[i]
            objAs.pos=0
            //objAs.width=zm.width
            objAs.vr=0
        }

        //        for(i=1;i<20;i++){
        //            objAs=r.children[i]
        //            //objAs.pos=0

        //            //let g=parseInt(objAs.objData.gdec)
        ////            for(var i3=0;i3<20;i3++){
        ////                let gAs=mDegs[i3]
        //                //for(var i2=0;i2<anchoLongArc;i2++){
        //            for(var i2=i;i2<20;i2++){
        //                    //log.lv('div*i='+div*i)
        //                    let seg1=div*i2
        //                    let seg2=(div*i2)+div
        //                    //log.lv('Segmentos:'+seg1+'-'+seg2)
        //                    //if(g>=seg1 && g<=seg2 && g>=mDegs[gAs] && g<=mDegs[gAs])cn++
        //                    //if(mDegs[i]>=seg1 && mDegs[i]<=seg2 && i!==i2 && i2>i)cn++
        //                if(isNear(mDegs[i], mDegs[i2]) && i!==i2 && i2>i)cn++


        //                }
        //            //}
        //            objAs.pos=0
        //            objAs.width=zm.width
        //            objAs.vr=0
        //            cn=0
        //            log.lv('Pos '+i+':'+objAs.pos)
        //        }

        //        for(i=1;i<20;i++){
        //            objAs=r.children[i]
        //            let g=parseInt(objAs.objData.gdec)
        //            let cn=0
        //            for(var i2=0;i2<i;i2++){
        //                if(isNear(mDegs[i2], g) && i2!==i && i2<i){
        //                //if(isNear(mDegs[i2], g) && i2!==i && i2<i && (parseInt(mDegs[i2])!==parseInt(g))){
        //                    cn++

        //                    let cne=0
        //                    for(var i3=0;i3<i2;i3++){
        //                        if(isNear(mDegs[i3], g) && i3!==i2 && i3<i2 && (parseInt(mDegs[i3])!==parseInt(g))){
        //                        //if(isNear(mDegs[i3], g)){

        //                            let objAs2=r.children[i3]
        //                            if(objAs.pos===objAs2.pos)cne++
        //                            //cn=objAs2.pos//+1-objAs.pos//-i2
        //                        }else{
        //                            //cn--
        //                        }
        ////                        let objAs2=r.children[i3]
        ////                        let g2=parseInt(objAs2.objData.gdec)
        ////                        if(isNear(mDegs[i3], g2))cantPrev++
        //                    }


        //                }
        //                objAs.pos=cn+cne
        //                cne=0
        //                //cn=0
        //            }
        //            cn=0
        //            //Nodo Norte
        //            //if(i===10)cn--

        //            //objAs.pos=cn
        //            //cn=0
        //        }


        //        let minObjAsWidth=zm.width
        //        for(i=0;i<20;i++){
        //            let oa=r.children[i]
        //            if(oa.width<minObjAsWidth){
        //                minObjAsWidth=oa.width
        //            }
        //        }
        if(!r.isBack){
            //zm.aspsCircleWidth=getMinAsWidth()-zm.planetSize*2
            //zm.planetsAreaWidth=zm.objZ2.width-getMinAsWidth()-zm.planetSize*2
            //zm.objZ1.width=getMinAsWidth()-zm.planetSize*2
        }else{
            //zm.planetsBackBandWidth=zm.width-getMinAsWidth()//-zm.planetSize*2
            //zm.planetsAreaWidthBack=getMinAsWidth()-zm.planetSize*2
        }

        //log.lv('objLastAs.width: '+objLastAs.width)

        //Fortuna
        //        let joHouses=json.ph['h1']
        //        let joSol=json.pc['c0']
        //        let joLuna=json.pc['c1']
        //        objAs=r.children[15]
        //        var gf
        //        if(houseSun>=6){
        //            //Fortuna en Carta Diurna
        //            //Calculo para Fortuna Diurna Asc + Luna - Sol
        //            gf=joHouses.gdec+joLuna.gdec - joSol.gdec
        //            if(gf>=360)gf=gf-360
        //            objAs.rotation=signCircle.rot-gf
        //        }else{
        //            //Fortuna en Carta Nocturna
        //            //Calculo para Fortuna Nocturna Asc + Sol - Luna
        //            gf=joHouses.gdec+joSol.gdec - joLuna.gdec
        //            if(gf>=360)gf=gf-360
        //            objAs.rotation=signCircle.rot-gf
        //        }
        //        //console.log('gf: '+JS.deg_to_dms(gf))
        //        var arrayDMS=JS.deg_to_dms(gf)
        //        o={}
        //        o.g=arrayDMS[0]
        //        o.m=arrayDMS[1]
        //        var rsDegSign=gf
        //        for(var i2=1;i2<13;i2++){
        //            if(i2*30<gf){
        //                objAs.is=i2
        //                rsDegSign-=30
        //                o.p=objSigns[i2]
        //            }

        //            if(json.ph['h'+i2].gdec<gf){
        //                o.h=i2
        //                o.ih=i2
        //            }
        //        }
        //        if(r.totalPosX<o.p){
        //            r.totalPosX=o.p
        //        }
        //        o.ns=objSignsNames.indexOf(o.is)
        //        o.rsg=rsDegSign
        //        objAs.objData=o
        //        objSigns[o.is]++

        /*
        //Infortunio
        //Diurna Ascendente + Marte - Saturno
        //Nocturna Ascendente + Saturno - Marte
        //joHouses=json.ph['h1']
        let joMarte=json.pc['c4']
        let joSaturno=json.pc['c6']
        objAs=r.children[15]
        //var gf
        if(houseSun>=6){
            //Fortuna en Carta Diurna
            //Calculo para Fortuna Diurna Asc + Luna - Sol
            gf=joHouses.gdec + joMarte.gdec - joSaturno.gdec
            if(gf>=360)gf=gf-360
            if(gf<0)gf=360-gf
            objAs.rotation=signCircle.rot-gf
        }else{
            //Fortuna en Carta Nocturna
            //Calculo para Fortuna Nocturna Asc + Sol - Luna
            gf=joHouses.gdec + joSaturno.gdec - joMarte.gdec
            if(gf>=360)gf=gf-360
            if(gf<0)gf=360-gf
            objAs.rotation=signCircle.rot-gf
        }
        arrayDMS=JS.deg_to_dms(gf)
        o={}
        o.g=arrayDMS[0]
        o.m=arrayDMS[1]
        rsDegSign=gf
        for(var i2=1;i2<13;i2++){
            if(i2*30<gf){
                objAs.is=i2
                rsDegSign-=30
                o.p=objSigns[i2]
            }

            if(json.ph['h'+i2].gdec<gf){
                o.h=i2
                o.ih=i2
            }
        }
        if(r.totalPosX<o.p){
            r.totalPosX=o.p
        }
        o.ns=objSignsNames.indexOf(o.is)
        o.rsg=rsDegSign
        objAs.objData=o
        objSigns[o.is]++*/
    }
    function getAs(i){
        let objAs=r.children[i]
        return objAs
    }
    function isNear(g1, g2){
        let is=true
        if(g1-20 >= g2 || g1+20 <= g2)is=false
        return is
    }
    function getAPD(){
        let a=[]
        for(var i=0;i<20;i++){
            var objAs=r.children[i]
            if(objAs.objData && objAs.objData.gdec){
                let deg=objAs.objData.gdec
                if(app.t==='dirprim' && r.isBack){
                    deg=parseFloat(deg+zm.dirPrimRot)
                }
                if(deg>=360.00)deg=parseFloat(deg-360)
                a.push(deg)
            }
        }
        return a
    }
    function getMinAsWidth(){
        let minObjAsWidth=zm.width
        for(let i=0;i<20;i++){
            let oa=r.children[i]
            if(oa.width<minObjAsWidth){
                minObjAsWidth=oa.width
            }
        }
        return minObjAsWidth
    }
    function getMaxAsAbsPos(){
        let absPos=1
        for(let i=0;i<zm.aBodies.length;i++){
            let oa=r.children[i]
            //zpn.log('oa.absPos: '+oa.absPos)
            if(oa.absPos>absPos){
                absPos=oa.absPos
            }
        }
        return absPos
    }
}
