import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smarthome_cloud/models/device_data.dart';
import 'package:smarthome_cloud/services/rmq_service.dart';
import 'package:smarthome_cloud/ui/shared/ui_helper.dart';
import 'package:smarthome_cloud/ui/views/qr_view.dart';
import 'package:smarthome_cloud/viewmodels/home_view_model.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  RMQService rmqService = new RMQService();
  bool index;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      index = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context,model,child) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.redAccent,
            title: Text("Smarthome"),
            actions: [
              InkWell(
                onTap: (){
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
          body: Padding(
              padding: EdgeInsets.only(top: 15),
              child: Container(
                child: SingleChildScrollView(
                  child: Container(
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            height: MediaQuery.of(context).size.height / 1.3,
                            width: MediaQuery.of(context).size.width,
                            child: FutureBuilder(
                              future: model.getDataList(),
                              builder:
                                  (BuildContext context, AsyncSnapshot<List<Device>> snapshot){
                                if (snapshot.hasData) {
                                  List <Device> devices = snapshot.data;
                                  return Container(
                                    margin: EdgeInsets.symmetric(vertical: 7, horizontal: 4),
                                    child: ListView(
                                      children: devices.map(
                                              (Device device) => Padding(
                                                padding: EdgeInsets.only(bottom: 20),
                                                child: Container(
                                                  height: 90,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.redAccent, width: 2),
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(20.0),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black26,
                                                        offset: Offset(3, 6),
                                                        blurRadius: 10,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Container(
                                                    child: InkWell(
                                                      child:  Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                                                            child: Container(
                                                              child: Row(
                                                                children: [
                                                                  Icon(FontAwesomeIcons.lightbulb, size: 26,),
                                                                  horizontalSpaceSmall,
                                                                  Text(device.name, style: TextStyle(fontSize: 20),maxLines: 1,)
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(right: 10),
                                                            child: Container(
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                children: [
                                                                  Padding(
                                                                      padding: EdgeInsets.only(bottom: 10),
                                                                      child: InkWell(
                                                                        splashColor: Colors.white,
                                                                        child: AnimatedContainer(
                                                                            duration: const Duration(milliseconds: 300),
                                                                            curve: Curves.decelerate,
                                                                            width: 100,
                                                                            height: 38,
                                                                            decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(50.0),
                                                                              border: Border.all(
                                                                                  color: index ? Colors.black : Colors.redAccent
                                                                              ),
                                                                              color: index ? Colors.redAccent : Colors.white,
                                                                            ),
                                                                            child: Padding(
                                                                              padding: EdgeInsets.all(7),
                                                                              child: Text("Control Menu", textAlign: TextAlign.center,style: TextStyle(color: Colors.redAccent),),
                                                                            )
                                                                        ),
                                                                        onTap: () async {
                                                                          await model.navigateDetailDeviceView(context,device);
                                                                        },
                                                                      )
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ),
                                              )
                                      ).toList(),
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: Container(
                                      child: Text("No data"),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
          ),
        ),
      ),
    );
  }
}
