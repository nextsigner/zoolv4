import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt.labs.settings 1.1
import "../../../comps" as Comps

import ZoolButton 1.2
import ZoolText 1.4
import ZoolTextInput 1.1

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor
    property alias currentIndex: lv.currentIndex
    property alias listModel: lm
    property int edadMaxima: 0
    property string jsonFull: ''
    property int svIndex: zsm.currentIndex
    property int itemIndex: -1

    property int currentAnioSelected: -1
    property int currentNumKarma: -1

    property real lat:-100.00
    property real lon:-100.00

    property real ulat:-100.00
    property real ulon:-100.00

    property int uAnio: -1

    property var uJson: ({})


    visible: zsm.aPanelsIds.indexOf(app.j.qmltypeof(r))===zsm.currentIndex
    onSvIndexChanged: {
        //        if(svIndex===itemIndex){
        //            if(edadMaxima<=0)xTit.showTi=true
        //            tF.restart()
        //        }else{
        //            tF.stop()
        //            tiAnio.focus=false
        //        }
    }
    onVisibleChanged: {
        //if(visible)zoolVoicePlayer.stop()
        if(visible){
            if(lv.count===0){
                setListLunar(parseInt(tiAnio.text), showAll.checked)
            }
            //zoolVoicePlayer.speak('Sección de Lista de Eventos Lunares.', true)
        }
    }
    Item{id:xuqp}

    Flickable{
        id: flk
        width: r.width
        height: r.height
        contentWidth: r.width
        contentHeight: colCentral.height+app.fs*2
        Column{
            id: colCentral
            anchors.horizontalCenter: parent.horizontalCenter
            Rectangle{
                id:xTit
                width: lv.width
                height: app.fs*1.5
                color: apps.fontColor
                border.width: 2
                border.color: 'white'//txtLabelTit.focus?'red':'white'
                anchors.horizontalCenter: parent.horizontalCenter
                property bool showTit: false
                property bool showTi: false
                //visible: !checkBoxRetSolar.checked
                onShowTiChanged: {
                    if(showTi){
                        tiAnio.focus=true
                        tiAnio.text=r.edadMaxima
                        tiAnio.selectAll()
                    }
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        xTit.showTit=false
                        //tShowXTit.start()
                    }
                    onExited: {
                        //xTit.showTit=false
                        //tShowXTit.start()
                    }
                    //onClicked: xTit.showTi=true
                }

                Rectangle{
                    color: parent.color
                    anchors.fill: parent
                    border.width: xTit.border.width
                    border.color: xTit.border.color
                    //visible: xTit.showTi
                    Row{
                        anchors.centerIn: parent
                        spacing: app.fs*0.5
                        ZoolText{
                            id: label
                            text:'<b>Año:</b>'
                            anchors.verticalCenter: parent.verticalCenter
                            c: apps.backgroundColor
                            fs: app.fs*0.5
                            w: app.fs
                        }
                        Rectangle{
                            id: xTiAnio
                            width: app.fs*1.5
                            height: app.fs*0.7
                            anchors.verticalCenter: parent.verticalCenter
                            color: apps.fontColor
                            border.width: 1
                            border.color: apps.backgroundColor
                            TextInput{
                                id: tiAnio
                                color: apps.backgroundColor
                                font.pixelSize: app.fs*0.5
                                width: parent.width*0.8
                                height: parent.height
                                anchors.centerIn: parent
                                validator: IntValidator {bottom: 1000; top: 3000}
                                onTextChanged: {
                                    if(focus)apps.zFocus='xLatIzq'
                                }
                                Keys.onReturnPressed: {
                                    r.enter()
                                }
                                Keys.onEnterPressed: {
                                    r.enter()
                                }
                            }
                        }

                        Comps.ButtonIcon{
                            id: botLupa
                            text: '\uf002'
                            width: app.fs
                            height: width
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                setListLunar(parseInt(tiAnio.text), showAll.checked)
                            }
                        }
                        Row{
                            spacing: app.fs*0.25
                            anchors.verticalCenter: parent.verticalCenter
                            ZoolText{
                                text:showAll.checked?'<b>Ver Solo</b><br><b>Eclipses</b>':'<b>Ver todas</b><br><b>las lunas</b>'
                                anchors.verticalCenter: parent.verticalCenter
                                c: apps.backgroundColor
                                fs: app.fs*0.5
                                w: r.width-showAll.width-botLupa.width-xTiAnio.width-label.width-app.fs*3.5
                                t.horizontalAlignment: Text.AlignRight
                            }
                            CheckBox{
                                id: showAll
                                checked: true
                                width: app.fs*0.5
                                anchors.verticalCenter: parent.verticalCenter
                                onCheckedChanged: {
                                    setListLunar(tiAnio.text, checked)
                                }
                            }
                        }
                    }
                }

                //                ZoolText{
                //                    id: txtLabelTit
                //                    //text: parent.showTit?'Revoluciones Solares hasta los '+r.edadMaxima+' años':'Click para cargar'
                //                    text: 'Revoluciones Solares hasta los '+r.edadMaxima+' años'
                //                    font.pixelSize: app.fs*0.5
                //                    width: parent.width-app.fs
                //                    wrapMode: Text.WordWrap
                //                    color: apps.backgroundColor
                //                    //focus: true
                //                    anchors.centerIn: parent
                //                    visible: !xTit.showTi
                //                }

                //                Timer{
                //                    id: tShowXTit
                //                    running: false
                //                    repeat: false
                //                    interval: 3000
                //                    onTriggered: parent.showTit=true
                //                }

            }
            //        Item{
            //            id: xCtrls
            //            width: r.width
            //            height: app.fs
            //            visible: lv.count>0
            Row{
                id: xCtrls
                spacing: app.fs*0.25
                height: btnLoad.height+app.fs*0.2
                //anchors.centerIn: parent
                anchors.horizontalCenter: parent.horizontalCenter
                visible: lv.count>0
                ZoolButton{
                    text:'\uf060'
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked:{
                        if(lv.currentIndex>0)lv.currentIndex--
                    }
                }
                ZoolText{
                    text: parseInt(lv.currentIndex + 1)+' de '+lv.count
                    fs: app.fs*0.5
                    w: app.fs*2
                    t.horizontalAlignment: Text.AlignHCenter
                    anchors.verticalCenter: parent.verticalCenter
                    opacity: lv.currentIndex>=0?1.0:0.0
                }
                ZoolButton{
                    text:'\uf061'
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked:{
                        if(lv.currentIndex<lv.count-1)lv.currentIndex++
                    }
                }
                //                ZoolText{
                //                    text: r.currentAnioSelected//lv.currentIndex
                //                    fs: app.fs*0.5
                //                    anchors.verticalCenter: parent.verticalCenter
                //                }
                ZoolButton{
                    id: btnLoad
                    text:'Cargar'
                    //height: app.fs*0.5
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked:{
                        //setListLunar(parseInt(tiAnio.text), true)
                        //log.lv('c:'+JSON.stringify(lm.get(lv.currentIndex).json, null, 2))
                        //loadToZm(t, lm.get(lv.currentIndex).json, lm.get(lv.currentIndex).ste)
                        loadToZm(t, lm.get(lv.currentIndex).json, lm.get(lv.currentIndex).ste)
                    }
                }
            }
            //}
            ListView{
                id: lv
                spacing: app.fs*0.1
                width: r.width
                height: r.height-xTit.height-xCtrls.height//-xRetSolar.height
                anchors.horizontalCenter: parent.horizontalCenter
                delegate: compItemList
                model: lm
                //cacheBuffer: 150
                //displayMarginBeginning: cacheBuffer*app.fs*3
                clip: true
                Rectangle{
                    id: xLoading
                    anchors.fill: parent
                    color: 'red'//apps.backgroundColor
                    opacity: 0.5
                    visible: false
                    ZoolText{
                        text:'<b>Cargando...</b>'
                        c: apps.backgroundColor
                        font.pixelSize: app.fs*0.5
                        anchors.centerIn: parent
                    }
                }

            }
        }
    }
    ListModel{
        id: lm
        function addItem(vT, vJson){
            return {
                t: vT,
                json: vJson
            }
        }
    }
    Component{
        id: compItemList
        Rectangle{
            id: item
            width: lv.width-r.border.width*2
            height: txtData.contentHeight+app.fs
            color: apps.backgroundColor
            border.width: !selected?1:3
            border.color: apps.fontColor
            property bool isTit: t<0
            property bool selected: lv.currentIndex===index
            Rectangle{
                anchors.fill: parent
                color: parent.border.color
                opacity: 0.2
                visible: parent.selected
            }
            MouseArea{
                anchors.fill: parent
                enabled: !item.isTit
                onClicked: {
                    lv.currentIndex=index
                    //log.lv('\n\n\njson item: '+JSON.stringify(json, null, 2))
                    loadToZm(t, json)
                }
            }
            Row{
                spacing: app.fs*0.25
                anchors.centerIn: parent
                visible: !item.isTit
                Item{
                    id: xLuna
                    width: app.fs
                    height: width
                    anchors.verticalCenter: parent.verticalCenter
                    property int t: 0
                    Rectangle{
                        color: xLuna.t===0?'black':'white'
                        width: parent.width
                        height: width
                        radius: width*0.5
                        border.width: xLuna.t===0?1:0
                        border.color: 'white'
                        anchors.centerIn: parent
                        Rectangle{
                            color: 'black'
                            width: parent.width*1.2
                            height: width
                            radius: width*0.5
                            anchors.verticalCenter: parent.verticalCenter
                            x: 0-width+parent.width*0.5
                            visible: xLuna.t===1
                        }
                        Rectangle{
                            color: 'black'
                            width: parent.width*1.2
                            height: width
                            radius: width*0.5
                            anchors.verticalCenter: parent.verticalCenter
                            x: parent.width*0.5
                            visible: xLuna.t===3
                        }
                    }
                }
                Text{
                    id: txtData
                    text: 'Dato index: '+index
                    font.pixelSize: app.fs*0.5
                    color: apps.fontColor
                    width: parent.parent.width-xLuna.width-app.fs-app.fs*0.25
                    wrapMode: Text.WordWrap
                    textFormat: Text.RichText
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            Rectangle{
                anchors.fill: parent
                visible: item.isTit
                color: apps.fontColor
                Text{
                    text: '<b>???</b>'
                    font.pixelSize: app.fs*0.5
                    color: apps.backgroundColor
                    anchors.centerIn: parent
                    Component.onCompleted: {
                        if(t===-1){
                            text='<b>Eclipses Lunares</b>'
                        }else if(t===-2){
                            text='<b>Eclipses Solares</b>'
                        }else if(t===-3){
                            text='<b>Lunas Nuevas</b>'
                        }else if(t===-4){
                            text='<b>Lunas Llenas</b>'
                        }else{
                            text='<b>Indefinido</b>'
                        }
                    }
                }
            }
            Component.onCompleted: {
                if(item.isTit)return
                //log.lv('json: '+JSON.stringify(json, null, 2))
                let sd=''
                let d=json.d
                let m=json.m
                let a=json.a

                xLuna.t=t
                let strDMS=''
                let aDMS=[]
                let is=-1
                let gdeg=-1
                if(t===0 || t===1){
                    if(t===0){
                        is=json.moon_is
                        aDMS=app.j.deg_to_dms(json.moon_gdec)
                        gdeg=parseInt(aDMS[0]-30.00*is)
                        if(gdeg===30){
                            gdeg=0
                            if(is<11){
                                is++
                            }else{
                                is=0
                            }
                        }
                        strDMS='°'+gdeg+' \''+aDMS[1]+' \'\''+aDMS[2]
                        sd+='<b>Luna en </b>: '+zm.aSigns[is]+' '+strDMS+'<br>'

                        is=json.sun_is
                        aDMS=app.j.deg_to_dms(json.sun_gdec)
                        gdeg=parseInt(aDMS[0]-30.00*is)
                        if(gdeg===30){
                            gdeg=0
                            if(is<11){
                                is++
                            }else{
                                is=0
                            }
                        }
                        strDMS='°'+gdeg+' \''+aDMS[1]+' \'\''+aDMS[2]
                        sd+='<b>Sol en </b>: '+zm.aSigns[json.sun_is]+' '+strDMS+'<br>'
                    }
                    if(t===1){
                        is=json.is
                        aDMS=app.j.deg_to_dms(json.gdec)
                        gdeg=parseInt(aDMS[0]-30.00*is)
                        if(gdeg===30){
                            gdeg=0
                            if(is<11){
                                is++
                            }else{
                                is=0
                            }
                        }
                        strDMS='°'+gdeg+' \''+aDMS[1]+' \'\''+aDMS[2]
                        sd+='<b>Sol y Luna en </b>: '+zm.aSigns[json.is]+' '+strDMS+'<br>'
                    }
                    //sd+='<b>Signo</b>: '+JSON.stringify(json, null, 2)+'<br>'
                    sd+=t<2?'<b>Tipo:</b> '+json.type+'<br>':''
                    sd+='<b>Fecha</b>: '+json.date.d+'/'+json.date.m+'/'+json.date.a+'<br>'
                    sd+='<b>Hora</b>: '+json.date.h+':'+json.date.min+'hs'
                }else{
                    if(t===2){
                        is=json.is
                        aDMS=app.j.deg_to_dms(json.gdec)
                        gdeg=parseInt(aDMS[0]-30.00*is)
                        if(gdeg===30){
                            gdeg=0
                            if(is<11){
                                is++
                            }else{
                                is=0
                            }
                        }
                        strDMS='°'+gdeg+' \''+aDMS[1]+' \'\''+aDMS[2]
                        sd+='<b>Luna Nueva en </b>: '+zm.aSigns[json.is]+' '+strDMS+'<br>'
                        sd+='<b>Fecha</b>: '+json.d+'/'+json.m+'/'+json.a+'<br>'
                        sd+='<b>Hora</b>: '+json.h+':'+json.min+'hs'
                    }else{
                        //sd+=''+JSON.stringify(json, null, 2)
                        is=json.moon_is
                        aDMS=app.j.deg_to_dms(json.moon_gdec)
                        gdeg=parseInt(aDMS[0]-30.00*is)
                        if(gdeg===30){
                            gdeg=0
                            if(is<11){
                                is++
                            }else{
                                is=0
                            }
                        }
                        strDMS='°'+gdeg+' \''+aDMS[1]+' \'\''+aDMS[2]
                        sd+='<b>Luna Llena en </b>: '+zm.aSigns[is]+' '+strDMS+'<br>'

                        is=json.sun_is
                        aDMS=app.j.deg_to_dms(json.sun_gdec)
                        gdeg=parseInt(aDMS[0]-30.00*is)
                        if(gdeg===30){
                            gdeg=0
                            if(is<11){
                                is++
                            }else{
                                is=0
                            }
                        }
                        strDMS='°'+gdeg+' \''+aDMS[1]+' \'\''+aDMS[2]
                        sd+='<b>Sol en </b>: '+zm.aSigns[is]+' '+strDMS+'<br>'
                        sd+='<b>Fecha</b>: '+json.d+'/'+json.m+'/'+json.a+'<br>'
                        sd+='<b>Hora</b>: '+json.h+':'+json.min+'hs'
                    }

                }
                txtData.text=sd            }
        }
    }



    Rectangle{
        anchors.fill: parent
        color: apps.backgroundColor
        visible: false
        Text{
            text: 'Módulo en construcción'
            width: parent.width*0.8
            color: apps.fontColor
            font.pixelSize: app.fs*0.5
            anchors.centerIn: parent
        }
    }
    Component.onCompleted: {
        zsm.aPanelsIds.push(app.j.qmltypeof(r))
        zsm.aPanelesTits.push('Lista Lunar')
        let d = new Date(Date.now())
        r.uAnio=d.getFullYear()
        tiAnio.text=r.uAnio
    }
    function setListLunar(anio, onlyEclipses){
        if(parseInt(r.uAnio)===parseInt(anio) && JSON.stringify(r.uJson)!=='{}'){
            //log.lv('Cargando r.uJson de '+r.uAnio+'.')
            procesarDatos(r.uJson, onlyEclipses)
            return
        }
        let p=zfdm.getJsonAbsParams(false)
        let jll=JSON.parse(swe.getLunarEvents(anio, p.gmt))
        //clipboard.setText(JSON.stringify(jll, null, 2))
        procesarDatos(jll, onlyEclipses)
    }
    function procesarDatos(j, onlyEclipses){
        //log.lv('json: '+JSON.stringify(j, null, 2))
        //return
        //log.lv('onlyEclipses: '+onlyEclipses)
        r.uJson=j
        lm.clear()

        //Eclipses Lunares
        lm.append(lm.addItem(-1, {}))
        let eclipses_lunares=j.eclipses_lunares
        for(var i=0;i<eclipses_lunares.length;i++){
            //log.lv('--->'+JSON.stringify(eclipses_lunares[i].date, null, 2))
            lm.append(lm.addItem(0, eclipses_lunares[i]))
        }
        //Eclipses Solares
        lm.append(lm.addItem(-2, {}))
        let eclipses_solares=j.eclipses_solares
        for(i=0;i<eclipses_solares.length;i++){
            //log.lv('--->'+JSON.stringify(eclipses_solares[i].date, null, 2))
            lm.append(lm.addItem(1, eclipses_solares[i]))
        }
        //Lunas Nuevas
        lm.append(lm.addItem(-3, {}))
        let lunas_nuevas=j.lunas_nuevas
        for(i=0;i<lunas_nuevas.length;i++){
            //log.lv('--->'+JSON.stringify(eclipses_solares[i].date, null, 2))
            lm.append(lm.addItem(2, lunas_nuevas[i]))
        }
        //Lunas Llenas
        lm.append(lm.addItem(-4, {}))
        let lunas_llenas=j.lunas_llenas
        for(i=0;i<lunas_llenas.length;i++){
            //log.lv('--->'+JSON.stringify(eclipses_solares[i].date, null, 2))
            lm.append(lm.addItem(3, lunas_llenas[i]))
        }

        return
        let aData=[]
        let aDataTipos=[]
        let t=Object.keys(j)[0]
        let uTipo=''
        if(t==='ciclos'){
            for(var i=0;Object.keys(j).length;i++){
                let tipo=j[t][i].t
                let d=j[t][i].d
                let m=j[t][i].m
                let a=j[t][i].a
                let s=d+'-'+m+'-'+a
                if(aData.indexOf(s)<0){

                    aData.push(s)
                    if(uTipo!==tipo)lm.append(lm.addItem(j[t][i]))
                    uTipo=tipo
                    //                    if(i>0 && aDataTipos[i - 1].indexOf(tipo)<0){
                    //                        lm.append(lm.addItem(j[t][i]))
                    //                    }else if(a===parseInt(tiAnio.text)){

                    //                    }
                    //                    aDataTipos.push(tipo)
                }
            }
        }


    }
    function loadToZm(vt, json){
        let j=zfdm.getJsonAbs()
        //j.params=zfdm.getJsonAbs().params
        if(vt<2){
            j.params.d=json.date.d
            j.params.m=json.date.m
            j.params.a=json.date.a
            j.params.h=json.date.h
            j.params.min=json.date.min
        }else{
            j.params.d=json.d
            j.params.m=json.m
            j.params.a=json.a
            j.params.h=json.h
            j.params.min=json.min
        }


        j.params.t='trans'
        //log.lv('JSON Lunar: '+JSON.stringify(j, null, 2))
        zm.loadBack(j)
        let t=j.params.t
        let hsys=j.params.hsys
        let nom=j.params.n
        let d=j.params.d
        let m=j.params.m
        let a=j.params.a
        let h=j.params.h
        let min=j.params.min
        let gmt=j.params.gmt
        let lat=j.params.lat
        let lon=j.params.lon
        let alt=j.params.alt
        let ciudad=j.params.c

        let ms=j.params.ms
        let aL=zoolDataView.atLeft
        let aR=[]
        let strSep='?'
        strSep=''
        if(vt===0){
            strSep='Eclipse Lunar '+json.type
        }
        if(vt===1){
            strSep='Eclipse Solar '+json.type
        }
        if(vt===2){
            strSep='Luna Nueva'
        }
        if(vt===3){
            strSep='Luna Llena'
        }

        //aR.push('<b>'+nom+'</b>')
        aR.push(''+d+'/'+m+'/'+a)
        aR.push(''+h+':'+min+'hs')
        aR.push('<b>GMT:</b> '+gmt)
        aR.push('<b>Ubicación:</b> '+ciudad)
        aR.push('<b>Lat:</b> '+parseFloat(lat).toFixed(2))
        aR.push('<b>Lon:</b> '+parseFloat(lon).toFixed(2))
        aR.push('<b>Alt:</b> '+alt)

        zoolDataView.setDataView(strSep, aL, aR)
    }
    function enter(){
        //log.lv('Ejecutando List Lunar: '+tiAnio.text)
        setListLunar(tiAnio.text, showAll.checked)
        //if(apps.dev)log.lv('ZoolRevolutionList.enter()... lv.currentIndex: '+lv.currentIndex)
        /*if(lv.currentIndex<=0 && lv.count<1){
            //log.lv('0 ZoolRevolutionList enter()...')
            xBottomBar.objPanelCmd.runCmd('rsl '+tiAnio.text)
            return
        }else{
            //log.lv('1 ZoolRevolutionList enter()...')
            r.prepareLoad()
        }*/
    }
    function insert(){
        tiAnio.focus=true
    }
    function up(){
        if(lv.currentIndex>0)lv.currentIndex--
    }
    function down(){
        if(lv.currentIndex<lv.count)lv.currentIndex++
    }
    function desactivar(){
        tiAnio.focus=false
    }
    //-->Funciones de Control Focus y Teclado
    function toEscape(){

    }
    function isFocus(){
        return false
    }
    property bool hasUnUsedFunction: true
    function unUsed(){
        //log.lv(app.j.qmltypeof(r)+'.unUsed()...')
    }
    //-->Funciones de Control Focus y Teclado
}
