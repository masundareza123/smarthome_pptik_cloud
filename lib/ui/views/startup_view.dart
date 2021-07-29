import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smarthome_cloud/ui/shared/ui_helper.dart';
import 'package:smarthome_cloud/viewmodels/startup_view_model.dart';
import 'package:stacked/stacked.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lock Orientation Portait Only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return ViewModelBuilder<StartUpViewModel>.reactive(
      viewModelBuilder: () => StartUpViewModel(),
      onModelReady: (model) {
        model.startTimer();
      },
      builder: (context, model, child) => Scaffold(
        backgroundColor: Color(0xffF1F4F6),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 150,
                height: 150,
                child: Image.asset('lib/assets/logosh.png'),
              ),
              verticalSpaceMedium,
              CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation(
                    Theme.of(context).primaryColor,
                  )),
              verticalSpaceMedium,
              verticalSpaceMedium,
            ],
          ),
        ),
      ),
    );
  }
}