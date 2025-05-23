import QtQuick 2.0

Item {
    id: r
    width: colCellsPlanets.width
    height:  cellWidth
    property bool isExt: false
    property int cellWidth: 10
    property int planet: -1
    property alias col: colCells
    Column{
        id: colCellsPlanets
        Repeater{
            //model:15
            model:20
            CellPlanetAsp{
                width: r.cellWidth
                indexPlanet: r.planet
                opacity: r.planet===index?1.0:0.0
                enabled: opacity===1.0
                yIndex: index
                isExt: r.isExt

                //visible: r.planet===index
            }
        }
    }
    Column{
        id: colCells
        Repeater{
            //model:15
            model:20
            CellAsp{
                objectName: 'cellAsp_'+index
                width: r.cellWidth
                opacity: index>planet&&r.planet!==index?1.0:0.0
                enabled: opacity===1.0
                bodie: r.planet
                yIndex: index
                isExt: r.isExt
                //visible: false
                //visible: opacity===1.0
                //indexAsp: 2
            }
        }
    }
    function clear(){
        for(var i=0;i<15;i++){
            let cellRow=colCells.children[i]
            cellRow.indexAsp=-1
            cellRow.indexPosAsp=-1
        }
    }
}
