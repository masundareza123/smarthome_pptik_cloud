
import 'package:flutter/material.dart';
import 'package:smarthome_cloud/models/device_data.dart';
import 'package:smarthome_cloud/ui/shared/ui_helper.dart';
import 'package:smarthome_cloud/ui/views/qr_view.dart';
import 'package:smarthome_cloud/ui/widgets/textfield_widget.dart';
import 'package:smarthome_cloud/viewmodels/register_view_model.dart';
import 'package:stacked/stacked.dart';

class RegisterDeviceView extends StatefulWidget {
  @override
  _RegisterDeviceViewState createState() => _RegisterDeviceViewState();
}

class _RegisterDeviceViewState extends State<RegisterDeviceView> {
  RegisterDeviceViewModel model = RegisterDeviceViewModel();

  // TextEditingController guidController = TextEditingController();
  // TextEditingController nameController = TextEditingController();
  // TextEditingController macController = TextEditingController();
  // TextEditingController typeController = TextEditingController();
  // TextEditingController versionController = TextEditingController();
  // TextEditingController minorController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  // TextEditingController test = TextEditingController();

  Device device;

  /*final List<Map<String, dynamic>> _items = [
    {
      'value': '1',
      'label': 'Value 1',
    },
    {
      'value': '11',
      'label': 'Value 2',
    },
    {
      'value': '111',
      'label': 'Value 3',
    },
    {
      'value': '1111',
      'label': 'Value 4',
    },
    {
      'value': '11111',
      'label': 'Value 5',
    },
    {
      'value': '111111',
      'label': 'Value 6',
    },
    {
      'value': '1111111',
      'label': 'Value 7',
    },
    {
      'value': '11111111',
      'label': 'Value 8',
    },
  ];*/


  @override
  Widget build(BuildContext context) {
    // print(sh)
    // ReactiveViewModel.
    // test.text = 'text';
    // guidController.text = '${device.guid}';
    // nameController.text = '${device.name}';
    // macController.text = '${device.mac}';
    // typeController.text = '${device.type}';
    // versionController.text = '${device.version}';
    // minorController.text = '${device.minor}';
    // print('${device.guid}');
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => RegisterDeviceViewModel(),
      onModelReady: (model) {
        model.getTask();
        // model.Swowdata();
        // print(model.busy);
        // model.openLocationSetting();
        // model.getTask();
      },
      builder: (context, model, child) => SafeArea(
          // mode
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.redAccent,
                title: Text("Smarthome"),
                actions: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QRViewExample()));
                    },
                    child: Icon(Icons.qr_code_scanner),
                  ),
                  horizontalSpaceSmall
                ],
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 8, right: 8, top: 20),
                  child: Form(
                      child: Column(
                    children: <Widget>[
                      Text(
                        "Register Device",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      TextFieldWidget(
                        title: "Serial Number",
                        controller: model.guidController,
                        readOnly: true,
                      ),
                      TextFieldWidget(
                        title: "Device Name",
                        controller: model.nameController,
                        readOnly: false,
                      ),
                      TextFieldWidget(
                          title: "Rules",
                          controller: model.quantityController,
                          readOnly: true),
                      TextFieldWidget(
                          title: "Mac",
                          controller: model.macController,
                          readOnly: true),
                      TextFieldWidget(
                          title: "Type",
                          controller: model.typeController,
                          readOnly: true),
                      TextFieldWidget(
                          title: "Version",
                          controller: model.versionController,
                          readOnly: true),
                      TextFieldWidget(
                          title: "Minor",
                          controller: model.minorController,
                          readOnly: true),
                      verticalSpaceSmall,
                      MaterialButton(
                          child: Container(
                            width: 100,
                            height: 30,
                            child: Center(
                              child: Text(
                                'SUBMIT',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            model.registerDevice(context);
                          }),
                      verticalSpaceMedium
                    ],
                  )),
                ),
              ))),
    );
  }
}
