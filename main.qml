import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 1.4
Window {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    property int colWidth: 100
    property int rows: 0
    property int cols: 0
    property var titles: []
    property var dum:  [
        [
            "primoa",
            "secondo",
            "a",
            "b",
            "c"
        ],
        [
            "terxo",
            "quaerto",
            "d",
            "e",
            "f"
        ],
        [
            "quinti",
            "sesto",
            "g",
            "h",
            "i"
        ]
    ]

    Component.onCompleted: {
        var i = 0
        var j= 0
        rows = dum.length
        cols = dum[0].length
        colWidth = window.width / cols

        for (j = 0; j < cols; j++) {
            titles[j]  = dum[0][j]
        }

        for (i = 1; i < rows; i++) {
            var row = {}
            for (j = 0; j < cols; j++) {
                var role = "col" + j
                row[role]  = dum[i][j]
            }
            sheetModel.append(row)
        }
        tableView.resources = tableHeader()
    }

    function tableHeader() {
       var roles = [...(new Array(cols)).keys()];
       var temp = []
       for(var i = 0; i< roles.length; i++) {
           var role  = "col" + roles[i]
           temp.push(columnComponent.createObject(tableView, { "role": role, "title": titles[i]}))
       }
       return temp
    }

    ListModel {
        id: sheetModel
    }

    Component
    {
        id: columnComponent
        TableViewColumn{width: colWidth }
    }

    TableView {
        id: tableView
        anchors.fill: parent
        model: sheetModel
        itemDelegate: Rectangle {
            implicitWidth: 15
            implicitHeight: 15
            color: "transparent"
            Text {
                anchors.fill: parent
                color: styleData.textColor
                elide: styleData.elideMode
                text: styleData.value
            }
        }
    }
}
