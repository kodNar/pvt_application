import 'package:flutter/material.dart';
import 'Settings.dart';
import 'workerData.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StalkerModel _stalkerModel = new StalkerModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => Settings()
                ));
              },
            ),
          ]
      ),
      body:
      ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: _stalkerModel.coWorkers.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                height: 70,
                color: Colors.amber,
                child: ListTile(
                  leading: _stalkerModel.coWorkers[index].location == WorkerLocations.home?new Icon(Icons.home):
                  _stalkerModel.coWorkers[index].location == WorkerLocations.office?new Icon(Icons.local_post_office):
                  _stalkerModel.coWorkers[index].location == WorkerLocations.Tenndalen?new Icon(Icons.directions_railway):
                  new Icon(Icons.money_off),
                  title: Text('${_stalkerModel.coWorkers[index].username}'),
                  subtitle: Text('Days: ${DateTime.now().difference(_stalkerModel.coWorkers[index].lastUpdated).inDays} since last update!'),
                )
            );
          }),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // lägger floating knappen i mitten.
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
          child: Icon(Icons.map)
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 3,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(icon: Icon(Icons.location_searching),
              onPressed: () {},
            ),
            IconButton(icon: Icon(Icons.access_alarm),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  //SETTINGS
  /*
  void openPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Settings"),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Settings page',
                  ),
                ],
              ),
            ),
          );
        }
    ));
  }
  */
}