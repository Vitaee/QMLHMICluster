import QtQuick 2.0

Row {
        id: motoramaGear
        width: 120
        height: 69
        property int activeFontSize: 40
        property int passiveFontSize: 30
        property color activeFontColor: "green"
        property color passiveFontColor: "#e6ffffff"
        property string currentGearId: "1"
        property double passiveOpacity : 0.65
        property Text currentGear: gearP
        spacing : 8

        Text {
                id: gearP
                height: parent.height
                width: parent.width / 4
                color: activeFontColor
                text: "P"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: activeFontSize
        }

        Text {
                id: gearR
                height: parent.height
                width: parent.width / 4
                color: passiveFontColor
                text: "R"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: passiveFontSize
        }

        Text {
                id: gearN
                height: parent.height
                width: parent.width / 4
                color: passiveFontColor
                text: "N"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: passiveFontSize
        }

        Text {
                id: gearD
                height: parent.height
                width: parent.width / 4
                color: passiveFontColor
                text: "D"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: passiveFontSize
        }




        Connections {
                target: motoramaGear
                onCurrentGearIdChanged: {
                        // Deactivate
                        currentGear.font.pointSize = passiveFontSize;
                        currentGear.color = passiveFontColor;


                        // handleGear
                        if (currentGearId === "0") {
                                currentGear = gearP;
                        } else if (currentGearId === "1") {
                                currentGear = gearR;
                        } else if (currentGearId === "2") {
                                currentGear = gearN;
                        } else if (currentGearId === "3") {
                                currentGear = gearD;
                        }

                        for(var i=0; i<4; i++)
                                motoramaGear.children[i].opacity = passiveOpacity;

                        currentGear.font.pointSize = activeFontSize;
                        currentGear.color = activeFontColor;
                        currentGear.opacity = 1;
                }
        }
}
