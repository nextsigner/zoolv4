import QtQuick 2.0
import ZipManager 4.0

Rectangle{
    id: r
    parent: capa101
    color: apps.backgroundColor
    anchors.fill: parent
//    width: parent.width*0.6
//    height: parent.height
//    anchors.centerIn: parent
    property alias zm: zipManager
    MouseArea{
        anchors.fill: parent
    }
    Column{
        width: r.width-app.fs*4
        spacing: app.fs
        anchors.centerIn: parent
        Text {
            text: '<h2>Actualizando Zool</h2>'
            font.pixelSize: app.fs
            color: apps.fontColor
            anchors.horizontalCenter: parent.horizontalCenter
        }
        ZipManager{
            id: zipManager
            width: parent.width
            curlPath: Qt.platform.os==='windows'?'"'+unik.getPath(1).replace(/\"/g, '')+'/curl-8.14.1_2-win64-mingw/bin/curl.exe"':'curl'
            app7ZipPath: Qt.platform.os==='windows'?'"'+unik.getPath(1).replace(/\"/g, '')+'/7-Zip32/7z.exe"':'7z'
            uFolder: '"'+unik.getPath(3)+'"'
            onLog: unik.log(data)
            onDownloadFinished: {
                //Retorna: downloadFinished(string url, string folderPath, string zipFileName)
                unik.log('Se descargó: '+zipFileName)
                unik.log('Origen: '+url)
                unik.log('Destino: '+folderPath)
            }
            property string d1: ''
            property string d2: ''
            property string d3: ''
            onUnzipFinished: {
                if(url)d1=url
                if(folderPath && folderPath!=='')d2=folderPath
                if(zipFileName)d3=zipFileName
                //Retorna: unzipFinished(string url, string folderPath, string zipFileName)
                //unik.log('Se ha descomprimido: '+zipFileName)
                r.visible=false
                //unik.log('zipFileName: '+zipFileName)
                //unik.log('zipFileName url: '+url)
                //unik.log('zipFileName folderPath: '+folderPath)
                let mainPath=d2+'/zoolv4-main'
                let aname=(''+presetAppName).toLowerCase()
                let unikeyCfgPath=''+unik.getPath(4)+'/'+aname+'.cfg'
                let j={}
                j.args={}
                j.args['folder']=mainPath
                j.args['dev']=false
                j.args['dep']=false
                unik.log('Seteando '+unikeyCfgPath)
                unik.log('Seteando JSON: '+JSON.stringify(j, null, 2))
                unik.setFile(unikeyCfgPath, JSON.stringify(j, null, 2))
                //unik.run(unik.getPath(0)+' -folder='+mainPath)
                unik.restart(['-folder='+mainPath], unik.getPath(4))
                //unik.addImportPath(mainPath.replace(/\"/g, '')+'/modules')
                //unik.cd(""+mainPath.replace(/\"/g, ''))
                //unik.log('Cargando desde ZipManager en contexto '+app.ctx+': "'+mainPath.replace(/\"/g, '')+'/ain.qml"')
                //engine.load('file:///'+mainPath.replace(/\"/g, '')+'/main.qml')
            }
            onResponseRepExist:{
                if(res.indexOf('404')>=0){
                    //tiGitRep.color='red'
                    unik.log('El repositorio ['+url+'] no existe.')
                }else{
                    //tiGitRep.color=apps.fontColor
                    unik.log('El repositorio ['+url+'] está disponible en internet.')
                    unik.log('Para probarlo presiona ENTER')
                    unik.log('Para instalarlo presiona Ctrl+ENTER')
                }
            }
            onResponseRepVersion:{
                //procRRV(res, url, tipo)
            }
            //
        }
    }
    Component.onCompleted: {
        //let ms=new Date(Date.now()).getTime()
        //app.j.getRD('https://github.com/nextsigner/zoolv4/releases/latest?r='+ms, setZoolLastVersion)
        r.visible=false
        let url='https://github.com/nextsigner/zoolv4'
        let c=''
        let nUrl=url.replace('https://github.com', 'https://raw.githubusercontent.com')
        c=''+zipManager.curlPath+' -s '+nUrl+'/main/version'
        let cmd=c

        let onLogDataCode='zmu.procRRV(logData, \''+url+'\', \'update\')'
        let onFinishedCode='//Nada\n'
        let onCompleteCode='//Nada\n'
        app.j.runUqp(r, 'uqpRepVersion', cmd, onLogDataCode, onFinishedCode, onCompleteCode)
    }
    function log(t){
        zpn.log(t)
    }
    function procRRV(res, url, tipo){
        //unik.log('onResponseRepVersion res: '+res)
        //unik.log('onResponseRepVersion url: '+url)
        //unik.log('onResponseRepVersion tipo: '+tipo)
        let nCtx=''
        let nRes=res.replace('\n', '')
        let version=''
        version='update'
        if(nRes.split('.').length>=3){
            nCtx=nRes+'_'+url+'_'+tipo
            version='update_'+nRes
            unik.log('El repositorio '+url+' tiene disponible la versión '+nRes)
            zipManager.version=version
            //zpn.log('zipManager.folderRoot:'+zipManager.folderRoot)
            /*zipManager.isProbe=false
            zipManager.resetApp=false
            zipManager.setCfg=false
            //zipManager.launch=false
            zipManager.download(tiGitRep.text)*/
            let jsonNot={}
            jsonNot.id='winuptate'
            let v1=nRes
            v1=v1.replace(/ /g, '').replace(/\n/g, '')
            let v2=app.version
            v2=v2.replace(/ /g, '').replace(/\n/g, '')
            if(v1===v2){
                //if(false){
                jsonNot.text='Está utilizando la versión más actualizada de Zool.\n\nVersión actual: '+v2+'\nÚltima versión disponible: '+v1+''
                zpn.addNot(jsonNot, true, 20000)
            }else{
                jsonNot.text='Hay una nueva versión de Zool disponible\n\nVersión actual: '+v2+'\nVersión disponible: '+v1+''
                //jsonNot.url='https://github.com/nextsigner/zoolv4/releases/latest'
                //jsonNot.bot1Text='Ver Repositorio GitHub'
                let c='import QtQuick 2.0\n'
                c+='Item{\n'
                c+='    Component.onCompleted:{\n'
                c+='          zmu.visible=true\n'
                c+='          let url = "https://github.com/nextsigner/zoolv4"\n'
                c+='          zmu.zm.version="'+v1+'"\n'
                c+='          zmu.zm.isProbe=false\n'
                c+='          zmu.zm.resetApp=false\n'
                c+='          zmu.zm.setCfg=false\n'
                c+='          zmu.zm.download(url)\n'
                c+='    }\n'
                c+='}\n'
                jsonNot.qml=c
                jsonNot.bot2Text='Actualizar ahora'
                zpn.addNot(jsonNot, true, 20000)
            }
        }else{
            unik.log('El repositorio '+url+' NO tiene un archivo "version" disponible.')
        }
    }
}
