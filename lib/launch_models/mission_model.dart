class Mission {
  String name, description, type, orbitname, orbitabbrev;

  Mission(
      {this.name,
      this.description,
      this.type,
      this.orbitname,
      this.orbitabbrev});

  factory Mission.fromJson(Map<String, dynamic> launchjson) {
    if (launchjson.toString() == "null") {
      return Mission(
        name: "Unknown name",
        description: "Unknown description",
        type: "Unknown type",
        orbitname: "Unknown orbit",
        orbitabbrev: "Unknown orbit",
      );
    } else {
      return Mission(
        name: launchjson["name"],
        description: launchjson["description"],
        type: launchjson["type"],
        orbitname: launchjson["orbit"].toString() != "null"
            ? launchjson["orbit"]["name"]
            : "Unknown orbit",
        orbitabbrev: launchjson["orbit"].toString() != "null"
            ? launchjson["orbit"]["abbrev"]
            : "Unknown orbit",
      );
    }
  }
}
