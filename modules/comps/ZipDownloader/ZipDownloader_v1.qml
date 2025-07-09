import QtQuick 2.0
import QtQuick.Controls 2.0

Item{
    id: r
    property bool dev: false
    property string curlPath: Qt.platform.os==='windows'?unik.getPath(1)+'/curl-8.14.1_2-win64-mingw/bin/curl.exe':'curl'
    property string app7ZipPath: Qt.platform.os==='windows'?unik.getPath(1)+'/7-Zip32/7z.exe':'7z'
    property real cPorc: 0
    property string uStdOut: ''

    property string version: ''
    property string folderRoot: ''
    property string folderDestination: ''

    property string uZipFilePath: ''
    property string uUrl: ''
    property string uFolder: unik.getPath(3)

    Item{
        id: xuqpCurl
    }
    Rectangle{
        id: xProgresDialog
        width: app.fs*12
        height: col.height+app.fs
        color: apps.backgroundColor
        border.width: 1
        border.color: apps.fontColor
        parent: capa101
        anchors.centerIn: parent
        clip: true
        visible: false
        Rectangle{
            width: xProgresDialog.parent.width
            height: xProgresDialog.parent.height
            color: 'black'
            opacity: 0.5
            parent: xProgresDialog.parent
            anchors.centerIn: parent
            z: parent.z-1
            visible: xProgresDialog.visible
            MouseArea{
                anchors.fill: parent
                onClicked: zpn.log('Para continuar, primero debes cerrar el cuadro de diálogo de la descarga.')
            }
        }
        Column{
            id: col
            spacing: app.fs*0.25
            anchors.centerIn: parent
            Text{
                text: 'Descargando Archivo Zip'
                font.pixelSize: app.fs*0.5
                color: apps.fontColor
            }
            Rectangle{
                id: xProgressBar
                width: xProgresDialog.width-app.fs
                height: app.fs
                color: 'transparent'
                border.width: 1
                border.color: apps.fontColor
                Rectangle{
                    width: (parent.width/100)*r.cPorc
                    height: parent.height
                    color: apps.fontColor
                }
                Text{
                    text: '%'+r.cPorc
                    font.pixelSize: app.fs*0.35
                    color: apps.fontColor
                    anchors.centerIn: parent
                    Rectangle{
                        width: parent.width+4
                        height: parent.height+4
                        color: apps.backgroundColor
                        anchors.centerIn: parent
                        z: parent.z-1
                    }
                }
            }
            Text{
                id: txtLog
                width: xProgresDialog.width-app.fs*0.5
                text: r.uStdOut
                font.pixelSize: app.fs*0.35
                color: apps.fontColor
                wrapMode: Text.WordWrap
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Row{
                spacing: app.fs*0.25
                Button{
                    text: 'Cancelar'
                    font.pixelSize: app.fs*0.5
                    onClicked: {
                        //tCheckDownload.stop()
                        //tCheckMove.stop()
                        //t7Zip.stop()
                        //t7ZipFinished.stop()
                        cleanUqpCurl()
                        r.cPorc=0.00
                        r.uStdOut='Cancelado.'
                    }
                }
                Button{
                    id: btnIniciarReintentar
                    text: 'Inicar'
                    font.pixelSize: app.fs*0.5
                    visible: false
                    onClicked: {
                        if(text==='Iniciar'){
                            cleanUqpCurl()
                            r.uStdOut='Iniciando...'
                            downloadGitHub(r.uUrl, r.uFolder)
                        }else{
                            //tCheckDownload.stop()
                            //tCheckMove.stop()
                            //t7Zip.stop()
                            //t7ZipFinished.stop()
                            cleanUqpCurl()
                            r.cPorc=0.00
                            r.uStdOut='Reintentando...'
                            downloadGitHub(r.uUrl, r.uFolder)
                        }
                    }
                }
                Button{
                    text: 'Cerrar'
                    font.pixelSize: app.fs*0.5
                    onClicked: {
                        xProgresDialog.visible=false
                    }
                }
            }
        }
    }
    /*Timer{
        id: t7Zip
        running: false
        repeat: false
        interval: 2000
        onTriggered: {
            if(r.cPorc>=100.00){
                mkUqp7Zip(r.uZipFilePath, r.uFolder)
            }
        }
    }
    Timer{
        id: t7ZipFinished
        running: false
        repeat: false
        interval: 5000
        onTriggered: {
            r.cPorc=100.00
            r.uStdOut='Moviendo archivos descargados...'
            mkUqpMove(r.uZipFilePath)
        }
    }
    Timer{
        id: tCheckDownload
        running: false
        repeat: true
        interval: 5000
        property string uLogData: ''
        property string zipFilePath: ''
        onTriggered: {
            if(unik.fileExist(zipFilePath)){
                txtLog.text='Archivo descargado!'
                r.cPorc=100.00
                t7Zip.restart()
            }else{
                txtLog.text='Revisando archivo descargado...'
            }
        }
    }
    Timer{
        id: tCheckMove
        running: false
        repeat: true
        interval: 5000
        property string folder: ''
        onTriggered: {
            if(unik.folderExist(folder)){
                txtLog.text='Archivos movidos con éxito.'
                stop()
                let mainPath=folder+'/main.qml'
                engine.addImportPaths(folder+'/modules')
                engine.load(mainPath)
            }else{
                txtLog.text='Revisando archivos movidos...'
            }
        }
    }*/
    function download(url, from){
        if(from===undefined || from==='github'){
            mkUqpCleanFolder(url, r.folderRoot)
        }else{
            //downloadGitHub(url)
        }
    }
    function downloadGitHub(url, folder){
        btnIniciarReintentar.text='Reintentar'
        if(folder===undefined)folder=r.folderRoot
        r.uUrl=url
        r.uFolder=folder
        let u=getUrlFromRepositoryToZip(url)
        let m0=u.split('/')
        if(m0.length<1){
            zpn.log('Hay un error en la dirección URL para descargar desde GitHub.\nUrl: '+url)
            return
        }else{
            //Formato: https://github.com/nextsigner/zoolv4/archive/refs/heads/main.zip
            let repName=m0[m0.length-5]
            if(!unik.folderExist(folder)){
                unik.mkdir(folder)
            }
            if(!unik.folderExist(folder)){
                zpn.log('Error en la descarga de repositorio GitHub: La carpeta '+folder+' no existe.')
                //btnIniciarReintentar.visible=true
                return
            }
            //btnIniciarReintentar.visible=false
            r.uZipFilePath=folder+'/'+repName+'.zip'
            log.lv('r.uZipFilePath: '+r.uZipFilePath)
            if(unik.fileExist(uZipFilePath)){
                //unik.deleteFile(r.uZipFilePath.replace('-main', ''))
                //unik.deleteFile(r.uZipFilePath)
                //unik.deleteFile(r.uZipFilePath+'-main')
            }
            mkUqpCurl(u, folder, repName+'.zip')

        }
    }
    function getUrlFromRepositoryToZip(repositoryUrl){
        //Formato: https://github.com/nextsigner/zoolv4/archive/refs/heads/main.zip
        let url=repositoryUrl
        url=url.replace(".git", "")
        url+='/archive/refs/heads/main.zip'
        console.log('getUrlFromRepositoryToZip('+repositoryUrl+'): '+url)
        return url
    }
    function cleanUqpCurl(){
        for(var i=0;i<xuqpCurl.children.length;i++){
            xuqpCurl.children[i].destroy(0)
        }
    }
    function mkUqpCurl(url, folderPath, fileName){
        cleanUqpCurl()
        let c='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='Item{\n'
        c+='UnikQProcess{\n'
        c+='    id: uqp1\n'
        c+='    onFinished:{\n'
        c+='        txtLog.text="Archivo descargado!"\n'
        c+='        r.cPorc=99.99\n'
        c+='        procCurlStdOut("finished")\n'
        c+='        uqp1.destroy(0)\n'
        c+='    }\n'
        c+='    onLogDataChanged:{\n'
        c+='        procCurlStdOut(logData)\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='        let cmd=\''+r.curlPath+' -# -L -o "'+folderPath+'/'+fileName+'" "'+url+'"\'\n'
        c+='        console.log("cmd curl: "+cmd)\n'
        c+='        xProgresDialog.visible=true\n'
        c+='        run(cmd)\n'
        c+='    }\n'
        c+='}\n'
        c+='}\n'
        //log.lv(c)
        let comp=Qt.createQmlObject(c, xuqpCurl, 'uqp-curl-code')
    }
    function procCurlStdOut(data){
        let d=data
        if(d.indexOf('#')>=0 && data!=="finished"){
            let s0="["+d+"]"
            let s1=s0.replace(/#/g, '')//m0[m0.length-1]
            let s2=s1.replace(/ /g, '')//m0[m0.length-1]
            let m0=s2.split('%')
            let s3=m0[m0.length-2]
            if(!s3){
                console.log('no s3:['+data+']')
                /*if((''+data).indexOf('##')>=0 || (''+data).indexOf('#=#=#')>=0){
                    txtLog.text='Presione Iniciar.'
                    btnIniciarReintentar.text='Iniciar'
                }else*/
                //                if((''+data).indexOf('                           #  -=O#-')===0){
                //                    txtLog.text='Descarga completada.'
                //                }else{
                //txtLog.text='Error al descargar.\nInforme del error: '+data
                txtLog.text='Calculando progreso de descarga... '//+data
                if(r.cPorc<=70.00){
                    r.cPorc+=1.00
                }else{
                    //tCheckDownload.restart()
                    /*if(tCheckDownload.uLogData===""+data){
                            txtLog.text='Iniciando revisión...'
                            //tCheckDownload.start()
                        }
                        tCheckDownload.uLogData=""+data*/
                }
                //}
                btnIniciarReintentar.visible=true
                //cleanUqpCurl()
                //download(r.uUrl)
                return
            }
            //tCheckDownload.stop()
            btnIniciarReintentar.visible=false
            txtLog.text='Descargando...'
            let sf=s3.replace(/\n/g, '').replace(/\r/g, '').replace(/\[/g, '')
            let nporc=parseFloat(sf).toFixed(2)
            r.cPorc=nporc>=0.0?nporc:0.00
            if(nporc>=100.0){
                txtLog.text='Archivo descargado con éxito.'
                //t7Zip.restart()
            }else{
                r.uStdOut='Descargando...'
            }
        }else{
            if(data==="finished"){
                if(r.dev)log.lv('Descarga finalizada.')
                mkUqp7Zip(r.uZipFilePath, r.uFolder)
            }else{
                if(r.dev)log.lv('Log 111: ['+data+']')
            }
        }
    }
    function mkUqp7Zip(zipFilePath, folder){
        //tCheckDownload.zipFilePath=zipFilePath
        let c='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='Item{\n'
        c+='UnikQProcess{\n'
        c+='    id: uqp2\n'
        c+='    onFinished:{\n'
        c+='        proc7ZipStdOut("finished")\n'
        c+='        uqp2.destroy(0)\n'
        c+='    }\n'
        c+='    onLogDataChanged:{\n'
        c+='        proc7ZipStdOut(logData)\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='        let cmd=\''+r.app7ZipPath+' x "'+zipFilePath+'" -o"'+folder+'" -aoa -bsp1   \'\n'
        c+='        if(r.dev)log.lv("cmd 7-Zip: "+cmd)\n'
        //c+='        xProgresDialog.visible=true\n'
        c+='        run(cmd)\n'
        c+='    }\n'
        c+='}\n'
        c+='}\n'
        //log.lv(c)
        let comp=Qt.createQmlObject(c, xuqpCurl, 'uqp-curl-code')
    }
    function mkUqpMove(zipFilePath){
        //log.lv('zipFilePath: '+zipFilePath)
        let fileNameOfFolder=zipFilePath.replace('.zip', '-main')
        let fileNameOfFolder2=fileNameOfFolder.replace('-main', '')
        if(r.folderDestination!==''){
            fileNameOfFolder2=r.folderDestination
        }
        //unik.deleteFile(fileNameOfFolder2)
        let c='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='Item{\n'
        c+='UnikQProcess{\n'
        c+='    id: uqp3\n'
        c+='    onFinished:{\n'
        c+='        uqp3.destroy(0)\n'
        c+='    }\n'
        c+='    onLogDataChanged:{\n'
        c+='        log.lv("Move: "+logData)\n'
        c+='        //No funciona porque mv no retorna nada procMoveStdOut(\'+logData+\', "'+fileNameOfFolder+'")\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='        let cmd=\'mv "'+fileNameOfFolder+'" "'+fileNameOfFolder2+'"\'\n'
        c+='        console.log("cmd Move: "+cmd)\n'
        c+='        log.lv("cmd Move: "+cmd)\n'
        c+='        txtLog.text="Moviendo archivos...\\n"+cmd\n'
        c+='        run(cmd)\n'
        c+='        tCheckMove.folder="'+fileNameOfFolder2+'"\n'
        c+='        tCheckMove.start()\n'
        c+='    }\n'
        c+='}\n'
        c+='}\n'
        //log.lv(c)

        let comp=Qt.createQmlObject(c, xuqpCurl, 'uqp-curl-code')
    }
    function procMoveStdOut(data, folder){
        log.lv('procMoveStdOut(...).data: '+data)
        log.lv('procMoveStdOut(...).folder: '+foder)
        let mainPath=folder+'/main.qml'
        log.lv('procMoveStdOut(...).mainPath: '+mainPath)
        //engine.load(mainPath)
        /*move "Z:/home/ns/Descargas/p400/zoolv4-main/*" "Z:/home/ns/Descargas/p400/"
    let m0
    rmdir "Z:/home/ns/Descargas/p400/zoolv4-main" /s /q*/
    }
    function proc7ZipStdOut(data){
        let m0
        let m1
        if(data!=="finished"){
            if(data.indexOf('Extracting archive: ')>=0){
                m0=data.split('Extracting archive: ')
                m1=m0[1].split(' ')
                let m3=m1[0].split('.zip')
                //log.lv('7Zip Archivo: '+m3[0]+'.zip')
                r.cPorc=0.00
                txtLog.text='Descomprimiendo: '+m3[0]+'.zip\nEspere unos segundos...'
            }else if(data.indexOf('Everything is Ok')>=0){
                //log.lv('7Zip OK: '+data)
                m0=data.split('Size = ')
                if(m0.length>1){
                    m1=m0[1].split('\n')
                    let t=parseInt(parseInt(m1[0])/1024/1024)
                    //log.lv('7Zip OK Tamaño: ['+t+'Mb]')
                    txtLog.text='Descomprimido: '+t+'Mb.'
                }else{
                    //log.lv('7Zip ????: '+data)
                    //r.cPorc=100.00
                    r.uStdOut='Archivo descomprimido con éxito.'
                    //t7ZipFinished.start()
                }

            }else if(data.indexOf('%')>=0){
                m0=data.split('%')
                //let m1=m0[1].split('\n')
                //let t=parseInt(parseInt(m1[0])/1024/1024)
                let p=(''+m0[0]).replace(/[^0-9\s]/g, "");
                let p2=parseFloat(p).toFixed(2)
                r.cPorc=p2
                //t7ZipFinished.restart()
                //log.lv('7Zip PORC: ['+p2+']')
                //txtLog.text='Descomprimido: '+t+'Mb.'
            }else{
                log.lv('7Zip: '+data)
            }
        }else{
            r.cPorc=100.00
            txtLog.text='Cargando aplicación...'
            let mainPath=r.uZipFilePath
            mainPath=mainPath.replace('.zip', '-main')
            if(r.dev)log.lv('unik.addImportPath(...): '+mainPath)
            //unik.addImportPath(mainPath+'/modules')
            if(r.dev)log.lv('Cargando main.qml en '+mainPath)
            mainPath=mainPath+'/main.qml'

            //unik.clearComponentCache()
            //engine.load(mainPath)
            //app.close()
        }

    }
    function unZip(zipfilePath, folder){
        mkUqp7Zip(zipfilePath, folder)
    }
    function mkUqpCleanFolder(url, folder){
        let c='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='Item{\n'
        c+='UnikQProcess{\n'
        c+='    id: uqp4\n'
        c+='    onFinished:{\n'
        c+='        downloadGitHub("'+url+'", "'+folder+'")\n'
        c+='        uqp2.destroy(0)\n'
        c+='    }\n'
        c+='    onLogDataChanged:{\n'
        //  c+='        procCurlStdOut(logData)\n'
        //c+='        log.lv("La carpeta '+folder+' ha sido vaciada.")\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='        let cmd=\'rm -r -rf "'+folder+'/*"\'\n'
        c+='        console.log("cmd clean: "+cmd)\n'
        c+='        log.lv("cmd clean: "+cmd)\n'
        c+='        run(cmd)\n'
        c+='    }\n'
        c+='}\n'
        c+='}\n'
        //log.lv(c)
        let comp=Qt.createQmlObject(c, xuqpCurl, 'uqp-curl-code')
    }
    Component.onCompleted: {
        if(r.version===''){
            r.folderRoot=unik.getPath(4)+'/qmlcodes'
        }else{
            r.folderRoot=unik.getPath(4)+'/'+r.version
        }
        //let url = 'https://github.com/nextsigner/zool-release'
        //downloadGitHub(url)
    }
}
