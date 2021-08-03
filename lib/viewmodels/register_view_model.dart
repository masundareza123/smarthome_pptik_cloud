import 'package:flutter/cupertino.dart';
import 'package:smarthome_cloud/constants/route_name.dart';
import 'package:smarthome_cloud/locator.dart';
import 'package:smarthome_cloud/models/device_data.dart';
import 'package:smarthome_cloud/services/alert_service.dart';
import 'package:smarthome_cloud/services/navigator_service.dart';
import 'package:smarthome_cloud/services/sqflite_service.dart';
import 'package:smarthome_cloud/viewmodels/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class RegisterDeviceViewModel extends BaseModel {
  TextEditingController guidController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController macController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController versionController = TextEditingController();
  TextEditingController minorController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  Device device;
  final Db _db = locator<Db>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AlertService _alertService = locator<AlertService>();

  // String guid;
  // String mac;
  // String type;
  // String quantity;
  // String name;
  // String version;
  // String minor;

  Future<void> getTask() async {
    showdata();
    // print('OnMode');

  }

  void showdata()async{
    // setBusy(true);
    // guidController.text='123';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data=prefs.getString('datadevice');
    var result = convert.jsonDecode(data);
    // final datadevice = json.decode(data);
    // print('datadevice ${data}');
        var guid=result['guid'];
        var name=result['name'];
        var type= result['type'];
        var mac =result['mac'];
        var quantity = result['quantity'];
        // var quantity=result['quantity'];
        var version=result['version'];
        var minor=result['minor'];
    // print('ini guidnya:${guid}');
    guidController.text=guid;
    nameController.text=name;
    typeController.text=type;
    macController.text=mac;
    quantityController.text=quantity;
    versionController.text=version;
    minorController.text=minor;
    // setBusy(false);
    // guidController.text=guid;
    // guidController='123'
    // guidController.text='123';
  }

void registerDevice(BuildContext context)async{

    try{
      if (guidController.text.length > 0 &&
          macController.text.length > 0 &&
          typeController.text.length > 0 &&
          quantityController.text.length > 0 &&
          nameController.text.length > 0 &&
          versionController.text.length > 0 &&
          minorController.text.length > 0) {
        var guid = guidController.text;
        var mac = macController.text;
        var type = typeController.text;
        var quantity = quantityController.text;
        var name = nameController.text;
        var version = versionController.text;
        var minor = minorController.text;
        var status = "mati";
        //guid TEXT PRIMARY KEY, mac TEXT, type TEXT, quantity TEXT, name TEXT, version TEXT, minor TEXT
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
        print("this is serial number $guid");
        print(device.toMap().toString());
        await _db.addDevice(device);
        print('$device');
        print("added");
        _alertService.showSuccess(context, "Success", "Device berhasil didaftrarkan", (){_navigationService.replaceTo(DashboardViewRoute);});
      }
    }catch(e){

    }

}

}