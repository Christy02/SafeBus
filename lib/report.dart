import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<SpeedData> speedDataList = [];
  DateTime start = Timestamp.now().toDate(), end = Timestamp.now().toDate();
  Timer? timer;
  String stime = "", etime = "", dur = "";
  Duration rdur = Duration(minutes: 10);
  double average = 100;
  dynamic max = 0, dist;
  int overspeed = 0;
  bool isDisposed = false;
  int ragScore = 0;

  @override
  void initState() {
    _gettime();
    calculateAverage();
    startFetchingSpeedData();
    calculateRAGScore();
    super.initState();
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
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('current_loc');
    DocumentSnapshot<Map<String, dynamic>> snapshot = await collectionRef
        .doc('bus')
        .get() as DocumentSnapshot<Map<String, dynamic>>;

    if (snapshot.exists) {
      if (!isDisposed) {
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
            if (!isDisposed) {
              setState(() {});
            }
          }
        }
      }
    }
  }

  @override
  void dispose() {
    stopFetchingSpeedData();
    isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 45),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(3, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bus Driver',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Driver Name: John Doe',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'Driver No: 9876543210',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'License No: AB12345',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                      SizedBox(width: 20.0),
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: AssetImage('assets/driver.jpg'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Container(
                      width: 156,
                      //height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(3, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Route start :',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            '   $stime',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 6.0),
                          Text(
                            'Route end :',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            '   $etime',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 6.0),
                          Text(
                            'Route duration :',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            '   $dur',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 6.0),
                          Text(
                            'Distance travelled :',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            '   $dist km',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: 156,
                      //height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(3, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Max Speed :',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            '   $max km/h',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 6.0),
                          Text(
                            'Avg Speed :',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            '   $average km/h',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 6.0),
                          Text(
                            'Overspeed count :',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            '   $overspeed',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 6.0),
                          Text(
                            'RAG Score :',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            '  $ragScore',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 400,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(3, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Speed vs Time',
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: charts.TimeSeriesChart(
                          _createSpeedData(),
                          animate: true,
                          dateTimeFactory: const charts.LocalDateTimeFactory(),
                          primaryMeasureAxis: charts.NumericAxisSpec(
                            tickProviderSpec:
                                charts.BasicNumericTickProviderSpec(
                              zeroBound: false,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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

  void _gettime() async {
    final DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('current_loc')
        .doc('bus')
        .get();

    final start = doc['route_start'].toDate();
    final end = doc['route_end'].toDate();
    stime =
        '${start.hour}:${start.minute}  ${start.day}/${start.month}/${start.year}';
    etime = '${end.hour}:${end.minute}  ${end.day}/${end.month}/${end.year}';
    rdur = end.difference(start);
    dur = '${rdur.inHours}hr : ${rdur.inMinutes.remainder(60)}min';
  }

  Future<void> calculateAverage() async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('current_loc');
    DocumentSnapshot snapshot = await collectionRef.doc('bus').get();

    double sum = 0;
    int count = 0;
    List<dynamic> values = snapshot.get('speed');
    for (dynamic value in values) {
      if (value > max) max = value;
      if (value > 5) overspeed++;
      sum += value;
      count++;
    }
    average = sum / count;
    average = double.parse(average.toStringAsFixed(3));
    max = double.parse(max.toStringAsFixed(3));
    dist = (average * (rdur.inMinutes / 60));
    dist = double.parse(dist.toStringAsFixed(3));
  }

  Future<void> calculateRAGScore() async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('current_loc');
    DocumentSnapshot snapshot = await collectionRef.doc('bus').get();

    List<dynamic> values = snapshot.get('speed');
    int greenThreshold = 50; // Set the threshold for Green
    int amberThreshold = 70; // Set the threshold for Amber

    int count = values.length;
    int greenCount = 0;
    int amberCount = 0;

    for (dynamic value in values) {
      if (value <= greenThreshold) {
        greenCount++;
      } else if (value <= amberThreshold) {
        amberCount++;
      }
    }

    double greenPercentage = (greenCount / count) * 100;
    double amberPercentage = (amberCount / count) * 100;
    double redPercentage = 100 - greenPercentage - amberPercentage;

    if (redPercentage >= 50) {
      ragScore = 0; // Red Score
    } else if (amberPercentage >= 50) {
      ragScore = 1; // Amber Score
    } else {
      ragScore = 2; // Green Score
    }
  }
}

class SpeedData {
  final DateTime time;
  final double speed;

  SpeedData(this.time, this.speed);
}
