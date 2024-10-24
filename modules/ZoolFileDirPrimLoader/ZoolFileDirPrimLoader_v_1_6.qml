import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt.labs.settings 1.1
import "../../comps" as Comps
import "../../js/Funcs.js" as JS

import ZoolText 1.0
import ZoolTextInput 1.0
import ZoolButton 1.2
import ZoolControlsTime 1.0
import ZoolLogView 1.0

/*
    Naibod 0° 59´8.33” = 0.9856481481481388
    Ptolomeo 1° = 1.0000
    Subduodenaria 0° 12´30” = 0.20833333333333
    Narónica 0° 36´ = 0.6
    Duodenaria 2° 30’ = 2.5
    Navamsa 3° 20’ = 3.3333333333333
    Septenaria 4° 17’ = 4.2833333333333
*/

Rectangle {
    id: r
    width: xLatIzq.width
    height: xLatIzq.height-xPanelesTits.height-app.fs*0.5
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor


    property var aClavesNames: ["Naibod 0° 59\' 8.33\"", "Ptolomeo 1°", "Subduodenaria 0° 12\' 30\"", "Narónica 0° 36´", "Duodenaria 2° 30\'", "Navamsa 3° 20’", "Septenaria 4° 17\'"]
    property var aClavesValuesDec: [0.9856481481481388, 1.0, 0.20833333333333, 0.6, 2.5, 3.3333333333333, 4.2833333333333]

    property bool moduleEnabled: false

    property alias ctFecha: controlTimeFecha
    property alias xCfgItem: colXConfig

    property real lat:-100.00
    property real lon:-100.00

    property real ulat:-100.00
    property real ulon:-100.00

    property string uParamsLoaded: ''

    property bool loadingFromExternal: false
    property string folderImg: '../../modules/ZoolBodies/ZoolAs/imgs_v1'
    visible: false
    onVisibleChanged: {
        //r.moduleEnabled=visible
        //if(visible)zoolVoicePlayer.stop()
        if(visible)zoolVoicePlayer.speak('Sección para crear Direcciones Primarias', true)
        if(!visible)r.moduleEnabled=false
    }
    Timer{
        id: tWaitLoadExterior
        running: false
        repeat: false
        interval: 3000
        onTriggered: {
            //comentado en v1.5
            //if(apps.dev)log.lv('tWaitLoadExterior...')
            //r.setDirPrimRotation()
        }
    }
    MouseArea{
        anchors.fill: parent
        onDoubleClicked: colXConfig.visible=!xCtrlJsonsFolderTemp.visible
    }

    Settings{
        id: settings
        fileName: 'zoolFileDirPrimLoader.cfg'

        property bool showModuleVersion: false
        property bool inputCoords: false
        property int cbClavesCurrentIndex: 0
    }
    ZoolText{
        text: 'ZoolFileDirPrimLoader v1.0'
        font.pixelSize: app.fs*0.5
        color: apps.fontColor
        anchors.left: parent.left
        anchors.leftMargin: app.fs*0.1
        anchors.top: parent.top
        anchors.topMargin: app.fs*0.1
        opacity: settings.showModuleVersion?1.0:0.0
        MouseArea{
            anchors.fill: parent
            onClicked: settings.showModuleVersion=!settings.showModuleVersion
        }
    }
    /*ZoolButton{
        text:'\uf013'
        anchors.right: parent.right
        anchors.rightMargin: app.fs*0.25
        anchors.top: parent.top
        anchors.topMargin: app.fs*0.25
        z: col.z+1
        onClicked:{
            zoolFileManager.s.showConfig=!zoolFileManager.s.showConfig
        }
    }*/

    Flickable{
        id: flk
        width: r.width-app.fs
        height: r.height
        contentWidth: col.width
        contentHeight: col.height
        anchors.horizontalCenter: parent.horizontalCenter
        Column{
            id: col
            anchors.centerIn: parent
            spacing: app.fs*0.5
            Item{width: 1; height: app.fs; visible: colXConfig.visible}
            Column{
                id: colXConfig
                anchors.horizontalCenter: parent.horizontalCenter
            }
            ZoolText{
                //t.width:r.width-app.fs
                text: '<b>Crear Direcciones Primarias</b>'
                w: r.width-app.fs
                font.pixelSize: app.fs*0.65
                color: 'white'
            }
            Column{
                spacing: app.fs*0.25
                anchors.horizontalCenter: parent.horizontalCenter
                ZoolButton{
                    text: r.moduleEnabled?'Desactivar Modulo':'Activar Modulo'
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked:{
                        r.moduleEnabled=!r.moduleEnabled
                    }
                }
                ZoolControlsTime{
                    id: controlTimeFecha
                    labelText: 'Momento de tránsitos'
                    //KeyNavigation.tab: tiCiudad.t
                    setAppTime: false
                    enableGMT:false
                    visible: false
                }



                ComboBox{
                    id: cbClaves
                    width: r.width-app.fs
                    font.pixelSize: app.fs*0.5
                    model: r.aClavesNames
                    currentIndex: settings.cbClavesCurrentIndex
                    visible: r.moduleEnabled
                    onCurrentIndexChanged: {
                        if(!visible)return
                        settings.cbClavesCurrentIndex=currentIndex
                        setDirPrimRotation()
                    }

                }
                ZoolControlsTime{
                    id: controlTimeFechaEvento
                    gmt: 0
                    labelText: 'Momento del evento'
                    //KeyNavigation.tab: tiCiudad.t
                    setAppTime: false
                    enableGMT:false
                    visible: r.moduleEnabled
                    anchors.horizontalCenter: parent.horizontalCenter
                    onCurrentDateChanged: {

                        //if(!visible || !r.loadingFromExternal)return
                        if(!r.moduleEnabled)return
                        if(!r.visible && !r.loadingFromExternal)return
                        tLoad.restart()
                        if(app.j.eventoEsMenorAInicio(app.currentDate, currentDate)){
                            currentDate=app.currentDate
                            return
                        }
                    }
                    Timer{
                        id: tLoad
                        running: false
                        repeat: false
                        interval: 500
                        onTriggered: {
                            setDirPrimRotation()
                        }
                    }
                    Timer{
                        id: tUpdateParamsEvento
                        running: false
                        repeat: false
                        interval: 1500
                        onTriggered: updateUParams()
                    }
                }
                Row{
                    spacing: app.fs*0.1
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: r.moduleEnabled
                    ZoolButton{
                        text:'Restablecer'
                        anchors.verticalCenter: parent.verticalCenter
                        onClicked:{
                            controlTimeFechaEvento.currentDate=controlTimeFecha.currentDate
                        }
                    }
                    ZoolButton{
                        text:'Guardar'
                        anchors.verticalCenter: parent.verticalCenter
                        onClicked:{
                            //app.j.loadBack(nom, vd, vm, va, vh, vmin, vgmt, vlat, vlon, valt, vCiudad, edad, tipo, hsys, ms, vAtRigth)

                            let vd=controlTimeFecha.dia
                            let vm=controlTimeFecha.mes
                            let va=controlTimeFecha.anio
                            let vh=controlTimeFecha.hora
                            let vmin=controlTimeFecha.minuto

                            let vgmt=app.currentGmt//controlTimeFecha.gmt//tiGMT.t.text
                            let vlon=app.currentLon
                            let vlat=app.currentLat
                            let valt=app.currentAlt
                            let vCiudad=app.currentLugar
                            let vhsys=apps.currentHsys

                            let vdEvento=controlTimeFechaEvento.dia
                            let vmEvento=controlTimeFechaEvento.mes
                            let vaEvento=controlTimeFechaEvento.anio
                            let vhEvento=controlTimeFechaEvento.hora
                            let vminEvento=controlTimeFechaEvento.minuto
                            let vgmtEvento=app.currentGmt

                            let edad=app.j.getEdadDosFechas(app.currentDate, new Date(vaEvento, vmEvento-1, vdEvento, vhEvento, vminEvento))

                            let nom='Dir. Prim de '+app.currentNom+' '+vaEvento+'/'+vmEvento+'/'+vdEvento
                            let aR=[]
                            aR.push('<b>Fecha:</b> '+vdEvento+'/'+vmEvento+'/'+vaEvento)
                            aR.push('<b>Edad:</b> '+edad+' años')
                            app.j.loadBack(nom, vdEvento, vmEvento, vaEvento, vhEvento, vminEvento, vgmtEvento, vlat, vlon, valt, vCiudad, edad, 'dirprim', vhsys, -1, aR)
                        }
                    }
                }
            }
            Rectangle{
                id: xFind
                width: colFind.width+app.fs*0.5
                height: colFind.height+app.fs*0.5
                color: 'transparent'
                border.width: 1
                border.color: apps.fontColor
                anchors.horizontalCenter: parent.horizontalCenter
                visible: r.moduleEnabled
                Column{
                    id: colFind
                    anchors.centerIn: parent
                    Row{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        ZoolButton{
                            text: 'Iniciar Rastreo'
                            //anchors.horizontalCenter: parent.horizontalCenter
                            onClicked:{
                                if(!tAutoFindAsps.running){
                                    log.clear()
                                }
                                if(rd1.checked){
                                    tAutoFindAsps.m=0
                                }
                                if(rd2.checked){
                                    tAutoFindAsps.m=1
                                }
                                if(rd3.checked){
                                    tAutoFindAsps.m=2
                                }
                                tAutoFindAsps.running=!tAutoFindAsps.running
                            }
                        }
                        ZoolButton{
                            text: 'Reiniciar'
                            //anchors.horizontalCenter: parent.horizontalCenter
                            onClicked:{
                                log.clear()
                                tAutoFindAsps.stop()
                                controlTimeFechaEvento.currentDate=controlTimeFecha.currentDate
                            }
                        }
                        ZoolButton{
                            text: 'Ver Lista'
                            //anchors.horizontalCenter: parent.horizontalCenter
                            onClicked:{
                                aspsList.visible=!aspsList.visible
                            }
                        }
                    }
                    Row{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Row{
                            ZoolText{
                                text:'Año'
                                fs: app.fs*0.5
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            RadioButton{
                                id: rd1
                                checked: true
                                onCheckedChanged: {
                                    if(checked){
                                        rd2.checked=false
                                        rd3.checked=false
                                    }
                                }
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                        Row{
                            ZoolText{
                                text:'Mes'
                                fs: app.fs*0.5
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            RadioButton{
                                id: rd2
                                //checked: true
                                onCheckedChanged: {
                                    if(checked){
                                        rd1.checked=false
                                        rd3.checked=false
                                    }
                                }
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                        Row{
                            ZoolText{
                                text:'Día'
                                fs: app.fs*0.5
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            RadioButton{
                                id: rd3
                                //checked: true
                                onCheckedChanged: {
                                    if(checked){
                                        rd1.checked=false
                                        rd2.checked=false
                                    }
                                }
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                }
            }
            Rectangle{
                id: xBtns
                width: gribBtns.width+app.fs*0.5
                height: col2.height+app.fs*0.5
                color: 'transparent'
                border.width: 1
                border.color: apps.fontColor
                anchors.horizontalCenter: parent.horizontalCenter
                visible: r.moduleEnabled
                property bool forBack: false
                Column{
                    id: col2
                    spacing: app.fs*0.25
                    anchors.centerIn: parent
                    ZoolText{
                        text:'Mostrar Cotas de Grados<br />en los cuerpos '+(xBtns.forBack?' <b>Significadores</b><br />(cuerpos exteriores movibles).':'<b>Promisores</b><br />(cuerpos interiores fijos).')
                        fs: app.fs*0.5
                        color: apps.fontColor
                    }
                    Row{
                        spacing: app.fs*0.1
                        ZoolText{
                            text:'Interior'
                            fs: app.fs*0.5
                            color: apps.fontColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        RadioButton {
                            id: rb1
                            checked: !xBtns.forBack
                            anchors.verticalCenter: parent.verticalCenter
                            onCheckedChanged: {
                                xBtns.forBack=!checked
                            }
                        }
                        Item{width: app.fs*0.25; height: 1}
                        ZoolText{
                            text:'Exterior'
                            fs: app.fs*0.5
                            color: apps.fontColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        RadioButton {
                            id: rb2
                            checked: xBtns.forBack
                            anchors.verticalCenter: parent.verticalCenter
                            onCheckedChanged: {
                                xBtns.forBack=checked
                            }
                        }
                    }
                    Grid{
                        id: gribBtns
                        columns: 6
                        spacing: app.fs*0.1
                        anchors.horizontalCenter: parent.horizontalCenter
                        Repeater{
                            model:15
                            Rectangle{
                                id: xBtn
                                width: r.width*0.12
                                height: width
                                opacity: selected?1.0:0.5
                                property bool selected: !xBtns.forBack?sweg.listCotasShowingBack.indexOf(index)>=0:sweg.listCotasShowing.indexOf(index)>=0
                                Timer{
                                    running: r.visible
                                    repeat: true
                                    interval: 250
                                    onTriggered: {
                                        txtinfo1.text='a1'+sweg.listCotasShowing.toString()
                                        txtinfo2.text='a2'+sweg.listCotasShowingBack.toString()
                                        if(!xBtns.forBack){
                                            xBtn.selected=sweg.listCotasShowing.indexOf(index)>=0
                                        }else{
                                            xBtn.selected=sweg.listCotasShowingBack.indexOf(index)>=0
                                        }
                                    }
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        if(!xBtns.forBack){
                                            if(sweg.listCotasShowing.indexOf(index)>=0){
                                                //sweg.listCotasShowing.splice(index, 1)
                                                sweg.listCotasShowing=app.j.removeItemAll(sweg.listCotasShowing, index)
                                            }else{
                                                sweg.listCotasShowing.push(index)
                                            }
                                        }else{
                                            if(sweg.listCotasShowingBack.indexOf(index)>=0){
                                                //sweg.listCotasShowingBack.splice(index, 1)
                                                sweg.listCotasShowingBack=app.j.removeItemAll(sweg.listCotasShowingBack, index)
                                            }else{
                                                sweg.listCotasShowingBack.push(index)
                                            }
                                        }

                                    }
                                }
                                //                            Text{
                                //                                text:xBtn.selected?'<b>'+app.planetasResAS[index]+'</b>':app.planetasResAS[index]
                                //                                font.pixelSize: parent.width*0.1
                                //                                anchors.centerIn: parent
                                //                            }
                                Image{
                                    id: img0
                                    source: r.folderImg+"/"+app.planetasRes[index]+".svg"
                                    width: parent.width*0.9
                                    height: width
                                    anchors.centerIn: parent
                                }

                            }
                        }
                    }
                    Text{
                        id: txtinfo1
                        text: 'a1: '+sweg.listCotasShowing.toString()
                        font.pixelSize: app.fs*0.5
                        color: 'red'
                        visible: apps.dev
                    }
                    Text{
                        id: txtinfo2
                        text: 'a2: '+sweg.listCotasShowingBack.toString()
                        font.pixelSize: app.fs*0.5
                        color: 'red'
                        visible: apps.dev
                    }
                }
            }
        }
    }
    Timer{
        id: tAutoFindAsps
        repeat: true
        running: false
        interval: 200
        property int m: 1
        onTriggered: {
            let d = controlTimeFechaEvento.currentDate
            if(m===0){
                d.setFullYear(d.getFullYear() + 1)
            }
            if(m===1){
                d.setMonth(d.getMonth() + 1)
            }
            if(m===2){
                d.setDate(d.getDate() + 1)
            }

            let dateStop=new Date(controlTimeFecha.currentDate)
            dateStop.setFullYear(dateStop.getFullYear() + 100)
            if(controlTimeFechaEvento.currentDate > dateStop){
                tAutoFindAsps.running=false
            }

            controlTimeFechaEvento.currentDate = d
            setDirPrimRotation()
            updateUParams()
        }
    }
    Item{id: xuqp}
    AspList{
        id: aspsList
        width: r.width
        height: xLatIzq.height//*0.5
        x:r.width//-app.fs*2
        y: zoolDataView.height
        parent: capa101//log
        moduleDirPrim: r
        visible: false
    }
    function updateUParams(){
        controlTimeFecha.gmt=app.currentGmt
        controlTimeFechaEvento.gmt=app.currentGmt
        if(r.ulat===-100.00&&r.ulon===-100.00)return
        for(var i=0;i<xuqp.children.length;i++){
            xuqp.children[i].destroy(0)
        }
        //sweg.enableLoadBack=true
        let vd=controlTimeFecha.dia
        let vm=controlTimeFecha.mes
        let va=controlTimeFecha.anio
        let vh=controlTimeFecha.hora
        let vmin=controlTimeFecha.minuto

        let vdEvento=controlTimeFechaEvento.dia
        let vmEvento=controlTimeFechaEvento.mes
        let vaEvento=controlTimeFechaEvento.anio
        let vhEvento=controlTimeFechaEvento.hora
        let vminEvento=controlTimeFechaEvento.minuto

        let vgmt=app.currentGmt//controlTimeFecha.gmt//tiGMT.t.text
        let vlon=r.lon
        let vlat=r.lat
        let vCiudad=app.currentLugar
        //r.uParamsLoaded='params_fecha_inicio_'+vd+'.'+vm+'.'+va+'.'+vh+'.'+vmin+'_fecha_evento_'+vdEvento+'.'+vmEvento+'.'+vaEvento+'.'+vhEvento+'.'+vminEvento+'.'+vgmt+'.'+vlat+'.'+vlon+'.'+vCiudad+'.'+apps.currentHsys

        r.uParamsLoaded='params_fecha_inicio_'+vd+'.'+vm+'.'+va+'.'+vh+'.'+vmin+'.'+vgmt+'.'+vlat+'.'+vlon+'.'+vCiudad+'.'+apps.currentHsys



        /*let edad=app.j.getEdadDosFechas(app.currentDate, new Date(vaEvento, vmEvento-1, vdEvento, vhEvento, vminEvento))
        let aR=[]
        aR.push('<b>Fecha:</b> '+vdEvento+'/'+vmEvento+'/'+vaEvento)
        aR.push('<b>Edad:</b> '+edad+' años')
        zoolDataView.setDataView('Dir. Primarias', zoolDataView.atLeft, aR)*/

    }
    function setDirPrimRotation(){
        //if(!r.visible  && !r.loadingFromExternal)return
        //if(apps.dev)log.lv('setDirPrimRotation()... r.loadingFromExternal: '+r.loadingFromExternal)
        r.ulat=app.currentLat
        r.ulon=app.currentLon
        r.lat=app.currentLat
        r.lon=app.currentLon

        let j=app.currentJson
        if(!j)return
        let signCircleRot=parseFloat(j.ph.h1.gdec).toFixed(2)
        //l.lv('signCircleRot:'+signCircleRot)

        //El astrólogo y matemático alemán Valentín Naibod cree perfeccionar la clave de Ptolomeo.
        let claveNaibodDeg=[0, 59, 8.33]

        //let claveNaibodDec=0.9856481481481388
        let claveDec=r.aClavesValuesDec[cbClaves.currentIndex]

        let da = new Date(controlTimeFecha.currentDate)//Momento de inicio o nacimiento.
        let db = new Date(controlTimeFechaEvento.currentDate)//Momento de evento.
        let msAnioInicio=da.getTime()
        let msAnioEvento=db.getTime()
        let resSegA=msAnioInicio / 1000 //Cálculo de segundos de inicio.
        let resSegB=msAnioEvento / 1000 //Cálculo de segundos de evento.
        let resMinA=resSegA / 60 //Cálculo de minutos de inicio.
        let resMinB=resSegB / 60 //Cálculo de minutos de evento.
        let resHoraA=resMinA / 60 //Cálculo de horas de inicio.
        let resHoraB=resMinB / 60 //Cálculo de horas de evento.
        let resDiffHoras=resHoraB-resHoraA //Cálculo de diferencia de horas.
        let resDias=resDiffHoras / 24 //Cálculo de días de diferencia.
        let resAnio=parseFloat(resDias / 365.25).toFixed(2) //Cálc. diferencia en años entre inicio y evento.
        let diffAnio=resAnio*claveDec
        let pcBackRot=parseFloat(parseFloat(signCircleRot)-parseFloat(diffAnio))

        //Cálculo de rotacion del esquema exterior para el método de Direcciones Primarias.
        let hcRot=parseFloat(parseFloat(90)-parseFloat(diffAnio))
        let hcBackRot=0.0-parseFloat(diffAnio)

        //rotation comentado en v1.5
        //sweg.objHousesCircleBack.rotation=hcBackRot
        //sweg.objPlanetsCircleBack.rotation=hcBackRot

        cloneIntToBackAndRot(parseFloat(diffAnio))

        let vdEvento=controlTimeFechaEvento.dia
        let vmEvento=controlTimeFechaEvento.mes
        let vaEvento=controlTimeFechaEvento.anio
        let vhEvento=controlTimeFechaEvento.hora
        let vminEvento=controlTimeFechaEvento.minuto

        //if(apps.dev)log.lv('controlTimeFechaEvento.onCurrentDateChanged...')
        let edad=app.j.getEdadDosFechas(app.currentDate, new Date(vaEvento, vmEvento-1, vdEvento, vhEvento, vminEvento))
        let aR=[]
        aR.push('<b>Fecha:</b> '+vdEvento+'/'+vmEvento+'/'+vaEvento)
        aR.push('<b>Edad:</b> '+edad+' años')
        zoolDataView.setDataView('Dir. Primarias', zoolDataView.atLeft, aR)

        updateAsps()

        //Lo que suceda a continuación es si ya se ha definido app.t o app.t a dirprim
        if(app.ev&&app.t==='dirprim')return
        tUpdateParamsEvento.restart()
        r.loadingFromExternal=true

    }

    function setDirPrimRotationFromExternalItem(dateInicio, dateEvento){
        r.lat=app.currentLat
        r.lon=app.currentLon
        r.ulat=app.currentLat
        r.lon=app.currentLon
        controlTimeFecha.gmt=app.currentGmt
        controlTimeFechaEvento.gmt=app.currentGmt
        controlTimeFecha.currentDate=dateInicio
        r.loadingFromExternal=true
        controlTimeFechaEvento.currentDate=dateEvento
        setDirPrimRotation()
    }



    //    function loadJsonFromArgsBack(){
    //        //if(apps.dev)log.ls('loadJsonFromArgsBack()...', 0, log.width)

    //        //return en v1.5
    //        return

    //        if(!r.visible && !r.loadingFromExternal)return
    //        r.uParamsLoaded=''

    //        let vtipo='dirprim'

    //        let d = new Date(Date.now())
    //        let ms=d.getTime()

    //        let vd=controlTimeFecha.dia
    //        let vm=controlTimeFecha.mes
    //        let va=controlTimeFecha.anio
    //        let vh=controlTimeFecha.hora
    //        let vmin=controlTimeFecha.minuto

    //        let vdEvento=controlTimeFechaEvento.dia
    //        let vmEvento=controlTimeFechaEvento.mes
    //        let vaEvento=controlTimeFechaEvento.anio
    //        let vhEvento=controlTimeFechaEvento.hora
    //        let vminEvento=controlTimeFechaEvento.minuto

    //        let vgmt=app.currentGmt//controlTimeFecha.gmt//tiGMT.t.text

    //        let vlat
    //        let vlon
    //        let valt=0

    //        vlat=app.currentLat
    //        vlon=app.currentLon

    //        let vCiudad=app.currentLugar.replace(/_/g, ' ')

    //        let nom='Direcciones Primarias '+vd+'.'+vm+'.'+va+' '+vh+'.'+vm

    //        let vhsys=apps.currentHsys

    //        let extId='id'
    //        extId+='_'+vd
    //        extId+='_'+vm
    //        extId+='_'+va
    //        extId+='_'+vh
    //        extId+='_'+vmin
    //        extId+='_'+vgmt
    //        extId+='_'+vlat
    //        extId+='_'+vlon
    //        extId+='_'+valt
    //        extId+='_'+vtipo
    //        extId+='_'+vhsys

    //        let j='{'
    //        j+='"paramsBack":{'
    //        j+='"t":"trans",'
    //        j+='"ms":'+ms+','
    //        j+='"n":"'+nom+'",'
    //        j+='"d":'+vd+','
    //        j+='"m":'+vm+','
    //        j+='"a":'+va+','
    //        j+='"h":'+vh+','
    //        j+='"min":'+vmin+','
    //        j+='"gmt":'+vgmt+','
    //        j+='"lat":'+vlat+','
    //        j+='"lon":'+vlon+','
    //        j+='"c":"'+vCiudad+'",'
    //        j+='"hsys":"'+vhsys+'",'
    //        j+='"extId":"'+extId+'"'
    //        j+='},'
    //        j+='"exts":[]'
    //        j+='}'
    //        app.currentDataBack=j

    //        app.j.loadBack(nom, vd, vm, va, vh, vmin, vgmt, vlat, vlon, valt, vCiudad, '0', vtipo, vhsys, -1, [])

    //        //if(apps.dev)log.lv('loadJsonFromArgsBack():\n'+app.fileData)
    //        //let json=JSON.parse(app.currentJsonData)
    //        //xArcsBack.rotation=360-jsonData.ph.h1.gdec+signCircle.rot//+1
    //        let rotSignCircle=sweg.objSignsCircle.rot
    //        let rotPlanetsCircle=rotSignCircle
    //        let rotHousesCircle=360-rotSignCircle//360-json.ph.h1.gdec+rotPlanetsCircle

    //        //rotation comentado en v1.5
    //        //sweg.objHousesCircleBack.rotation=rotHousesCircle

    //        controlTimeFechaEvento.visible=true
    //        if(r.loadingFromExternal){
    //            tWaitLoadExterior.restart()
    //        }
    //        r.loadingFromExternal=false
    //    }

    function cloneIntToBackAndRot(deg){
        let json=app.currentJson
        //if(apps.dev)log.lv('app.currentJson: '+JSON.stringify(app.currentJson, null, 2))

        //Atención! Se debe definir app.t='dirprim'
        //y sweg.dirPrimRot antes de llamar
        //a la función sweg.loadSweJsonBack(...)
        sweg.dirPrimRot=deg
        app.t='dirprim'

        //La función sweg.loadSweJsonBack(...) espera un string con datos del tipo json NO parseado.
        sweg.loadSweJsonBack(JSON.stringify(app.currentJson, null, 2))



        app.ev=true
    }
    function updateAsps(){
        //
        //log.clear()
        log.width=xApp.width*0.2
        log.x=xApp.width*0.8
        let a=sweg.getAPD(false)
        let ab=sweg.getAPD(true)
        for(var i=0;i<a.length;i++){
            //if(i!==9)continue
            for(var ib=0;ib<a.length;ib++){
                let pInt=app.planetas[i]
                let pExt=app.planetas[ib]

                let ga=parseFloat(a[i]).toFixed(6)
                let gab=parseFloat(ab[ib]).toFixed(6)//+sweg.dirPrimRot
                let retAspType=sweg.getAspType(ga, gab, true, i, ib, pInt, pExt)

                let f=controlTimeFechaEvento.currentDate
                let sf='Fecha: '+controlTimeFechaEvento.dia+'/'+controlTimeFechaEvento.mes+'/'+controlTimeFechaEvento.anio+' '+controlTimeFechaEvento.hora+':'+controlTimeFechaEvento.minuto+'hs'


                if(retAspType>=0){
                    if(sweg.listCotasShowing.indexOf(i)>=0){
                        aspsList.addItem(retAspType, ib, i, controlTimeFechaEvento.currentDate)
                    }

//                    if(retAspType===1){
//                        log.lv(retAspType+' Conjunción\n'+pExt+'/'+pInt+': '+ga+' '+gab+' '+sf+'\n')

//                    }else if(retAspType===2){
//                        log.lv(retAspType+' Oposición\n'+pExt+'/'+pInt+': '+ga+' '+gab+' '+sf+'\n')
//                        //aspsList.addItem(1, 0, 0, controlTimeFechaEvento.currentDate)
//                    }else if(retAspType===3){
//                        log.lv(retAspType+' Cuadratura\n'+pExt+'/'+pInt+': '+ga+' '+gab+' '+sf+'\n')
//                        //aspsList.addItem(2, 0, 0, controlTimeFechaEvento.currentDate)
//                    }else{
//                        log.lv(retAspType+' '+pExt+'/'+pInt+': '+ga+' '+gab+' '+sf+'\n')
//                    }

                }

            }
        }
    }
    function setFechaEvento(d){
        controlTimeFechaEvento.currentDate=d
    }
    function enter(){
        if(botCrear.focus&&tiNombre.text!==''&&tiFecha1.text!==''&&tiFecha2.text!==''&&tiFecha3.text!==''&&tiHora1.text!==''&&tiHora2.text!==''&&tiGMT.text!==''&&tiCiudad.text!==''){
            //searchGeoLoc(true)
        }
    }
    function clear(){
        r.ulat=-100
        r.ulon=-100
        tiNombre.t.text=''
        tiFecha1.t.text=''
        tiFecha2.t.text=''
        tiFecha3.t.text=''
        //tiHora1.t.text=''
        tiHora2.t.text=''
        tiCiudad.t.text=''
        tiGMT.t.text=''
    }
    function toRight(){
        if(controlTimeFecha.focus){
            controlTimeFecha.toRight()
        }
    }
    function toLeft(){
        if(controlTimeFecha.focus){
            controlTimeFecha.toLeft()
        }
    }
    function toUp(){
        if(controlTimeFecha.focus){
            controlTimeFecha.toUp()
        }
    }
    function toDown(){
        if(controlTimeFecha.focus){
            controlTimeFecha.toDown()
        }
    }
    function setInitFocus(){
        tiNombre.t.selectAll()
        tiNombre.t.focus=true
    }

}
