import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarthome_cloud/models/device_data.dart';
import 'package:smarthome_cloud/services/rmq_service.dart';
import 'package:smarthome_cloud/services/sqflite_service.dart';
import 'package:smarthome_cloud/ui/shared/ui_helper.dart';

class DetailDeviceView extends StatefulWidget {
  final Device device;
  DetailDeviceView(this.device);

  @override
  DetailDeviceViewState createState() => DetailDeviceViewState(this.device);
}

class DetailDeviceViewState extends State<DetailDeviceView> {
  Db database = Db();
  Device device;
  //bool status = false;
  bool index = false;
  // String cek;
  String test1 = "1";
  String test2 = "11";

  //String values = '1';
  RMQService rmqService = new RMQService();
  DetailDeviceViewState(this.device);



  @override
  void initState() {
    super.initState();
    //checkStatus();
  }

  // Future <void> checkStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if(test1 == '1' || test2 == '11'){
  //     var index1 = true;
  //   }else{
  //     var index1 = false;
  //   }
  //   await prefs.setBool('status', index);
  // }

  // @override
  // void replaceCharAt(){
  //   values =values.substring(0, index) + newChar ;
  //   print(values);
  // }

  void fungsiLampu1(bool status, String rule1, String rule2){
    if(status){
      rmqService.publish("${device.guid}#$rule1");
      //print(values);
      print("guid : ${device.guid} & $rule1 nyala");
    }else{
      rmqService.publish("${device.guid}#$rule2");
      //print(values);
      print("guid : ${device.guid} & $rule2 mati");
    }index = status;
  }
  void fungsiLampu2(bool status, String rule1, String rule2){
    if(status){
      rmqService.publish("${device.guid}#$rule1");
      //print(values);
      //print("guid : ${device.guid} nyala");
      print("guid : ${device.guid} & $rule1 nyala");
    }else{
      rmqService.publish("${device.guid}#$rule2");
      //print(values);
      //print("guid : ${device.guid} mati");
      print("guid : ${device.guid} & $rule2 mati");
    }index = status;
  }

  @override
  Widget build(BuildContext context) {
    String value1 = test1.replaceAll("1", "0");
    String value2 = test2.replaceAll("11", "00");

    // void cekState(bool status){
    //   if(test1 == '1'){
    //     fungsiLampu1(index);
    //   }else if(test1 == '11'){
    //     fungsiLampu2(index);
    //   }
    // }

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.redAccent,
              title: Text("Smarthome"),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 10, left: 3, right: 3),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.redAccent),
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text("Device Name : ${device.name}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text("Guid      : ${device.guid}"),
                              Text("Version : ${device.version}"),
                              Text("Type      : ${device.type}"),
                              Text("Rule       : ${device.quantity}"),
                              Text("Minor    : ${device.minor}"),
                              Text("Mac       : ${device.mac}")

                            ],
                          ),
                        ),
                        verticalSpaceSmall,
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: InkWell(
                            splashColor: Colors.white,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.decelerate,
                              width: 70,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                border: Border.all(
                                    color: index ? Colors.black : Colors.redAccent
                                ),
                                color: index ? Colors.redAccent : Colors.white,
                              ),
                              child: AnimatedAlign(
                                duration: const Duration(milliseconds: 300),
                                alignment: index ? Alignment.centerRight : Alignment.centerLeft,
                                curve: Curves.decelerate,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: index ? Colors.white : Colors.redAccent,
                                        borderRadius: BorderRadius.circular(100)
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            onTap: (){
                              setState(() {
                                index =! index;
                                //cekState(index);
                                fungsiLampu1(index, test1, value1);
                                fungsiLampu2(index, test2, value2);
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            )
        )
    );
  }
}
