import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smarthome_cloud/constants/route_name.dart';
import 'package:smarthome_cloud/locator.dart';
import 'package:smarthome_cloud/models/device_data.dart';
import 'package:smarthome_cloud/services/navigator_service.dart';
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
  DetailDeviceViewState(this.device);
  Db database = Db();
  final Db _db = locator<Db>();
  final NavigationService _navigationService = locator<NavigationService>();
  Device device;
  //bool status = false;
  bool index = false;
  // String cek;
  String test1 = "1";
  String test2 = "11";
  String status;
  //String values = '1';
  RMQService rmqService = new RMQService();



  @override
  void initState() {
    super.initState();
    if(device.status == "nyala"){
      index = true;
      print("kondisi awal ${device.status}");
    }else{
      index = false;
      print("kondisi awal ${device.status}");
    }
    // checkStatus();
  }



  void fungsiLampu1(bool status, String rule1, String rule2){
    if(status){
      //updateStatus(device);
      rmqService.publish("${device.guid}#$rule1");
      print("guid : ${device.guid} & ${device.status} f1");
    }else{
      //updateStatus(device);
      rmqService.publish("${device.guid}#$rule2");
      print("guid : ${device.guid} & ${device.status} f1");
    }index = status;
  }

  void fungsiLampu2(bool status, String rule1, String rule2){
    if(status){
      rmqService.publish("${device.guid}#$rule1");
      print("guid : ${device.guid} & ${device.status} f2");
    }else{
      rmqService.publish("${device.guid}#$rule2");
      print("guid : ${device.guid} & ${device.status} f2");
    }index = status;
  }

  @override
  Widget build(BuildContext context) {
    String value1 = test1.replaceAll("1", "0");
    String value2 = test2.replaceAll("11", "00");
    void updateStatus(Device device) async {
      if (device.status == "mati"){
        var guid = device.guid;
        var mac = device.mac;
        var type = device.type;
        var quantity = device.quantity;
        var name = device.name;
        var version = device.version;
        var minor = device.minor;
        var status = "nyala";
        device = Device(
            guid,
            mac,
            minor,
            name,
            quantity,
            status,
            type,
            version
        );
      }else{
        var guid = device.guid;
        var mac = device.mac;
        var type = device.type;
        var quantity = device.quantity;
        var name = device.name;
        var version = device.version;
        var minor = device.minor;
        var status = "mati";
        device = Device(
            guid,
            mac,
            minor,
            name,
            quantity,
            status,
            type,
            version
        );
      }
      await database.addDevice(device);
      print("update status : ${device.status}");
      print(device);
      _navigationService.replaceTo(DashboardViewRoute);
    }
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
                            onTap: () async {
                              setState(() {
                                index =! index;
                                //cekState(index);
                                fungsiLampu1(index, test1, value1);
                                fungsiLampu2(index, test2, value2);
                                updateStatus(device);
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
