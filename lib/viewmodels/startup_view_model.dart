import 'dart:async';

import 'package:smarthome_cloud/constants/route_name.dart';
import 'package:smarthome_cloud/locator.dart';
import 'package:smarthome_cloud/services/navigator_service.dart';
import 'package:smarthome_cloud/viewmodels/base_model.dart';

class StartUpViewModel extends BaseModel{
  final NavigationService _navigationService = locator<NavigationService>();

  startTimer() async {
    var _duration = Duration(seconds: 5);
    return Timer(_duration, handleStartUpLogic);
  }

  Future handleStartUpLogic() async {
    _navigationService.replaceTo(DashboardViewRoute);
  }
}