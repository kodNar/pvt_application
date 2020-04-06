import 'package:flutter/material.dart';
import 'workerData.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PVT',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'sdfsdfsdfdsfds:)'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 5;
  StalkerModel _stalkerModel = new StalkerModel();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter--;
    });
  }

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
                openPage(context);
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
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: Icon(Icons.add_to_home_screen)
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
    //Skapar ny sida

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
