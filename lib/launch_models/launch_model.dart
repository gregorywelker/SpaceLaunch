import 'package:space_launch/launch_models/mission_model.dart';

import 'launch_pad_model.dart';
import 'launch_provider_model.dart';
import 'launch_rocket_model.dart';
import 'launch_status_model.dart';

class Launch {
  String id, name, imageurl;
  DateTime windowStart;

  LaunchProvider provider;
  LaunchStatus status;
  Rocket rocket;
  LaunchPad pad;
  Mission mission;

  Launch(
      {this.id,
      this.name,
      this.imageurl,
      this.windowStart,
      this.provider,
      this.status,
      this.rocket,
      this.pad,
      this.mission});

  factory Launch.fromJson(Map<String, dynamic> launchjson) {
    LaunchProvider provider =
        LaunchProvider.fromJson(launchjson["launch_service_provider"]);

    LaunchStatus status = LaunchStatus.fromJson(launchjson["status"]);

    Rocket rocket = Rocket.fromJson(launchjson["rocket"]);

    LaunchPad pad = LaunchPad.fromJson(launchjson["pad"]);

    Mission mission = Mission.fromJson(launchjson["mission"]);

    return Launch(
        id: launchjson["id"],
        name: launchjson["name"],
        imageurl: launchjson["image"],
        windowStart: DateTime.parse(launchjson["window_start"]),
        provider: provider,
        status: status,
        rocket: rocket,
        pad: pad,
        mission: mission);
  }
}
