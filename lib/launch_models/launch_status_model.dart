class LaunchStatus {
  String name, abbrev, description;

  LaunchStatus({this.name, this.abbrev, this.description});

  factory LaunchStatus.fromJson(Map<String, dynamic> launchjson) {
    return LaunchStatus(
        name: launchjson["name"],
        abbrev: launchjson["abbrev"],
        description: launchjson["description"]);
  }
}
