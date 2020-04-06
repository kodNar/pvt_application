import 'package:flutter/material.dart';
import 'Settings.dart';
import 'workerData.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StalkerModel _stalkerModel = new StalkerModel();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings_applications),
              tooltip: 'Settings',
              onPressed: () {
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => Settings()
                ));
              },
            ),
            Text('Volume')
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
}