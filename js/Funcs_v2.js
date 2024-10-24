function firstRunTime(){
    log.ls('\n\nBienvenido!.\n', 0, xLatIzq.width)
    if(apps.workSpace===''){
        let jsonFolder=unik.getPath(3)+'/Zool'
        apps.workSpace=jsonFolder
        if(!unik.fileExist(jsonFolder)){
            log.ls('\nCreando carpeta de archivos:\n'+apps.workSpace, log.x, log.width)
            unik.mkdir(jsonFolder)
        }
    }
    console.log('Loading United Kingdom now...')
    console.log('JsonFolder: '+apps.workSpace)

    let d=new Date(Date.now())
    let currentUserHours=d.getHours()
    let diffHours=d.getUTCHours()
    let currentGmtUser=0
    if(currentUserHours>diffHours){
        currentGmtUser=parseFloat(currentUserHours-diffHours)
    }else{
        currentGmtUser=parseFloat(0-(diffHours-currentUserHours)).toFixed(1)
    }

    //log.ls('currentGmtUser: '+currentGmtUser, 0, xLatIzq.width)
    let dia=d.getDate()
    let mes=d.getMonth()+1
    let anio=d.getFullYear()
    let nom="Primer Inicio de Zool"
    loadFromArgs(d.getDate(), parseInt(d.getMonth() +1),d.getFullYear(), d.getHours(), d.getMinutes(), currentGmtUser,0.0,0.0,6, nom, "United Kingdom", "vn", true)


    log.ls('Al parecer es la primera vez que inicia Zool en su equipo.\n\n', 0, xLatIzq.width)
    //apps.url=apps.workSpace+'/Primer_Inicio_de_Zool.json'
    log.ls('Cargando el archivo '+apps.url+' creado por primera y única vez a modo de ejemplo.\n\n', 0, xLatIzq.width)
    log.l('\nZool se está ejecutando en la carpeta'+unik.currentFolderPath())
}

function setFs() {
    let w = Screen.width
    let h = Screen.height
    if(w===1920 && h === 1080){
        app.fs = w*0.031
    }
    if(w===1680 && h === 1050){
        app.fs = w*0.036
    }
    if(w===1400 && h === 1050){
        app.fs = w*0.041
    }
    if(w===1600 && h === 900){
        app.fs = w*0.031
    }
    if(w===1280 && h === 1024){
        app.fs = w*0.045
    }
    if(w===1440 && h === 900){
        app.fs = w*0.035
    }
    if(w===1280 && h === 800){
        app.fs = w*0.035
    }
    if(w===1152 && h === 864){
        app.fs = w*0.042
    }
    if(w===1280 && h === 720){
        app.fs = w*0.03
    }
}

//function loadFromArgsBack(d, m, a, h, min, gmt, lat, lon, alt, nom, ciudad, tipo, save){
//    app.ev=true

//    let nGmt=gmt
//    //IMPORTANTE
//    //GMT A 0 SI ES RS
//    if(tipo==='rs')nGmt=0

//    let dataMs=new Date(Date.now())
//    let j='{"paramsBack":{"t":"'+tipo+'", "ms":'+dataMs.getTime()+', "n":"'+nom+'", "d":'+d+',  "m":'+m+', "a":'+a+', "h":'+h+', "min":'+min+', "gmt":'+nGmt+', "lat":'+lat+', "lon":'+lon+', "alt":'+alt+', "c":"'+ciudad+'"}}'
//    app.t=tipo
//    j=j.replace('/, "/g', ',"')

//    let aL=zoolDataView.atLeft
//    let aR=[]
//    aR.push('<b>'+nom+'</b>')
//    aR.push(d+'/'+m+'/'+a)
//    aR.push(h+':'+min+'hs')
//    aR.push('GMT '+nGmt)
//    aR.push('<b> '+ciudad+'</b>')
//    aR.push('<b>Lat:</b> '+lat)
//    aR.push('<b>Lon:</b> '+lon)
//    aR.push('<b>Alt:</b> '+alt)

//    app.currentNomBack=nom
//    app.currentFechaBack=d+'/'+m+'/'+a
//    app.currentLugarBack=ciudad
//    app.currentGmtBack=gmt
//    app.currentLonBack=lon
//    app.currentLatBack=lat

//    if(tipo==='sin'){

//        zoolDataView.setDataView('Sinastría', aL, aR)
//    }
//    if(tipo==='rs'){
//        zoolDataView.setDataView('Rev. Solar '+a, aL, aR)
//    }
//    if(tipo==='trans'){
//        zoolDataView.setDataView('Tránsitos'+a, aL, aR)
//    }
//    if(tipo==='dirprim'){
//        zoolDataView.setDataView('Dir. Prim. '+a+'/'+m+'/'+d, aL, aR)
//    }
//    if(save){
//        let fn=apps.workSpace+'/'+nom.replace(/ /g, '_')+'.json'
//        //if(apps.dev)log.lv('loadFromArgs('+d+', '+m+', '+a+', '+h+', '+min+', '+gmt+', '+lat+', '+lon+', '+alt+', '+nom+', '+ciudad+', '+save+'): '+fn)
//        unik.setFile(fn, j)
//        loadJsonBack(fn)
//        return
//    }
//    app.currentDataBack=j
//    //if(apps.dev)log.lv('sweg.loadBack(JSON.parse(j), tipo): '+j+'\ntipo: '+tipo)
//    sweg.loadBack(JSON.parse(j), tipo)
//    //runJsonTempBack()
//}

