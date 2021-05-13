class LaunchPad {
  String name, latitude, longitude, locationname, locationcc, padlocationimgurl;
  int launchcount, locationlaunchcount, locationlandcount;
  LaunchPad(
      {this.name,
      this.latitude,
      this.longitude,
      this.launchcount,
      this.locationname,
      this.locationcc,
      this.padlocationimgurl,
      this.locationlaunchcount,
      this.locationlandcount});

  factory LaunchPad.fromJson(Map<String, dynamic> launchjson) {
    return LaunchPad(
      name: launchjson["name"],
      latitude: launchjson["latitude"],
      longitude: launchjson["longitude"],
      launchcount: launchjson["total_launch_count"],
      locationname: launchjson["location"]["name"],
      locationcc: launchjson["location"]["country_code"],
      padlocationimgurl: launchjson["location"]["map_image"],
      locationlaunchcount: launchjson["location"]["total_launch_count"],
      locationlandcount: launchjson["location"]["total_land_count"],
    );
  }
}
