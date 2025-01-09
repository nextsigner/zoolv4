import QtQuick 2.0

Item{
    id: r
    QtObject{
        id: setZoolLastVersion
        function setData(data, isData){
            if(isData){
                console.log('Host: '+data)
                let m0=data.split('\n')
                let s=''
                for(var i=0;i<m0.length;i++){
                    if(m0[i].indexOf('<link>')>=0 && m0[i].indexOf('Zool_v')>=0 && m0[i].indexOf('.exe')>=0){
                        let m1=m0[i].split('Zool_v')
                        let m2=m1[1].split('.exe')
                        s+=''+m2[0]+'\n'
                        break
                    }
                }
                let jsonNot={}
                jsonNot.id='winuptate'
                let v1=s
                v1=v1.replace(/ /g, '').replace(/\n/g, '')
                let v2=app.version
                v2=v2.replace(/ /g, '').replace(/\n/g, '')
                if(v1===v2){
                    jsonNot.text='Está utilizando la versión más actualizada de Zool.\n\nVersión actual: '+v2+'\nÚltima versión disponible: '+v1+''
                    zpn.addNot(jsonNot, true, 20000)
                }else{
                    jsonNot.text='Hay una nueva versión de Zool disponible\n\nVersión actual: '+v2+'\nVersión disponible: '+v1+''
                    jsonNot.url='https://sourceforge.net/projects/zool/files/'
                    jsonNot.bot1Text='Ver página de Descarga'
                    zpn.addNot(jsonNot, true, 20000)
                }

                /*let c='import QtQuick 2.0\n'
                c+='Item{\n'
                c+='    Component.onCompleted:{\n'
                c+='        log.lv("Descargando actualización...")\n'
                //c+='        var gitDownloaded=unik.downloadGit(\'https://github.com/nextsigner/zoolv4.git\', \'C:\\pd1\')\n'
                //https://github.com/nextsigner/zoolv4/archive/refs/heads/main.zip
                c+='       var gitDownloaded=unik.downloadZipFile(\'https://downloads.sourceforge.net/project/zool/Zool_v4.11.18.2.zip.zip?use_mirror=sitsa\', \'C:/pd1\')\n'
                c+='        log.lv("Descargado: "+gitDownloaded)\n'
                c+='    }\n'
                c+='}\n'
                jsonNot.qml=c*/

                //log.lv(s)
                //let comp=Qt.createQmlObject(data, app, 'xzoolstart')
            }else{
                //console.log('setXZoolStart Data '+isData+': '+data)
                //JS.showMsgDialog('Error! - Zool Informa', 'Problemas de conexión a internet', 'Por alguna razón, la aplicación no está pudiendo acceder a internet para obtener los datos requeridos. Error: '+data)
            }
        }
    }

    Component.onCompleted: {
        let ms=new Date(Date.now()).getTime()
        app.j.getRD('https://sourceforge.net/projects/zool/rss?path=/&r='+ms, setZoolLastVersion)

    }
}
