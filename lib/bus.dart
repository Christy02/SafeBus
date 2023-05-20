import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class BusPage extends StatefulWidget {
  @override
  _BusPageState createState() => _BusPageState();
}

class _BusPageState extends State<BusPage> {
  List<SpeedData> speedDataList = [];

  Timer? timer;

  @override
  void initState() {
    super.initState();
    startFetchingSpeedData();
  }

  void startFetchingSpeedData() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      fetchSpeedDataFromFirestore();
    });
  }

  void stopFetchingSpeedData() {
    timer?.cancel();
    timer = null;
  }

  void fetchSpeedDataFromFirestore() async {
    // Replace 'current_loc' with your Firestore collection name
    // Replace 'bus' with the specific document ID for the bus you want to retrieve data from
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('current_loc');
    DocumentSnapshot<Map<String, dynamic>> snapshot = await collectionRef
        .doc('bus')
        .get() as DocumentSnapshot<Map<String, dynamic>>;

    if (snapshot.exists) {
      Map<String, dynamic>? data = snapshot.data();

      if (data != null && data.containsKey('speed')) {
        List<dynamic>? speedValues = data['speed'] as List<dynamic>?;

        if (speedValues != null) {
          speedDataList.clear();

          for (int i = 0; i < speedValues.length; i++) {
            var speed = (speedValues[i] as num?)?.toDouble();
            if (speed != null) {
              var time = DateTime.now().add(Duration(seconds: i));
              var speedData = SpeedData(time, speed);
              speedDataList.add(speedData);
            }
          }

          // Update the graph
          setState(() {});
        }
      }
    }
  }

  @override
  void dispose() {
    stopFetchingSpeedData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speed Graph'),
      ),
      body: Center(
        child: Container(
          height: 300,
          padding: EdgeInsets.all(16),
          child: charts.TimeSeriesChart(
            _createSpeedData(),
            animate: true,
            dateTimeFactory: const charts.LocalDateTimeFactory(),
            primaryMeasureAxis: charts.NumericAxisSpec(
              tickProviderSpec:
                  charts.BasicNumericTickProviderSpec(zeroBound: false),
            ),
          ),
        ),
      ),
    );
  }

  List<charts.Series<SpeedData, DateTime>> _createSpeedData() {
    return [
      charts.Series<SpeedData, DateTime>(
        id: 'Speed',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (SpeedData speedData, _) => speedData.time,
        measureFn: (SpeedData speedData, _) => speedData.speed,
        data: speedDataList,
      ),
    ];
  }
}

class SpeedData {
  final DateTime time;
  final double speed;

  SpeedData(this.time, this.speed);
}

void main() {
  runApp(MaterialApp(
    home: BusPage(),
  ));
}
