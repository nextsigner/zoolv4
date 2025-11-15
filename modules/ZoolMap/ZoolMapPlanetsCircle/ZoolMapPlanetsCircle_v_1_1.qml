import QtQuick 2.0
import ZoolMap.ZoolMapAs 1.3

Item{
    id: r
    width: parent.width
    height: 10
    anchors.centerIn: parent
    property bool isBack: false
    property var cAs: r
    property int planetSize: !r.isBack?zm.planetSizeInt:zm.planetSizeExt//zm.fs*0.75

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
            //objAs.pos=1
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
            let objHC=r.isBack?zm.objHousesCircle:zm.objHousesCircleBack
            o.ih=objHC.getHousePos(jo.gdec, json.ph.h1.gdec, i, jo.ih)
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
                //o.ih=zm.objHousesCircleBack.getHousePos(o.gdec, json.ph.h1.gdec, i, jo.ih)
                o.ih=zm.objHousesCircleBack.getPlanetIndexHouse(o.gdec, json.ph)+1
                o.is=jo.is
                //o.rsg=jo.gdec-(30*(parseInt(jo.gdec/30)))
                o.rsg=10//jo.gdec-(30*(o.ih))
                objAs.is=jo.is
            }else{
                let intJson=zm.currentJson//JSON.parse(app.fileData)
                //o.ih=!r.isBack?zm.objHousesCircleBack.getHousePos(o.gdec, intJson.ph.h1.gdec, i, jo.ih):zm.objHousesCircle.getHousePos(o.gdec, intJson.ph.h1.gdec, i, jo.ih)
                o.ih=zm.objHousesCircle.getPlanetIndexHouse(o.gdec, json.ph)+1
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
        /*for(i=0;i<20;i++){
            mPos.push(0)
            objAs=r.children[i]
            //objAs.pos=0
            //objAs.width=zm.width
            //objAs.vr=0
        }*/

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
            //zm.aspsCircleWidth=getMinAsWidth()-zm.planetSizeInt*2
            //zm.planetsAreaWidth=zm.objZ2.width-getMinAsWidth()-zm.planetSizeInt*2
            //zm.objZ1.width=getMinAsWidth()-zm.planetSizeInt*2
        }else{
            //zm.planetsBackBandWidth=zm.width-getMinAsWidth()//-zm.planetSizeInt*2
            //zm.planetsAreaWidthBack=getMinAsWidth()-zm.planetSizeInt*2
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
        //zpn.log('posMaxInt: '+posMaxInt)
        setMaxPos()
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
    function setMaxPos(){
        var objAs
        let maxPos=1
        let aGdecs=[]
        for(var i=0;i<zm.aBodies.length;i++){
            objAs=getAs(i)
            //aGdecs.push({ grados: objAs.objData.gdec, pos: 1 })
            aGdecs.push(objAs.objData.gdec)
        }
        if(!r.isBack){
            zm.aGdecsInt=aGdecs
        }else{
            zm.aGdecsExt=aGdecs
        }
        ordenarPosiciones()
        //const rangoDeGrados = 10;

        //let misObjetos = [];
        //const objetosActualizados = actualizarPosicionCircular(aGdecs, rangoDeGrados);
        //const objetosFinales = organizarObjetosCirculares(aGdecs, rangoDeGrados);
        //zpn.log('zm.aGdecsPosInt: '+JSON.stringify(zm.aGdecsPosInt, null, 2))
        //zpn.log('objetosFinales: '+JSON.stringify(objetosFinales, null, 2))
        if(!r.isBack){
            //zm.aGdecsPosInt=objetosActualizados
            //zm.aGdecsPosInt=objetosFinales
            //zpn.log('zm.aGdecsPosInt: '+JSON.stringify(zm.aGdecsPosInt, null, 2))
            //zpn.log('zm.aGdecsPosInt: '+JSON.stringify(zm.aGdecsPosInt, null, 2))
            /*for(var i3=0;i3<zm.aBodies.length;i3++){
                //zpn.log(' '+zm.aBodies[i3]+': '+zm.aGdecsPosInt[i3].grados)
                //zpn.log(' '+zm.aBodies[i3]+': '+objetosFinales[i3].posicion)
                zpn.log(' '+zm.aBodies[i3]+': '+JSON.stringify(objetosFinales[i3], null, 2))
                zpn.log(' '+zm.aBodies[i3]+'.grado.pos: '+objetosFinales[i3].grado.pos)
                //getAs(i3).pos=objetosFinales[i3].grado.pos
                //misObjetos.push({ "grado": zm.aGdecsPosInt[i3].grados, "posicion": 1 })
            }*/
            //zpn.log(' misObjetos: '+misObjetos.join('\n'))



        }else{
            //zm.aGdecsPosExt=objetosActualizados
            //zpn.log('zm.aGdecsPosExt: '+JSON.stringify(zm.aGdecsPosExt, null, 2))
        }
        //zpn.log('objetosActualizados: '+JSON.stringify(objetosActualizados, null, 2))
        for(i=0;i<zm.aBodies.length;i++){
            let p = aGdecs[i].pos
            if(p>maxPos){
                maxPos=p
            }
        }
        if(!r.isBack){
            //zm.posMaxInt=maxPos
        }else{
            //zm.posMaxExt=maxPos
        }
        //zpn.log('setMaxPos() zm.posMaxInt: '+zm.posMaxInt)
        /*for(i=zm.aBodies.length-1;i>0;i--){
            objAs=getAs(i)
            objAs.pos=objetosActualizados[i].pos
        }*/
        //zpn.log('objetosActualizados: '+JSON.stringify(objetosActualizados, null, 2))
    }
    function actualizarPosicionCircular(aObjects, rango) {
        // Asegurarse de que el rango sea un número positivo
        const rangoAbsoluto = Math.abs(rango);

        // Iterar sobre cada objeto para compararlo con todos los demás
        for (let i = 0; i < aObjects.length; i++) {
            const objetoActual = aObjects[i];

            // Iterar sobre cada objeto para la comparación
            for (let j = 0; j < aObjects.length; j++) {
                // Evitar comparar un objeto consigo mismo
                if (i === j) {
                    continue;
                }

                const objetoComparado = aObjects[j];
                const gradosActual = objetoActual.grados;
                const gradosComparado = objetoComparado.grados;

                // Calcular la diferencia de grados. Esto es lo que resuelve el problema del círculo
                let diferencia = Math.abs(gradosActual - gradosComparado);

                // Usar el módulo para manejar la "vuelta" del círculo (ej. 355° y 5°)
                diferencia = Math.min(diferencia, 360 - diferencia);

                // Si la diferencia está dentro del rango, incrementamos la posición
                if (diferencia <= rangoAbsoluto) {
                    objetoComparado.pos++;
                }
            }
        }
        return aObjects;
    }
    function organizarObjetosCirculares(aGrados, margen) {
        let objetos = [];

        // Función para normalizar grados entre 0 y 360
        const normalizarGrado = (grado) => {
            return (grado % 360 + 360) % 360;
        };

        // Iterar sobre cada grado para crear y posicionar un objeto
        aGrados.forEach((gradoActual, index) => {
                            let posicion = 1;
                            let gradoNormalizadoActual = normalizarGrado(gradoActual);

                            // Encontrar objetos existentes que colisionan con el grado actual
                            const objetosEnRango = objetos.filter(obj => {
                                                                      const gradoExistenteNormalizado = normalizarGrado(obj.grado);
                                                                      const rangoInferior = normalizarGrado(gradoNormalizadoActual - margen);
                                                                      const rangoSuperior = normalizarGrado(gradoNormalizadoActual + margen);

                                                                      if (rangoInferior > rangoSuperior) {
                                                                          // Manejar el cruce de 360°/0°
                                                                          return (gradoExistenteNormalizado >= rangoInferior || gradoExistenteNormalizado <= rangoSuperior);
                                                                      } else {
                                                                          return (gradoExistenteNormalizado >= rangoInferior && gradoExistenteNormalizado <= rangoSuperior);
                                                                      }
                                                                  }).sort((a, b) => a.posicion - b.posicion); // Ordenar por posición para asignar la siguiente disponible

                            // Si hay colisiones, asignar la siguiente posición
                            if (objetosEnRango.length > 0) {
                                posicion = objetosEnRango[objetosEnRango.length - 1].posicion + 1;
                                // Asegurarse de que no se salte ninguna posición
                                while (objetosEnRango.some(obj => obj.posicion === posicion)) {
                                    posicion++;
                                }
                            }

                            // Agregar el nuevo objeto al array
                            objetos.push({
                                             id: index + 1, // Puedes usar el índice como un ID
                                             grado: gradoActual,
                                             posicion: posicion
                                         });
                        });

        return objetos;
    }

    function setAsOffSetData(){
        let json=zm.currentJson
        let jo
        let o
        for(var i=0;i<zm.aBodies.length;i++){
            var objAs=r.children[i]
            let nuevoGrado=objAs.objData.gdec+zm.dirPrimRot
            if(nuevoGrado>360||nuevoGrado<0){
                nuevoGrado=360-nuevoGrado
            }
            let aDMS=app.j.deg_to_dms(nuevoGrado)
            let asObjData=objAs.objData
            objAs.is=zm.getIndexSign(nuevoGrado)
            asObjData.gdec=nuevoGrado
            asObjData.is=zm.getIndexSign(nuevoGrado)
            asObjData.ns=objSignsNames.indexOf(asObjData.is)
            asObjData.ih=zm.getHouseIndexFromArrayDegs(objAs.objData.gdec, zm.getJsonPhToArray(zm.currentJson.ph))
            asObjData.ihExt=zm.getHouseIndexFromArrayDegs(nuevoGrado-zm.objSignsCircle.rot, zm.getJsonPhToArray(zm.currentJson.ph))
            asObjData.rsg=nuevoGrado-(30*objAs.is)
            asObjData.g=aDMS[0]
            asObjData.m=aDMS[1]
            asObjData.s=aDMS[2]
            objAs.objData=asObjData
        }
    }



    function hayAlgoAhi(startDegree, secondStartDegree){
        const margen=10.00
        // Normalize degrees to be within the 0-360 range
        const normalize = (deg) => ((deg % 360) + 360) % 360;

        const normalizedStart = normalize(startDegree);
        const normalizedSecondStart = normalize(secondStartDegree);

        // Define the arcs
        const endDegree = normalize(normalizedStart + margen);
        const secondEndDegree = normalize(normalizedSecondStart + margen);

        // Check for overlap, handling the wrap-around case (end < start)
        const isOverlapping = (start1, end1, start2, end2) => {
            // Standard overlap check
            if (end1 >= start1 && end2 >= start2) {
                return (
                    (start1 >= start2 && start1 <= end2) ||
                    (end1 >= start2 && end1 <= end2) ||
                    (start2 >= start1 && start2 <= end1) ||
                    (end2 >= start1 && end2 <= end1)
                    );
            }

            // Overlap where the first arc wraps around (end1 < start1)
            if (end1 < start1) {
                return (
                    (start2 >= start1 || end2 <= end1) || // Second arc spans the wrap-around
                    (start2 >= start1 && start2 <= 360) || // Second arc starts in the first part
                    (end2 >= 0 && end2 <= end1) // Second arc ends in the second part
                    );
            }

            // Overlap where the second arc wraps around (end2 < start2)
            if (end2 < start2) {
                return (
                    (start1 >= start2 || end1 <= end2) || // First arc spans the wrap-around
                    (start1 >= start2 && start1 <= 360) || // First arc starts in the first part
                    (end1 >= 0 && end1 <= end2) // First arc ends in the second part
                    );
            }
        };

        return isOverlapping(normalizedStart, endDegree, normalizedSecondStart, secondEndDegree);
    }
    function ordenarPosiciones(){
        let aGdecs
        if(!r.isBack){
            aGdecs=zm.aGdecsInt
        }else{
            aGdecs=zm.aGdecsExt
        }
        let maxPos=0
        let aBodiesPos=[]
        for(var i=0;i<aGdecs.length;i++){
            aBodiesPos.push(1)
            let objAs=getAs(i)
            objAs.pos=0
        }
        for(i=1;i<aGdecs.length;i++){
            for(var i2=i-1;i2<aGdecs.length;i2++){
                let haa=hayAlgoAhi(aGdecs[i], aGdecs[i2])
                if(haa && i!==i2){
                    //zpn.log('ordenando: '+aGdecs[i])
                    //zpn.log('haa '+zm.aBodies[i]+' '+zm.aBodies[i2])
                    aBodiesPos[i2]++
                    if(aBodiesPos[i2]>maxPos){
                        maxPos++
                    }
                }
            }
        }
        //zpn.log('aBodiesPos: '+aBodiesPos.join('\n'))
        for(i=0;i<aGdecs.length;i++){
            let objAs=getAs(i)
            objAs.pos=aBodiesPos[i]-1
        }
        for(i=1;i<aGdecs.length;i++){
            let objAs=getAs(i)
            for(i2=0;i2<aGdecs.length;i2++){
                let objAs2=getAs(i2)
                //objAs.pos=aBodiesPos[i]-1
                let haa=hayAlgoAhi(aGdecs[i], aGdecs[i2])
                if(haa && i!==i2 && objAs.pos === objAs2.pos){
                    objAs.pos++
                }
            }
            if(objAs.pos>maxPos){
                maxPos=objAs.pos
            }
        }
        for(i=0;i<aGdecs.length;i++){
            let objAs=getAs(i)
            if(objAs.pos+1>maxPos){
                maxPos++
            }
        }
        //maxPos++
        //zpn.log('maxPos: '+maxPos)
        if(!r.isBack){
            zm.posMaxInt=maxPos
            //zm.currentMinPlanetsWidth=zm.objAI.width-(zm.planetSizeInt*zm.posMaxInt*2)-zm.objSignsCircle.w*2-zm.planetSizeInt
            //zm.setAreasWidth(true)
        }else{
            zm.posMaxExt=maxPos
            //zm.setAreasWidth(false)
        }
    }

    // Examples
    //console.log(isOverlappingArc(10, 11.5)); // true
    //console.log(isOverlappingArc(10, 12.5)); // false
    //console.log(isOverlappingArc(359.5, 0.5)); // true (wrapping around 360)
    //console.log(isOverlappingArc(359.5, 1.6)); // false (the overlap ends at 1.5)

}
