class Rocket {
  String name, family, fullname, variant;

  Rocket({this.name, this.family, this.fullname, this.variant});

  factory Rocket.fromJson(Map<String, dynamic> launchjson) {
    return Rocket(
        name: launchjson["configuration"]["name"],
        family: launchjson["configuration"]["family"],
        fullname: launchjson["configuration"]["full_name"],
        variant: launchjson["configuration"]["variant"]);
  }
}
