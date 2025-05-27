import QtQuick 2.0

Rectangle{
    id: r
    width: 300
    height: lv.height
    color: 'transparent'
    border.width: 2
    border.color: apps.fontColor
    clip: true
    property alias olv: lv
    property alias olm: lm
    signal selected(string j)
    ListView{
        id: lv
        model: lm
        delegate: compItem
        width: r.width
        height: contentHeight
        //anchors.fill: parent

    }
    ListModel{
            id: lm
            function ai(vj){
                return {
                    j: vj
                }
            }
    }
    Component{
        id: compItem
        Rectangle{
                id: xItem
                width: r.width-app.fs*0.2
                height: t1.contentHeight+app.fs*0.2
                color: index===lv.currentIndex?apps.fontColor:apps.backgroundColor
                border.width: 1
                border.color:index!==lv.currentIndex?apps.fontColor:apps.backgroundColor
                anchors.horizontalCenter: parent.horizontalCenter
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        lv.currentIndex=index
                        r.selected(JSON.stringify(j))
                    }
                }
                Text{
                    id: t1
                    width: parent.width-app.fs*0.2
                    wrapMode: Text.WordWrap
                    font.pixelSize: app.fs*0.5
                    color: index!==lv.currentIndex?apps.fontColor:apps.backgroundColor
                    horizontalAlignment: Text.AlignHCenter
                    anchors.centerIn: parent
                }
                Component.onCompleted: {
                    /*
 {
  "a": 1976,
  "af": 1977,
  "ai": 1976,
  "b": "Marte",
  "d": 10,
  "df": 1,
  "di": 1,
  "gb": 134.45937343697767,
  "gr": 134.4070384569482,
  "h": 16,
  "isData": true,
  "m": 6,
  "mf": 1,
  "mi": 1,
  "min": 48,
  "numAstro": 4,
  "tol": 0.1
}
                    */
                    t1.text=j.b+' '+j.d+'/'+j.m+'/'+j.a+' '+j.h+':'+j.min
                    //console.log(t1.text)
                }
        }
    }
    function addItem(j){
        lm.append(lm.ai(j))
    }
    function clear(){
        lm.clear()
    }
    function isDateInList(j){
        let ret=false
        for(var i=0;i<lm.count;i++){
            let j0=lm.get(i).j
            if(j.a===j0.a && j.m===j0.m && j.d===j0.d){
                ret=true
                break
            }
        }
        return ret
    }
}