function loadTransFromTime(date){
    let j=JSON.parse(app.currentData)
    let p=j.params
    let d=new Date(date.getTime())
    let dia=d.getDate()
    let mes=d.getMonth() + 1
    let anio=d.getFullYear()
    let hora=d.getHours()
    let minuto=d.getMinutes()
    loadFromArgsBack(dia, mes, anio, hora, minuto, p.gmt, p.lat, p.lon, p.alt?p.alt:0, 'Tránsitos '+dia+'-'+mes+'-'+anio+' '+hora+':'+minuto, p.c, 'trans', false)
    app.currentGmtBack=app.currentGmt
    //app.currentDateBack=d
}

function loadTransNow(){
    let j=JSON.parse(app.currentData)
    let p=j.params
    let d=new Date(Date.now())
    let dia=d.getDate()
    let mes=d.getMonth() + 1
    let anio=d.getFullYear()
    let hora=d.getHours()
    let minuto=d.getMinutes()
    loadFromArgsBack(dia, mes, anio, hora, minuto, p.gmt, p.lat, p.lon, p.alt?p.alt:0, 'Tránsitos '+dia+'-'+mes+'-'+anio+' '+hora+':'+minuto, p.c, 'trans', false)
    app.currentGmtBack=app.currentGmt
    app.currentDateBack=d
}

