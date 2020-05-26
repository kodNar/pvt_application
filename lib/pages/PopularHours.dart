import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';


class PopularHours extends StatefulWidget {

  final String _name;
  PopularHours(this._name);
  @override
  _PopularHoursState createState() => _PopularHoursState(_name);
}

class _PopularHoursState extends State<PopularHours> {
  String _name;
  DateTime date = DateTime.now();
  String dayOfWeek;
  _PopularHoursState(String _name){
    this._name = _name;
  }
  @override
  void initState() {
    dayOfWeek = DateFormat('EEEE').format(date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 132, 50, 155),
      appBar: AppBar(
        title: Text(_name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width ,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/OutdoorGymPicture.png'),
                  fit: BoxFit.fill),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text('Popular hours: $dayOfWeek',
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            ),
          ),
    Container(
      width: 525,
      height: 200,
      child: SimpleBarChart.withSampleData(),
    ),
          Text('Time of day',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
/// Bar chart example

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory SimpleBarChart.withSampleData() {

    return new SimpleBarChart(
      _createSimulatedData(),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<HourAndUsers, String>> _createSimulatedData() {
    final data = [
      new HourAndUsers('00:00', 1),
      new HourAndUsers('04:00', 5),
      new HourAndUsers('08:00', 12),
      new HourAndUsers('12:00', 15),
      new HourAndUsers('16:00', 14),
      new HourAndUsers('20:00', 9),
    ];

    return [
      new charts.Series<HourAndUsers, String>(
        id: 'popularHours',
        colorFn: (_, __) => charts.MaterialPalette.white,
        domainFn: (HourAndUsers sales, _) => sales.timeOfDay,
        measureFn: (HourAndUsers sales, _) => sales.amountOfPeople,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class HourAndUsers {
  final String timeOfDay;
  final int amountOfPeople;

  HourAndUsers(this.timeOfDay, this.amountOfPeople);
}


