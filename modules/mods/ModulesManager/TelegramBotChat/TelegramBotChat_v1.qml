import QtQuick 2.0
import QtQuick.Controls 2.0
import Qt.labs.settings 1.1
import QtQuick.Layouts 1.12
import QtQuick.LocalStorage 2.12


import comps.FocusSen 1.0
import ZoolButton 1.2
import ZoolText 1.4
import ZoolTextInput 1.1

Item{
    id: rMod
    width: 1
    height: 1
    property string moduleName: 'InterLink'
    property var aParents: [xMed, xLatIzq, xLatDer, capa101]
    Settings{
        id: s
        fileName: u.getPath(4)+'/module_'+r.moduleName+'.cfg'
        property int typeShow: 0
        onTypeShowChanged: {
            r.parent=rMod.aParents[s.typeShow]
        }
    }
    Rectangle{
        id: r
        width: parent.width
        height: parent.height
        border.width: 1
        border.color: apps.fontColor
        radius: app.fs*0.25
        color: apps.backgroundColor
        parent: zsm.getPanel('ModulesManager')
        property string token: '8362574405:AAGTg51UkjETUe_8lkSCJDOtgO4uhMTA6W4'
        property string chatId: "8415772982"
        MouseArea{
            anchors.fill: parent
            onDoubleClicked: {
                toNextArea()
            }
        }
        Column{
            id: col
            anchors.centerIn: parent
            spacing: app.fs*0.5
            Item{width: 1; height: app.fs*0.5}
            Text{
                id: txtTit
                text:'<b>InterLink</b>'
                font.pixelSize: app.fs*0.5
                color: apps.fontColor
                anchors.horizontalCenter: parent.horizontalCenter
            }
            //Item{width: 1; height: app.fs*0.5}
            Rectangle{
                width: r.width
                height: r.height
                color: '#333'
                border.width: 2
                border.color: 'red'
                ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 10

                        // Área de visualización de mensajes

                            ListView {
                                id: chatView
                                model: ListModel { id: chatModel }
                                delegate: Text {
                                    text: "<b>" + (model.fromMe ? "Yo: " : "Bot: ") + "</b>" + model.message
                                    wrapMode: Text.WordWrap
                                    width: chatView.width
                                }
                            }


                        // Campo de entrada de texto
                        RowLayout {
                            TextField {
                                id: messageInput
                                placeholderText: "Escribe un mensaje..."
                                Layout.fillWidth: true
                                onAccepted: sendBtn.clicked()
                            }
                            Button {
                                id: sendBtn
                                text: "Enviar"
                                onClicked: {
                                    if (messageInput.text !== "") {
                                        enviarMensaje(messageInput.text);
                                    }
                                }
                            }
                        }

                        Button {
                            text: "Actualizar Chat"
                            Layout.fillWidth: true
                            onClicked: recibirMensajes()
                        }
                    }

                    // --- FUNCIONES DE RED ---

                    }

        }
        ZoolButton{
            id: botChangeArea
            text:'Cambiar de Area'
            fs: app.fs*0.35
            colorInverted: true
            anchors.right: parent.right
            anchors.rightMargin: app.fs*0.1
            anchors.top: parent.top
            anchors.topMargin: app.fs*0.1
            onClicked: {
                toNextArea()
            }
        }
    }
    Component.onCompleted: {
        initDb()
    }


    /*function enviarMensaje(texto) {
        var url = "https://api.telegram.org/bot" + r.token + "/sendMessage";
        var params = "chat_id=" + r.chatId + "&text=" + encodeURIComponent(texto);

        var xhr = new XMLHttpRequest();
        xhr.open("POST", url, true);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                chatModel.append({"message": texto, "fromMe": true});
                messageInput.text = "";
            }
        }
        xhr.send(params);
    }*/
    function enviarMensaje(texto) {
        var url = "https://api.telegram.org/bot" + r.token + "/sendMessage";
        var params = "chat_id=" + r.chatId + "&text=" + encodeURIComponent(texto);

        var xhr = new XMLHttpRequest();
        xhr.open("POST", url, true);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    // AQUÍ: Como el envío fue exitoso, lo agregamos manualmente al chat
                    chatModel.append({
                        "message": texto,
                        "fromMe": true,
                        "updateId": 0 // ID ficticio
                    });
                    messageInput.text = "";
                } else {
                    console.log("Error al enviar: " + xhr.responseText);
                    log.lv("Error al enviar: " + xhr.responseText);
                }
            }
        }
        xhr.send(params);
    }

    function recibirMensajes() {
        //Get Chat ID: https://api.telegram.org/bot8362574405:AAGTg51UkjETUe_8lkSCJDOtgO4uhMTA6W4/getUpdates
        //var url = "https://api.telegram.org/bot" + r.token + "/getUpdates";
        var url = "https://api.telegram.org/bot8362574405:AAGTg51UkjETUe_8lkSCJDOtgO4uhMTA6W4/getUpdates"

        var xhr = new XMLHttpRequest();
        xhr.open("GET", url, true);

        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                var response = JSON.parse(xhr.responseText);
                var results = response.result;
                log.lv('JSON: '+JSON.stringify(results, null, 2))

                // Limpiamos y recargamos para el ejemplo
                // (En un chat real compararías IDs para no duplicar)
                chatModel.clear();
                for (var i = 0; i < results.length; i++) {
                    var msg = results[i].message;
                    log.lv('results['+i+']: '+JSON.stringify(results[i], null, 2))
                    if (msg) {
                        chatModel.append({
                            "message": msg.text,
                            "fromMe": msg.chat.id.toString() === r.chatId
                        });
                    }
                }
            }
        }
        xhr.send();
    }


    //-->Teclado
    function toEnter(ctrl){

    }
    function clear(){

    }
    function toLeft(ctrl){
        if(!ctrl){

        }else{

        }
    }
    function toRight(ctrl){
        if(!ctrl){

        }else{

        }
    }
    function toUp(){

    }
    function toDown(){

    }
    function toTab(){

    }
    function toEscape(){

    }
    function isFocus(){
        return false
    }
    function toHelp(){
        let itemHelpExist=zsm.cleanOneDinamicItems("ItemHelp_"+app.j.qmltypeof(r))
        if(!itemHelpExist){
            let text='<h2>Ayuda en Construcción</h2><br><br><b><b>Presionar F1: </b>Para ver u ocultar esta ayuda.'

            let c='import comps.ItemHelp 1.0\n'
            c+='ItemHelp{\n'
            c+='    text:"'+text+'"\n'
            c+='    ctx: "'+zsm.cPanelName+'"\n'
            c+='    objectName: "ItemHelp_'+app.j.qmltypeof(r)+'"\n'
            c+='}\n'
            let comp=Qt.createQmlObject(c, zsm, 'itemhelpcode')
        }
    }



    property var db: null

    function initDb() {
        //engine.setOfflineStoragePath("C:/Ruta/Personalizada/De/Mi/App");
        db = LocalStorage.openDatabaseSync("ChatDB", "1.0", "Historial de Telegram", 1000000);
        db.transaction(function(tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS Mensajes(id INTEGER PRIMARY KEY AUTOINCREMENT, texto TEXT, autor TEXT)');
        });
    }

    function guardarMensaje(texto, autor) {
        db.transaction(function(tx) {
            tx.executeSql('INSERT INTO Mensajes (texto, autor) VALUES(?, ?)', [texto, autor]);
        });
    }

    //<--Teclado

    //-->Funciones ModulesTemplate
    function toNextArea(){
        if(s.typeShow<rMod.aParents.length-1){
            s.typeShow++
        }else{
            s.typeShow=0
        }
        zpn.log('s.fileName: '+s.fileName)
    }
    //<--Funciones ModulesTemplate
}
