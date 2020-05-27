import 'dart:math';
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

  _PopularHoursState(String _name) {
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
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/OutdoorGymPicture.png'),
                  fit: BoxFit.fill),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'Popular hours: $dayOfWeek',
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            child: Text(
              'During these hours most of the users log their workout',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            width: 525,
            height: 200,
            child: PopularHoursChart.withSampleData(),
          ),
          Text(
            'Time of day',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class PopularHoursChart extends StatelessWidget {
  final bool animate;
  final List<charts.Series> seriesList;
  Random random;

  PopularHoursChart(this.seriesList, {this.animate});

  factory PopularHoursChart.withSampleData() {
    return PopularHoursChart(
      _createSimulatedData(),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      /// Used from https://google.github.io/charts/flutter/example/axes/custom_font_size_and_color.html

      seriesList,
      animate: animate,
      domainAxis: charts.OrdinalAxisSpec(
          renderSpec: charts.SmallTickRendererSpec(
              labelStyle: charts.TextStyleSpec(
                  fontSize: 18, color: charts.MaterialPalette.white),
              lineStyle:
                  charts.LineStyleSpec(color: charts.MaterialPalette.white))),
      primaryMeasureAxis: charts.NumericAxisSpec(
          renderSpec: charts.GridlineRendererSpec(
              labelStyle: charts.TextStyleSpec(
                  fontSize: 18, color: charts.MaterialPalette.white),
              lineStyle:
                  charts.LineStyleSpec(color: charts.MaterialPalette.white))),
    );
  }

  static List<charts.Series<HourAndUsers, String>> _createSimulatedData() {
    Random random = Random();
    final simulatedData = [
      HourAndUsers('00:00', random.nextInt(3)),
      HourAndUsers('04:00', random.nextInt(5)),
      HourAndUsers('08:00', random.nextInt(2) + 5),
      HourAndUsers('12:00', random.nextInt(3) + 8),
      HourAndUsers('16:00', random.nextInt(4) + 9),
      HourAndUsers('20:00', random.nextInt(4) + 9),
    ];

    return [
       charts.Series<HourAndUsers, String>(
        id: 'popularHours',
        fillColorFn: (__, popularHours) => charts.MaterialPalette.white,
        domainFn: (HourAndUsers popularHours, _) => popularHours.timeOfDay,
        measureFn: (HourAndUsers popularHours, _) =>
            popularHours.amountOfPeople,
        data: simulatedData,
      ),
    ];
  }
}

class HourAndUsers {
  final String timeOfDay;
  final int amountOfPeople;

  HourAndUsers(this.timeOfDay, this.amountOfPeople);
}
