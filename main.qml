import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4

Window {
    visible: true
    width: 800
    height: 450
    title: qsTr("HMI Cluster")

    Rectangle{

        Keys.onPressed:{
            if (event.key == Qt.Key_R){
                changeGear("1")
            } else if (event.key == Qt.Key_D){
                changeGear("3")
            }else if (event.key == Qt.Key_P){
                changeGear("0")
            }else if(event.key == Qt.Key_N){
                changeGear("2")
            } else if(event.key == Qt.Key_4){
                changeSignal("left")
            } else if (event.key == Qt.Key_6){
                changeSignal("right")
            }

        }

        id: background
        width: 800
        height: 450
        color: "black"

        anchors { centerIn: parent }



        // left speed bar.
        SpeedBars{
            id: leftSpeed


            property bool accelerate
            value: accelerate ? maximumValue : 0

            antialiasing: true
            maximumValue: 180
            Component.onCompleted: forceActiveFocus()
            Behavior on value { NumberAnimation { duration: 1500 }}
            Keys.onSpacePressed: accelerate = true;

            Keys.onReleased: {
                if (event.key === Qt.Key_Space) {

                    accelerate = false;
                    event.accepted = true;
                }
            }

            Text {
                    width: 60
                    color: "#56fdff"
                    text: leftSpeed.value.toFixed(0) + " k/m"

                    y: 220
                    x:115



            }


        }



        function changeGear(gearData){
            lGear.currentGearId = gearData
        }
        function changeSignal(signalData){
            if (signalData == "left"){

                if (!turn_left.visible){

                   turn_left.visible = true;
                } else if ( turn_left.visible){
                    turn_left.visible = false;
                }

            } else if (signalData == "right"){
                if (!turn_right.visible){

                   turn_right.visible = true;
                } else if ( turn_right.visible){
                    turn_right.visible = false;
                }

            }


        }

        Gears {
                id: lGear
                x: 357
                y: 500
                currentGearId: "0"
                anchors{
                    horizontalCenter: background.horizontalCenter
                    centerIn: background
                }

        }

        Text {
            id: clock
            text: "Clock"
            color: "white"
            anchors{
                horizontalCenter: background.horizontalCenter

            }
            y: 50
        }
        Text {
            id: dayInfo
            text: "Date"
            color: "white"
            anchors{
                horizontalCenter: background.horizontalCenter

            }
            y: 75 }
        Timer {
            interval: 500
            running: true
            repeat: true

            onTriggered: {
                var date = new Date()
                clock.text = date.toLocaleTimeString(Qt.locale("tr_TR"), "HH:mm:ss")
                dayInfo.text = date.toLocaleDateString(Qt.locale("tr_TR"))

            }
        }


        // right speed bar.

        CircularGauge{
            property bool accelerate1
            value: 0
            id: rightSpeed
            maximumValue: 80

            anchors{
                verticalCenter: background.verticalCenter
                right: background.right
            }

            Behavior on value {
                NumberAnimation{
                    duration: 3000
                    easing.type: Easing.OutQuad

                }
            }





        }
        Timer{
            repeat: true
            running: true
            interval:  2000
            onTriggered: {
                var data = Math.floor(Math.random() * 90) + 0
                rightSpeed.value = data
            }
        }

        Image{
            id:turn_left
            x:247
            y:95
            opacity: 1
            smooth: true

            source: "Turn_Left.png"
            width: 25
            height:25
            antialiasing: true
            visible: true


        }


        Image {
            id:turn_right
            source: "Turn_Right.png"
            y:95
            x: 528
            width: 25
            height: 25
            visible: true
        }

    }

}
