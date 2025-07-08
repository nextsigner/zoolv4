import QtQuick 2.0
import QtQuick.Controls 2.0

Item{
    id: r
    property string curlPath: Qt.platform.os==='windows'?unik.getPath(1)+'/curl-8.14.1_2-win64-mingw/bin/curl.exe':'curl'
    property string app7ZipPath: Qt.platform.os==='windows'?unik.getPath(1)+'/7-Zip32/7z.exe':'7z'
    property real cPorc: 0
    property string uStdOut: ''

    property string uZipFilePath: ''
    property string uFolder: unik.getPath(3)

    Item{
        id: xuqpCurl
    }
    Component.onCompleted: {
        //let url=getUrlFromRepositoryToZip('https://github.com/nextsigner/zoolv4')
        //mkUqpCurl(url, '/home/ns/Descargas', 'pzip1.zip')
        //log.lv('Url Git: '+url)
        let folder='/home/ns/Descargas/p400'
        //downloadGitHub('https://github.com/nextsigner/zoolv4', folder)
        downloadGitHub('https://github.com/nextsigner/zool-release', folder)
        //unZip('/home/ns/Descargas/zool-release.zip')
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
                    onClicked: {
                        cleanUqpCurl()
                        r.cPorc=0.00
                        r.uStdOut='Cancelado.'
                    }
                }
                Button{
                    text: 'Cerrar'
                    onClicked: {
                        xProgresDialog.visible=false
                    }
                }
            }
        }
    }
    Timer{
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
    function download(url){
        //return unik.downloadZipFile()
    }
    function downloadGitHub(url, folder){
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
                return
            }
            r.uZipFilePath=folder+'/'+repName+'.zip'
            if(unik.fileExist(uZipFilePath)){
                unik.deleteFile(r.uZipFilePath)
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
        if(d.indexOf('#')>=0){
            let s0="["+d+"]"
            let s1=s0.replace(/#/g, '')//m0[m0.length-1]
            let s2=s1.replace(/ /g, '')//m0[m0.length-1]
            let m0=s2.split('%')
            let s3=m0[m0.length-2]
            let sf=s3.replace(/\n/g, '').replace(/\r/g, '').replace(/\[/g, '')
            let nporc=parseFloat(sf).toFixed(2)
            r.cPorc=nporc>=0.0?nporc:0.00
            if(nporc>=100.0){
                r.uStdOut='Archivo descargado con éxito.'
                t7Zip.restart()
            }else{
                r.uStdOut='Descargando...'
            }
        }
    }
    function mkUqp7Zip(zipFilePath, folder){
        let c='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='Item{\n'
        c+='UnikQProcess{\n'
        c+='    onLogDataChanged:{\n'
        c+='        proc7ZipStdOut(logData)\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='        let cmd=\''+r.app7ZipPath+' x "'+zipFilePath+'" -o"'+folder+'" -aoa -bsp1   \'\n'
        c+='        console.log("cmd 7-Zip: "+cmd)\n'
        //c+='        xProgresDialog.visible=true\n'
        c+='        run(cmd)\n'
        c+='    }\n'
        c+='}\n'
        c+='}\n'
        //log.lv(c)
        let comp=Qt.createQmlObject(c, xuqpCurl, 'uqp-curl-code')
    }
    function mkUqpMove(zipFilePath){
        log.lv('zipFilePath: '+zipFilePath)
        let fileNameOfFolder=zipFilePath.replace('.zip', '-main')
        let fileNameOfFolder2=fileNameOfFolder.replace('-main', '')
        let c='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='Item{\n'
        c+='UnikQProcess{\n'
        c+='    onLogDataChanged:{\n'
        c+='        procMoveStdOut(logData)\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='        let cmd=\'mv "'+fileNameOfFolder+'" "'+fileNameOfFolder2+'"\'\n'
        c+='        console.log("cmd Move: "+cmd)\n'
        c+='        log.lv("cmd Move: "+cmd)\n'
        //c+='        xProgresDialog.visible=true\n'
        //c+='        run(cmd)\n'
        c+='    }\n'
        c+='}\n'
        c+='}\n'
        //log.lv(c)
        let comp=Qt.createQmlObject(c, xuqpCurl, 'uqp-curl-code')
    }
    /*move "Z:/home/ns/Descargas/p400/zoolv4-main/*" "Z:/home/ns/Descargas/p400/"
let m0
rmdir "Z:/home/ns/Descargas/p400/zoolv4-main" /s /q*/
    function proc7ZipStdOut(data){
        let m0
        let m1
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
                t7ZipFinished.start()
            }

        }else if(data.indexOf('%')>=0){
            m0=data.split('%')
            //let m1=m0[1].split('\n')
            //let t=parseInt(parseInt(m1[0])/1024/1024)
            let p=(''+m0[0]).replace(/[^0-9\s]/g, "");
            let p2=parseFloat(p).toFixed(2)
            r.cPorc=p2
            t7ZipFinished.restart()
            //log.lv('7Zip PORC: ['+p2+']')
            //txtLog.text='Descomprimido: '+t+'Mb.'
        }else{
            log.lv('7Zip: '+data)
        }

    }
    function unZip(zipfilePath, folder){
            mkUqp7Zip(zipfilePath, folder)
    }
}
