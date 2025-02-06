import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StockData {
  final DateTime date;
  final double open, high, low, close;
  final int volume;

  StockData(
      {required this.date,
      required this.open,
      required this.high,
      required this.low,
      required this.close,
      required this.volume});
}

class Stock {
  String? s;
  List<int>? t;
  List<double>? o;
  List<double>? h;
  List<double>? l;
  List<double>? c;
  List<int>? v;

  Stock({this.s, this.t, this.o, this.h, this.l, this.c, this.v});

  Stock.fromJson(Map<String, dynamic> json) {
    s = json['s'];
    t = json['t'].cast<int>();
    o = json['o'].cast<double>();
    h = json['h'].cast<double>();
    l = json['l'].cast<double>();
    c = json['c'].cast<double>();
    v = json['v'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s'] = this.s;
    data['t'] = this.t;
    data['o'] = this.o;
    data['h'] = this.h;
    data['l'] = this.l;
    data['c'] = this.c;
    data['v'] = this.v;
    return data;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stock Chart Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const StockChartScreen(),
    );
  }
}

class StockChartScreen extends StatefulWidget {
  const StockChartScreen({super.key});

  @override
  _StockChartScreenState createState() => _StockChartScreenState();
}

class _StockChartScreenState extends State<StockChartScreen> {
  String jsonString = '''{
    "s": "ok",
    "t": [
        1669906800,
        1670166000,
        1670252400,
        1683039600,
        1683126000,
        1738767600
    ],
    "o": [
        1156.4,
        803.7,
        773.4,
        801.1,
        1321.0,
        1320.1
    ],
    "h": [
        1198.0,
        753.8,
        925.0,
        932.9,
        1363.0,
        1348.0
    ],
    "l": [
        1156.4,
        1150.0,
        1140.0,
        1137.0,
        1306.0,
        1293.7
    ],
    "c": [
        1156.4,
        1152.0,
        1152.1,
        1140.6,
        1363.0,
        1320.0
    ],
    "v": [
        1602,
        651,
        1238,
        557,
        463,
        5988
    ]
}''';

  List<StockData> stockData = [];
  late TrackballBehavior _trackballBehavior;
  late Stock stock;

  @override
  void initState() {
    super.initState();
    // Decoding JSON string to Dart objects
    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    stock = Stock.fromJson(jsonData);
    _trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    stockData = getStockData();
  }

