import QtQuick 2.7
import QtQuick.Controls 2.12

//import ZoolMenus.ZoolMenuCtxSep 1.0

Rectangle {
    id: r
    width: parent.width
    height: app.fs*1.5
    color: apps.backgroundColor
    border.width: 1
    border.color: apps.fontColor

    property string stringMiddleSeparator: 'VN'
    property url uItemGrabber
    property int fs: app.fs*0.5
    property var atLeft: []
    property var atRight: []
    property string uExtIdLoaded: ''

    onAtLeftChanged: {
        //setDataView(r.stringMiddleSeparator, r.atLeft, r.atRight)
    }
    onAtRightChanged: {
        //setDataView(r.stringMiddleSeparator, r.atLeft, r.atRight)
    }
    Rectangle{
        width: txtLoading.contentWidth+app.fs*0.3
        height: txtLoading.contentHeight+app.fs*0.3
        color: apps.backgroundColor
        border.width: 2
        border.color: apps.fontColor
        radius: app.fs*0.1
        anchors.centerIn: parent
        visible: !row.visible
        Text{
            id: txtLoading
            text: '<b>Cargando...<b>'
            font.pixelSize: r.height*0.5
            color: apps.fontColor
            anchors.centerIn: parent
        }
    }
    Row{
        anchors.centerIn: parent
        //anchors.horizontalCenterOffset: r.width*0.5-row.width*0.5-()
        parent: xSep
        z:9
        visible: r.atRight.length>0
        Rectangle{
            width: r.width
            height: r.height
            color: apps.houseColor
        }
        Rectangle{
            width: r.width
            height: r.height
            color: apps.houseColorBack
        }
    }
    Row{
        id: row
        width: rowDataLeft.width+xSep.width+rowDataRight.width+spacing*2
        spacing: app.fs*0.15
        anchors.centerIn: parent
        visible: !tResizeFs.running
        Rectangle{
            id: circuloSaveRemote
            width: app.fs*0.5
            height: width
            radius: width*0.5
            color: 'green'
            border.width: 2
            border.color: apps.fontColor
            anchors.verticalCenter: parent.verticalCenter
            //y:(parent.height-height)/2
            visible:  circuloSave.visible
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    let j=zfdm.getJsonAbs()
                    //log.lv('j:'+JSON.stringify(j.params, null, 2))
                    zrdm.sendNewParams(j)
                }
            }
        }
        Rectangle{
            id: circuloSave
            width: app.fs*0.5
            height: width
            radius: width*0.5
            color: !zm.isDataDiff?'gray':'red'
            border.width: 2
            border.color: apps.fontColor
            anchors.verticalCenter: parent.verticalCenter
            //y:(parent.height-height)/2
            visible:  !zm.ev
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(!zm.isDataDiff)return
                    let date=new Date(Date.now())
                    let msmod=date.getTime()
                    let json=zm.currentJson.params
                    //log.lv('Parmas'+JSON.stringify(json, null, 2))
                    //let cjson=JSON.parse(zm.fileData)
                    let cjson=zfdm.getJsonAbs()
                    let j=zm.getParamsFromArgs(cjson.params.n, json.d, json.m, json.a, json.h, json.min, json.gmt, json.lat, json.lon, json.alt, cjson.params.c, cjson.params.t, json.hsys, cjson.params.ms, msmod)

                    //log.lv('Parmas'+JSON.stringify(cjson, null, 2))
                    //log.lv('Parmas: '+JSON.stringify(j, null, 2))
                    //log.lv('zm.currentJson: '+JSON.stringify(zm.currentJson.params, null, 2))
                    //zfdm.saveJson(j)
                    zfdm.updateParams(j.params, true)
                }
            }
        }
        Row{
            id: rowDataLeft
            spacing: app.fs*0.15
            anchors.verticalCenter: parent.verticalCenter
        }
        Item{
            id: xSep
            width: txtSep.contentWidth+app.fs*0.3+border.width
            height: txtSep.contentHeight+app.fs*0.3+border.width
            anchors.verticalCenter: parent.verticalCenter
            visible: r.atRight.length>0
            z:-100
            Rectangle{
                id: bgSep
                anchors.fill: parent
                color: apps.fontColor
                border.width: app.backIsSaved?2:6
                border.color: apps.backgroundColor
                radius: app.fs*0.1
                z:10

//                SequentialAnimation on border.color {
//                    running: !app.backIsSaved
//                    loops: Animation.Infinite
//                    ColorAnimation {
//                        from: apps.fontColor
//                        to: apps.backgroundColor
//                        duration: 400
//                    }
//                    ColorAnimation {
//                        from: apps.backgroundColor
//                        to: apps.fontColor
//                        duration: 400
//                    }

//                }

            }
            Text{
                id: txtSep
                text: '<b>'+r.stringMiddleSeparator+'</b>'
                //font.pixelSize: !app.backIsSaved?r.height*0.35:r.height*0.5
                font.pixelSize: r.height*0.5
                color: apps.backgroundColor
                anchors.centerIn: parent
                z:11
            }
            MouseArea{
                anchors.fill: parent
                //enabled: parent.cellIndex===0
                acceptedButtons: Qt.AllButtons;
                onClicked: {
                    if (mouse.button === Qt.RightButton) {
                        zMenuSep.stringMiddleSep=r.stringMiddleSeparator
                        zMenuSep.popup()

                    } else if (mouse.button === Qt.LeftButton) {
                        //Qt.quit()
                    }
                }
            }

//            Rectangle{
//                id: xTxtSG
//                width: txtSG.contentWidth+app.fs*0.3+border.width
//                height: txtSG.contentHeight+border.width
//                color: apps.fontColor
//                border.width: 1
//                border.color: bgSep.border.color
//                radius: app.fs*0.1
//                anchors.horizontalCenter: parent.horizontalCenter
//                anchors.verticalCenter: parent.bottom
//                z: txtSep.z+1
//                visible: !app.backIsSaved

////                MouseArea{
////                    anchors.fill: parent
////                    onClicked: {
////                        let isSaved=zfdm.saveExtToJsonFile(r.uExtIdLoaded)
////                        app.backIsSaved=isSaved
////                        if(apps.dev)log.lv('Guardado desde zoolDataView: '+app.backIsSaved)
////                    }
////                }

//                Text{
//                    id: txtSG
//                    text: '<b>Sin guardar</b>'
//                    font.pixelSize: r.height*0.2
//                    color: apps.backgroundColor//bgSep.border.color
//                    anchors.centerIn: xTxtSG
//                    //visible: xTxtSG.visible
//                }
//            }


        }
        Row{
            id: rowDataRight
            spacing: app.fs*0.15
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    Rectangle{
        anchors.fill: row
        border.width: 4
        border.color: 'red'
        color: 'transparent'
        visible: apps.dev
    }
    Component{
        id: compCellData
        Rectangle{
            width: txtRow.contentWidth+app.fs*0.3
            height: txtRow.contentHeight+app.fs*0.3
            color: apps.backgroundColor
            border.width: 2//modelData==='@'?0:1
            border.color: apps.fontColor
            radius: app.fs*0.1
            anchors.verticalCenter: parent.verticalCenter
            property int cellIndex: -1
            property string txtData: 'txtData'

            Rectangle{
                id: bgCell
                anchors.fill: parent
                color: apps.backgroundColor
                radius: parent.radius
                border.width: 1//modelData==='@'?0:1
                border.color: apps.fontColor
            }
            Text{
                id: txtRow
                //text: modelData!=='@'?modelData:r.stringMiddleSeparator//.replace(/_/g, ' ')
                text: txtData
                font.pixelSize: r.fs
                color: apps.fontColor
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                //enabled: parent.cellIndex===0
                acceptedButtons: Qt.AllButtons;
                onClicked: {
                    //apps.sweFs=app.fs
                    if (mouse.button === Qt.RightButton) { // 'mouse' is a MouseEvent argument passed into the onClicked signal handler
                        if(parent.cellIndex===0){
                            zMenuNom.popup()
                        }
                    } else if (mouse.button === Qt.LeftButton) {
                        //Qt.quit()
                    }
                }
            }

        }
    }
    //    Timer{
    //        id: tWaitUpdateData
    //        running: false
    //        repeat: false
    //        interval: 1500
    //        onTriggered: {
    //            if(row.width>app.fs*53){
    //                //tResizeFs.start()
    //            }else{
    //                //tResizeFs.stop()
    //                //row.visible=true
    //            }
    //        }
    //    }
    Timer{
        id: tResizeFs
        running: row.width>xApp.width
        repeat: true
        interval: 50
        onTriggered: {
            r.fs-=1
            //            //if(row.width<r.width-app.fs){
            //            if(row.width<app.fs*53){
            //                //stop()
            //                row.visible=true
            //            }
        }
    }
    function setDataView(sep, aL, aR){
        //row.visible=false
        r.fs=r.height*0.5
        r.stringMiddleSeparator=sep
        r.atLeft=aL
        r.atRight=aR
        //if(apps.dev)log.lv('zoolDataView.setDataView(sep, aL, aR): '+aL.toString()+' \n'+aR.toString())
        updateDataView()
    }
    function updateDataView(){
        for(var i=0; i < rowDataLeft.children.length;i++){
            rowDataLeft.children[i].destroy(1)
        }
        for(i=0; i < rowDataRight.children.length;i++){
            rowDataRight.children[i].destroy(1)
        }
        let aL=r.atLeft
        let aR=r.atRight
        for(i=0; i < aL.length;i++){
            var obj=compCellData.createObject(rowDataLeft, {txtData:aL[i], cellIndex: i})
        }
        for(i=0; i < aR.length;i++){
            obj=compCellData.createObject(rowDataRight, {txtData:aR[i]})
        }
        //tWaitUpdateData.start()
    }

    function clearExtData(){
        r.fs=r.height*0.5
        r.stringMiddleSeparator=''
        r.atRight=[]
        updateDataView()
    }
}
