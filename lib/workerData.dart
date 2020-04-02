class CoWorker {
  String username;

  //home/office/unknown
  WorkerLocations location;
  DateTime lastUpdated;

  CoWorker({this.username, this.location, this.lastUpdated});
}

enum WorkerLocations { home, office, unknown, Tenndalen }

class StalkerModel {
  List<CoWorker> coWorkers;

  CoWorker myself;

//home location
//work location

  StalkerModel() {
    myself = new CoWorker(username: "Einar",
        location: WorkerLocations.unknown,
        lastUpdated: DateTime.now());
    updateWorkers();
  }

  void updateWorkers() {
    coWorkers = simCoWorkers;
    coWorkers.add(myself);

  }

  final simCoWorkers = [

    new CoWorker(
      username: "Rebben",
      location: WorkerLocations.home,
      lastUpdated: DateTime.parse("2020-02-01 20:08:12Z")),
  new CoWorker(
      username: "Keiki",
      location: WorkerLocations.Tenndalen,
      lastUpdated: DateTime.parse("2020-03-22 15:30:21Z")),
  new CoWorker(
      username: "Figge",
      location: WorkerLocations.office,
      lastUpdated: DateTime.parse("2019-07-22 14:30:41Z"))

  ];
}
