import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import "../"
import ZoolButton 1.2
import ZoolControlsTime 1.0

import ZoolNumPit.ZoolPinaculo 1.0

import "../../comps" as Comps


import ZoolNumPit.ZoolNumPitLog 1.0

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    clip: true
    color: apps.backgroundColor
    border.width: 1
    border.color: apps.fontColor

    property bool isExt: false

    property int contentWidth: r.width-app.fs*0.5

    property alias logView: zoolNumPitLog

    property bool calcForm: false
    property string jsonPath: './modules/ZoolNumPit/numv3.json'
    property string jsonNum: ''
    property var aDes: ['dato1', 'dato2', 'dato3', 'dato4', 'dato5', 'dato6', 'dato7', 'dato8', 'dato9']

    //property var currentDate
    property var currentDate
    property int currentNum: 0
    property int numKarmico: -1

    property color borderColor: apps.fontColor
    property int borderWidth: app.fs*0.15
    property int dir: -1
    property int uRot: 0

    //Número total de la fecha de nacimiento
    property int currentNumNacimiento: -1
    property int currentNumNatalicio: -1

    //Numero total de Nombre
    property int currentNumNombre: -1

    //Numero de suma de vocales de nombre
    property int currentNumNombreInt: -1
    property int currentNumNombreIntM: -1

    //Numero de suma de consonantes de nombre
    property int currentNumNombreExt: -1
    property int currentNumNombreExtM: -1

    //Número total de nacimiento y nombre
    property int currentNumDestino: -1

    //Numero de suma de letras de firma
    property int currentNumFirma: -1

    //Pinaculos
    property int currentPin1: -1
    property int currentPin2: -1
    property int currentPin3: -1
    property int currentPin4: -1
    property int currentTipoPin1: -1
    property int currentTipoPin2: -1
    property int currentTipoPin3: -1
    property int currentTipoPin4: -1

    property int currentNumPersonalidad: -1
    property int currentNumAnioPersonal: -1
    property bool esMaestro: false

    //Strings Fórmulas
    property string sFormulaInt : ''
    property string sFormulaExt: ''
    property string sFormulaNumPer : ''
    property string sFormulaNatalicio : ''

    //Strings y Variables de Arbol Genealógico
    property int currentIndexAG: -1
    property var arbolGenealogico: []
    property string currentAG : '?'
    property string currentCargaAG : 'Daton aún no especificado.'
    property var aCargasAG :  []
    property var aCargasExpAG :  []
    property var aDonesAG :  []
    property var aMetasAG :  []
    property var aPersonasSituacionesAG :  []


    property int itemIndex: -1
    visible: zsm.aPanelsIds.indexOf(app.j.qmltypeof(r))===zsm.currentIndex
    onVisibleChanged: {
        if(visible && txtDataSearchFecha.text.indexOf('NaN')>=0){
            //log.lv('t:'+txtDataSearchFecha.text)
            //log.lv('tAP:'+txtDataSearchFechaAP.text)
            ct.currentDate=zm.currentDate
        }
        //if(visible)zoolVoicePlayer.stop()
        //if(visible)zoolVoicePlayer.speak('Sección de numerología.', true)
    }
    onCurrentNumNacimientoChanged: {
        calcularPersonalidad()
    }
    onCurrentNumNombreChanged: {
        calcularPersonalidad()
    }
    onCurrentNumAnioPersonalChanged: {
        currentNum=currentNumAnioPersonal-1
    }
    onCurrentDateChanged: {
        //r.logView.l('CurrentDate: '+currentDate.toString())
        //r.logView.visible=true
        let d = currentDate.getDate()
        let m = currentDate.getMonth() + 1
        let a = currentDate.getFullYear()
        let f = d + '/' + m + '/' + a
        let aGetNums=app.j.getNums(f)
        currentNumNacimiento=aGetNums[0]
        r.numKarmico=aGetNums[3]
        r.currentNumNatalicio=d
        r.sFormulaNatalicio=aGetNums[1]
        labelFNTS.text=currentDate.toString()
        r.currentIndexAG=aGetNums[2]
        //log.ls('l103: r.currentIndexAG: '+r.currentIndexAG, 500, 500)
    }
    MouseArea{
        anchors.fill: parent
        onClicked: {
            //zpin.visible=!zpin.visible
        }
    }
    Flickable{
        id: flk
        anchors.fill: r
        contentWidth: r.width
        contentHeight: col1.height*1.1
        Column{
            id: col1
            spacing: app.fs*0.5
            anchors.horizontalCenter: parent.horizontalCenter

            Item{width: 2; height: app.fs*0.1}
            Text{
                text: '<b>Numerología</b>'
                color: apps.fontColor
                font.pixelSize: app.fs*0.65
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Button{
                text: !zpin.visible?'Ver Pinaculo':'Ocultar Pinaculo'
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    zpin.visible=!zpin.visible
                }
            }
            ZoolPinaculo{
                id: zpin
                visible: false
                w: r.width-app.fs*0.5
                modNumPit: r
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Rectangle{
                id: xForm
                width: r.contentWidth
                height: col2.height
                color: 'transparent'
                anchors.horizontalCenter: parent.horizontalCenter
                Column{
                    id: col2
                    spacing: app.fs*0.25
                    Rectangle{
                        id: xFN
                        width: xForm.width
                        height: colFN.height+app.fs
                        color: 'transparent'
                        border.width: 2
                        border.color: apps.fontColor
                        radius: app.fs*0.2
                        Column{
                            id: colFN
                            spacing: app.fs*0.5
                            anchors.centerIn: parent
                            Column{
                                spacing: app.fs*0.25
                                Text{
                                    id: labelFN
                                    text: '<b>Fecha de Nacimiento</b>'
                                    color: apps.fontColor
                                    font.pixelSize: app.fs*0.5
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                Rectangle{
                                    id:xTiFecha
                                    width: r.width-app.fs
                                    height: app.fs*1.2
                                    color: apps.backgroundColor
                                    border.width: 0
                                    border.color: apps.fontColor
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    visible: false
                                    TextInput {
                                        id: txtDataSearchFecha
                                        text: apps.numUFecha
                                        font.pixelSize: app.fs*0.5
                                        width: parent.width-app.fs*0.2
                                        wrapMode: Text.WordWrap
                                        color: apps.fontColor
                                        //focus: true
                                        //inputMask: '00.00.0000'
                                        anchors.centerIn: parent
                                        Keys.onReturnPressed: {
                                            if(text==='')return
                                            calc()
                                            //r.logView.l(getNumNomText(text))
                                        }
                                        onTextChanged: {
                                            calc()
                                        }
                                        onFocusChanged: {
                                            if(focus)selectAll()
                                        }
                                        Rectangle{
                                            width: parent.width+app.fs
                                            height: parent.height+app.fs
                                            color: 'transparent'
                                            //border.width: 2
                                            //border.color: 'white'
                                            z: parent.z-1
                                            anchors.centerIn: parent
                                        }
                                    }
                                }
                                ZoolControlsTime{
                                    id: ct
                                    verHoraMinuto: false
                                    enableGMT: false
                                    fs: app.fs
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.horizontalCenterOffset: fs*0.5
                                    onCurrentDateChanged:{
                                        if(dia<0||mes<0||anio<0)return
                                        let s=''+dia
                                        s+='.'+mes
                                        s+='.'+anio
                                        txtDataSearchFecha.text=s
                                        calc()
                                    }
                                }
                                Item{width: 2; height: app.fs*0.25}
                            }
                            Item{
                                width: app.fs
                                height: width
                                anchors.horizontalCenter: parent.horizontalCenter
                                //Este Item muestra la fecha en tipo string()
                                visible: false
                                //                                Rectangle{
                                //                                    anchors.fill: parent
                                //                                    color: 'red'
                                //                                }
                                Text{
                                    id: labelFNTS
                                    text: r.currentDate?r.currentDate.toString():''
                                    color: apps.fontColor
                                    font.pixelSize: app.fs*0.25
                                    anchors.centerIn: parent
                                    onTextChanged: {
                                        font.pixelSize=app.fs*1.5
                                        opacity=0.0
                                    }
                                    Timer{
                                        id: tShow
                                        running: false
                                        repeat: false
                                        interval: 500
                                        onTriggered: {
                                            parent.opacity=1.0
                                        }
                                    }
                                    Timer{
                                        running: parent.width>r.width-app.fs
                                        repeat: true
                                        interval: 50
                                        onTriggered: {
                                            tShow.restart()
                                            parent.font.pixelSize-=1
                                        }
                                    }
                                }
                            }
                            Item{
                                width: app.fs
                                height: width
                                anchors.horizontalCenter: parent.horizontalCenter
                                Text{
                                    id: f0
                                    color: apps.fontColor
                                    font.pixelSize: app.fs*0.6
                                    anchors.centerIn: parent
                                    onTextChanged: {
                                        font.pixelSize=app.fs*1.5
                                        opacity=0.0
                                    }
                                    Timer{
                                        id: tShowForm
                                        running: false
                                        repeat: false
                                        interval: 500
                                        onTriggered: {
                                            parent.opacity=1.0
                                        }
                                    }
                                    Timer{
                                        running: parent.width>r.width-app.fs
                                        repeat: true
                                        interval: 50
                                        onTriggered: {
                                            tShowForm.restart()
                                            parent.font.pixelSize-=1
                                        }
                                    }

                                }
                            }
                            Row{
                                spacing: app.fs*0.5
                                anchors.horizontalCenter:  parent.horizontalCenter
                                Text{
                                    text: '<b>N° Karma/Misión</b>: '
                                    color: apps.fontColor
                                    font.pixelSize: app.fs*0.5
                                    anchors.verticalCenter: parent.verticalCenter
                                    onTextChanged: {
                                        //let txt=getTipoGrupo(parseInt(r.currentNumNacimiento))
                                        //txtDataGrupo.text='AAA'+JSON.stringify(txt, null, 2)
                                        //txtDataGrupo.text='lsd faslñs als lsak añlk añlsdkf asñlk ñalk j'
                                    }
                                }
                                Rectangle{
                                    id: xNumKarma
                                    width: app.fs*2
                                    height: width
                                    radius: width*0.5
                                    border.width: app.fs*0.2
                                    border.color: apps.fontColor
                                    //rotation: 360-parent.rotation
                                    color: apps.backgroundColor
                                    anchors.verticalCenter: parent.verticalCenter
                                    Text{
                                        text: '<b>'+r.currentNumNacimiento+'</b>'
                                        font.pixelSize: parent.width*0.8
                                        color: apps.fontColor
                                        anchors.centerIn: parent
                                    }
                                }
                            }
                            Rectangle{
                                id: xNumGrupo
                                width: r.width-app.fs//*0.5
                                height: txtDataGrupo.contentHeight+app.fs*0.5
                                radius: app.fs*0.2
                                border.width: 1
                                border.color: apps.fontColor
                                color: apps.backgroundColor
                                anchors.horizontalCenter: parent.horizontalCenter
                                Text{
                                    id: txtDataGrupo
                                    //text: 'ASDF ASDF ASDF ASDF ASDF ASDF ASDF ASDF ASDF ASDF '
                                    width: parent.width-app.fs*0.5
                                    wrapMode: Text.WordWrap
                                    font.pixelSize: app.fs*0.5
                                    color: apps.fontColor
                                    anchors.centerIn: parent
                                }
                            }
                            Column{
                                spacing: app.fs*0.25
                                anchors.horizontalCenter:  parent.horizontalCenter

                                Row{
                                    spacing: app.fs*0.25
                                    anchors.horizontalCenter:  parent.horizontalCenter
                                    Text{
                                        text: 'Información:'
                                        font.pixelSize: app.fs*0.5
                                        color: apps.fontColor
                                        //anchors.verticalCenter: parent.verticalCenter
                                    }
                                    CheckBox{
                                        id: checkBoxShowInfo
                                        width: app.fs*0.5
                                        height: width
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }
                                Row{
                                    spacing: app.fs*0.25
                                    anchors.horizontalCenter:  parent.horizontalCenter
                                    ZoolButton{
                                        text: 'Ver información'
                                        fs: app.fs*0.5
                                        anchors.verticalCenter: parent.verticalCenter
                                        onClicked:{
                                            let p=zfdm.getJsonAbsParams(false)
                                            let sexo='fem'
                                            if(p.g==='m'){
                                                sexo='masc'
                                            }
                                            zm.getZiDataNum(r.currentNumNacimiento, sexo, !checkBoxShowInfo.checked)
                                        }
                                    }
                                }



                            }
                        }
                    }
                }
            }
            Rectangle{
                id: xAP
                width: r.contentWidth
                height: colAP.height+app.fs
                color: 'transparent'
                border.width: 2
                border.color: apps.fontColor
                radius: app.fs*0.2
                anchors.horizontalCenter: parent.horizontalCenter
                Column{
                    id: colAP
                    spacing: app.fs*0.5
                    anchors.centerIn: parent
                    Column{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Row{
                            spacing: app.fs*0.25
                            anchors.horizontalCenter: parent.horizontalCenter
                            Text{
                                id: labelAP
                                text: '<b>N° Año Personal</b>'
                                color: apps.fontColor
                                font.pixelSize: app.fs*0.5
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Rectangle{
                                id: xNumAP
                                width: app.fs*2
                                height: width
                                radius: width*0.5
                                border.width: app.fs*0.1
                                border.color: apps.fontColor
                                //rotation: 360-parent.rotation
                                color: apps.backgroundColor
                                anchors.verticalCenter: parent.verticalCenter
                                Text{
                                    text: '<b>'+r.currentNumAnioPersonal+'</b>'
                                    font.pixelSize: parent.width*0.6
                                    color: apps.fontColor
                                    anchors.centerIn: parent
                                }
                            }
                        }

                        Row{
                            id: rowAp
                            spacing: app.fs*0.25
                            anchors.horizontalCenter: parent.horizontalCenter
                            Text{
                                id: labelAP2
                                text: '<b>Año:</b> '
                                color: apps.fontColor
                                font.pixelSize: app.fs*0.5
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Rectangle{
                                id: xTiFechaAP
                                width: app.fs*4//r.contentWidth-labelAP2.width-xNumAP.width-parent.spacing*3
                                height: app.fs*1.2
                                color: apps.backgroundColor
                                border.width: 2
                                border.color: apps.fontColor
                                anchors.verticalCenter: parent.verticalCenter
                                TextInput {
                                    id: txtDataSearchFechaAP
                                    text: ''
                                    font.pixelSize: app.fs*0.5
                                    width: parent.width-app.fs*0.2
                                    wrapMode: Text.WordWrap
                                    color: apps.fontColor
                                    //focus: true
                                    //inputMask: '00.00.0000'
                                    anchors.centerIn: parent
                                    Keys.onReturnPressed: {
                                        if(text==='')return
                                        //r.logView.l(getNumNomText(text))
                                    }
                                    onTextChanged: {
                                        calcularAP()
                                    }
                                    onFocusChanged: {
                                        if(focus)selectAll()
                                    }
                                    Rectangle{
                                        width: parent.width+app.fs
                                        height: parent.height+app.fs
                                        color: 'transparent'
                                        //border.width: 2
                                        //border.color: 'white'
                                        z: parent.z-1
                                        anchors.centerIn: parent
                                    }
                                }
                            }
                        }
                        Text{
                            id: f1
                            color: apps.fontColor
                            font.pixelSize: app.fs*0.6
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        ComboBox{
                            id: cbTipoProg
                            width: parent.width-app.fs*0.25
                            model: ['Año Próximo', 'Año Pasado', 'Año Actual']
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Column{
                            spacing: app.fs*0.25
                            anchors.horizontalCenter:  parent.horizontalCenter
                            ZoolButton{
                                text: 'Ver Datos de '+cbTipoProg.currentText
                                fs: app.fs*0.5
                                //bgColor: 'red'
                                anchors.horizontalCenter: parent.horizontalCenter
                                onClicked:{
                                    let offSet=0
                                    if(cbTipoProg.currentIndex===0){
                                        offSet=1
                                    }
                                    if(cbTipoProg.currentIndex===1){
                                        offSet=-1
                                    }
                                    if(cbTipoProg.currentIndex===2){
                                        offSet=0
                                    }
                                    let mfecha=txtDataSearchFecha.text.split('.')
                                    if(!mfecha[0]||!mfecha[1]||!mfecha[2]||mfecha[2].length<4){
                                        f1.text=''
                                        r.currentNumAnioPersonal=-1
                                        return
                                    }
                                    let d=mfecha[0]
                                    let m=mfecha[1]
                                    let a = txtDataSearchFechaAP.text
                                    let anioPersonal= new Date(parseInt(a), parseInt(m)-1, parseInt(d))
                                    let ap=getNumYear(anioPersonal, offSet)
                                    let anioGlobal= new Date(parseInt(a), 0, 1)
                                    let ag=getNumYearGlobal(anioGlobal.getFullYear()+offSet)
                                    let aa=parseInt(a)+offSet
                                    let s='global_'+ag+'_personal_'+ap
                                    let data=getNumProg(s, ag, ap, aa)
                                    logView.clear()
                                    logView.l(data)
                                    logView.scrollToTop()
                                    logView.visible=true
                                }
                            }
                            ZoolButton{
                                text: 'Copiar Datos de '+cbTipoProg.currentText
                                fs: app.fs*0.5
                                anchors.horizontalCenter: parent.horizontalCenter
                                onClicked:{
                                    let offSet=0
                                    if(cbTipoProg.currentIndex===0){
                                        offSet=1
                                    }
                                    if(cbTipoProg.currentIndex===1){
                                        offSet=-1
                                    }
                                    if(cbTipoProg.currentIndex===2){
                                        offSet=0
                                    }
                                    let mfecha=txtDataSearchFecha.text.split('.')
                                    if(!mfecha[0]||!mfecha[1]||!mfecha[2]||mfecha[2].length<4){
                                        f1.text=''
                                        r.currentNumAnioPersonal=-1
                                        return
                                    }
                                    let d=mfecha[0]
                                    let m=mfecha[1]
                                    let a = txtDataSearchFechaAP.text
                                    let anioPersonal= new Date(parseInt(a), parseInt(m)-1, parseInt(d))
                                    let ap=getNumYear(anioPersonal, offSet)
                                    let anioGlobal= new Date(parseInt(a), 0, 1)
                                    let ag=getNumYearGlobal(anioGlobal.getFullYear()+offSet)
                                    let aa=parseInt(a)+offSet
                                    let s='global_'+ag+'_personal_'+ap
                                    let data=getNumProg(s, ag, ap, aa)
                                    let aap=parseInt(ap - 1)
                                    if(aap===0)aap=9
                                    data+='\nSi quieres comprobar si se cumplieron las predicciones numerológicas del año anterior al año '+aa+', osea el año '+parseInt(aa - 1)+', cuando el año mundial era '+parseInt(ag - 1)+' y tu año personal era '+aap+', escribeme al Whatsapp +549 11 3802 4370\n\n'
                                    clipboard.setText(data)
                                }
                            }
                        }
                    }                }
            }
            Rectangle{
                id: xFormNom
                width: r.contentWidth
                height: colNom.height+app.fs
                color: 'transparent'
                border.width: 2
                border.color: apps.fontColor
                radius: app.fs*0.2
                anchors.horizontalCenter: parent.horizontalCenter
                Column{
                    id: colNom
                    spacing: app.fs*0.75
                    anchors.centerIn: parent
                    Text{
                        text: '<b>Calcular Nombre</b>'
                        color: apps.fontColor
                        font.pixelSize: app.fs*0.5
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Rectangle{
                        id:xTiNombre
                        width: xForm.width-app.fs*0.5
                        height: txtDataSearchNom.contentHeight+app.fs*0.25
                        color: apps.backgroundColor
                        border.width: 2
                        border.color: apps.fontColor
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text{
                            text: '<b>Nombre:</b>'
                            color: apps.fontColor
                            font.pixelSize: app.fs*0.25
                            anchors.bottom: parent.top
                            anchors.bottomMargin: app.fs*0.25
                        }
                        TextInput {
                            id: txtDataSearchNom
                            //text: apps.numUNom
                            font.pixelSize: app.fs*0.5
                            width: parent.width-app.fs*0.2
                            wrapMode: Text.WordWrap
                            color: apps.fontColor
                            focus: false
                            anchors.centerIn: parent
                            Keys.onReturnPressed: {
                                if(text==='')return
                                //r.logView.l(getNumNomText(text))
                                let p=zfdm.getJsonAbsParams(false)
                                p.nc=text
                                zfdm.updateParams(p, true)
                                calc()
                                //apps.numUNom=text
                            }
                            onTextChanged: {
                                //r.logView.l(getNumNomText(text))
                                let p=zfdm.getJsonAbsParams(false)
                                p.nc=text
                                zfdm.updateParams(p, true)
                                calc()
                                //apps.numUNom=text
                            }
                            onFocusChanged: {
                                if(focus)selectAll()
                            }
                            Rectangle{
                                width: parent.width+app.fs
                                height: parent.height+app.fs
                                color: 'transparent'
                                //border.width: 2
                                //border.color: 'white'
                                z: parent.z-1
                                anchors.centerIn: parent
                            }
                        }
                    }
                    Rectangle{
                        id:xTiFirma
                        width: xForm.width-app.fs*0.5
                        height: app.fs*1.2
                        color: apps.backgroundColor
                        border.width: 2
                        border.color: apps.fontColor
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text{
                            text: '<b>Firma:</b>'
                            color: apps.fontColor
                            font.pixelSize: app.fs*0.25
                            anchors.bottom: parent.top
                            anchors.bottomMargin: app.fs*0.25
                        }
                        TextInput {
                            id: txtDataSearchFirma
                            //text: apps.numUFirma
                            font.pixelSize: app.fs*0.5
                            width: parent.width-app.fs*0.2
                            wrapMode: Text.WordWrap
                            color: apps.fontColor
                            focus: false
                            anchors.centerIn: parent
                            Keys.onReturnPressed: {
                                if(text==='')return
                                //r.logView.l(getNumNomText(text))
                                let p=zfdm.getJsonAbsParams(false)
                                p.nf=text
                                zfdm.updateParams(p, true)
                                calc()
                                //apps.numUNom=text
                            }
                            onTextChanged: {
                                //r.logView.l(getNumNomText(text))
                                let p=zfdm.getJsonAbsParams(false)
                                p.nf=text
                                zfdm.updateParams(p, true)
                                calc()
                                //apps.numUFirma=text
                            }
                            onFocusChanged: {
                                if(focus)selectAll()
                            }
                            Rectangle{
                                width: parent.width+app.fs
                                height: parent.height+app.fs
                                color: 'transparent'
                                //border.width: 2
                                //border.color: 'white'
                                z: parent.z-1
                                anchors.centerIn: parent
                            }
                        }
                    }
                }
            }
            Row{
                spacing: app.fs*0.25
                anchors.horizontalCenter: parent.horizontalCenter
                visible: false
                Text{
                    text: '<b>Género: </b>'
                    font.pixelSize: app.fs*0.5
                    color: 'white'
                    anchors.verticalCenter: parent.verticalCenter
                }
                Row{
                    anchors.verticalCenter: parent.verticalCenter
                    Text{
                        text: 'Masculino'
                        font.pixelSize: app.fs*0.25
                        color: 'white'
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    RadioButton{
                        id: rbM
                        font.pixelSize: app.fs*0.25
                        anchors.verticalCenter: parent.verticalCenter
                        checked: true
                        onCheckedChanged: {
                            if(checked){
                                rbF.checked=false
                                let p=zfdm.getJsonAbsParams(false)
                                p.g='m'
                                zfdm.updateParams(p, true)
                            }
                        }
                    }
                }
                Row{
                    anchors.verticalCenter: parent.verticalCenter
                    Text{
                        text: 'Femenino'
                        font.pixelSize: app.fs*0.25
                        color: 'white'
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    RadioButton{
                        id: rbF
                        font.pixelSize: app.fs*0.25
                        anchors.verticalCenter: parent.verticalCenter
                        checked: false
                        onCheckedChanged: {
                            if(checked){
                                rbM.checked=false
                                let p=zfdm.getJsonAbsParams(false)
                                p.g='f'
                                zfdm.updateParams(p, true)
                            }
                        }
                    }
                }
            }
            Rectangle{
                id: xResults
                width: r.contentWidth
                height: children[0].height+app.fs*0.5
                border.width: 2
                border.color: apps.fontColor
                color: 'transparent'
                radius: app.fs*0.25
                anchors.horizontalCenter: parent.horizontalCenter
                Column{
                    spacing: app.fs*0.5
                    //width: r.width-app.fs*0.5
                    width: parent.width-app.fs*0.5
                    anchors.centerIn: parent
                    opacity: r.currentNumPersonalidad!==-1&&r.currentNumNombre!==-1&&r.currentNumNombreInt!==-1&&r.currentNumNombreExt!==-1&&r.currentNumFirma!==-1&&r.currentNumDestino!==-1?1.0:0.5
                    Text{
                        text:'<b>Resultados</b> '
                        font.pixelSize: app.fs*0.75
                        color: apps.fontColor
                        //anchors.verticalCenter: parent.verticalCenter
                    }
                    Row{
                        spacing: app.fs*0.25
                        Text{
                            text:'<b>N° de </b><br><b>Misión:</b> '+r.currentNumNacimiento
                            font.pixelSize: app.fs*0.5
                            color: apps.fontColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Comps.ButtonIcon{
                            text: '\uf06e'
                            width: app.fs*0.6
                            height: width
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                let genero='m'
                                if(rbF.checked)genero='f'
                                r.logView.clear()
                                if(checkBoxFormula.checked){
                                    r.logView.l('N° de Misión '+r.currentNumNacimiento+'\n')
                                    r.logView.l('Fórmula: '+f0.text+'\n')
                                    r.logView.l(getItemJson('per'+r.currentNumNacimiento+genero))
                                }else{
                                    r.logView.l('¿Cómo es su vibración de misión '+r.currentNumNacimiento+'?\n')
                                    r.logView.l(getItemJson('per'+r.currentNumNacimiento+genero))
                                }
                                r.logView.visible=true
                                r.logView.flk.contentY=0
                                calc()
                            }
                        }
                        Comps.ButtonIcon{
                            text: '\uf0c5'
                            width: app.fs*0.6
                            height: width
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                if(txtDataSearchNom.text==='')return
                                let genero='m'
                                if(rbF.checked)genero='f'
                                let data=''
                                if(checkBoxFormula.checked){
                                    data+='Fórmula: '+f0.text+'\n\n'
                                }
                                data+=getItemJson('per'+r.currentNumNacimiento+genero)
                                clipboard.setText(data)
                                let j={}
                                j.text='Se copió el dato del número de MISIÓN se ha copiado al portapepeles.'
                                zpn.addNot(j, true, 5000)
                                calc()
                            }
                        }
                    }
                    Row{
                        spacing: app.fs*0.25
                        Text{
                            text:'<b>Personalidad:</b> '+r.currentNumPersonalidad
                            font.pixelSize: app.fs*0.5
                            color: apps.fontColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Comps.ButtonIcon{
                            text: '\uf06e'
                            width: app.fs*0.6
                            height: width
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                let genero='m'
                                if(rbF.checked)genero='f'
                                r.logView.clear()
                                if(checkBoxFormula.checked){
                                    r.logView.l('Personalidad '+r.currentNumPersonalidad+'\n')
                                    r.logView.l('Fórmula: '+r.sFormulaNumPer+'\n')
                                    r.logView.l(getItemJson('per'+r.currentNumPersonalidad+genero))
                                }else{
                                    r.logView.l('¿Cómo es su personalidad?\n')
                                    r.logView.l(getItemJson('per'+r.currentNumPersonalidad+genero))
                                }
                                r.logView.visible=true
                                r.logView.flk.contentY=0
                                calc()
                            }
                        }
                        Comps.ButtonIcon{
                            text: '\uf0c5'
                            width: app.fs*0.6
                            height: width
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                if(txtDataSearchNom.text==='')return
                                let genero='m'
                                if(rbF.checked)genero='f'
                                let data=''
                                if(checkBoxFormula.checked){
                                    data+='Personalidad '+r.currentNumPersonalidad+'\n'
                                    data+='Fórmula: '+r.sFormulaNumPer+'\n'
                                    data+=getItemJson('per'+r.currentNumPersonalidad+genero)
                                }else{
                                    data+='¿Cómo es su personalidad?\n'
                                    data+=getItemJson('per'+r.currentNumPersonalidad+genero)
                                }
                                data+=getItemJson('per'+r.currentNumPersonalidad+genero)
                                clipboard.setText(data)
                                let j={}
                                j.text='Se copió el dato de la PERSONALIDAD al portapepeles.'
                                zpn.addNot(j, true, 5000)
                                calc()
                            }
                        }
                    }
                    Rectangle{
                        //width: xResults.width-app.fs*0.25
                        width: xForm.width-app.fs*0.5
                        height: children[0].height+app.fs*0.5
                        border.width: 2
                        border.color: apps.fontColor
                        color: 'transparent'
                        Column{
                            anchors.centerIn: parent
                            spacing: app.fs*0.25
                            width: parent.width-app.fs*0.5
                            Row{
                                spacing: app.fs*0.5
                                Text{
                                    text:'<b>Nombre:</b> '+r.currentNumNombre+(r.currentNumNombre===13||r.currentNumNombre===14||r.currentNumNombre===16||r.currentNumNombre===19?' (Karmático)':(r.currentNumNombre===11||r.currentNumNombre===22||r.currentNumNombre===33||r.currentNumNombre===44?' (Maestro)':''))
                                    font.pixelSize: app.fs*0.5
                                    color: apps.fontColor
                                    anchors.verticalCenter: parent.verticalCenter

                                }
                                Comps.ButtonIcon{
                                    text: '\uf06e'
                                    width: app.fs*0.6
                                    height: width
                                    anchors.verticalCenter: parent.verticalCenter
                                    onClicked: {
                                        if(txtDataSearchNom.text==='')return
                                        r.logView.clear()
                                        r.logView.l(getNumNomText(txtDataSearchNom.text, checkBoxFormula.checked))
                                        r.logView.visible=true
                                        r.logView.flk.contentY=0
                                        calc()
                                    }
                                }
                                Comps.ButtonIcon{
                                    text: '\uf0c5'
                                    width: app.fs*0.6
                                    height: width
                                    anchors.verticalCenter: parent.verticalCenter
                                    onClicked: {
                                        if(txtDataSearchNom.text==='')return
                                        let data=''
                                        data+=getNumNomText(txtDataSearchNom.text, checkBoxFormula.checked)
                                        clipboard.setText(data)
                                        let j={}
                                        j.text='Se copió el dato del NOMBRE al portapepeles.'
                                        zpn.addNot(j, true, 5000)
                                        calc()
                                    }
                                }
                            }
                            Text{
                                id: txtDataNomIntExt
                                text:'<b>* Interior:</b> '+r.sFormulaInt+''+r.currentNumNombreInt+'<br />       <b>* Exterior:</b> '+r.sFormulaExt+''+r.currentNumNombreExt
                                width: r.width-app.fs*0.6
                                wrapMode: Text.WordWrap
                                font.pixelSize: app.fs*0.5
                                color: apps.fontColor
                                //anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                    Row{
                        spacing: app.fs*0.25
                        Text{
                            text:'<b>Natalicio:</b> '+r.currentNumNatalicio+' / '+r.sFormulaNatalicio
                            font.pixelSize: app.fs*0.5
                            color: apps.fontColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Comps.ButtonIcon{
                            text: '\uf06e'
                            width: app.fs*0.6
                            height: width
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                if(txtDataSearchNom.text==='')return
                                r.logView.clear()
                                r.logView.l(getDataJsonNumDia())
                                r.logView.visible=true
                                r.logView.flk.contentY=0
                                calc()
                            }
                        }
                        Comps.ButtonIcon{
                            text: '\uf0c5'
                            width: app.fs*0.6
                            height: width
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                if(txtDataSearchNom.text==='')return
                                clipboard.setText(getDataJsonNumDia())
                                let j={}
                                j.text='Se copió el dato del NATALICIO al portapepeles.'
                                zpn.addNot(j, true, 5000)
                                calc()
                            }
                        }
                    }
                    Row{
                        spacing: app.fs*0.25
                        Text{
                            text:'<b>Firma:</b> '+r.currentNumFirma
                            font.pixelSize: app.fs*0.5
                            color: apps.fontColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Comps.ButtonIcon{
                            text: '\uf06e'
                            width: app.fs*0.6
                            height: width
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                r.logView.clear()
                                r.logView.l('¿Cómo es la energía de su firma?\n')
                                r.logView.l(getItemJson('firma'+r.currentNumFirma))
                                r.logView.visible=true
                                r.logView.flk.contentY=0
                                calc()
                            }
                        }
                        Comps.ButtonIcon{
                            text: '\uf0c5'
                            width: app.fs*0.6
                            height: width
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                if(txtDataSearchNom.text==='')return
                                clipboard.setText(getItemJson('firma'+r.currentNumFirma))
                                let j={}
                                j.text='Se copió el dato de la FIRMA al portapepeles.'
                                zpn.addNot(j, true, 5000)
                                calc()
                            }
                        }
                    }
                    Row{
                        spacing: app.fs*0.25
                        Text{
                            text:'<b>Destino:</b> '+r.currentNumDestino
                            font.pixelSize: app.fs*0.5
                            color: apps.fontColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Comps.ButtonIcon{
                            text: '\uf06e'
                            width: app.fs*0.6
                            height: width
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                r.logView.clear()
                                r.logView.l('¿Cómo podría ser su destino?\n')
                                r.logView.l(getItemJson('dest'+r.currentNumDestino))
                                r.logView.visible=true
                                r.logView.flk.contentY=0
                                calc()
                            }
                        }
                        Comps.ButtonIcon{
                            text: '\uf0c5'
                            width: app.fs*0.6
                            height: width
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                if(txtDataSearchNom.text==='')return
                                clipboard.setText(getItemJson('dest'+r.currentNumDestino))
                                let j={}
                                j.text='Se copió el dato del DESTINO al portapepeles.'
                                zpn.addNot(j, true, 5000)
                                calc()
                            }
                        }
                    }
                }
            }
            Rectangle{
                id: xAG
                width: r.contentWidth
                height: colAG.height+app.fs
                color: 'transparent'
                border.width: 2
                border.color: apps.fontColor
                radius: app.fs*0.2
                anchors.horizontalCenter: parent.horizontalCenter
                Column{
                    id: colAG
                    spacing: app.fs*0.25
                    anchors.centerIn: parent
                    Text{


                        text: '<b>Tipo de Árbol Genealógico</b>'
                        width: parent.parent.width-app.fs
                        wrapMode: Text.WordWrap
                        color: apps.fontColor
                        font.pixelSize: app.fs*0.6
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text{
                        text: '<b>Árbol tipo:</b> '+r.currentAG
                        width: parent.parent.width-app.fs
                        wrapMode: Text.WordWrap
                        color: apps.fontColor
                        font.pixelSize: app.fs*0.45
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Item{width: 1; height: app.fs*0.25}
                    Text{
                        text: '<b>Tipo de Carga Familiar</b>'
                        width: parent.parent.width-app.fs
                        wrapMode: Text.WordWrap
                        color: apps.fontColor
                        font.pixelSize: app.fs*0.45
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text{
                        id: txtCargaAG
                        text: r.currentCargaAG
                        width: parent.parent.width-app.fs
                        wrapMode: Text.WordWrap
                        color: apps.fontColor
                        font.pixelSize: app.fs*0.45
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
            Rectangle{
                id: xBtns
                width: r.contentWidth
                height: colBtns.height+app.fs
                color: 'transparent'
                border.width: 2
                border.color: apps.fontColor
                radius: app.fs*0.2
                anchors.horizontalCenter: parent.horizontalCenter
                Column{
                    id: colBtns
                    spacing: app.fs*0.25
                    anchors.centerIn: parent
                    Text{
                        text: '<b>Calcular</b>'
                        color: apps.fontColor
                        font.pixelSize: app.fs*0.5
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Row{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text{
                            text: '<b>Mostrar cálculo</b>'
                            color: apps.fontColor
                            font.pixelSize: app.fs*0.5
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        CheckBox{
                            id: checkBoxFormula
                            checked: apps.numShowFormula
                            anchors.verticalCenter: parent.verticalCenter
                            onCheckedChanged: apps.numShowFormula=checked
                        }
                    }
                    //                    Row{
                    //                        spacing: app.fs*0.25
                    //                        anchors.horizontalCenter: parent.horizontalCenter
                    //                        Button{
                    //                            text:  'Natalicio'
                    //                            anchors.verticalCenter: parent.verticalCenter
                    //                            onClicked: {
                    //                                if(txtDataSearchNom.text==='')return
                    //                                r.logView.clear()
                    //                                r.logView.l(getDataJsonNumDia())
                    //                                r.logView.visible=true
                    //                                r.logView.flk.contentY=0
                    //                            }
                    //                        }
                    //                    }
                    Row{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Button{
                            text:  'Años Personales'
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                r.logView.clear()
                                r.logView.l(mkDataList())
                                r.logView.visible=true
                                r.logView.flk.contentY=0
                            }
                        }
                    }
                    Button{
                        text:  'Cuadro Num. Carta'
                        anchors.horizontalCenter: parent.horizontalCenter
                        onClicked: {
                            calc()
                            let aGetNums=app.j.getNums(zm.currentFecha)
                            r.currentIndexAG=aGetNums[2]
                            r.numKarmico=aGetNums[3]
                            r.logView.clear()
                            r.logView.l(getTodo(checkBoxFormula.checked))
                            r.logView.visible=true
                            r.logView.flk.contentY=0
                            if(Qt.platform.os!=='android'){
                                clipboard.setText(r.logView.text)
                            }else{
                                r.logView.cp()
                            }
                        }
                    }
                    Button{
                        text:  'Cuadro Num. Formulario'
                        anchors.horizontalCenter: parent.horizontalCenter
                        onClicked: {
                            calc()
                            //let nf=
                            let m0=txtDataSearchFecha.text.split('.')
                            if(m0.length<3){
                                log.ls('Error! Hay un problema con la fecha.\nFecha: '+txtDataSearchFecha.text, 0, xLatIzq.width)
                                return
                            }
                            let dia=parseInt(m0[0])
                            let mes=parseInt(m0[1])
                            let anio=parseInt(m0[2])
                            let nfecha=''+dia+'/'+mes+'/'+anio
                            let aGetNums=app.j.getNums(nfecha)
                            r.currentIndexAG=aGetNums[2]
                            r.numKarmico=aGetNums[3]
                            r.logView.clear()
                            r.logView.l(getTodo(checkBoxFormula.checked))
                            r.logView.visible=true
                            r.logView.flk.contentY=0
                            if(Qt.platform.os!=='android'){
                                clipboard.setText(r.logView.text)
                            }else{
                                r.logView.cp()
                            }
                        }
                    }
                    Row{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Button{
                            text:  'Guardar todo en archivo'
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                calc()
                                let m0=txtDataSearchFecha.text.split('.')
                                if(m0.length<3){
                                    log.ls('Error! Hay un problema con la fecha.\nFecha: '+txtDataSearchFecha.text, 0, xLatIzq.width)
                                    return
                                }
                                let dia=parseInt(m0[0])
                                let mes=parseInt(m0[1])
                                let anio=parseInt(m0[2])
                                let nfecha=''+dia+'/'+mes+'/'+anio
                                let aGetNums=app.j.getNums(nfecha)
                                r.currentIndexAG=aGetNums[2]
                                r.numKarmico=aGetNums[3]
                                let folder=apps.numCurrentFolder.replace('file://', '')
                                if(!unik.folderExist(folder)){
                                    log.ls('La carpeta para guardar el archivo no existe: '+folder, 0, xApp.width*0.2)
                                    return
                                }
                                let fn=folder+'/'+(txtDataSearchNom.text).replace(/ /g,'_')+'_con_formulas.txt'
                                let fn2=folder+'/'+(txtDataSearchNom.text).replace(/ /g,'_')+'_sin_formulas.txt'

                                unik.setFile(fn2, getTodo(false))
                                unik.setFile(fn, getTodo(true))
                                r.logView.clear()
                                r.logView.l('El archivo se ha guardado en '+fn)
                                r.logView.l('El archivo se ha guardado en '+fn2)
                                r.log.visible=true
                                r.logView.flk.contentY=0
                                if(Qt.platform.os!=='android'){
                                    clipboard.setText(r.logView.text)
                                }else{
                                    r.logView.cp()
                                }
                            }
                        }

                    }
                    Button{
                        text:  'Seleccionar Carpeta'
                        anchors.horizontalCenter: parent.horizontalCenter
                        onClicked: {
                            fileDialogFolder.visible=true
                        }
                    }
                    Row{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Button{
                            text:  'Limpiar'
                            onClicked: r.logView.clear()
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Button{
                            text:  'Copiar'
                            onClicked: {
                                if(Qt.platform.os!=='android'){
                                    clipboard.setText(r.logView.text)
                                }else{
                                    r.logView.cp()
                                }
                            }
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }
        }
    }
    Timer{
        id: tCalc
        running: !r.logView.visible
        repeat: true
        interval: 250
        onTriggered: {
            //calc()
        }
    }
    FileDialog {
        id: fileDialogFolder
        title: "Seleccionar Carpeta"
        folder: apps.numCurrentFolder
        selectFolder: true
        selectMultiple: false
        onAccepted: {
            let u=fileDialogFolder.fileUrls[0]
            apps.numCurrentFolder=(""+u).replace('file://', '')
        }
        onRejected: {
            console.log("Canceled")
        }
        //Component.onCompleted: visible = true
    }
    ZoolNumPitLog{id: zoolNumPitLog; parent: capa101}
    Component.onCompleted: {
        zsm.aPanelsIds.push(app.j.qmltypeof(r))
        zsm.aPanelesTits.push('Numerología')
        let date = new Date(Date.now())
        txtDataSearchFechaAP.text=date.getFullYear()
        let a =[]
        let d = 'INICIOS, VIDA NUEVA, RENOVACIONES'
        a.push(d)
        d = 'TOMA DE DESICIONES, SALIR DE TUS FRONTERAS, LA REALIDAD SE TE PONE CARA A CARA, NO PODES ESQUIVARLA, MOMENTO DE HACERSE CARGO, ACEPTAR LA REALIDAD'
        a.push(d)
        d = 'NOTORIEDAD, BRILLO, OPCIONES, OPORTUNIDADES'
        a.push(d)
        d = 'CONSTRUCCIÓN, DISCIPLINA, TIEMPO DE PONER ORDEN EN TU VIDA'
        a.push(d)
        d = 'PROGRESO, MOVIMIENTO, SALIR DE LA ZONA DE CONFORT'
        a.push(d)
        d = 'TRABAJO EN RELACIONES, PRODUCTIVIDAD, GENERACIÓN'
        a.push(d)
        d = 'RESPONSABILIDAD Y ESTRUCTURA, ASUMIR LA PROPIA REALIDAD'
        a.push(d)
        d = 'COSECHA Y LOGROS, RETO Y CONQUISTA A SUPERAR'
        a.push(d)
        d = 'AUTOSUFICIENCIA, CONSOLIDACIÓN, CIERRE DE CICLO'
        a.push(d)
        r.aDes=a

        r.arbolGenealogico=getDataJsonArGen()['arboltipo']
        r.aCargasAG=getDataJsonArGen()['cargas']
        r.aCargasExpAG=getDataJsonArGen()['cargasExp']
        r.aDonesAG=getDataJsonArGen()['dones']
        r.aMetasAG=getDataJsonArGen()['metas']
        r.aPersonasSituacionesAG=getDataJsonArGen()['personasSituaciones']

        calc()
    }
    function bigNumToPitNum(num, retMK){
        let s=(''+num).replace('-', '')
        let m0=s.split('')
        let ret=num
        if((ret===13||ret===14||ret===16||ret===19||ret===11||ret===22||ret===33)&&retMK){
            return ret
        }
        ret=0
        for(var i=0;i<m0.length;i++){
            ret+=parseInt(m0[i])
        }
        if((ret===13||ret===14||ret===16||ret===19||ret===11||ret===22||ret===33)&&retMK){
            return ret
        }
        if(ret>9){
            s=(''+ret)
            m0=s.split('')
            ret=0
            for(i=0;i<m0.length;i++){
                ret+=parseInt(m0[i])
            }
        }
        if((ret===13||ret===14||ret===16||ret===19||ret===11||ret===22||ret===33)&&retMK){
            return ret
        }
        return ret
    }
    function bigNumToPitNumNeg(num){
        let s=(''+num).replace('-', '')
        let m0=s.split('')
        let ret=num
        if(ret===13||ret===14||ret===16||ret===19){
            return ret
        }
        ret=0
        for(var i=0;i<m0.length;i++){
            ret-=parseInt(m0[i])
        }
        if(ret===13||ret===14||ret===16||ret===19){
            return ret
        }
        if(ret<-9){
            s=(''+ret)
            m0=s.split('')
            ret=0
            for(i=0;i<m0.length;i++){
                ret-=parseInt(m0[i])
            }
        }
        if(ret===13||ret===14||ret===16||ret===19){
            return ret
        }
        return ret
    }
    function getNumFromText(text, intOext){
        let ret=-1
        let t=text.toUpperCase().replace(/ /g, '')
        let av=[]
        let ac=[]
        let ml=t.split('')

        for(var i=0;i<ml.length;i++){
            let l=ml[i]
            if(l==='A'||l==='E'||l==='I'||l==='O'||l==='U'||l==='Á'||l==='É'||l==='Í'||l==='Ó'||l==='Ú'){
                av.push(l)
            }else{
                ac.push(l)
            }
        }

        let vtv=0
        let vtc=0
        let rc=0
        if(intOext==='int'){
            for(i=0;i<av.length;i++){
                rc=gvl(av[i])
                vtv+=rc
            }
            ret=vtv
        }else{
            for(i=0;i<ac.length;i++){
                rc=gvl(ac[i])
                vtc+=rc
            }
            ret=vtc
        }
        return bigNumToPitNum(ret, true)
    }
    function getNumNomText(text, formula){
        let ret=''
        let t=text.toUpperCase().replace(/ /g, '')
        let av=[]
        let ac=[]
        let ml=t.split('')
        for(var i=0;i<ml.length;i++){
            let l=ml[i]
            if(l==='A'||l==='E'||l==='I'||l==='O'||l==='U'||l==='Á'||l==='É'||l==='Í'||l==='Ó'||l==='Ú'){
                av.push(l)
            }else{
                ac.push(l)
            }
        }
        let vtv=0
        let vtc=0
        let sfv=''
        let sfc=''
        let rc=0
        for(i=0;i<av.length;i++){
            rc=gvl(av[i])
            vtv+=rc
            if(i===0){
                sfv+=rc
            }else{
                sfv+='+'+rc
            }
        }
        sfv+='='+vtv
        for(i=0;i<ac.length;i++){
            rc=gvl(ac[i])
            vtc+=rc
            if(i===0){
                sfc+=rc
            }else{
                sfc+='+'+rc
            }
        }
        sfc+='='+vtc
        let m0

        let dataInt=''
        let dataExt=''
        let st='int'
        let st2='ext'
        let resM1=-1
        let resM2=-1
        r.currentNumNombreIntM=-1
        r.currentNumNombreExtM=-1
        r.sFormulaInt=''
        r.sFormulaExt=''
        if(vtv===11||vtv===33){
            dataInt='En su interior nació con el número Maestro '+vtv+'\n'
            dataInt+=getDataNum('intm', vtv)+'\n\n'
            m0=(''+vtv).split('')
            r.sFormulaInt='Maestro '+vtv+'='+m0[0]+'+'+m0[1]+'='
            r.currentNumNombreIntM=vtv
            //vtv=1
        }
        if(vtv===22||vtv===44){
            dataInt='En su interior nació con el número Maestro '+vtv+'\n'
            dataInt+=getDataNum('intm', vtv)+'\n\n'
            m0=(''+vtv).split('')
            r.sFormulaInt='Maestro '+vtv+'='+m0[0]+'+'+m0[1]+'='
            r.currentNumNombreIntM=vtv
        }
        if(vtc===11||vtc===33){
            dataExt='En su exterior nació con el número Maestro '+vtc+'\n'
            dataExt+=getDataNum('extm', vtc)+'\n\n'
            m0=(''+vtc).split('')
            r.sFormulaExt='Maestro '+vtc+'='+m0[0]+'+'+m0[1]+'='
            r.currentNumNombreExtM=vtc
            //vtc=1
        }
        if(vtc===22||vtc===44){
            dataExt='En su exterior nació con el número Maestro '+vtc+'\n'
            dataExt+=getDataNum('extm', vtc)+'\n\n'
            m0=(''+vtc).split('')
            r.sFormulaExt='Maestro '+vtc+'='+m0[0]+'+'+m0[1]+'='
            r.currentNumNombreExtM=vtc
            //vtc=2
        }
        if(vtv>9){
            m0=(''+vtv).split('')
            vtv=parseInt(m0[0])+parseInt(m0[1])
            sfv+='='+vtv
        }
        if(vtv>9){
            m0=(''+vtv).split('')
            vtv=parseInt(m0[0])+parseInt(m0[1])
            sfv+='='+vtv
        }
        if(vtc>9){
            m0=(''+vtc).split('')
            vtc=parseInt(m0[0])+parseInt(m0[1])
            sfc+='='+vtc
        }
        if(vtc>9){
            m0=(''+vtc).split('')
            vtc=parseInt(m0[0])+parseInt(m0[1])
            sfc+='='+vtc
        }
        //r.logView.l('st:'+st+' vtv:'+vtv)
        if(r.currentNumNombreIntM===-1){
            dataInt+=getDataNum(st, vtv)
        }else{
            dataInt+=getDataNum('intm', r.currentNumNombreIntM)
        }

        r.currentNumNombreInt=vtv
        //r.logView.l('st2:'+st2+' vtc: '+vtc)
        if(r.currentNumNombreExtM===-1){
            dataExt+=getDataNum(st2, vtc)
        }else{
            dataExt+=getDataNum('extm', r.currentNumNombreExtM)
        }
        r.currentNumNombreExt=vtc
        let nunNombre=r.currentNumNombreInt+r.currentNumNombreExt
        if(nunNombre>9){
            m0=(''+nunNombre).split('')
            nunNombre=parseInt(m0[0]) + parseInt(m0[1])
        }
        if(nunNombre>9){
            m0=(''+nunNombre).split('')
            nunNombre=parseInt(m0[0]) + parseInt(m0[1])
        }
        if(nunNombre>9){
            m0=(''+nunNombre).split('')
            nunNombre=parseInt(m0[0]) + parseInt(m0[1])
        }
        r.currentNumNombre=bigNumToPitNum(nunNombre, true)
        let numDestino=nunNombre + r.currentNumFirma
        if(numDestino>9){
            m0=(''+numDestino).split('')
            numDestino=parseInt(m0[0]) + parseInt(m0[1])
        }
        if(numDestino>9){
            m0=(''+numDestino).split('')
            numDestino=parseInt(m0[0]) + parseInt(m0[1])
        }
        if(numDestino>9){
            m0=(''+numDestino).split('')
            numDestino=parseInt(m0[0]) + parseInt(m0[1])
        }
        r.currentNumDestino=numDestino

        if(formula){
            ret+='Vocales: '+av.toString()+'\n'
            ret+='Fórmula de Vocales: '+sfv+'\n'
            ret+='Vibración '+dataInt+'\n'
            ret+='\n'
            ret+='Consonantes: '+ac.toString()+'\n'
            ret+='Fórmula de Consonantes: '+sfc+'\n'
            ret+='Vibración '+dataExt+'\n'
        }else{
            ret+='¿Cómo es la forma de ser de '+txtDataSearchNom.text+' por dentro?\n\n'+dataInt+'\n\n'
            ret+='¿Cómo es la forma de ser de '+txtDataSearchNom.text+' hacia afuera?\n\n'+dataExt+'\n\n'
        }
        return ret
    }
    function setNumFirma(){
        let t=txtDataSearchFirma.text.toUpperCase().replace(/ /g, '')//.replace(/./g, '')
        let av=[]
        let ml=t.split('')
        //console.log('vtv ap:'+ml)
        for(var i=0;i<ml.length;i++){
            let l=ml[i]
            av.push(l)
        }
        let rc=0
        let vtv=0
        for(i=0;i<av.length;i++){
            rc=gvl(av[i])
            vtv+=rc
            //console.log('vtv firma:'+vtv)
        }

        let m0
        if(vtv===11||vtv===33){
            let dataInt='En su interior nació con el número Maestro '+vtv+'\n'
            dataInt+=getDataNum('intm', vtv)+'\n\n'
            //vtv=1
        }
        if(vtv===22||vtv===44){
            return vtv
        }
        if(vtv>9){
            m0=(''+vtv).split('')
            vtv=parseInt(m0[0])+parseInt(m0[1])

        }
        if(vtv>9){
            m0=(''+vtv).split('')
            vtv=parseInt(m0[0])+parseInt(m0[1])
        }
        return vtv
    }
    function getDataJsonNumDia(){
        let ret=''
        let mfecha=txtDataSearchFecha.text.split('.')
        if(!mfecha[0]||!mfecha[1]||!mfecha[2]||mfecha[2].length<4){
            return ret
        }
        let stringDia=''
        let dia=parseInt(mfecha[0])
        if(dia>0&&dia<=31){
            stringDia=getDataNumDia(dia)
            ret+='Natalicio en día '+dia+': '+stringDia
        }
        return ret
    }
    function getDataNum(t, v){
        //r.logView.l('t:'+t)
        //r.logView.l('v:'+v)
        let ret='?'
        let jsonString
        if(r.jsonNum===''){
            r.jsonNum=unik.getFile(r.jsonPath)
        }
        jsonString=r.jsonNum.replace(/\n/g, ' ')
        let json=JSON.parse(jsonString)

        ret=json[''+t+''+v]
        return ret
    }
    function getDataNumDia(dia){
        let ret='?'
        let jsonString
        if(r.jsonNum===''){
            r.jsonNum=unik.getFile(r.jsonPath)
        }
        jsonString=r.jsonNum.replace(/\n/g, ' ')
        let json=JSON.parse(jsonString)

        ret=json['d'+dia]
        return ret
    }
    function getItemJson(i){
        let ret='?'
        let jsonString
        if(r.jsonNum===''){
            r.jsonNum=unik.getFile(r.jsonPath)
        }
        jsonString=r.jsonNum.replace(/\n/g, ' ')
        let json=JSON.parse(jsonString)

        ret=json[i]
        return ret
    }
    function getDataJsonArGen(){
        let ret='?'
        let jsonString
        jsonString=unik.getFile(r.jsonPath)
        jsonString=jsonString.replace(/\n/g, ' ')
        let json=JSON.parse(jsonString)

        ret=json['argen']
        return ret
    }
    function gvl(l){
        let r=0
        let col1=['A', 'J', 'R']
        let col2=['B', 'K', 'S']
        let col3=['C', 'L', 'T']
        let col4=['D', 'M', 'U']
        let col5=['E', 'N', 'V']
        let col6=['F', 'Ñ', 'W']
        let col7=['G', 'O', 'X']
        let col8=['H', 'P', 'Y']
        let col9=['I', 'Q', 'Z']
        if(col1.indexOf(l)>=0){
            r=1
        }else if(col2.indexOf(l)>=0){
            r=2
        }else if(col3.indexOf(l)>=0){
            r=3
        }else if(col4.indexOf(l)>=0){
            r=4
        }else if(col5.indexOf(l)>=0){
            r=5
        }else if(col6.indexOf(l)>=0){
            r=6
        }else if(col7.indexOf(l)>=0){
            r=7
        }else if(col8.indexOf(l)>=0){
            r=8
        }else if(col9.indexOf(l)>=0){
            r=9
        }else{
            r=9
        }
        return r
    }
    function mkDataList(){
        let ret=''
        let mfecha=txtDataSearchFecha.text.split('.')
        if(!mfecha[0]||!mfecha[1]||!mfecha[2]||mfecha[2].length<4){
            return ret
        }
        var ai=parseInt(mfecha[2])
        var d =parseInt(mfecha[0])
        var m =parseInt(mfecha[1])
        var sformTodo='Ciclo de Vida Numerológico\n\n'
        //return
        for(var i=ai;i<ai+101;i++){
            var currentNumAP=-1
            var sform=''
            let a = i
            let sf=''+d+'/'+m+'/'+a
            //let aGetNums=app.j.getNums(sf)
            //currentNumAnioPersonal=aGetNums[0]
            let msfd=(''+d).split('')
            let sfd=''+msfd[0]
            if(msfd.length>1){
                sfd +='+'+msfd[1]
            }
            let msfm=(''+m).split('')
            let sfm=''+msfm[0]
            if(msfm.length>1){
                sfm +='+'+msfm[1]
            }
            //let msform=(''+a).split('')
            let msfa=(''+a).split('')
            let sfa=''+msfa[0]
            if(msfa.length>1){
                sfa +='+'+msfa[1]
            }
            if(msfa.length>2){
                sfa +='+'+msfa[2]
            }
            if(msfa.length>3){
                sfa +='+'+msfa[3]
            }
            let sform= sfd + '+' + sfm + '+' + sfa//msform[0] + '+' + msform[1] + '+'  + msform[2]+ '+'  + msform[3]
            let sum=0
            let mSum=sform.split('+')
            for(var i2=0;i2<mSum.length;i2++){
                sum+=parseInt(mSum[i2])
            }
            let mCheckSum=(''+sum).split('')
            if(mCheckSum.length>1){
                let dobleDigSum=parseInt(mCheckSum[0])+parseInt(mCheckSum[1])
                sform+='='+sum+'='+dobleDigSum
                let mCheckSum2=(''+dobleDigSum).split('')
                if(mCheckSum2.length>1){
                    let dobleDigSum2=parseInt(mCheckSum2[0])+parseInt(mCheckSum2[1])
                    sform+='='+dobleDigSum2
                    currentNumAP=dobleDigSum2
                }else{
                    currentNumAP=dobleDigSum
                }
            }else{
                currentNumAP=sum
            }
            let edad=a - ai
            var sp
            if(edad===0){
                sp='Período: Desde el nacimiento '+d+'/'+m+'/'+a+' hasta el día '+d+'/'+m+'/'+parseInt(a + 1)
            }else{
                sp='Período: Desde el cumpleaños del día '+d+'/'+m+'/'+a+' hasta el día '+d+'/'+m+'/'+parseInt(a + 1)
            }
            //sformTodo+='Año: '+i+' - Edad: '+edad+' - Ciclo: '+parseInt(currentNumAP)+'\n'+sp+'\nCálculo: '+sform+'\n'+aDes[currentNumAP - 1]+'\n\n'
            sformTodo+='Año: '+i+' - Edad: '+edad+'\nAño personal de ciclo: '+parseInt(currentNumAP)+'\n'+sp+'\nCálculo: '+sform+'\n'+aDes[currentNumAP - 1]+'\n\n'
        }
        return sformTodo
    }
    function printData(nom, date){
        let genero='m'
        if(rbF.checked)genero='f'
        txtDataSearchNom.text=nom
        let d = date.getDate()
        let m = date.getMonth() + 1
        let a = date.getFullYear()
        let f = d + '/' + m + '/' + a
        let aGetNums=app.j.getNums(f)
        let vcurrentNumNacimiento=aGetNums[0]
        r.currentIndexAG=aGetNums[2]
        r.numKarmico=aGetNums[3]
        //log.ls('l1396: r.currentIndexAG: '+r.currentIndexAG, 500, 500)
        r.logView.l('Número de Karma '+vcurrentNumNacimiento+'\n')
        r.logView.l(getNumNomText(nom, checkBoxFormula.checked))
        r.logView.l('¿Cómo es su personalidad?\n\n\n\n\n\n')
        r.logView.l(getItemJson('per'+vcurrentNumNacimiento+genero))
    }
    function calcularAP(){
        r.esMaestro=false
        let mfecha=txtDataSearchFecha.text.split('.')
        if(!mfecha[0]||!mfecha[1]||!mfecha[2]||mfecha[2].length<4){
            f1.text=''
            r.currentNumAnioPersonal=-1
            return
        }
        let d=mfecha[0]
        let m=mfecha[1]
        let a = txtDataSearchFechaAP.text

        let dateForGetNumYear= new Date(parseInt(a), parseInt(m)-1, parseInt(d))
        r.currentNumAnioPersonal=getNumYear(dateForGetNumYear, 0)

        let sf=''+d+'/'+m+'/'+a
        let msfd=(''+d).split('')
        let sfd=''+msfd[0]
        if(msfd.length>1){
            sfd +='+'+msfd[1]
        }
        let msfm=(''+m).split('')
        let sfm=''+msfm[0]
        if(msfm.length>1){
            sfm +='+'+msfm[1]
        }
        //let msform=(''+a).split('')
        let msfa=(''+a).split('')
        let sfa=''+msfa[0]
        if(msfa.length>1){
            sfa +='+'+msfa[1]
        }
        if(msfa.length>2){
            sfa +='+'+msfa[2]
        }
        if(msfa.length>3){
            sfa +='+'+msfa[3]
        }
        let sform= sfd + '+' + sfm + '+' + sfa//msform[0] + '+' + msform[1] + '+'  + msform[2]+ '+'  + msform[3]
        let sum=0
        let mSum=sform.split('+')
        for(var i=0;i<mSum.length;i++){
            sum+=parseInt(mSum[i])
        }
        let mCheckSum=(''+sum).split('')
        if(mCheckSum.length>1){
            if(sum===11||sum===22||sum===33){
                r.esMaestro=true
            }
            let dobleDigSum=parseInt(mCheckSum[0])+parseInt(mCheckSum[1])
            sform+='='+sum+'='+dobleDigSum
            let mCheckSum2=(''+dobleDigSum).split('')
            if(mCheckSum2.length>1){
                let dobleDigSum2=parseInt(mCheckSum2[0])+parseInt(mCheckSum2[1])
                sform+='='+dobleDigSum2
                //currentNumAnioPersonal=dobleDigSum2
            }else{
                //currentNumAnioPersonal=dobleDigSum
            }

        }else{
            currentNumAnioPersonal=sum
        }
        f1.text=sform
        let edad=a - parseInt(txtDataSearchFechaAP.text)

        let sp='Período: Desde el cumpleaños del día '+d+'/'+m+'/'+a+' hasta el día '+d+'/'+m+'/'+parseInt(a + 1)
        //r.logView.l('Año: '+a+' - Edad: '+edad+' - Ciclo: '+parseInt(r.currentNum +1)+'\n'+sp+'\nCálculo: '+f1.text+'\n'+aDes[r.currentNum]+'\n')

    }
    function calcularPersonalidad(){
        r.sFormulaNumPer='Se reduce a un dígito la suma de los números de su fecha de nacimiento ('+r.currentNumNacimiento+') más la suma de todas las letras de su nombre ('+r.currentNumNombre+')\n'
        let ret=r.currentNumNacimiento + r.currentNumNombre
        r.sFormulaNumPer+=''+r.currentNumNacimiento +'+'+ r.currentNumNombre
        let m0
        if(ret>9){
            m0=(''+ret).split('')
            ret=parseInt(m0[0]) + parseInt(m0[1])
            r.sFormulaNumPer+='='+parseInt(m0[0]) +'+'+ parseInt(m0[1])
        }
        if(ret>9){
            m0=(''+ret).split('')
            ret=parseInt(m0[0]) + parseInt(m0[1])
            r.sFormulaNumPer+='='+parseInt(m0[0]) +'+'+ parseInt(m0[1])
        }
        if(ret>9){
            m0=(''+ret).split('')
            ret=parseInt(m0[0]) + parseInt(m0[1])
            r.sFormulaNumPer+='='+parseInt(m0[0]) +'+'+ parseInt(m0[1])
        }
        r.sFormulaNumPer+='='+ret
        r.currentNumPersonalidad=ret

        //setExtraData()
    }
    function setCurrentDate(date){
        let d = date.getDate()
        let m = date.getMonth() + 1
        let a = date.getFullYear()
        txtDataSearchFecha.text=d + '.' + m + '.' + a
        let nct=new Date(a, m-1, d)
        ct.currentDate=nct
        //        ct.dia=d
        //        ct.mes=m
        //        ct.anio=a
    }
    function setCurrentNombre(nom){
        let p=zfdm.getJsonAbsParams(false)
        if(p.nc){
            txtDataSearchNom.text=p.nc
        }else{
            txtDataSearchNom.text=nom
        }
        if(p.nf){
            txtDataSearchFirma.text=p.nf
        }else{
            txtDataSearchFirma.text='Sin firma'
        }
        if(p.g){
            if(p.g==='m'){
                rbM.checked=true
                rbF.checked=false
            }else if(p.g==='f'){
                rbM.checked=false
                rbF.checked=true
            }else{
                rbM.checked=true
                rbF.checked=false
            }
        }else{
            txtDataSearchFirma.text='Sin firma'
        }
    }
    function setNumNac(){
        let mfecha=txtDataSearchFecha.text.split('.')
        if(!mfecha[0]||!mfecha[1]||!mfecha[2]||mfecha[2].length<4){
            f0.text=''
            currentNumNacimiento=-1
            return
        }
        /*let d=mfecha[0]
        let m=mfecha[1]
        let a = mfecha[2]*/
        let d=ct.dia
        let m=ct.mes
        let a=ct.anio
        let sf=''+d+'/'+m+'/'+a
        let aGetNums=app.j.getNums(sf)
        currentNumNacimiento=aGetNums[0]
        r.numKarmico=aGetNums[3]
        r.currentIndexAG=aGetNums[2]
        //log.ls('l1518: r.currentIndexAG: '+r.currentIndexAG, 500, 500)
        let dateP = new Date(parseInt(txtDataSearchFechaAP.text), m - 1, d, 0, 1)
        //controlTimeYear.currentDate=dateP
        r.currentDate = dateP
        let msfd=(''+d).split('')
        let sfd=''+msfd[0]
        if(msfd.length>1){
            sfd +='+'+msfd[1]
        }
        let msfm=(''+m).split('')
        let sfm=''+msfm[0]
        if(msfm.length>1){
            sfm +='+'+msfm[1]
        }
        //let msform=(''+a).split('')
        let msfa=(''+a).split('')
        let sfa=''+msfa[0]
        if(msfa.length>1){
            sfa +='+'+msfa[1]
        }
        if(msfa.length>2){
            sfa +='+'+msfa[2]
        }
        if(msfa.length>3){
            sfa +='+'+msfa[3]
        }
        let sform= sfd + '+' + sfm + '+' + sfa//msform[0] + '+' + msform[1] + '+'  + msform[2]+ '+'  + msform[3]
        let sum=0
        let mSum=sform.split('+')
        for(var i=0;i<mSum.length;i++){
            sum+=parseInt(mSum[i])
        }
        let mCheckSum=(''+sum).split('')
        if(mCheckSum.length>1){
            if(sum===11||sum===22||sum===33){
                //r.esMaestro=true
            }
            let dobleDigSum=parseInt(mCheckSum[0])+parseInt(mCheckSum[1])
            sform+='='+sum+'='+dobleDigSum
            let mCheckSum2=(''+dobleDigSum).split('')
            if(mCheckSum2.length>1){
                let dobleDigSum2=parseInt(mCheckSum2[0])+parseInt(mCheckSum2[1])
                sform+='='+dobleDigSum2
                currentNumNacimiento=dobleDigSum2
            }else{
                currentNumNacimiento=dobleDigSum
            }
        }else{
            currentNumNacimiento=sum
        }
        //log.ls('r.currentNumNacimiento: '+r.currentNumNacimiento, 500, 500)
        f0.text=sform
        apps.numUFecha=txtDataSearchFecha.text
        calcularAP()
    }
    //    function setIndexAG(){
    //        let fechaConPuntos=txtDataSearchFecha.text.split('.').join('.')
    //        let d = app.j.getNums(fechaConPuntos)
    //        let ag=parseInt(d[2])
    //        r.currentIndexAG=ag
    //    }
    function calc(){
        r.currentNumFirma=setNumFirma()
        setNumNac()
        let txtSearchNum=''+ct.dia+'.'+ct.mes+'.'+ct.anio
        //let dataNombre=getNumNomText(txtDataSearchNom.text, checkBoxFormula.checked)
        let dataNombre=getNumNomText(txtSearchNum, checkBoxFormula.checked)
        setPins()
        labelFNTS.text=r.currentDate?r.currentDate.toString():''
        setExtraData()

        //Número de Nombre
        let text=txtDataSearchNom.text
        let numNomInt=getNumFromText(text, 'int')
        let numNomExt=getNumFromText(text, 'ext')
        r.currentNumNombre=bigNumToPitNum(numNomInt+numNomExt, true)
        txtDataNomIntExt.text='<b>* Interior:</b> '+numNomInt+'<br />       <b>* Exterior:</b> '+numNomExt

        //Número de Personalidad se suma el número de Karma/Misión más el número de Nombre
        r.currentNumPersonalidad=bigNumToPitNum(r.currentNumNacimiento+r.currentNumNombre, true)

        //Número de Firma
        text=txtDataSearchFirma.text
        numNomInt=getNumFromText(text, 'int')
        numNomExt=getNumFromText(text, 'ext')
        r.currentNumFirma=bigNumToPitNum(numNomInt+numNomExt, true)

        //Numero de Destino es igual a la suma de número de Nombre y número de Firma
        r.currentNumDestino=bigNumToPitNum(r.currentNumNombre+r.currentNumFirma, true)


        //Load ZoolPinaculo
        let m0=txtDataSearchFecha.text.split('.')
        let m = parseInt(m0[1])
        let d = parseInt(m0[0])
        let a = parseInt(m0[2])
        zpin.load(bigNumToPitNum(m, true), bigNumToPitNum(d, true), bigNumToPitNum(a, true), bigNumToPitNum(m+d+a, true))

    }
    function getTodo(formula){
        let m0=txtDataSearchFecha.text.split('.')
        if(m0.length<=2){
            log.lv('Error en la fecha del módulo NumPit. Elformato debería ser algo como esto: 20.6.1975')
            return
        }
        let anioNac=parseInt(m0[2])
        let ret=''
        let genero='m'
        if(rbF.checked)genero='f'
        ret+='\n\nCuadro Numerológico de '+txtDataSearchNom.text+'\n\n'
        if(formula){
            ret+='Personalidad '+r.currentNumPersonalidad+'\n'
            ret+='Fórmula: '+r.sFormulaNumPer+'\n'

            ret+=getItemJson('per'+r.currentNumPersonalidad+genero)
        }else{
            ret+='¿Cómo es su personalidad?\n\n'
            ret+=getItemJson('per'+r.currentNumPersonalidad+genero)
        }
        ret+='\n\n'

        //Número de nacimiento o karma
        if(formula){
            ret+='N° de Misión '+r.currentNumNacimiento+'\n\n'
            ret+='Fórmula: '+f0.text+'\n'
            ret+=getItemJson('per'+r.currentNumNacimiento+genero)
        }else{
            ret+='¿Cómo es su vibración de nacimiento o karma '+r.currentNumNacimiento+'?\n\n'
            ret+=getItemJson('per'+r.currentNumNacimiento+genero)
        }
        ret+='\n\n'

        //Nombre
        ret+=getNumNomText(txtDataSearchNom.text, formula)
        //ret+='\n'

        //Natalicio
        ret+=getDataJsonNumDia()
        ret+='\n\n'

        //Firma
        ret+='¿Cómo es la energía de su firma?\n\n'
        ret+=getItemJson('firma'+r.currentNumFirma)
        ret+='\n\n'

        //Destino
        ret+='¿Cómo podría ser su destino?\n\n'
        ret+=getItemJson('dest'+r.currentNumDestino)
        ret+='\n\n'

        //Árbol Genealógico Cargas
        let indexAG=r.currentIndexAG
        //log.ls('l1633_r.currentIndexAG: '+r.currentIndexAG, 500, 500)
        if(formula){
            ret+='Árbol Genealógico del tipo '+r.arbolGenealogico[indexAG]+'\n\n'
            ret+='Tipo de carga familiar: '+r.aCargasAG[indexAG]+'\n\n'
            ret+='Don, fuerza o talento para potenciar y/o utilizar en la vida: '+r.aDonesAG[indexAG]+'\n\n'
            ret+='Misión de vida o Meta que debería perseguir: '+r.aMetasAG[indexAG]+'\n\n'
            ret+='Tipo de Personas y situaciones: '+r.aPersonasSituacionesAG[indexAG]+'\n\n'
        }else{
            ret+='¿Cuál podría ser el infortunio en su vida?'+'\n'
            ret+='¿Dicho infortunio en que area de su vida le afectaría?'+'\n'
            ret+='Infortunio: '+r.aCargasAG[indexAG]+'\n\n'
            ret+='¿Cuál podría ser su don o su principal virtud a conseguir, expresar y manifestar?'+'\n'
            ret+='Don, fuerza o talento para potenciar y/o utilizar en la vida: '+r.aDonesAG[indexAG]+'\n\n'
            ret+='¿Cuál podría ser su misión o de qué manera podría brindar algo hacia sí mismo/a o a los demás?'+'\n'
            ret+='Misión de vida o Meta que debería perseguir: '+r.aMetasAG[indexAG]+'\n\n'
            ret+='¿Con qué tipo de personas o situaciones se podría encontrar muy seguido en su vida?'+'\n'
            ret+=''+r.aPersonasSituacionesAG[indexAG]+'\n\n'
        }

        //Pinaculos
        ret+='Pináculos\n\n'
        ret+='1° Pináculo del tipo '+r.currentTipoPin1+': Desde los '+r.currentPin1+' hasta '+parseInt(r.currentPin2)+' años. '
        ret+='Duración aproximada desde el año '+(parseInt(anioNac + r.currentPin1))+' hasta el año '+(parseInt(anioNac + r.currentPin2))+'.\n'
        ret+=getItemJson('pin'+r.currentTipoPin1)
        ret+='\n\n'

        ret+='2° Pináculo del tipo '+r.currentTipoPin2+': Desde los '+r.currentPin2+' hasta '+parseInt(r.currentPin3)+' años. '
        ret+='Duración aproximada desde el año '+(parseInt(anioNac + r.currentPin2))+' hasta el año '+(parseInt(anioNac + r.currentPin3))+'.\n'
        ret+=getItemJson('pin'+r.currentTipoPin2)
        ret+='\n\n'

        ret+='3° Pináculo del tipo '+r.currentTipoPin3+': Desde los '+r.currentPin3+' hasta '+parseInt(r.currentPin4)+' años. '
        ret+='Duración aproximada desde el año '+(parseInt(anioNac + r.currentPin3))+' hasta el año '+(parseInt(anioNac + r.currentPin4))+'.\n'
        ret+=getItemJson('pin'+r.currentTipoPin3)
        ret+='\n\n'

        ret+='4° Pináculo del tipo '+r.currentTipoPin4+': Desde los '+r.currentPin4+' hasta el final de la vida.\n'
        ret+='Desde el año '+(parseInt(anioNac + r.currentPin4))+' en adelante.\n'
        ret+=getItemJson('pin'+r.currentTipoPin4)
        ret+='\n\n'

        ret+='\n'


        //Lista de 100 años personales
        ret+=mkDataList()
        ret+='\n\n'

        //Créditos
        let dt=new Date(Date.now())
        ret+='Cuadro numerológico creado en fecha '+dt.toString()+'\n'
        ret+='Utilizando la aplicación NumPit desarrollada por Ricardo Martín Pizarro. Whatsapp +549 11 3802 4370. E-Mail: nextsigner@gmail.com\n'
        ret+='\n\n'
        return ret
    }
    function setPins(){
        let p1=36-r.currentNumNacimiento
        r.currentPin1=p1
        r.currentPin2=p1+9
        r.currentPin3=p1+9+9
        r.currentPin4=p1+9+9+9
        let m0

        let txtSearchNum=''+ct.dia+'.'+ct.mes+'.'+ct.anio
        //let mfecha=txtDataSearchFecha.text.split('.')
        let mfecha=txtSearchNum.split('.')

        //Calculando tipo de pináculo 1
        let tPin=parseInt(mfecha[0]) + parseInt(mfecha[1])
        if(tPin>9){
            m0=(''+tPin).split('')
            tPin=parseInt(m0[0])+parseInt(m0[1])
        }
        if(tPin>9){
            m0=(''+tPin).split('')
            tPin=parseInt(m0[0])+parseInt(m0[1])
        }
        if(tPin>9){
            m0=(''+tPin).split('')
            tPin=parseInt(m0[0])+parseInt(m0[1])
        }
        r.currentTipoPin1=tPin

        //Calculando tipo de pináculo 2
        let mAnio=(''+mfecha[2]).split('')
        tPin=parseInt(mfecha[0]) + parseInt(mAnio[0]) + parseInt(mAnio[1]) + parseInt(mAnio[2]) + parseInt(mAnio[3])
        if(tPin>9){
            m0=(''+tPin).split('')
            tPin=parseInt(m0[0])+parseInt(m0[1])
        }
        if(tPin>9){
            m0=(''+tPin).split('')
            tPin=parseInt(m0[0])+parseInt(m0[1])
        }
        if(tPin>9){
            m0=(''+tPin).split('')
            tPin=parseInt(m0[0])+parseInt(m0[1])
        }
        r.currentTipoPin2=tPin

        //Calculando tipo de pináculo 3
        tPin=r.currentTipoPin1 + r.currentTipoPin2
        if(tPin>9){
            m0=(''+tPin).split('')
            tPin=parseInt(m0[0])+parseInt(m0[1])
        }
        if(tPin>9){
            m0=(''+tPin).split('')
            tPin=parseInt(m0[0])+parseInt(m0[1])
        }
        if(tPin>9){
            m0=(''+tPin).split('')
            tPin=parseInt(m0[0])+parseInt(m0[1])
        }
        r.currentTipoPin3=tPin

        //Calculando tipo de pináculo 4
        tPin=parseInt(mfecha[1]) + parseInt(mAnio[0]) + parseInt(mAnio[1]) + parseInt(mAnio[2]) + parseInt(mAnio[3])
        if(tPin>9){
            m0=(''+tPin).split('')
            tPin=parseInt(m0[0])+parseInt(m0[1])
        }
        if(tPin>9){
            m0=(''+tPin).split('')
            tPin=parseInt(m0[0])+parseInt(m0[1])
        }
        if(tPin>9){
            m0=(''+tPin).split('')
            tPin=parseInt(m0[0])+parseInt(m0[1])
        }
        r.currentTipoPin4=tPin
    }
    function toEnter(){
        if(txtDataSearchFecha.focus){
            calc()
            return
        }
    }
    function toUp(){}
    function toDown(){}
    function toLeft(){}
    function toRight(){}
    function toTab(){}
    function updateGenero(){
        let p=zfdm.getJsonAbsParams(false)
        if(p.g==='m'){
            rbM.checked=true
            return
        }
        rbF.checked=true
    }
    function getNumProg(ctx, ag, ap, aa){
        //zpn.log(ctx)
        let tt='futuro'
        let realAA=new Date(Date.now()).getFullYear()
        if(aa===realAA){
            tt='actual'
        }
        if(aa<realAA){
            tt='pasado'
        }
        let jd=unik.getFile('modules/ZoolNumPit/num_prognosis.json').replace(/\n/g, '')
        let j=JSON.parse(jd)
        let prognosis=j.prognosis
        let dataPrognosis=prognosis[ctx]
        let s=''
        if(tt==='pasado'){
            s+='Cálculo Numerológico (No se calcula Prognosis ni futurología porque se está calculando un tiempo pasado, que ya pasó, fueron predicciones válidas hasta el 31  de Diciembre de '+aa+')\n\n'
            s+='¿Qué cosas, asuntos o situaciones se te presentaron en el año '+aa+'?\n\n'
            s+='La información que leerás a continuación, es sobre qué pudo haber sucedido en tu vida, teniendo en cuenta que el mundo iba transitando por el año mundial '+ag+' y vos vas por el año personal '+ap+'.\n\n'
            s+='Estas NO son predicciones, porque ya este año mundial '+ag+' y tu año personal '+ap+' ya ocurrieron en el pasado.\n\n'
            s+='¿Cómo se pudo haber manifestado o presentado aquel año personal '+ap+' en aquel año mundial '+ag+' del pasado?\n\n'
        }else if(tt==='actual'){
            s+='Cálculo Numerológico para Prognosis (Futorología válida solo hasta el 31 de Diciembre de '+aa+')\n\n'
            s+='¿Qué cosas, asuntos o situaciones se te estan presentando en este año '+aa+'?\n\n'
            s+='La información que leerás a continuación, es sobre qué puede estar sucediendo en tu vida, teniendo en cuenta que el mundo va por el año mundial '+ag+' y vos vas por el año personal '+ap+'.\n\n'
            s+='Predicciones al transitar un año mundial '+ag+' en tu año personal '+ap+', tal vez en este año algunas de estas cosas ya hayan ocurrido.\n\n'
            s+='¿Cómo se podría estar manifestando o presentando en este tu año personal '+ap+' en este año mundial '+ag+'?\n\n'
        }else{
            s+='Cálculo Numerológico para Prognosis (Futorología)\n\n'
            s+='¿Qué cosas, asuntos o situaciones se te presentarán en el futuro, en el año '+aa+'?\n\n'
            s+='La información que leerás a continuación, es sobre qué puede suceder en tu vida, teniendo en cuenta que el mundo irá  por el año mundial '+ag+' y vos irás por el año personal '+ap+'.\n\n'
            s+='Predicciones al transitar un año mundial '+ag+' en tu año personal '+ap+'.\n\n'
            s+='¿Cómo se podría manifestar o presentarse tu año personal '+ap+' en un año mundial '+ag+'?\n\n'
        }

        s+='Aspectos Positivos\n\n'
        for(var i=0; i < Object.keys(dataPrognosis.manifestaciones_positivas).length;i++){
            let item=dataPrognosis.manifestaciones_positivas[i]
            for(var i2=0; i2 < Object.keys(item).length;i2++){
                let tit=Object.keys(item)[i2]
                let des=item[tit]
                tit=zdm.cfl(tit).replace(/_/g, ' ')
                s+=tit+':\n'
                s+=des+'\n\n'
            }
        }
        s+='Aspectos Negativos\n\n'
        for(i=0; i < Object.keys(dataPrognosis.manifestaciones_negativas).length;i++){
            let item=dataPrognosis.manifestaciones_negativas[i]
            for(i2=0; i2 < Object.keys(item).length;i2++){
                let tit=Object.keys(item)[i2]
                let des=item[tit]
                tit=zdm.cfl(tit).replace(/_/g, ' ')
                s+=tit+':\n'
                s+=des+'\n\n'
            }
        }
        let itemGlobal=prognosis['global_'+ag]
        s+='A continuación, se explica cómo afecta un año mundial '+ag+' a todo el planeta. En base a estas vibración se calcularon las predicciones tuyas combinandolas con las de tu año personal '+ap+'.'
        s+='¿Qué asuntos y aspectos se presentan en un año mundial '+ag+'?\n\n'
        for(i=0; i < Object.keys(itemGlobal).length;i++){
            let item=itemGlobal[i]
            for(i2=0; i2 < Object.keys(item).length;i2++){
                let tit=Object.keys(item)[i2]
                let des=item[tit]
                tit=zdm.cfl(tit).replace(/_/g, ' ')
                s+=tit+':\n'
                s+=des+'\n\n'
            }
        }
        return s
    }

    function getNumYear(a, offSet) {
        //        if (!(fecha instanceof Date)) {
        //            throw new Error("El argumento debe ser un objeto de tipo Date.");
        //        }
        let fecha=new Date(a)
        fecha.setFullYear(fecha.getFullYear() + offSet)

        // Convertir la fecha a una cadena en formato "YYYYMMDD"
        var dia = fecha.getDate().toString().padStart(2, '0');
        var mes = (fecha.getMonth() + 1).toString().padStart(2, '0'); // Los meses son 0-indexados
        var anio = fecha.getFullYear().toString();
        var cadenaNumeros = anio + mes + dia;

        // Función auxiliar para sumar los dígitos de un número
        function sumarDigitos(numero) {
            return numero.toString().split('').reduce(function(acc, digito) {
                return acc + parseInt(digito, 10);
            }, 0);
        }

        // Reducir el número hasta obtener un dígito o un número maestro
        var suma = sumarDigitos(cadenaNumeros);
        while (suma > 9 && [11, 22, 33, 44, 55, 66].indexOf(suma) === -1) {
            suma = sumarDigitos(suma);
        }

        return suma;
    }
    function getNumYearGlobal(a) {
        if (typeof a !== "number" || a < 1000 || a > 9999) {
            throw new Error("El argumento debe ser un número de 4 dígitos correspondiente al año.");
        }

        // Función auxiliar para sumar los dígitos de un número
        function sumarDigitos(numero) {
            return numero.toString().split('').reduce(function(acc, digito) {
                return acc + parseInt(digito, 10);
            }, 0);
        }

        // Sumar los dígitos del año
        var suma = sumarDigitos(a);

        // Reducir el número hasta obtener un dígito o un número maestro
        while (suma > 9 && [11, 22, 33, 44, 55, 66].indexOf(suma) === -1) {
            suma = sumarDigitos(suma);
        }

        return suma;
    }

    function getTipoGrupo(n){
        let tipo=''
        let a=[]
        if(n===1||n===5||n===7||n===11){
            tipo='Mentales'
            a.push('Mayormente racionales.')
            a.push('Suelen ser solitarios, independientes.')
            a.push('Hace prevalecer la mente en el sujeto.')
            a.push('')
        }
        if(n===2||n===4||n===8||n===22){
            tipo='Materiales'
            a.push('Grupo de los negocios.')
            a.push('Orientados a acciones materiales prácticas.')
            a.push('Buscan estabilidad y seguridad.')
        }
        if(n===3||n===6||n===9){
            tipo='Emocionales'
            a.push('Creativos.')
            a.push('Emotivos.')
            a.push('Necesitan atención de los demás.')
            a.push('Orientados al públicos y servir a los demás.')
        }
        let j={}
        j.t=tipo
        j.data=a
        return j
    }
    function getNum2Digitos(f){
        let n=-1
        let m0=f.split('=')
        for(var i=m0.length-1;i>0;i--){
            if(m0[i].length===2){
                n=parseInt(m0[i])
                break
            }
        }
        return n
    }
    function getDataNumKarmico(n){
        let ret=''
        let a = []
        if(n===13||n===14||n===16||n===19){
            ret+='<b>El número '+n+' es kármico</b>'
            a.push('Se relaciona directamente con deudas contraídas en vidas pasadas por una indebida utilización de las energías.')
            a.push('Ofrecen la oportunidad de saldar los errores o tareas pendientes de existencias anteriores.')
            a.push('La misión de los números kármicos es enseñar que cada acción tiene su retribución (Ley de Causa y Efecto) y que todos tenemos la oportunidad de enmendar el camino.')
            for(var i=0;i<a.length;i++){
                ret+='<br><br>'+a[i]
            }
        }
        return ret
    }

    function setExtraData(){
        let txt=getTipoGrupo(parseInt(r.currentNumNacimiento))
        let stg='<b>Grupo: </b>'+txt.t+'<br>'
        stg+='<ul>'
        for(var i10=0;i10<txt.data.length;i10++){
            if(txt.data[i10].length>0){
                stg+='<li>'+txt.data[i10]+'</li>'
            }
        }
        stg+='</ul>'
        txtDataGrupo.text=stg

        let num2Digitos=getNum2Digitos(f0.text)
        if(num2Digitos>0){
            txtDataGrupo.text+='<br>'+getDataNumKarmico(num2Digitos)
        }
    }
    function getNumDataInfo(num){
        //Retorna JSON con p=Planeta, pc=Palabra Clave, pd=Púnto Débil y data=Matriz (Array) Descripción.
        let j={}
        j.pc=''
        j.pd=''
        j.dataPos=[]
        j.dataNeg=[]
        if(num===1){
            j.g='Mental'
            j.p='Sol'

            j.pc='Iniciador'
            j.pd='Orgullo'

            //Positivo
            j.dataPos.push('Personas originales, creativas, innovadoras, independientes, precursoras y líderes.')
            j.dataPos.push('Fuerte individualidad.')
            j.dataPos.push('Líderes natos con mucha habilidad y con capacidad para convencer y motivar en lugar de imponer.')
            j.dataPos.push('No les gusta sentirse "Uno más del montón." y ponen énfasis en hacer algo que los diferencie.')
            j.dataPos.push('Les gusta sobresalir y les molesta la mediocridad.')
            j.dataPos.push('Auto suficientes y muy seguros de sí mismos.')
            j.dataPos.push('Tienden a ser sus propios jefes. Generalmente no les gusta tener jefes o les cuesta seguir ordenes de sus superiores.')
            j.dataPos.push('Son los pioneros que toman el riesgo de hacer las cosas diferentes.')
            j.dataPos.push('Sociables y siempre están en constante auto superación.')
            j.dataPos.push('Ven el vaso medio lleno y son personas muy positivas.')
            j.dataPos.push('Sinceros y respetuosos.')
            j.dataPos.push('Entusiastas, joviales, inquietos, espontáneos y ambiciosos.')
            j.dataPos.push('Piden consejos de las personas que respetan pero solo para tomarlo como base y crear sus propios métodos.')
            j.dataPos.push('Tienden a trabajar solos o por su cuenta.')
            j.dataPos.push('Emprendedores natos, es el número más valiente y arriesgado.')
            j.dataPos.push('Son muy decididos y logran lo que se proponen.')
            j.dataPos.push('Les importa mucho su independencia.')
            j.dataPos.push('Vienen a abrir nuevos caminos para liberar a su clan.')
            j.dataPos.push('Gran curiosidad por explorar lo desconocido.')
            j.dataPos.push('Buenos para motivar e impulsar gente con su ejemplo y magnetismo.')

            //Negativo
            j.dataNeg=[]
            j.dataNeg.push('Generan dependecia. Dependen emocional o económicamente de otros. Hacen que los demás dependan de él para ser "necesario".')
            j.dataNeg.push('Mucho miedo a la soledad.')
            j.dataNeg.push('Personas egoístas y pesimistas.')
            j.dataNeg.push('Desconsiderados con las opiniones y los sentimientos de los demás.')
            j.dataNeg.push('Se vuelven dominantes y en algunas ocasiones hasta tiránicos.')
            j.dataNeg.push('Totalmente egocéntricos.')
            j.dataNeg.push('Personas muy inseguras, temerosas y miedosas.')
            j.dataNeg.push('Autoestima baja.')
            j.dataNeg.push('Necesitarán sentirse el centro de atanción y si no lo logran se retirarán del lugar de donde estén.')
            j.dataNeg.push('Actitudes prepotentes y egoistas.')
            j.dataNeg.push('Sentirán desconfianza y pesimismo.')
            j.dataNeg.push('Pasividad y miedo de emprender nuevos caminos.')
            j.dataNeg.push('Posible adicción a los juegos y apuestas.')
            j.dataNeg.push('Cuando su autoestima es muy baja podrán ser personas introvertidas, muy calladas y mediocres.')
            j.dataNeg.push('Las características negativas del 1, son las más fáciles de superar. Mientras más alto es el número más difícil es superparlo.')
        }
        if(num===2){
            j.g='Material'
            j.p='Luna'
            j.pc='Conexión'
            j.pd='La indecisión y la desconfianza.'

            //Positivo
            j.dataPos.push('Enfocados en construir relaciones sanas: Priorizan la creación de vínculos positivos en sus relaciones personales.')
            j.dataPos.push('Cooperativos y colaboradores: Tienen una gran disposición para trabajar en equipo y cooperar con los demás.')
            j.dataPos.push('Evitan riesgos: Prefieren la seguridad y evitan exponerse a situaciones de riesgo.')
            j.dataPos.push('Les gusta ser útiles: Se sienten realizados al ayudar y servir a otros.')
            j.dataPos.push('Prefieren ser seguidores: Se sienten más cómodos desempeñando roles de apoyo que liderando.')
            j.dataPos.push('Altruistas y bondadosos: Practican el altruismo y buscan la armonía en sus interacciones.')
            j.dataPos.push('Diplomáticos y conciliadores: Son hábiles para armonizar situaciones y resolver conflictos, viendo las diferentes perspectivas.')

            j.dataPos.push('Suerte y oportunidades: Tienden a tener buena suerte y a recibir oportunidades fácilmente.')
            j.dataPos.push('Habilidades para la supervivencia: Siempre encuentran la manera de satisfacer sus necesidades.')
            j.dataPos.push('Amantes del arte: Disfrutan de la música y el baile.')
            j.dataPos.push('Sensibles y románticos: Son personas muy sensibles, románticas y amorosas.')
            j.dataPos.push('Mecanismos de defensa: En ocasiones, pueden mostrar frialdad o desinterés para protegerse de la vulnerabilidad.')
            j.dataPos.push('Buscan la armonía: Prefieren vivir en un ambiente tranquilo y armonioso.')
            j.dataPos.push('Evitan el conflicto: Tienden a huir de situaciones conflictivas, ya que la violencia los abruma.')
            j.dataPos.push('Intuitivos y perceptivos: Desarrollan una gran intuición y percepción.')
            j.dataPos.push('Cualidades positivas: Son personas dulces, tiernas, comprensivas y suaves.')

            //Negativo
            j.dataNeg.push('Aislamiento social: Se desconectan de los demás y se aíslan en su propio mundo, sin sentir la necesidad de socializar.')
            j.dataNeg.push('Miedo al abandono y la traición: Experimentan un profundo temor a ser abandonados, traicionados o lastimados.')
            j.dataNeg.push('Insensibilidad emocional: Se cierran al amor y se vuelven insensibles a las necesidades de los demás, llegando incluso a ser crueles.')
            j.dataNeg.push('Insatisfacción vital: Se sienten inconformes con lo que tienen en la vida.')
            j.dataNeg.push('Estancamiento: Debido a que las cosas les llegan fácilmente, pueden dejar de esforzarse y estancarse, confiando en que todo se resolverá eventualmente.')
            j.dataNeg.push('Indecisión y aversión al riesgo: Les cuesta tomar decisiones y arriesgarse.
Miedo al juicio: Sienten un gran temor a ser juzgados por los demás.')
            j.dataNeg.push('Fantasía y evasión: Crean historias en su cabeza y viven en un mundo paralelo.')
            j.dataNeg.push('Manipulación y engaño: Son manipuladores, infieles y mentirosos.')
            j.dataNeg.push('Habilidad para la manipulación: Tienen una gran habilidad para lograr que otros o las situaciones se adapten a su conveniencia.')
            j.dataNeg.push('Victimismo: Se hacen víctimas para que otros los cuiden o protejan.')
            j.dataNeg.push('Engaño y falta de compromiso: Desarrollan el engaño y la trampa, y no cumplen sus promesas.')
            j.dataNeg.push('Autoengaño: Tienen tendencia a auto-engañarse.')
            j.dataNeg.push('Pérdida de identidad: Copian o asimilan conductas, ideas o pensamientos de otros, perdiendo su propia identidad.')
            j.dataNeg.push('Influenciabilidad: Son fácilmente influenciables.')

        }
        if(num===3){
            j.g='Emocional'
            j.p='Júpiter'
            j.pc='Creatividad'
            j.pd='Dispersión'

            //Positivo
            j.dataPos.push('Mueve tres energías: Comunicación, Creatividad y Alegría.
Gran capacidad de expresión e ingenio mental.')
            j.dataPos.push('Tienen una mente revolucionada; suelen anticipar lo que otros dirán.')
            j.dataPos.push('Positivos y optimistas.')
            j.dataPos.push('Cordiales y amistosos; no pasan desapercibidos en lugares donde hay actividad, gente y alegría.')
            j.dataPos.push('Les gusta tener público para ser escuchados.')
            j.dataPos.push('Talento y simpatía desbordantes.')
            j.dataPos.push('Simpáticos y encantadores.')
            j.dataPos.push('Habilidad para comunicarse y relacionarse con todo tipo de personas.')
            j.dataPos.push('Saben convertirse en el centro de interés dondequiera que estén.')
            j.dataPos.push('Cuando quieren caer bien, es casi imposible resistir su encanto.')
            j.dataPos.push('Genera la energía de la alegría.')
            j.dataPos.push('No les gusta estar solos')
            j.dataPos.push('Tienen facilidad para el diseño, la arquitectura, la publicidad e ingeniería.')
            j.dataPos.push('Personas artísticas, les agrada admirar la belleza especialmente las formas y colores.')
            j.dataPos.push('Grandes consejeros, los terapeutas de los amigos, la gente les cuenta sus intimidades porque inspiran confianza.')
            j.dataPos.push('Tienen poder en su palabra, la palabra correcta en el momento adecuado.')

            //Negativo
            j.dataNeg.push('No expresan. Se guardan sus pensamientos y sentimientos
para no causar problemas o ser juzgados.')
            j.dataNeg.push('No crean. Tienen miedo de crear algo nuevo y fracasar.')
            j.dataNeg.push('Generan tristeza; como una energía muy pesada que los tira.')
            j.dataNeg.push('Posibles periodos depresivos.')
            j.dataNeg.push('Conflicto con la autoridad (padres, maestros, jefes, políticos, etc.).')
            j.dataNeg.push('Deberán tener cuidado de no comprometerte en decenas de actividades e intereses, ya que tienden a dispersar su energía en cosas improductivas.')
            j.dataNeg.push('Materialistas y convenencieros, con tal de rodearse de
cosas bellas.')
            j.dataNeg.push('Critican a los demás severamente cuando se equivocan o
cometen algún error.')
            j.dataNeg.push('Hacen notar sarcásticamente las flaquezas de los otros.')
            j.dataNeg.push('Chismosos (usar la palabra para destruir).')
            j.dataNeg.push('Dramáticamente intolerantes a la crítica hacia ellos.')
            j.dataNeg.push('Prefieren alejarse cuando se sientan expuestos antes que enfrentar sus errores.')
            j.dataNeg.push('Les gusta dirigirles la vida a los demas y ser el centro de
atención.')
            j.dataNeg.push('Se vuelven inconstantes y llegan a tomar todo como un
juego.')
            j.dataNeg.push('Rara vez terminan lo que inician.')
        }
        if(num===4){
            j.g='Materiales'
            j.p='Marte'
            j.pc='Construcción'
            j.pd='Rigidez'

            //Positivo
            j.dataPos.push('Vienen a construir cimientos y estructuras.')
            j.dataPos.push('Gran capacidad de trabajo. Largas jornadas de trabajo sin cansarse.')
            j.dataPos.push('Dedicados, responsables y confiables. Infunden respeto.
Cuando se comprometen, cumplen cueste lo que cueste.')
            j.dataPos.push('Orientados a cosas prácticas y tangibles. Mejoran lo ya creado por alguien más.')
            j.dataPos.push('Generalmente lo que tienen lo consiguen por su propio esfuerzo durante la vida.')
            j.dataPos.push('Tienden a reprimir sus sentimientos y no es fácil que expresen lo que sienten.')
            j.dataPos.push('Se preocupan por mantener una imagen (Exitoso, responsable, honesto, trabajador).')
            j.dataPos.push('No les gusta mucho llamar la atención; mantienen una imagen moderada y conservadora.')
            j.dataPos.push('Imponen orden, disciplina. Trabajan bajo su propio método.
Firmes y estable, con gran atención al detalle.')
            j.dataPos.push('Grandes deportistas por su nivel de resistencia es superior al de los demás. Tienden a lo material antes que a lo espiritual; su seguridad económica es muy importante.')
            j.dataPos.push('Buscan la estabilidad: aman la rutina y la vida hogareña.')
            j.dataPos.push('Disciplinados y son altamente resistentes ante los retos.')
            j.dataPos.push('Personas responsables, leales, discretas y honestas.')
            j.dataPos.push('Defienden los conceptos arraigados y las tradiciones.
Protectores de su familia.')

            //Negativo
            j.dataNeg.push('Des-estructura y desorden.')
            j.dataNeg.push('Comodinos o flojos, con tendencia a dormir mucho. Pereza.
Pagarán para que les hagan las cosas que no les gusta hacer.')
            j.dataNeg.push('Irresponsables o inconstantes con sus tareas o labores.')
            j.dataNeg.push('Crueles; utilizan sus palabras como armas.')
            j.dataNeg.push('Inflexibles y cuadrados, demasiado rígidas y muy testarudas.')
            j.dataNeg.push('Celosos de closet; lo demuestran con insinuaciones o actitudes.')
            j.dataNeg.push('Cuando pierden el control pueden ser muy violentos y destructivos.')
            j.dataNeg.push('Se angustian si sienten que alguien puede descubrir que no son del todo la imagen que se han creado.')
            j.dataNeg.push('Des-estructura y desorden.')
            j.dataNeg.push('Comodinos o flojos, con tendencia a dormir mucho. Pereza.')
            j.dataNeg.push('Pagarán para que les hagan las cosas que no les gusta hacer.')
            j.dataNeg.push('Irresponsables o inconstantes con sus tareas o labores.
Crueles; utilizan sus palabras como armas.')
            j.dataNeg.push('Inflexibles y cuadrados, demasiado rígidas y muy testarudas.')
            j.dataNeg.push('Celosos de closet; lo demuestran con insinuaciones o actitudes.')
            j.dataNeg.push('Cuando pierden el control pueden ser muy violentos y destructivos.')
            j.dataNeg.push('Se angustian si sienten que alguien puede descubrir que no son del todo la imagen que se han creado.')
        }
        if(num===5){
            j.g='Mentales'
            j.p='Mercurio'
            j.pc='Movimiento y Libertad'
            j.pd='Inconstancia'

            //Positivo 5

            j.dataPos('Necesitan sentirse libres y no permiten que los opriman o dominen.')
            j.dataPos('Gran optimismo, inspiración y entusiasmo.
* Mentalidad ágil, dinámica y muy curiosa.')
            j.dataPos('Quieren experimentar y aceptar todo lo que sea desconocido, insólito y moderno.')
            j.dataPos('Están en constante cambio, la rutina los marchita, los apaga; son los grandes aventureros.')
            j.dataPos('Amantes de viajes, diversiones y transformación.')
            j.dataPos('Se esfuerzan constantemente por alcanzar un sentir de estar vivos.')
            j.dataPos('Gran magnetismo con el sexo opuesto. Vanidosos.')
            j.dataPos('Suelen llevarse bien con todos los números ya que se adaptan a cualquier ambiente.')
            j.dataPos('Valientes y osados, les atrae el peligro.')
            j.dataPos('Inquietos, polifacéticos, impulsivos y cambiantes.')
            j.dataPos('Corresponde al cuerpo físico. Les importa su apariencia y cuidan su cuerpo.')
            j.dataPos('Realizan muchas actividades diferentes.')
            j.dataPos('Son muy intuitivos y tienen grandes facultades psíquicas y de percepción.')
            j.dataPos('Capaces de leer a las personas que los rodean con facilidad.')
            j.dataPos('Extrovertidos; tendrán mucha facilidad para las ventas y relaciones públicas.')

            //Negativo 5
            j.dataNeg('')
            j.dataNeg('En negativo, genera dominio. Auto-restricción o dominio y control sobre los demás.')
            j.dataNeg('Suelen tener una vida difícil y conflictiva ya que atrae situaciones difíciles.')
            j.dataNeg('Les cuesta mucho encontrar el equilibrio interior.')
            j.dataNeg('Extremadamente introvertidos, rara vez los oirás hablar y pasan inadvertidos.')
            j.dataNeg('Suele tomar decisiones precipitadas porque se vuelve impaciente.')
            j.dataNeg('El más impulsivo de los números.')
            j.dataNeg('Falta de sinceridad, irresponsabilidad, egoísmo.')
            j.dataNeg('Se puede perder en los excesos de los placeres (sexo, alcohol, fiesta, comida, etc.).')
            j.dataNeg('Su afecto es superficial por su falta de compromiso.')
            j.dataNeg('Egoísta y violento. Descontento e insatisfecho.')
            j.dataNeg('Generalmente de pequeños vivieron o fueron testigos de algún abuso.')
            j.dataNeg('En la parte negativa muchos 5 indica alguna manera de abuso o violencia.')
            j.dataNeg('Gran rencor y enojo contra la vida.')
            j.dataNeg('Infieles y desleales.')
            j.dataNeg('No son solidarios y no se harán cargo de los problemas de los demás (incluso de sus hijos, socios, familia, etc.).')
            j.dataNeg('Tienden a ser vulgares en su comportamiento y forma de vestir.')
        }
        if(num===6){
            j.g='Emocional'
            j.p='Venus'
            j.pc='Unión y Equilibrio'
            j.pd='Control y sobreprotección'

            //Positivo 6
            j.dataPos.push('La armonía para ellos mismos y para las personas que quieren les es fundamental.')
            j.dataPos.push('Gran necesidad de sentirse amados y protegidos.
Sensibles.')
            j.dataPos.push('Generosos a cambio de que se sigan sus reglas.
Congruentes con lo que creen.')
            j.dataPos.push('Sentido patriótico; pueden ser activistas en pro de la justicia.')
            j.dataPos.push('Tienen la habilidad de mostrarse serenos en situaciones de riesgo o emergencia.')
            j.dataPos.push('Suelen ser personas queridas, respetadas y admiradas; crean un ambiente de paz y ayudan a las personas que los necesitan.')
            j.dataPos.push('Normalmente conservadores, (muchas veces anticuados) y tradicionalistas.')
            j.dataPos.push('Respetan y se adaptan gustosamente a las leyes
Les gusta vestir bien, comer bien y vivir confortablemente.')
            j.dataPos.push('Personas muy productivas, trabajadoras tenaces y eficientes.')
            j.dataPos.push('Tendencia a cargar desde muy joven con responsabilidades familiares muy fuertes.')
            j.dataPos.push('No permitirán que ninguno de sus seres queridos se derrumbe o decaiga.')
            j.dataPos.push('Nunca abandonan las cosas que empiezan, las continuan hasta que las terminan o concluyen.')

            //Negativo 6
            j.dataNeg.push('Grandes inseguridades y obsesiones emocionales.')
            j.dataNeg.push('Sobre-protegen o a dan de más; resuelven la vida de otros, buscando crear un vínculo de gratitud o de hacerse sentir necesarios ("comprar amor").')
            j.dataNeg.push('Si no pueden comprar el amor, se sienten devaluados o despreciados.')
            j.dataNeg.push('Muy generosos pero en forma condicionada... "Te quiero, si solo si..."')
            j.dataNeg.push('Quieren controlar hasta asfixiar, principalmente a la pareja y a los hijos.')
            j.dataNeg.push('Rescatadores de las personas con conflictos emocionales o crisis lo que provoca relaciones insanas y desgastantes, especialmente con el sexo opuesto.')
            j.dataNeg.push('Posesivos, absorbentes y egoístas.
Celosos y con tendencias a esclavizar y a castrar a otros.')
            j.dataNeg.push('Tendencia al sacrificio y a convertirse en personas sufridas y resignadas.')
            j.dataNeg.push('Hipocondríacas, para manipular la atención y el cariño de otros.')
            j.dataNeg.push('Se recomienda respetar a sus seres queridos dándoles libertad y no tratar de resolver sus problemas, volviéndolos dependientes, inseguros e inútiles.')
            j.dataNeg.push('Supersticiosos.')
        }
        return j
    }
}
