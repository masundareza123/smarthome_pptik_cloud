import 'package:flutter/material.dart';
import 'package:smarthome_cloud/ui/views/home_view.dart';
import 'package:smarthome_cloud/ui/views/register_manual_view.dart';

class DashboardView extends StatefulWidget {

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {

  int currentTab = 0;
  final List<Widget> screens = [
    HomeView(),
    RegisterManualView(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: PageStorage(
              child: currentScreen,
              bucket: bucket,
            ),

            floatingActionButtonLocation : FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
                child: Container(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          MaterialButton(
                            minWidth: 40,
                            onPressed: (){
                              setState(() {
                                currentScreen = HomeView();
                                currentTab = 0;
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.home_outlined,
                                  color: currentTab == 0 ? Colors.redAccent : Colors.black26,
                                ),
                                Text(
                                  "Home",
                                  style: TextStyle(
                                    color: currentTab == 0 ? Colors.redAccent : Colors.black26,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          MaterialButton(
                            minWidth: 40,
                            onPressed: (){
                              setState(() {
                                currentScreen = RegisterManualView();
                                currentTab = 1;
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.settings,
                                  color: currentTab == 1 ? Colors.redAccent : Colors.black26,
                                ),
                                Text(
                                  "Register Device",
                                  style: TextStyle(
                                    color: currentTab == 1 ? Colors.redAccent : Colors.black26,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
            )
        )
    );
  }
}
