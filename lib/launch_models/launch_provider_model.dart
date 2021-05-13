class LaunchProvider {
  String name, type;

  LaunchProvider({this.name, this.type});

  factory LaunchProvider.fromJson(Map<String, dynamic> launchjson) {
    return LaunchProvider(name: launchjson["name"], type: launchjson["type"]);
  }
}
