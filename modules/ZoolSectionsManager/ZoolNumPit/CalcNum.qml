import QtQuick 2.0
import ZoolTextInput 1.0
import comps.FocusSen 1.0

Rectangle{
    id: r
    width: parent.width
    height: col1.height+app.fs*0.5
    //border.width: 1
    //border.color: apps.fontColor
    color: 'transparent'
    //clip: true
    Column{
        id: col1
        anchors.centerIn: parent
        Item{width: 1; height: app.fs*1.2}
        ZoolTextInput{
            id: tiTexto
            width: r.width-app.fs*0.5
            height: app.fs*1.8
            t.font.pixelSize: app.fs*0.65
            t.parent.width: r.width-app.fs*0.5
            anchors.horizontalCenter: parent.horizontalCenter
            //KeyNavigation.tab: cbGenero//controlTimeFecha
            //t.maximumLength: 50
            borderColor:apps.fontColor
            borderRadius: app.fs*0.25
            padding: app.fs*0.25
            horizontalAlignment: TextInput.AlignLeft
            onTextChanged: {
                calc()
            }
            onEnterPressed: {
                calc()
            }
            FocusSen{
                width: parent.r.width
                height: parent.r.height
                radius: parent.r.radius
                border.width:2
                anchors.centerIn: parent
                visible: parent.t.focus
            }
            Text {
                text: 'Texto a calcular'
                font.pixelSize: app.fs*0.5
                color: 'white'
                //anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
            }
        }
        Item{width: 1; height: app.fs*0.5}
        Row{
            id: row1
            //width: r.width
            height: app.fs*3
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
    Component{
        id: comp
        Rectangle{
            id: xItem
            width: aData[0]!=='TOTAL'?w:app.fs*2
            height: w*2//col.height
            color: apps.backgroundColor
            border.width: 1
            border.color: 'red'
            opacity: aData[1]===0||aData[2]===0?0.0:1.0
            property var aData: ['a', 1]
            property int w: app.fs
            Column{
                id: col
                anchors.centerIn: parent
                Repeater{
                    model: aData[0]!==' '?xItem.aData:[xItem.aData[1]]//aData[0]!=='TOTAL'?xItem.aData:1
                    Rectangle{
                        width: aData[0]!=='TOTAL'?xItem.w:txt.contentWidth+app.fs*0.5
                        height: width
                        border.width: aData[0]!==' '?1:app.fs*0.15
                        border.color: aData[0]!==' '?apps.fontColor:'red'
                        color: apps.backgroundColor
                        Text{
                            id: txt
                            text: aData[0]!==' '?modelData:aData[1]
                            font.pixelSize: aData[0]!=='TOTAL'?parent.width*0.8:parent.width*0.3
                            color: apps.fontColor
                            anchors.centerIn: parent
                            opacity: txt.contentWidth<parent.width-4
                            Timer{
                                running: parent.contentWidth>parent.parent.width-4
                                repeat: true
                                interval: 100
                                onTriggered: {
                                    parent.font.pixelSize-=2
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    Component{
        id: compTotal
        Rectangle{
            id: xItem
            width: aData[0]!=='TOTAL'?w:app.fs*2
            height: w*2//col.height
            color: apps.backgroundColor
            border.width: 1
            border.color: 'red'
            //opacity: aData[0]===' '?0.0:1.0
            property var aData: ['a', 1]
            property int w: app.fs
            Column{
                id: col
                anchors.centerIn: parent
                Repeater{
                    model: xItem.aData//aData[0]!=='TOTAL'?xItem.aData:1
                    Rectangle{
                        width: txt.contentWidth+app.fs*0.5
                        height: xItem.w
                        border.width: 1
                        border.color: apps.fontColor
                        color: apps.backgroundColor
                        Text{
                            id: txt
                            text: modelData//aData[0]!=='TOTAL'?modelData:'Total: '+modelData
                            font.pixelSize: app.fs*0.5
                            color: apps.fontColor
                            anchors.centerIn: parent
                        }
                    }
                }
            }
        }
    }
    Component.onCompleted: {
        tiTexto.t.focus=true
    }
    function clear(){
        for(var i=0;i<row1.children.length;i++){
            row1.children[i].destroy(0)
        }
    }
    function calc(){
        clear()
        let tot=0
        let textProc=(''+tiTexto.t.text.toUpperCase())+' '
        let mText=textProc.split('')
        var a=[]
        let tp=0
        for(var i=0;i<mText.length;i++){
            a=[]
            a.push(mText[i])
            let num=getNumOfLetter(mText[i])
            tot+=num
            if(mText[i]===' '){
                a.push(tp)
                a.push(tot)
                tp=0
                let obj0=comp.createObject(row1, {aData: a})
            }else{
                a.push(num)
                a.push(tot)
                let obj=comp.createObject(row1, {aData: a})
            }
            tp+=num
        }
        a=[]
        a.push(' ')
        a.push(0)
        a.push(0)
        let objSpace=comp.createObject(row1, {aData: a})

        let numRed=tot//getNumRed(tot)
        for(i=0;i<20;i++){
            let stot='TOTAL'
            a=[]
            if(isReducible(numRed)){
                stot='Sub.T'
                a.push(stot)
                a.push(numRed)
                let objSubTotal=compTotal.createObject(row1, {aData: a})
                numRed=getNumRed(numRed)
                a=[]
                a.push(' ')
                a.push(0)
                let objSpace2=comp.createObject(row1, {aData: a})
            }else{
                //stot='Sub.T'
                //a.push(stot)
                //a.push(tot)
                //let objTotal=compTotal.createObject(row1, {aData: a})
                //break
            }
        }
        a = []
        a.push('TOTAL')
        a.push(numRed)
        let objTotal=compTotal.createObject(row1, {aData: a})
    }
    function getNumOfLetter(l){
        let ret=0
        if(l==='1' || l==='A' || l==='J' || l==='S'){
            ret=1
        }
        if(l==='2' || l==='B' || l==='K' || l==='T'){
            ret=2
        }
        if(l==='3' || l==='C' || l==='L' || l==='U'){
            ret=3
        }
        if(l==='4' || l==='D' || l==='M' || l==='V'){
            ret=4
        }
        if(l==='5' || l==='E' || l==='N' || l==='Ñ' || l==='W'){
            ret=5
        }
        if(l==='6' || l==='F' || l==='O' || l==='X'){
            ret=6
        }
        if(l==='7' || l==='G' || l==='P' || l==='Y'){
            ret=7
        }
        if(l==='8' || l==='H' || l==='Q' || l==='Z'){
            ret=8
        }
        if(l==='9' || l==='I' || l==='R'){
            ret=9
        }
        return ret
    }
    function isReducible(n){
        let is=false
        if(n>=10 && n!==13 && n!==14 && n!==16 && n !==19){
            is=true
        }
        return is
    }
    function getNumRed(n){
        let ret=n
        let m0=(''+ret).split('')
        let nRet=0
        for(var i2=0;i2<m0.length;i2++){
            nRet+=parseInt(m0[i2])
        }
        ret=nRet
        return ret
    }
}
