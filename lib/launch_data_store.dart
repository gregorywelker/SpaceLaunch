import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'launch_models/launch_model.dart';
import 'launch_fetcher.dart';

class LaunchDataStore extends ChangeNotifier {
  final List<Launch> launches = [];

  Future<void> loadLaunches() async {
    final prefs = await SharedPreferences.getInstance();

    int launchCount = prefs.getInt('launchCount') ?? 0;

    List<String> launchids = [];

    for (var i = 0; i < launchCount; i++) {
      print(prefs.getString('launch_$i'));
      launchids.add(prefs.getString('launch_$i'));
    }

    for (var i = 0; i < launchids.length; i++) {
      await LaunchFetcher.fetchLaunchByID(launchids[i]).then((result) {
        if (result.statusCode == 200) {
          Launch launch = new Launch.fromJson(jsonDecode(result.body));
          if (!containsLaunch(launch)) {
            launches.add(launch);
          }
        }
      });
    }
  }

  updateLaunchesOnStorage() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.clear();

    prefs.setInt('launchCount', launches.length);
    for (var i = 0; i < launches.length; i++) {
      prefs.setString('launch_$i', launches[i].id);
    }
  }

  bool containsLaunch(Launch launch) {
    for (var i = 0; i < launches.length; i++) {
      if (launches[i].id == launch.id) {
        return true;
      }
    }
    return false;
  }

  addLaunch(Launch launch) {
    if (!containsLaunch(launch)) {
      launches.add(launch);
      launches.sort((a, b) => a.windowStart.compareTo(b.windowStart));
      notifyListeners();
      updateLaunchesOnStorage();
    }
  }

  removeLaunch(Launch launch) {
    if (containsLaunch(launch)) {
      launches.remove(launch);
      notifyListeners();
      updateLaunchesOnStorage();
    }
  }
}