//VNA
function showIW(){
    console.log('uSon: '+app.uSon)
    let m0=app.uSon.split('_')
    let fileLocation='./iw/main.qml'
    let comp=Qt.createComponent(fileLocation)

    //Cuerpo en Casa
    let nomCuerpo=m0[0]!=='asc'?app.planetas[app.planetasRes.indexOf(m0[0])]:'Ascendente'
    let jsonFileName=m0[0]!=='asc'?quitarAcentos(nomCuerpo.toLowerCase())+'.json':'asc.json'
    let jsonFileLocation='./quiron/data/'+jsonFileName
    //    if(!unik.fileExist(jsonFileLocation)){
    //        let obj=comp.createObject(app, {textData:'No hay datos disponibles.', width: sweg.width, height: sweg.height, x:0, y:0, fs: app.fs*0.5, title:'Sin datos'})
    //    }else{
    let numHome=m0[0]!=='asc'?-1:1
    let vNumRom=['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 'XI', 'XII']
    numHome=parseInt(m0[2])//vNumRom.indexOf(m0[2])+1
    console.log('::::Abriendo signo: '+app.objSignsNames.indexOf(m0[1])+' casa: '+numHome+' nomCuerpo: '+nomCuerpo)
    getJSON(jsonFileName, comp, app.objSignsNames.indexOf(m0[1])+1, numHome, nomCuerpo)
    //}
}
function showIWFromCtxMenuBar(){
    //log.ls('app.uSonFCMB: '+app.uSonFCMB, 500, 500)
    let m0=app.uSonFCMB.split('_')
    let fileLocation='./iw/main.qml'
    let comp=Qt.createComponent(fileLocation)

    //Cuerpo en Casa
    let nomCuerpo=m0[0]!=='asc'?app.planetas[app.planetasRes.indexOf(m0[0])]:'Ascendente'
    let jsonFileName=m0[0]!=='asc'?quitarAcentos(nomCuerpo.toLowerCase())+'.json':'asc.json'
    let jsonFileLocation='./quiron/data/'+jsonFileName
    //    if(!unik.fileExist(jsonFileLocation)){
    //        let obj=comp.createObject(app, {textData:'No hay datos disponibles.', width: sweg.width, height: sweg.height, x:0, y:0, fs: app.fs*0.5, title:'Sin datos'})
    //    }else{
    let numHome=m0[0]!=='asc'?-1:1
    let vNumRom=['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 'XI', 'XII']
    numHome=parseInt(m0[2])//vNumRom.indexOf(m0[2])+1
    console.log('::::Abriendo signo: '+app.objSignsNames.indexOf(m0[1])+' casa: '+numHome+' nomCuerpo: '+nomCuerpo)
    getJSON(jsonFileName, comp, app.objSignsNames.indexOf(m0[1])+1, numHome, nomCuerpo)
    //}
}
function showEditor(j){
    let json=JSON.parse(j)
    let fileLocation='./editor/main.qml'
    let comp=Qt.createComponent(fileLocation)
    let data=''
    if(json.params.data){
        data=json.params.data
    }
    let title=('Editando '+json.params.n).replace(/_/g,' ')
    let obj=comp.createObject(app, {width: app.width*0.6, x:app.width*0.2, fs: app.fs*0.5, title: title, data: data})
}
function getJSON(fileLocation, comp, s, c, nomCuerpo) {
    var request = new XMLHttpRequest()

    //Url File Local Data
    //'file:///home/ns/Documentos/unik/quiron/data/neptuno.json'

    //let jsonFileUrl='file:./quiron/data/'+fileLocation
    let msr=new Date(Date.now()).getTime()
    let jsonFileUrl=apps.hostQuiron+'/'+fileLocation+'?r='+msr

    console.log('jsonFileUrl: '+jsonFileUrl)
    request.open('GET', jsonFileUrl, true);
    //request.open('GET', 'https://github.com/nextsigner/quiron/raw/main/data/'+cbPlanetas.currentText+'.json', true);
    request.onreadystatechange = function() {
        if (request.readyState === XMLHttpRequest.DONE) {
            if (request.status && request.status === 200) {
                //console.log(":::", request.responseText)
                var result = JSON.parse(parseRetRed(request.responseText.replace(/\n/g, '')))
                if(result){
                    console.log('getJSON result: '+result)
                    //console.log('Abriendo casa de json: '+c)
                    //console.log('Abriendo dato signo:'+s+' casa:'+c+'...')
                    let dataJson0=''
                    let dataList=[]
                    //Dato Global
                    if(result['sg']){
                        let dataJsonG=result['sg'].split('|')
                        dataList.push('<h2>Significado de '+nomCuerpo+'</h2>')
                        for(i=0;i<dataJsonG.length;i++){
                            dataList.push(dataJsonG[i])
                        }
                    }else{
                        //log.l('Dato sg no existe! '+jsonFileUrl)
                        //log.visible=true
                    }

                    if(result['h'+c]){
                        console.log('Abriendo dato de casa... ')
                        dataJson0=result['h'+c].split('|')
                        dataList.push('<h2>'+nomCuerpo+' en casa '+c+'</h2>')
                        for(var i=0;i<dataJson0.length;i++){
                            dataList.push(dataJson0[i])
                        }
                    }

                    //console.log('Signo para mostar: '+s)
                    if(result['s'+s]){
                        console.log('Abriendo dato de signo... ')




                        dataJson0=result['s'+s].split('|')
                        dataList.push('<h2>'+nomCuerpo+' en '+app.signos[s - 1]+'</h2>')
                        for(i=0;i<dataJson0.length;i++){
                            dataList.push(dataJson0[i])
                        }
                    }
                    let obj=comp.createObject(app, {dataList: dataList, width: apps.iwWidth, x:app.width*0.2, fs: app.fs*0.5, title: nomCuerpo+' en '+app.signos[s - 1]+' en casa '+c, xOffSet: app.fs*6})
                }
                //console.log('Data-->'+JSON.stringify(result))
            } else {
                console.log("HTTP:", request.status, request.statusText)
                JS.showMsgDialog('Error! - Zool Informa', 'Error! Al acceder al repositorio Quirón. Problemas de conexión a internet', 'No se ha podido obtener datos de la base de datos del Repositorio Quirón.\n\nPor alguna razón, la aplicación no está pudiendo acceder a internet para obtener los datos requeridos. Error: '+data)
            }
        }
    }
    request.send()
}
function showSABIANOS(numSign, numDegree){
    log.lv('numSign: '+numSign)
    log.lv('numDegree: '+numDegree)
    panelSabianos.numSign=numSign
    panelSabianos.numDegree=numDegree
    panelSabianos.state='show'
    panelSabianos.loadData()
}
function quitarAcentos(cadena){
    const acentos = {'á':'a','é':'e','í':'i','ó':'o','ú':'u','Á':'A','É':'E','Í':'I','Ó':'O','Ú':'U'};
    return cadena.split('').map( letra => acentos[letra] || letra).join('').toString();
}
function setInfo(i1, i2, i3, son){
    if(son){
        infoCentral.info1=i1
        infoCentral.info2=i2
        infoCentral.info3=i3
        app.uSon=son
    }
}
//function getEdadDosFechas(dateAnterior, datePosterior) {
//    let hoy = new Date(dateAnterior)
//    let fechaNacimiento = new Date(datePosterior)
//    fechaNacimiento=fechaNacimiento.setMonth(fechaNacimiento.getMonth() - 1)
//    let fechaNacimiento2 = new Date(fechaNacimiento)
//    let edad = hoy.getFullYear() - fechaNacimiento2.getFullYear()
//    let diferenciaMeses = hoy.getMonth() - fechaNacimiento2.getMonth()
//    if(diferenciaMeses < 0 ||(diferenciaMeses === 0 && hoy.getDate() < fechaNacimiento2.getDate())){
//        edad--
//    }
//    return Math.abs(edad)
//}
function getEdadDosFechas(dateAnterior, datePosterior) {
    let dA= new Date(dateAnterior)
    let dB = new Date(datePosterior)
    let edad = dB.getFullYear() - dA.getFullYear()
    //if(apps.dev)log.lv('getEdadDosFechas( ... ): \n'+dA.toString()+'\n'+dB.toString())

    let vANac=dA.getFullYear()
    let vMNac=dA.getMonth()
    let vDNac=dA.getDate()
    let vHNac=dA.getHours()
    let vMinNac=dA.getMinutes()

    let vAMom=dB.getFullYear()
    let vMMom=dB.getMonth()
    let vDMom=dB.getDate()
    let vHMom=dB.getHours()
    let vMinMom=dB.getMinutes()
    //if(vANac === vAMom){

    //Si año es menor
    if(vAMom < vANac){
        return 0
    }

    //Si año es igual
    if(vAMom === vANac && vMMom < vMNac){
        return 0
    }
    if(vAMom === vANac && vMMom === vMNac && vDMom < vDNac){
        return 0
    }
    if(vAMom === vANac && vMMom === vMNac && vDMom === vDNac && vHMom < vHNac){
        return 0
    }
    if(vAMom === vANac && vMMom === vMNac && vDMom === vDNac && vHMom === vHNac && vMinMom < vMinNac){
        return 0
    }

    //Si año es mayor
    if(vAMom > vANac){
        if(vMMom === vMNac && vDMom === vDNac && vHMom === vHNac && vMinMom === vMinNac){
            return edad
        }
        if(vMMom === vMNac && vDMom === vDNac && vHMom === vHNac && vMinMom < vMinNac){
            return edad-1
        }
        if(vMMom === vMNac && vDMom === vDNac && vHMom < vHNac && vMinMom === vMinNac){
            return edad-1
        }
        if(vMMom === vMNac && vDMom < vDNac && vHMom === vHNac && vMinMom === vMinNac){
            return edad-1
        }
        if(vMMom < vMNac && vDMom === vDNac && vHMom == vHNac && vMinMom === vMinNac){
            return edad-1
        }

        return edad
    }

    //    if(vAMom >= vANac && vMNac < vMMom){
    //        edad--
    //        return Math.abs(edad)
    //    }
    //    if(vAMom >= vANac && vMMom >= vMNac && vDMom < vDNac){
    //        edad--
    //        return Math.abs(edad)
    //    }
    //    if(vAMom >= vANac && vMMom >= vMNac && vDMom >= vDNac && vHMom < vHNac){
    //        edad--
    //        return Math.abs(edad)
    //    }
    //    if(vAMom >= vANac && vMMom >= vMNac && vDMom >= vDNac && vHMom >= vHNac && vMinMom < vMinNac){
    //        edad--
    //        return Math.abs(edad)
    //    }



    return Math.abs(edad)
}

function eventoEsMenorAInicio(dateInicio, dateEvento){
    let msInicio= new Date(dateInicio).getTime()
    let msEvento= new Date(dateEvento).getTime()
    return msEvento < msInicio
}

function runCmd(){
    let c='import unik.UnikQProcess 1.0\n'
        +'UnikQProcess{\n'
        +'  '
        +'}\n'
}
function deg_to_dms (deg) {
    var d = Math.floor (deg);
    var minfloat = (deg-d)*60;
    var m = Math.floor(minfloat);
    var secfloat = (minfloat-m)*60;
    var s = Math.round(secfloat);
    // After rounding, the seconds might become 60. These two
    // if-tests are not necessary if no rounding is done.
    if (s==60) {
        m++;
        s=0;
    }
    if (m==60) {
        d++;
        m=0;
    }
    return [d, m, s]
}
function qmltypeof(obj) {
    let str = obj.toString();
    let m0=str.split('_')
    return m0[0]
}

//Zool
function mkSinFile(file){
    let jsonFileDataInterior=zm.fileData
    let json=JSON.parse(jsonFileDataInterior)
    let jsonFileDataExt=unik.getFile(file).replace(/\n/g, '')
    let jsonExt=JSON.parse(jsonFileDataExt)
    json.params.t='sin'
    json.paramsBack=jsonExt.params
    json.paramsBack.t='sin'
    json.paramsBack.n='Sinastría '+json.params.n+' - '+json.paramsBack.n

    let cNom=json.paramsBack.n
    let nFileName=(apps.workSpace+'/'+cNom+'.json').replace(/ /g,'_')
    let e=unik.fileExist(nFileName)
    if(e){
        //log.l('Existe')
        loadJson(nFileName)
    }else{
        //log.l('No Existe')
        unik.setFile(nFileName, JSON.stringify(json))
        xEditor.visible=true
        loadJson(nFileName)
    }
}
function mkRsFile(file){
    let jsonFileDataInterior=zm.fileData
    let json=JSON.parse(jsonFileDataInterior)
    let jsonFileDataExt=JSON.stringify(JSON.parse(app.currentDataBack))//unik.getFile(file).replace(/\n/g, '')
    let jsonExt=JSON.parse(jsonFileDataExt)
    log.ls('jsonExt: '+jsonFileDataExt, 0, log.width)
    json.params.n='Rev. Solar de '+json.params.n+' - Año '+jsonExt.paramsBack.a
    json.params.t='rs'
    json.paramsBack={}
    json.paramsBack=jsonExt.paramsBack
    json.paramsBack.t='rs'
    json.paramsBack.n=json.params.n

    let cNom=json.params.n
    let nFileName=(apps.workSpace+'/'+cNom+'.json').replace(/ /g,'_')
    log.ls('nFileName: '+nFileName, 0, log.width)
    let e=unik.fileExist(nFileName)
    if(e){
        log.l('Existe')
        loadJson(nFileName)
    }else{
        log.l('No Existe')
        unik.setFile(nFileName, JSON.stringify(json))
        xEditor.visible=true
        loadJson(nFileName)
    }
}
function mkTransFile(){
    let jsonFileDataInterior=zm.fileData
    let json=JSON.parse(jsonFileDataInterior)
    let jsonFileDataExt=JSON.stringify(JSON.parse(app.currentDataBack))//unik.getFile(file).replace(/\n/g, '')
    let jsonExt=JSON.parse(jsonFileDataExt)
    //if(apps.dev)log.lv('jsonExt: '+JSON.stringify(jsonExt))
    json.params.n=json.params.n+' - '+jsonExt.params.n
    //if(apps.dev)log.lv('json.params.n: '+json.params.n)
    json.params.t='trans'
    if(json.params[app.stringRes+'zoompos']){
        delete json.params[app.stringRes+'zoompos']
    }
    json.paramsBack={}
    json.paramsBack=jsonExt.params//Back
    json.paramsBack.t='trans'
    json.paramsBack.n=json.params.n

    let cNom=json.params.n
    let nFileName=(apps.workSpace+'/'+cNom+'.json').replace(/ /g,'_')
    log.lv('nFileName: '+nFileName)
    let e=unik.fileExist(nFileName)
    if(e){
        log.l('Existe')
        loadJson(nFileName)
    }else{
        log.l('No Existe')
        unik.setFile(nFileName, JSON.stringify(json))
        xEditor.visible=true
        loadJson(nFileName)
    }
}

function loadRs(date, gmt, lat, lon, alt){    
    let nDateNow= new Date(Date.now())
    let nDate= new Date(date)
    let dia=nDate.getDate()
    let mes=nDate.getMonth() + 1
    let anio=nDate.getFullYear()
    let hora=nDate.getHours()
    let minuto=nDate.getMinutes()


    let ad=getADate(nDate)
    loadFromArgsBack(ad[0], ad[1], ad[2], ad[3], ad[4], gmt, lat, lon, alt, app.currentNom, app.currentLugar, 'rs', false)
}
function loadSin(date, gmt, lat, lon, alt, nom, ciudad){
    let ad=getADate(date)
    //xDataStatusBar.currentIndex=2
    loadFromArgsBack(ad[0], ad[1], ad[2], ad[3], ad[4], gmt, lat, lon, alt, nom, ciudad, 'sin', false)
}
function runJsonTemp(){
    var jsonData
    try
    {
        jsonData=JSON.parse(zm.currentData)
    }
    catch (e)
    {
        console.log('Json Fallado: '+zm.currentData)
        log.lv('Ha fallado la carga del archivo '+apps.url)
        log.lv('Error de Json.parse(): '+e)
        //log.ls(JSON.stringify(JSON.parse(app.currentData), null, 2), 0, xApp.width)
        //unik.speak('Error in Json file')
        return
    }

    let nom=jsonData.params.n.replace(/_/g, ' ')
    let vd=jsonData.params.d
    let vm=jsonData.params.m
    let va=jsonData.params.a
    let vh=jsonData.params.h
    let vmin=jsonData.params.min
    let vgmt=app.currentGmt
    let vlon=jsonData.params.lon
    let vlat=jsonData.params.lat
    let vCiudad=jsonData.params.c.replace(/_/g, ' ')
    let edad=''
    let numEdad=zm.getEdad(parseInt(va), parseInt(vm), parseInt(vd), parseInt(vh), parseInt(vmin))
    if(jsonData.params.t==='pron')numEdad=0
    let stringEdad=edad.indexOf('NaN')<0?edad:''
    let textData=''
    zm.currentFecha=vd+'/'+vm+'/'+va
    zm.load(jsonData)
}
function runJsonTempBack(){
    var jsonData
    //let jss=app.currentDataBack.replace(/\n/g, '')
    let jss=zm.currentDataBack.replace(/\n/g, '')
    try
    {
        jsonData=JSON.parse(jss)
    }catch(e){
        console.log('runJsonTempBack() Json Fallado: '+zm.currentDataBack)
        if(apps.dev){
            log.lv('Ha fallado la carga del archivo BACK '+apps.url)
            log.lv(zm.currentDataBack)
            //log.lv(JSON.stringify(JSON.parse(app.currentDataBack), null, 2))
        }
        //unik.speak('Error in Json file')
        return
    }

    let params
    if(jsonData.paramsBack){
        params=jsonData.paramsBack
    }else{
        params=jsonData.params
    }
    if(params.t==='vn'){
        if(apps.dev)log.lv('No se carga params back porque es tipo VN.')
        return
    }
    let nom=params.n.replace(/_/g, ' ')
    let vd=params.d
    let vm=params.m
    let va=params.a
    let vh=params.h
    let vmin=params.min
    let vgmt=app.currentGmt
    let vlon=params.lon
    let vlat=params.lat
    let vCiudad=params.c.replace(/_/g, ' ')
    let edad=''
    let numEdad=zm.getEdad(parseInt(va), parseInt(vm), parseInt(vd), parseInt(vh), parseInt(vmin))
    let stringEdad=edad.indexOf('NaN')<0?edad:''
    let textData=''

    zm.currentFechaBack=vd+'/'+vm+'/'+va
    zm.loadBack(jsonData, params.t)
    //app.currentDateBack=new Date(vd, vm, va, vh, vmin)
    //swegz.sweg.load(jsonData)
}
function setNewTimeJsonFileData(date){
    let jsonData=JSON.parse(zm.fileData)
    //console.log('json: '+JSON.stringify(jsonData))
    //console.log('json2: '+jsonData.params)
    let d = new Date(Date.now())
    let ms=jsonData.params.ms
    let nom=jsonData.params.n.replace(/_/g, ' ')

    //console.log('Date: '+date.toString())
    let vd=date.getDate()
    let vm=date.getMonth()+1
    let va=date.getFullYear()
    let vh=date.getHours()
    let vmin=date.getMinutes()

    let vgmt=zm.currentGmt
    let vlon=jsonData.params.lon
    let vlat=jsonData.params.lat
    let vCiudad=jsonData.params.c.replace(/_/g, ' ')
    let vZoomAndPos={}
    let j='{'
    j+='"params":{'
    j+='"t":"'+app.t+'",'
    j+='"ms":'+ms+','
    j+='"n":"'+nom+'",'
    j+='"d":'+vd+','
    j+='"m":'+vm+','
    j+='"a":'+va+','
    j+='"h":'+vh+','
    j+='"min":'+vmin+','
    j+='"gmt":'+vgmt+','
    j+='"lat":'+vlat+','
    j+='"lon":'+vlon+','
    j+='"c":"'+vCiudad+'"'
    j+='}'
    j+='}'

    let json=JSON.parse(j)
    if(jsonData[app.stringRes+'zoompos']){
        json[app.stringRes+'zoompos']=jsonData[app.stringRes+'zoompos']
    }
    if(jsonData.rots){
        json.rots=jsonData.rots
    }

    zm.currentData=JSON.stringify(json)
    //console.log('j: '+j)
    //console.log('fd: '+zm.fileData)
}
function setNewTimeJsonFileDataBack(date){
    //log.l('zm.fileDataBack: '+zm.fileDataBack)
    //log.visible=true
    //log.width=xApp.width*0.2
    //log.ls('setNewTimeJsonFileDataBack(date): '+date, 0, 500)
    //log.ls('zm.fileDataBack: '+zm.fileDataBack, 0, 500)
    if(zm.fileDataBack===''){
        if(apps.dev)log.lv('zm.fileDataBack is empty.')
        return
    }
    let jsonData=JSON.parse(zm.fileDataBack)
    //console.log('json: '+JSON.stringify(jsonData))
    //console.log('json2: '+jsonData.params)
    let d = new Date(Date.now())
    let params
    if(jsonData.paramsBack){
        params=jsonData.paramsBack
    }else{
        params=jsonData.params
    }
    let ms=params.ms
    let nom=params.n.replace(/_/g, ' ')

    console.log('Date: '+date.toString())
    let vd=date.getDate()
    let vm=date.getMonth()+1
    let va=date.getFullYear()
    let vh=date.getHours()
    let vmin=date.getMinutes()

    let vgmt=app.currentGmtBack
    let vlon=params.lon
    let vlat=params.lat
    let vCiudad=params.c.replace(/_/g, ' ')
    let j='{'
    j+='"params":{'
    j+='"t":"'+app.t+'",'
    j+='"ms":'+ms+','
    j+='"n":"'+nom+'",'
    j+='"d":'+vd+','
    j+='"m":'+vm+','
    j+='"a":'+va+','
    j+='"h":'+vh+','
    j+='"min":'+vmin+','
    j+='"gmt":'+vgmt+','
    j+='"lat":'+vlat+','
    j+='"lon":'+vlon+','
    j+='"c":"'+vCiudad+'"'
    j+='}'
    j+='}'
    zm.currentDataBack=j
    //    log.l('cjb:'+app.currentDataBack)
    //    log.width=xApp.width*0.2
    //    log.visible=true
    //console.log('j: '+j)
    //console.log('fd: '+zm.fileData)
}
function saveJson(){
    //log.lv('zm.fileData: '+JSON.stringify(JSON.parse(zm.fileData), null, 2))
    //log.lv('zm.currentData: '+JSON.stringify(JSON.parse(zm.currentData), null, 2))
    zm.fileData=zm.currentData
    let jsonFileName=apps.url
    let json=JSON.parse(zm.fileData)
    if(unik.fileExist(apps.url.replace('file://', ''))){
        let dataModNow=new Date(Date.now())
        json.params.msmod=dataModNow.getTime()
    }
    unik.setFile(jsonFileName, JSON.stringify(json))
    loadJson(apps.url)
}
function saveJsonBack(){
    zm.fileData=zm.currentData
    let json=JSON.parse(zm.currentData)
    json.params.t='rs'
    //log.ls('app.currentDataBack: '+app.currentDataBack, 0, 500)
    //json['paramsBack']={}
    let pb=JSON.parse(zm.currentDataBack)
    json['paramsBack']={}=pb.paramsBack
    if(unik.fileExist(apps.url.replace('file://', ''))){
        let dataModNow=new Date(Date.now())
        json.params.msmod=dataModNow.getTime()
    }
    log.ww=false
    log.ls('zm.fileData: '+JSON.stringify(json), 0, 500)
    let jsonFileName=apps.workSpace+'/'+(''+pb.paramsBack.n).replace(/ /g, '_')+'.json'
    apps.url=jsonFileName
    log.ls('apps.url: '+apps.url, 0, 500)
    unik.setFile(jsonFileName, JSON.stringify(json))
    //loadJson(apps.url)
}

function loadJsonNow(file){
    let fn=file
    let jsonFileName=fn
    let jsonFileData=unik.getFile(jsonFileName).replace(/\n/g, '')
    //console.log('main.loadJson('+file+'):'+jsonFileData)

    let json=JSON.parse(jsonFileData)
    let d=new Date(Date.now())
    let o=json.params
    o.ms=d.getTime()
    o.d=d.getDate()
    o.m=d.getMonth()
    o.a=d.getFullYear()
    o.h=d.getHours()
    o.min=d.getMinutes()
    o.n=(o.n+' '+o.d+'-'+o.m+'-'+o.a+'-'+o.h+':'+o.min).replace(/Ahora/g, '').replace(/ahora/g, '')
    json.params=o
    zm.loadSign(json)
    //swegz.sweg.loadSign(json)
    let nom=o.n.replace(/_/g, ' ')
    let vd=o.d
    let vm=o.m
    let va=o.a
    let vh=o.h
    let vmin=o.min
    let vgmt=o.gmt
    let vlon=o.lon
    let vlat=o.lat
    let vCiudad=o.c.replace(/_/g, ' ')
    let edad=''
    let numEdad=zm.getEdad(parseInt(va), parseInt(vm), parseInt(vd), parseInt(vh), parseInt(vmin))
    let stringEdad=edad.indexOf('NaN')<0?edad:''
    let textData=''

    //    textData=''
    //            +'<b>'+nom+'</b> '
    //            +''+vd+'/'+vm+'/'+va+' '+vh+':'+vmin+'hs GMT '+vgmt+stringEdad+' '
    //            +'<b> Edad:</b>'+getEdad(vd, vm, va, vh, vmin)+' '
    //            +'<b> '+vCiudad+'</b> '
    //            +'<b>lon:</b> '+vlon+' <b>lat:</b> '+vlat+' '

    setTitleData(nom, vd, vm, va, vh, vmin, vgmt, vCiudad, vlat, vlon, mod)

    //Seteando datos globales de mapa energético
    app.currentDate= new Date(parseInt(va), parseInt(vm) - 1, parseInt(vd), parseInt(vh), parseInt(vmin))
    //console.log('2 main.loadJson('+file+'): '+app.currentDate.toString())

    //getCmdData.getData(vd, vm, va, vh, vmin, vlon, vlat, 0, vgmt)
    zm.currentNom=nom
    zm.currentFecha=vd+'/'+vm+'/'+va
    zm.currentGmt=vgmt
    zm.currentLon=vlon
    zm.currentLat=vlat

    zm.currentData=zm.fileData
    zm.fileData=jsonFileData
}

//Funciones de Internet
function getRD(url, item){//Remote Data
    var request = new XMLHttpRequest()
    request.open('GET', url, true);
    request.onreadystatechange = function() {
        if (request.readyState === XMLHttpRequest.DONE) {
            if (request.status && request.status === 200) {
                /*let d=request.responseText
                if(d.indexOf('redirected')>=0&&d.indexOf('</html>')>=0){
                    let m0=d.split('</html>')
                     item.setData(m0[1], true)
                }else{
                     item.setData(d, true)
                }*/
                item.setData(parseRetRed(request.responseText), true)
            } else {
                item.setData("Url: "+url+" Status:"+request.status+" HTTP: "+request.statusText, false)
            }
        }
    }
    request.send()
}
function parseRetRed(d){
    if(d.indexOf('redirected')>=0&&d.indexOf('</html>')>=0){
        let m0=d.split('</html>')
        return m0[1]
    }else{
        return d
    }
}

//Funciones varias
function getADate(date){
    let d=date.getDate()
    let m=date.getMonth() + 1
    let a=date.getFullYear()
    let h=date.getHours()
    let min=date.getMinutes()
    return [d, m, a, h, min]
}
function removeItemAll(arr, value) {
    var i = 0;
    while (i < arr.length) {
        if (arr[i] === value) {
            arr.splice(i, 1);
        } else {
            ++i;
        }
    }
    return arr;
}
//Funciones de GUI
function showMsgDialog(title, subTitle, text){
    let c='import QtQuick 2.0\n'
        +'import comps.ZoolMessageDialog 1.0\n'
        +'ZoolMessageDialog {\n'
        +'  title: "'+title+'"\n'
        +'  subTitle: "'+subTitle+'"\n'
        +'  text: "                   '+text+'                  "\n'
        +'}\n'
    console.log(c)
    let comp=Qt.createQmlObject(c, app, 'codeshowMsgDialog')
}
function raiseItem(item){
    let z=0
    for(let i=0;i<item.parent.children.length;i++){
        //console.log('id:'+item.parent.children[i].objectName)
        if(item.parent.children[i]!==item&&item.parent.children[i].objectName!=='swegzcontainer'){
            item.parent.children[i].state='hide'
        }
    }
    item.state='show'
}

//Funciones SWEG
function saveZoomAndPos(){
    if(zm.currentPlanetIndex>=0&&app.currentXAs){
        if(zm.currentPlanetIndex===20||app.currentPlanetIndex===21){
            if(zm.currentPlanetIndex===21){
                app.currentXAs.saveZoomAndPos('mc')
            }
            if(zm.currentPlanetIndex===20){
                app.currentXAs.saveZoomAndPos('asc')
            }
        }else{
            app.currentXAs.saveZoomAndPos()
        }
        //Cap.captureSweg()
        return
    }
    if(zm.currentPlanetIndexBack>=0&&app.currentXAsBack){
        if(zm.currentPlanetIndexBack===21||zm.currentPlanetIndexBack===20){
            if(zm.currentPlanetIndexBack===21){
                zm.currentXAs.saveZoomAndPos('mcBack')
            }
            if(zm.currentPlanetIndexBack===20){
                zm.currentXAsBack.saveZoomAndPos('ascBack')
            }
        }else{
            app.currentXAsBack.saveZoomAndPos()
        }
        //Cap.captureSweg()
        return
    }
}

//Numerologia
function getNums(fecha){
    let d=''
    let nf=0
    let nf10=false
    let f=fecha
    let m0=f.split('/')
    let m1=m0[0].split('')
    if(m1.length<=0)return [-1, -1, -1]
    let m2=m0[1].split('')
    let m3=m0[2].split('')
    nf+=parseInt(m1[0])
    if(m1.length>1){
        nf+=parseInt(m1[1])
    }
    nf+=parseInt(m2[0])
    if(m2.length>1){
        nf+=parseInt(m2[1])
    }
    nf+=parseInt(m3[0])
    if(m3.length>3){
        nf+=parseInt(m3[1])
        nf+=parseInt(m3[2])
        nf+=parseInt(m3[3])
    }
    if(nf===10)nf10=true
    if(nf>9&&nf!==11&&nf!==22&&nf!==33&&nf!==44){
        let m4=(''+nf).split('')
        let nnf=parseInt(m4[0])
        if(m4.length>1){
            nnf+=parseInt(m4[1])
        }
        nf=nnf
    }
    d=''+parseInt(m0[0])
    if(parseInt(m0[0])>9){
        let m5=d.split('')
        let nfd=parseInt(m5[0])
        if(m5.length>1){
            nfd+=parseInt(m5[1])
        }
        d+='-'+nfd
    }
    if(nf===10)nf10=true
    if(nf>9){
        let m6=(''+nf).split('')
        let nnf6=parseInt(m6[0])
        if(m6.length>1){
            nnf6+=parseInt(m6[1])
        }
        nf=nnf6
    }
    let numArbolGen=-1
    if(!nf10){
        if(nf===1||nf===6||nf===8)numArbolGen=0
        if(nf===2||nf===5||nf===9)numArbolGen=1
        if(nf===3||nf===4)numArbolGen=2
        if(nf===7)numArbolGen=3
    }else{
        numArbolGen=2
    }
    return [nf, d, numArbolGen]
}

//Funciones varias
function timer(parent) {
    return Qt.createQmlObject("import QtQuick 2.0; Timer {}", parent);
}

//Modules
function loadModules(){
    let d='{"modules":['

    d+='{"enabled": true, "name":"Contexto de Namimiento", "url": "https://github.com/nextsigner/ZoolCtxNac.git"}'
    d+=',{"enabled": false, "name":"Modulo inexistente", "url": "https://github.com/nextsigner/inexistente.git"}'

    d+=']}'
    let jsonFileData=d
    let json=JSON.parse(jsonFileData)
    for(var i=0;i<json.modules.length;i++){
        if(json.modules[i].enabled){
            //log.ls('Modules: '+json.modules[i].name, 0, 500)
            let url=json.modules[i].url
            let f=(''+url.split('/')[url.split('/').length - 1]).replace('.git', '')
            //let folder=unik.getPath(5)+'/modules'//+f
            let folder=unik.getPath(4)+'/modules'//+f
            //log.ls('Modules Folder: '+folder, 0, 500)
            if(!unik.folderExist(folder)){
                unik.mkdir(folder)
                //let download=unik.downloadGit(url, folder)
                //log.ls('Modules Folder not exist making: '+folder, 0, 500)
            }else{
                //log.ls('Modules Folder exist: '+folder, 0, 500)
            }
            //loadModule(f)
            //            let download=unik.downloadGit(url, folder)
            //            if(download){
            //                loadModule(f)
            //            }
            loadModule(f)
        }else{
            //log.ls('Modules disabled: '+json.modules[i].name, 0, 500)
        }
    }
}
function loadModule(module){
    //log.ls('loadModule('+folder+')...', 0, xLatIzq.width)
    //engine.addImportPath(unik.getPath(4)+'/modules/'+folder);
    let c='import QtQuick 2.0\n'
    //c+='import "'+unik.currentFolderPath()+'/zool-modules/'+folder+'" as Module\n'
    //c+='import "'+unik.getPath(4)+'/modules/'+folder+'" as Module\n'
    //c+='import "'+unik.getPath(4)+'/modules/'+folder+'" as Module\n'
    //c+='import "'+unik.getPath(4)+'/modules/'+folder+'" as Module\n'
    c+='import mods.'+module+' 1.0\n'
    c+='Item{\n'
    c+='    '+module+'{}\n'
    c+='}\n'
    //log.ls('code: '+c, 0, xLatIzq.width)
    let comp=Qt.createQmlObject(c, xApp, 'loadmodule')
    //log.ls('L1104 Funcs.js Current Path: '+unik.currentFolderPath(), 0, xApp.width*0.2)
}
