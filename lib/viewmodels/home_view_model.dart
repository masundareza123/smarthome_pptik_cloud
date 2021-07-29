import 'package:smarthome_cloud/models/device_data.dart';
import 'package:smarthome_cloud/services/sqflite_service.dart';
import 'package:smarthome_cloud/ui/views/detail_device_view.dart';
import 'package:smarthome_cloud/viewmodels/base_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';


class HomeViewModel extends BaseModel {
  Db database = Db();
  Device device;



  Future<List<Device>> getDataList() async{
    List<Device> deviceList;
    final Future<Database> dbFuture = database.getDatabaseInstance();

    await dbFuture.then((databaseOPEN) async {
      Future<List<Device>> deviceListFuture = database.getAllDevice();
      deviceList = await deviceListFuture.then((value) => value);
    });
    print(deviceList);
    return deviceList;
  }

  Future<Device> navigateDetailDeviceView(
      BuildContext context, Device device) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
          return DetailDeviceView(device);
        }));
    // result disini sebagai nilai dari buku pop up
    return result;
  }
}