  List<StockData> getStockData() {
    Random random = Random();
    List<StockData> stockDataList = [];

    for (int i = 0; i < 5; i++) {
      // Random date, for example from 2016-01-01 to 2016-12-31
      DateTime randomDate =
          DateTime(2016, 1, 1).add(Duration(days: random.nextInt(30)));

      // Use stock data from the JSON
      double open = stock.o![i];
      double high = stock.h![i] as double; // Ensure it's a double
      double low = stock.l![i];
      double close = stock.c![i];
      int volume = stock.v![i]; // Volume from JSON

      // Create StockData instance and add it to the list
      StockData stockData = StockData(
        date: randomDate,
        open: open,
        high: high,
        low: low,
        close: close,
        volume: volume,
      );

      stockDataList.add(stockData);
    }
    return stockDataList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stock Chart")),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: SfCartesianChart(
              title: ChartTitle(text: 'Stock'),
              trackballBehavior: _trackballBehavior,
              primaryXAxis: DateTimeAxis(
                minimum: DateTime(2016, 01, 01),
                maximum: DateTime(2016, 2, 31),
                intervalType: DateTimeIntervalType.months,
              ),
              primaryYAxis: NumericAxis(
                minimum: 600,
                maximum: 2300,
                interval: 50,
                opposedPosition: true,
              ),
              zoomPanBehavior: ZoomPanBehavior(
                enablePinching: true,
                enablePanning: true,
                enableDoubleTapZooming: true,
              ),
              series: <CandleSeries<StockData, DateTime>>[
                CandleSeries<StockData, DateTime>(
                  enableSolidCandles: true,
                  dataSource: stockData,
                  xValueMapper: (StockData data, _) => data.date,
                  lowValueMapper: (StockData data, _) => data.low,
                  highValueMapper: (StockData data, _) => data.high,
                  openValueMapper: (StockData data, _) => data.open,
                  closeValueMapper: (StockData data, _) => data.close,
                )
              ],
            ),
          ),
          Expanded(
            child: SfCartesianChart(
              primaryXAxis: DateTimeAxis(
                minimum: DateTime(2016, 01, 01),
                maximum: DateTime(2016, 2, 31),
                intervalType: DateTimeIntervalType.months,
              ),
              primaryYAxis: NumericAxis(),
              series: <ColumnSeries<StockData, DateTime>>[
                ColumnSeries<StockData, DateTime>(
                  dataSource: stockData,
                  xValueMapper: (StockData data, _) => data.date,
                  yValueMapper: (StockData data, _) => data.volume,
                  color: Colors.blue,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

// List<StockData> getStockData() {
//   return [
//     StockData(
//         date: DateTime(2016, 01, 11),
//         open: 98.97,
//         high: 101.19,
//         low: 95.36,
//         close: 97.13,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 01, 18),
//         open: 98.41,
//         high: 101.46,
//         low: 93.42,
//         close: 101.42,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 01, 25),
//         open: 101.52,
//         high: 101.53,
//         low: 92.39,
//         close: 97.34,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 02),
//         open: 96.47,
//         high: 97.33,
//         low: 93.69,
//         close: 94.02,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 02, 08),
//         open: 93.13,
//         high: 96.35,
//         low: 92.59,
//         close: 93.99,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 02, 15),
//         open: 91.02,
//         high: 94.89,
//         low: 90.61,
//         close: 92.04,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 02, 22),
//         open: 98.0237,
//         high: 98.0237,
//         low: 98.0237,
//         close: 98.0237,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 02, 29),
//         open: 99.86,
//         high: 106.75,
//         low: 99.65,
//         close: 106.01,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 03, 07),
//         open: 102.39,
//         high: 102.83,
//         low: 100.15,
//         close: 102.26,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 03, 14),
//         open: 101.91,
//         high: 106.5,
//         low: 101.78,
//         close: 105.92,
//         volume: 200000),
//     StockData(
//       date: DateTime(2016, 03, 21),
//       open: 105.93,
//       high: 107.65,
//       low: 104.89,
//       close: 105.67,
//       volume: 130000,
//     ),
//     StockData(
//         date: DateTime(2016, 03, 28),
//         open: 106,
//         high: 110.42,
//         low: 104.88,
//         close: 109.99,
//         volume: 170000),
//     StockData(
//         date: DateTime(2016, 04, 04),
//         open: 110.42,
//         high: 112.19,
//         low: 108.121,
//         close: 108.66,
//         volume: 100900),
//     StockData(
//         date: DateTime(2016, 04, 11),
//         open: 108.97,
//         high: 112.39,
//         low: 108.66,
//         close: 109.85,
//         volume: 300000),
//     StockData(
//         date: DateTime(2016, 04, 18),
//         open: 108.89,
//         high: 108.95,
//         low: 104.62,
//         close: 105.68,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 04, 25),
//         open: 105,
//         high: 105.65,
//         low: 92.51,
//         close: 93.74,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 05, 02),
//         open: 93.965,
//         high: 95.9,
//         low: 91.85,
//         close: 92.72,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 05, 09),
//         open: 93,
//         high: 93.77,
//         low: 89.47,
//         close: 90.52,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 05, 16),
//         open: 92.39,
//         high: 95.43,
//         low: 91.65,
//         close: 95.22,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 05, 23),
//         open: 95.87,
//         high: 100.73,
//         low: 95.67,
//         close: 100.35,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 05, 30),
//         open: 99.6,
//         high: 100.4,
//         low: 96.63,
//         close: 97.92,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 06, 06),
//         open: 97.99,
//         high: 101.89,
//         low: 97.55,
//         close: 98.83,
//         volume: 400000),
//     StockData(
//         date: DateTime(2016, 06, 13),
//         open: 98.69,
//         high: 99.12,
//         low: 95.3,
//         close: 95.33,
//         volume: 700000),
//     StockData(
//         date: DateTime(2016, 06, 20),
//         open: 96,
//         high: 96.89,
//         low: 92.65,
//         close: 93.4,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 06, 27),
//         open: 93,
//         high: 96.465,
//         low: 91.5,
//         close: 95.89,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 07, 04),
//         open: 95.39,
//         high: 96.89,
//         low: 94.37,
//         close: 96.68,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 07, 11),
//         open: 96.75,
//         high: 99.3,
//         low: 96.73,
//         close: 98.78,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 07, 18),
//         open: 98.7,
//         high: 101,
//         low: 98.31,
//         close: 98.66,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 07, 25),
//         open: 98.25,
//         high: 104.55,
//         low: 96.42,
//         close: 104.21,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 08),
//         open: 104.41,
//         high: 107.65,
//         low: 104,
//         close: 107.48,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 08, 08),
//         open: 107.52,
//         high: 108.94,
//         low: 107.16,
//         close: 108.18,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 08, 15),
//         open: 108.14,
//         high: 110.23,
//         low: 108.08,
//         close: 109.36,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 08, 22),
//         open: 108.86,
//         high: 109.32,
//         low: 106.31,
//         close: 106.94,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 08, 29),
//         open: 106.62,
//         high: 108,
//         low: 105.5,
//         close: 107.73,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 09, 05),
//         open: 107.9,
//         high: 108.76,
//         low: 103.13,
//         close: 103.13,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 09, 12),
//         open: 102.65,
//         high: 116.13,
//         low: 102.53,
//         close: 114.92,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 09, 19),
//         open: 115.19,
//         high: 116.18,
//         low: 111.55,
//         close: 112.71,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 09, 26),
//         open: 111.64,
//         high: 114.64,
//         low: 111.55,
//         close: 113.05,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 10, 03),
//         open: 112.71,
//         high: 114.56,
//         low: 112.28,
//         close: 114.06,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 10, 10),
//         open: 115.02,
//         high: 118.69,
//         low: 114.72,
//         close: 117.63,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 10, 17),
//         open: 117.33,
//         high: 118.21,
//         low: 113.8,
//         close: 116.6,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 01, 11),
//         open: 98.97,
//         high: 101.19,
//         low: 95.36,
//         close: 97.13,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 01, 18),
//         open: 98.41,
//         high: 101.46,
//         low: 93.42,
//         close: 101.42,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 01, 25),
//         open: 101.52,
//         high: 101.53,
//         low: 92.39,
//         close: 97.34,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 02),
//         open: 96.47,
//         high: 97.33,
//         low: 93.69,
//         close: 94.02,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 02, 08),
//         open: 93.13,
//         high: 96.35,
//         low: 92.59,
//         close: 93.99,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 02, 15),
//         open: 91.02,
//         high: 94.89,
//         low: 90.61,
//         close: 92.04,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 02, 22),
//         open: 98.0237,
//         high: 98.0237,
//         low: 98.0237,
//         close: 98.0237,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 02, 29),
//         open: 99.86,
//         high: 106.75,
//         low: 99.65,
//         close: 106.01,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 03, 07),
//         open: 102.39,
//         high: 102.83,
//         low: 100.15,
//         close: 102.26,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 03, 14),
//         open: 101.91,
//         high: 106.5,
//         low: 101.78,
//         close: 105.92,
//         volume: 200000),
//     StockData(
//       date: DateTime(2016, 03, 21),
//       open: 105.93,
//       high: 107.65,
//       low: 104.89,
//       close: 105.67,
//       volume: 130000,
//     ),
//     StockData(
//         date: DateTime(2016, 03, 28),
//         open: 106,
//         high: 110.42,
//         low: 104.88,
//         close: 109.99,
//         volume: 170000),
//     StockData(
//         date: DateTime(2016, 04, 04),
//         open: 110.42,
//         high: 112.19,
//         low: 108.121,
//         close: 108.66,
//         volume: 100900),
//     StockData(
//         date: DateTime(2016, 04, 11),
//         open: 108.97,
//         high: 112.39,
//         low: 108.66,
//         close: 109.85,
//         volume: 300000),
//     StockData(
//         date: DateTime(2016, 04, 18),
//         open: 108.89,
//         high: 108.95,
//         low: 104.62,
//         close: 105.68,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 04, 25),
//         open: 105,
//         high: 105.65,
//         low: 92.51,
//         close: 93.74,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 05, 02),
//         open: 93.965,
//         high: 95.9,
//         low: 91.85,
//         close: 92.72,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 05, 09),
//         open: 93,
//         high: 93.77,
//         low: 89.47,
//         close: 90.52,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 05, 16),
//         open: 92.39,
//         high: 95.43,
//         low: 91.65,
//         close: 95.22,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 05, 23),
//         open: 95.87,
//         high: 100.73,
//         low: 95.67,
//         close: 100.35,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 05, 30),
//         open: 99.6,
//         high: 100.4,
//         low: 96.63,
//         close: 97.92,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 06, 06),
//         open: 97.99,
//         high: 101.89,
//         low: 97.55,
//         close: 98.83,
//         volume: 400000),
//     StockData(
//         date: DateTime(2016, 06, 13),
//         open: 98.69,
//         high: 99.12,
//         low: 95.3,
//         close: 95.33,
//         volume: 700000),
//     StockData(
//         date: DateTime(2016, 06, 20),
//         open: 96,
//         high: 96.89,
//         low: 92.65,
//         close: 93.4,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 06, 27),
//         open: 93,
//         high: 96.465,
//         low: 91.5,
//         close: 95.89,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 07, 04),
//         open: 95.39,
//         high: 96.89,
//         low: 94.37,
//         close: 96.68,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 07, 11),
//         open: 96.75,
//         high: 99.3,
//         low: 96.73,
//         close: 98.78,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 07, 18),
//         open: 98.7,
//         high: 101,
//         low: 98.31,
//         close: 98.66,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 07, 25),
//         open: 98.25,
//         high: 104.55,
//         low: 96.42,
//         close: 104.21,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 08),
//         open: 104.41,
//         high: 107.65,
//         low: 104,
//         close: 107.48,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 08, 08),
//         open: 107.52,
//         high: 108.94,
//         low: 107.16,
//         close: 108.18,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 08, 15),
//         open: 108.14,
//         high: 110.23,
//         low: 108.08,
//         close: 109.36,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 08, 22),
//         open: 108.86,
//         high: 109.32,
//         low: 106.31,
//         close: 106.94,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 08, 29),
//         open: 106.62,
//         high: 108,
//         low: 105.5,
//         close: 107.73,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 09, 05),
//         open: 107.9,
//         high: 108.76,
//         low: 103.13,
//         close: 103.13,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 09, 12),
//         open: 102.65,
//         high: 116.13,
//         low: 102.53,
//         close: 114.92,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 09, 19),
//         open: 115.19,
//         high: 116.18,
//         low: 111.55,
//         close: 112.71,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 09, 26),
//         open: 111.64,
//         high: 114.64,
//         low: 111.55,
//         close: 113.05,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 10, 03),
//         open: 112.71,
//         high: 114.56,
//         low: 112.28,
//         close: 114.06,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 10, 10),
//         open: 115.02,
//         high: 118.69,
//         low: 114.72,
//         close: 117.63,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 10, 17),
//         open: 117.33,
//         high: 118.21,
//         low: 113.8,
//         close: 116.6,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 10, 24),
//         open: 117.1,
//         high: 118.36,
//         low: 113.31,
//         close: 113.72,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 10, 31),
//         open: 113.65,
//         high: 114.23,
//         low: 108.11,
//         close: 108.84,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 11, 07),
//         open: 110.08,
//         high: 111.72,
//         low: 105.83,
//         close: 108.43,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 11, 14),
//         open: 107.71,
//         high: 110.54,
//         low: 104.08,
//         close: 110.06,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 01, 11),
//         open: 98.97,
//         high: 101.19,
//         low: 95.36,
//         close: 97.13,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 01, 18),
//         open: 98.41,
//         high: 101.46,
//         low: 93.42,
//         close: 101.42,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 01, 25),
//         open: 101.52,
//         high: 101.53,
//         low: 92.39,
//         close: 97.34,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 02),
//         open: 96.47,
//         high: 97.33,
//         low: 93.69,
//         close: 94.02,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 02, 08),
//         open: 93.13,
//         high: 96.35,
//         low: 92.59,
//         close: 93.99,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 02, 15),
//         open: 91.02,
//         high: 94.89,
//         low: 90.61,
//         close: 92.04,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 02, 22),
//         open: 98.0237,
//         high: 98.0237,
//         low: 98.0237,
//         close: 98.0237,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 02, 29),
//         open: 99.86,
//         high: 106.75,
//         low: 99.65,
//         close: 106.01,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 03, 07),
//         open: 102.39,
//         high: 102.83,
//         low: 100.15,
//         close: 102.26,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 03, 14),
//         open: 101.91,
//         high: 106.5,
//         low: 101.78,
//         close: 105.92,
//         volume: 200000),
//     StockData(
//       date: DateTime(2017, 03, 21),
//       open: 105.93,
//       high: 107.65,
//       low: 104.89,
//       close: 105.67,
//       volume: 130000,
//     ),
//     StockData(
//         date: DateTime(2017, 03, 28),
//         open: 106,
//         high: 110.42,
//         low: 104.88,
//         close: 109.99,
//         volume: 170000),
//     StockData(
//         date: DateTime(2017, 04, 04),
//         open: 110.42,
//         high: 112.19,
//         low: 108.121,
//         close: 108.66,
//         volume: 100900),
//     StockData(
//         date: DateTime(2017, 04, 11),
//         open: 108.97,
//         high: 112.39,
//         low: 108.66,
//         close: 109.85,
//         volume: 300000),
//     StockData(
//         date: DateTime(2017, 04, 18),
//         open: 108.89,
//         high: 108.95,
//         low: 104.62,
//         close: 105.68,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 04, 25),
//         open: 105,
//         high: 105.65,
//         low: 92.51,
//         close: 93.74,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 05, 02),
//         open: 93.965,
//         high: 95.9,
//         low: 91.85,
//         close: 92.72,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 05, 09),
//         open: 93,
//         high: 93.77,
//         low: 89.47,
//         close: 90.52,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 05, 16),
//         open: 92.39,
//         high: 95.43,
//         low: 91.65,
//         close: 95.22,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 05, 23),
//         open: 95.87,
//         high: 100.73,
//         low: 95.67,
//         close: 100.35,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 05, 30),
//         open: 99.6,
//         high: 100.4,
//         low: 96.63,
//         close: 97.92,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 06, 06),
//         open: 97.99,
//         high: 101.89,
//         low: 97.55,
//         close: 98.83,
//         volume: 400000),
//     StockData(
//         date: DateTime(2017, 06, 13),
//         open: 98.69,
//         high: 99.12,
//         low: 95.3,
//         close: 95.33,
//         volume: 700000),
//     StockData(
//         date: DateTime(2017, 06, 20),
//         open: 96,
//         high: 96.89,
//         low: 92.65,
//         close: 93.4,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 06, 27),
//         open: 93,
//         high: 96.465,
//         low: 91.5,
//         close: 95.89,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 07, 04),
//         open: 95.39,
//         high: 96.89,
//         low: 94.37,
//         close: 96.68,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 07, 11),
//         open: 96.75,
//         high: 99.3,
//         low: 96.73,
//         close: 98.78,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 07, 18),
//         open: 98.7,
//         high: 101,
//         low: 98.31,
//         close: 98.66,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 07, 25),
//         open: 98.25,
//         high: 104.55,
//         low: 96.42,
//         close: 104.21,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 08),
//         open: 104.41,
//         high: 107.65,
//         low: 104,
//         close: 107.48,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 08, 08),
//         open: 107.52,
//         high: 108.94,
//         low: 107.16,
//         close: 108.18,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 08, 15),
//         open: 108.14,
//         high: 110.23,
//         low: 108.08,
//         close: 109.36,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 08, 22),
//         open: 108.86,
//         high: 109.32,
//         low: 106.31,
//         close: 106.94,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 08, 29),
//         open: 106.62,
//         high: 108,
//         low: 105.5,
//         close: 107.73,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 09, 05),
//         open: 107.9,
//         high: 108.76,
//         low: 103.13,
//         close: 103.13,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 09, 12),
//         open: 102.65,
//         high: 116.13,
//         low: 102.53,
//         close: 114.92,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 09, 19),
//         open: 115.19,
//         high: 116.18,
//         low: 111.55,
//         close: 112.71,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 09, 26),
//         open: 111.64,
//         high: 114.64,
//         low: 111.55,
//         close: 113.05,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 10, 03),
//         open: 112.71,
//         high: 114.56,
//         low: 112.28,
//         close: 114.06,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 10, 10),
//         open: 115.02,
//         high: 118.69,
//         low: 114.72,
//         close: 117.63,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 10, 17),
//         open: 117.33,
//         high: 118.21,
//         low: 113.8,
//         close: 116.6,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 10, 24),
//         open: 117.1,
//         high: 118.36,
//         low: 113.31,
//         close: 113.72,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 10, 31),
//         open: 113.65,
//         high: 114.23,
//         low: 108.11,
//         close: 108.84,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 11, 07),
//         open: 110.08,
//         high: 111.72,
//         low: 105.83,
//         close: 108.43,
//         volume: 100000),
//     StockData(
//         date: DateTime(2017, 11, 14),
//         open: 107.71,
//         high: 110.54,
//         low: 104.08,
//         close: 110.06,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 11, 21),
//         open: 115.42,
//         high: 115.42,
//         low: 115.42,
//         close: 115.42,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 11, 28),
//         open: 111.43,
//         high: 112.465,
//         low: 108.85,
//         close: 109.9,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 12, 05),
//         open: 110,
//         high: 114.7,
//         low: 108.25,
//         close: 113.95,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 12, 12),
//         open: 113.29,
//         high: 116.73,
//         low: 112.49,
//         close: 115.97,
//         volume: 100000),
//     StockData(
//         date: DateTime(2016, 12, 19),
//         open: 115.8,
//         high: 117.5,
//         low: 115.59,
//         close: 116.52,
//         volume: 200000),
//     StockData(
//         date: DateTime(2016, 12, 26),
//         open: 116.52,
//         high: 118.0166,
//         low: 115.43,
//         close: 115.82,
//         volume: 300000),

//     // StockData(DateTime(2024, 1, 1), 150.20, 195.60, 148.80, 153.40, 1500000),
//     // StockData(DateTime(2024, 1, 2), 153.40, 195.20, 152.10, 156.80, 1800000),
//     // StockData(DateTime(2024, 1, 3), 156.80, 158.90, 124.30, 200.20, 2100000),
//     // StockData(DateTime(2024, 1, 4), 155.20, 160.00, 154.80, 159.60, 1900000),
//     // StockData(DateTime(2024, 1, 5), 159.60, 162.40, 158.20, 161.80, 2300000),
//     // StockData(DateTime(2024, 1, 8), 161.80, 163.90, 160.50, 162.70, 1700000),
//     // StockData(DateTime(2024, 1, 9), 162.70, 165.20, 161.30, 164.90, 2000000),
//     // StockData(DateTime(2024, 1, 10), 164.90, 166.80, 163.40, 165.60, 2200000),
//     // StockData(DateTime(2024, 1, 11), 165.60, 168.30, 164.20, 167.90, 2400000),
//     // StockData(DateTime(2024, 1, 12), 167.90, 195.50, 166.40, 168.80, 1900000),
//     // StockData(DateTime(2024, 1, 15), 168.80, 171.20, 167.60, 170.40, 2100000),
//     // StockData(DateTime(2024, 1, 16), 170.40, 172.90, 169.30, 171.80, 2300000),
//     // StockData(DateTime(2024, 1, 17), 171.80, 200.60, 170.20, 172.50, 2000000),
//     // StockData(DateTime(2024, 1, 18), 172.50, 175.10, 171.40, 174.30, 2500000),
//     // StockData(DateTime(2024, 1, 19), 174.30, 176.80, 173.20, 175.90, 2200000),
//   ];
// }
