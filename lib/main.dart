import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(const MyApp());
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
  List<StockData> stockData = [];
  late TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    super.initState();
    _trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    stockData = getStockData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stock Chart")),
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: SfCartesianChart(
                primaryXAxis: DateTimeAxis(
                  minimum: DateTime(2016, 01, 01),
                  maximum: DateTime(2017, 12, 31),
                  intervalType: DateTimeIntervalType.months,
                  majorGridLines: MajorGridLines(width: 0),
                ),
                primaryYAxis: NumericAxis(
                  minimum: 70,
                  maximum: 130,
                  interval: 15,
                  opposedPosition: true,
                ),
                axes: <ChartAxis>[
                  NumericAxis(
                    name: 'volumeAxis', // Secondary Y-axis for volume
                    title: AxisTitle(text: 'Volume'),
                    opposedPosition: true, // Moves the Y-axis to the right
                    minimum: 0,
                    maximum: 1000000, // Adjust based on your volume data
                    interval: 200000,
                  ),
                ],
                series: <ChartSeries>[
                  // Price Candlestick Chart
                  CandleSeries<StockData, DateTime>(
                    dataSource: stockData,
                    xValueMapper: (StockData data, _) => data.date,
                    lowValueMapper: (StockData data, _) => data.low,
                    highValueMapper: (StockData data, _) => data.high,
                    openValueMapper: (StockData data, _) => data.open,
                    closeValueMapper: (StockData data, _) => data.close,
                    name: 'Price',
                    bearColor: Colors.red,
                    bullColor: Colors.green,
                    enableSolidCandles: true,
                  ),
                  // Volume Bar Chart with a Secondary Y-Axis
                  ColumnSeries<StockData, DateTime>(
                    dataSource: stockData,
                    xValueMapper: (StockData data, _) => data.date,
                    yValueMapper: (StockData data, _) => data.volume,
                    color: Colors.blue,
                    yAxisName: 'volumeAxis', // Link to secondary Y-axis
                  ),
                ],
              )),
          // Expanded(
          //   child: SfCartesianChart(
          //     primaryXAxis: DateTimeAxis(),
          //     primaryYAxis: NumericAxis(),
          //     series: <ColumnSeries<StockData, DateTime>>[
          //       ColumnSeries<StockData, DateTime>(
          //         dataSource: stockData,
          //         xValueMapper: (StockData data, _) => data.date,
          //         yValueMapper: (StockData data, _) => data.volume,
          //         color: Colors.blue,
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

class StockData {
  final DateTime date;
  final double open, high, low, close, volume;

  StockData(
      {required this.date,
      required this.open,
      required this.high,
      required this.low,
      required this.close,
      required this.volume});
}

List<StockData> getStockData() {
  return [
    StockData(
        date: DateTime(2016, 01, 11),
        open: 98.97,
        high: 101.19,
        low: 95.36,
        close: 97.13,
        volume: 100000),
    StockData(
        date: DateTime(2016, 01, 18),
        open: 98.41,
        high: 101.46,
        low: 93.42,
        close: 101.42,
        volume: 100000),
    StockData(
        date: DateTime(2016, 01, 25),
        open: 101.52,
        high: 101.53,
        low: 92.39,
        close: 97.34,
        volume: 100000),
    StockData(
        date: DateTime(2016, 02),
        open: 96.47,
        high: 97.33,
        low: 93.69,
        close: 94.02,
        volume: 100000),
    StockData(
        date: DateTime(2016, 02, 08),
        open: 93.13,
        high: 96.35,
        low: 92.59,
        close: 93.99,
        volume: 100000),
    StockData(
        date: DateTime(2016, 02, 15),
        open: 91.02,
        high: 94.89,
        low: 90.61,
        close: 92.04,
        volume: 100000),
    StockData(
        date: DateTime(2016, 02, 22),
        open: 98.0237,
        high: 98.0237,
        low: 98.0237,
        close: 98.0237,
        volume: 100000),
    StockData(
        date: DateTime(2016, 02, 29),
        open: 99.86,
        high: 106.75,
        low: 99.65,
        close: 106.01,
        volume: 100000),
    StockData(
        date: DateTime(2016, 03, 07),
        open: 102.39,
        high: 102.83,
        low: 100.15,
        close: 102.26,
        volume: 100000),
    StockData(
        date: DateTime(2016, 03, 14),
        open: 101.91,
        high: 106.5,
        low: 101.78,
        close: 105.92,
        volume: 200000),
    StockData(
      date: DateTime(2016, 03, 21),
      open: 105.93,
      high: 107.65,
      low: 104.89,
      close: 105.67,
      volume: 130000,
    ),
    StockData(
        date: DateTime(2016, 03, 28),
        open: 106,
        high: 110.42,
        low: 104.88,
        close: 109.99,
        volume: 170000),
    StockData(
        date: DateTime(2016, 04, 04),
        open: 110.42,
        high: 112.19,
        low: 108.121,
        close: 108.66,
        volume: 100900),
    StockData(
        date: DateTime(2016, 04, 11),
        open: 108.97,
        high: 112.39,
        low: 108.66,
        close: 109.85,
        volume: 300000),
    StockData(
        date: DateTime(2016, 04, 18),
        open: 108.89,
        high: 108.95,
        low: 104.62,
        close: 105.68,
        volume: 100000),
    StockData(
        date: DateTime(2016, 04, 25),
        open: 105,
        high: 105.65,
        low: 92.51,
        close: 93.74,
        volume: 100000),
    StockData(
        date: DateTime(2016, 05, 02),
        open: 93.965,
        high: 95.9,
        low: 91.85,
        close: 92.72,
        volume: 100000),
    StockData(
        date: DateTime(2016, 05, 09),
        open: 93,
        high: 93.77,
        low: 89.47,
        close: 90.52,
        volume: 100000),
    StockData(
        date: DateTime(2016, 05, 16),
        open: 92.39,
        high: 95.43,
        low: 91.65,
        close: 95.22,
        volume: 100000),
    StockData(
        date: DateTime(2016, 05, 23),
        open: 95.87,
        high: 100.73,
        low: 95.67,
        close: 100.35,
        volume: 100000),
    StockData(
        date: DateTime(2016, 05, 30),
        open: 99.6,
        high: 100.4,
        low: 96.63,
        close: 97.92,
        volume: 100000),
    StockData(
        date: DateTime(2016, 06, 06),
        open: 97.99,
        high: 101.89,
        low: 97.55,
        close: 98.83,
        volume: 400000),
    StockData(
        date: DateTime(2016, 06, 13),
        open: 98.69,
        high: 99.12,
        low: 95.3,
        close: 95.33,
        volume: 700000),
    StockData(
        date: DateTime(2016, 06, 20),
        open: 96,
        high: 96.89,
        low: 92.65,
        close: 93.4,
        volume: 100000),
    StockData(
        date: DateTime(2016, 06, 27),
        open: 93,
        high: 96.465,
        low: 91.5,
        close: 95.89,
        volume: 100000),
    StockData(
        date: DateTime(2016, 07, 04),
        open: 95.39,
        high: 96.89,
        low: 94.37,
        close: 96.68,
        volume: 100000),
    StockData(
        date: DateTime(2016, 07, 11),
        open: 96.75,
        high: 99.3,
        low: 96.73,
        close: 98.78,
        volume: 100000),
    StockData(
        date: DateTime(2016, 07, 18),
        open: 98.7,
        high: 101,
        low: 98.31,
        close: 98.66,
        volume: 100000),
    StockData(
        date: DateTime(2016, 07, 25),
        open: 98.25,
        high: 104.55,
        low: 96.42,
        close: 104.21,
        volume: 100000),
    StockData(
        date: DateTime(2016, 08),
        open: 104.41,
        high: 107.65,
        low: 104,
        close: 107.48,
        volume: 100000),
    StockData(
        date: DateTime(2016, 08, 08),
        open: 107.52,
        high: 108.94,
        low: 107.16,
        close: 108.18,
        volume: 100000),
    StockData(
        date: DateTime(2016, 08, 15),
        open: 108.14,
        high: 110.23,
        low: 108.08,
        close: 109.36,
        volume: 100000),
    StockData(
        date: DateTime(2016, 08, 22),
        open: 108.86,
        high: 109.32,
        low: 106.31,
        close: 106.94,
        volume: 100000),
    StockData(
        date: DateTime(2016, 08, 29),
        open: 106.62,
        high: 108,
        low: 105.5,
        close: 107.73,
        volume: 100000),
    StockData(
        date: DateTime(2016, 09, 05),
        open: 107.9,
        high: 108.76,
        low: 103.13,
        close: 103.13,
        volume: 100000),
    StockData(
        date: DateTime(2016, 09, 12),
        open: 102.65,
        high: 116.13,
        low: 102.53,
        close: 114.92,
        volume: 100000),
    StockData(
        date: DateTime(2016, 09, 19),
        open: 115.19,
        high: 116.18,
        low: 111.55,
        close: 112.71,
        volume: 100000),
    StockData(
        date: DateTime(2016, 09, 26),
        open: 111.64,
        high: 114.64,
        low: 111.55,
        close: 113.05,
        volume: 100000),
    StockData(
        date: DateTime(2016, 10, 03),
        open: 112.71,
        high: 114.56,
        low: 112.28,
        close: 114.06,
        volume: 100000),
    StockData(
        date: DateTime(2016, 10, 10),
        open: 115.02,
        high: 118.69,
        low: 114.72,
        close: 117.63,
        volume: 100000),
    StockData(
        date: DateTime(2016, 10, 17),
        open: 117.33,
        high: 118.21,
        low: 113.8,
        close: 116.6,
        volume: 100000),
    StockData(
        date: DateTime(2016, 01, 11),
        open: 98.97,
        high: 101.19,
        low: 95.36,
        close: 97.13,
        volume: 100000),
    StockData(
        date: DateTime(2016, 01, 18),
        open: 98.41,
        high: 101.46,
        low: 93.42,
        close: 101.42,
        volume: 100000),
    StockData(
        date: DateTime(2016, 01, 25),
        open: 101.52,
        high: 101.53,
        low: 92.39,
        close: 97.34,
        volume: 100000),
    StockData(
        date: DateTime(2016, 02),
        open: 96.47,
        high: 97.33,
        low: 93.69,
        close: 94.02,
        volume: 100000),
    StockData(
        date: DateTime(2016, 02, 08),
        open: 93.13,
        high: 96.35,
        low: 92.59,
        close: 93.99,
        volume: 100000),
    StockData(
        date: DateTime(2016, 02, 15),
        open: 91.02,
        high: 94.89,
        low: 90.61,
        close: 92.04,
        volume: 100000),
    StockData(
        date: DateTime(2016, 02, 22),
        open: 98.0237,
        high: 98.0237,
        low: 98.0237,
        close: 98.0237,
        volume: 100000),
    StockData(
        date: DateTime(2016, 02, 29),
        open: 99.86,
        high: 106.75,
        low: 99.65,
        close: 106.01,
        volume: 100000),
    StockData(
        date: DateTime(2016, 03, 07),
        open: 102.39,
        high: 102.83,
        low: 100.15,
        close: 102.26,
        volume: 100000),
    StockData(
        date: DateTime(2016, 03, 14),
        open: 101.91,
        high: 106.5,
        low: 101.78,
        close: 105.92,
        volume: 200000),
    StockData(
      date: DateTime(2016, 03, 21),
      open: 105.93,
      high: 107.65,
      low: 104.89,
      close: 105.67,
      volume: 130000,
    ),
    StockData(
        date: DateTime(2016, 03, 28),
        open: 106,
        high: 110.42,
        low: 104.88,
        close: 109.99,
        volume: 170000),
    StockData(
        date: DateTime(2016, 04, 04),
        open: 110.42,
        high: 112.19,
        low: 108.121,
        close: 108.66,
        volume: 100900),
    StockData(
        date: DateTime(2016, 04, 11),
        open: 108.97,
        high: 112.39,
        low: 108.66,
        close: 109.85,
        volume: 300000),
    StockData(
        date: DateTime(2016, 04, 18),
        open: 108.89,
        high: 108.95,
        low: 104.62,
        close: 105.68,
        volume: 100000),
    StockData(
        date: DateTime(2016, 04, 25),
        open: 105,
        high: 105.65,
        low: 92.51,
        close: 93.74,
        volume: 100000),
    StockData(
        date: DateTime(2016, 05, 02),
        open: 93.965,
        high: 95.9,
        low: 91.85,
        close: 92.72,
        volume: 100000),
    StockData(
        date: DateTime(2016, 05, 09),
        open: 93,
        high: 93.77,
        low: 89.47,
        close: 90.52,
        volume: 100000),
    StockData(
        date: DateTime(2016, 05, 16),
        open: 92.39,
        high: 95.43,
        low: 91.65,
        close: 95.22,
        volume: 100000),
    StockData(
        date: DateTime(2016, 05, 23),
        open: 95.87,
        high: 100.73,
        low: 95.67,
        close: 100.35,
        volume: 100000),
    StockData(
        date: DateTime(2016, 05, 30),
        open: 99.6,
        high: 100.4,
        low: 96.63,
        close: 97.92,
        volume: 100000),
    StockData(
        date: DateTime(2016, 06, 06),
        open: 97.99,
        high: 101.89,
        low: 97.55,
        close: 98.83,
        volume: 400000),
    StockData(
        date: DateTime(2016, 06, 13),
        open: 98.69,
        high: 99.12,
        low: 95.3,
        close: 95.33,
        volume: 700000),
    StockData(
        date: DateTime(2016, 06, 20),
        open: 96,
        high: 96.89,
        low: 92.65,
        close: 93.4,
        volume: 100000),
    StockData(
        date: DateTime(2016, 06, 27),
        open: 93,
        high: 96.465,
        low: 91.5,
        close: 95.89,
        volume: 100000),
    StockData(
        date: DateTime(2016, 07, 04),
        open: 95.39,
        high: 96.89,
        low: 94.37,
        close: 96.68,
        volume: 100000),
    StockData(
        date: DateTime(2016, 07, 11),
        open: 96.75,
        high: 99.3,
        low: 96.73,
        close: 98.78,
        volume: 100000),
    StockData(
        date: DateTime(2016, 07, 18),
        open: 98.7,
        high: 101,
        low: 98.31,
        close: 98.66,
        volume: 100000),
    StockData(
        date: DateTime(2016, 07, 25),
        open: 98.25,
        high: 104.55,
        low: 96.42,
        close: 104.21,
        volume: 100000),
    StockData(
        date: DateTime(2016, 08),
        open: 104.41,
        high: 107.65,
        low: 104,
        close: 107.48,
        volume: 100000),
    StockData(
        date: DateTime(2016, 08, 08),
        open: 107.52,
        high: 108.94,
        low: 107.16,
        close: 108.18,
        volume: 100000),
    StockData(
        date: DateTime(2016, 08, 15),
        open: 108.14,
        high: 110.23,
        low: 108.08,
        close: 109.36,
        volume: 100000),
    StockData(
        date: DateTime(2016, 08, 22),
        open: 108.86,
        high: 109.32,
        low: 106.31,
        close: 106.94,
        volume: 100000),
    StockData(
        date: DateTime(2016, 08, 29),
        open: 106.62,
        high: 108,
        low: 105.5,
        close: 107.73,
        volume: 100000),
    StockData(
        date: DateTime(2016, 09, 05),
        open: 107.9,
        high: 108.76,
        low: 103.13,
        close: 103.13,
        volume: 100000),
    StockData(
        date: DateTime(2016, 09, 12),
        open: 102.65,
        high: 116.13,
        low: 102.53,
        close: 114.92,
        volume: 100000),
    StockData(
        date: DateTime(2016, 09, 19),
        open: 115.19,
        high: 116.18,
        low: 111.55,
        close: 112.71,
        volume: 100000),
    StockData(
        date: DateTime(2016, 09, 26),
        open: 111.64,
        high: 114.64,
        low: 111.55,
        close: 113.05,
        volume: 100000),
    StockData(
        date: DateTime(2016, 10, 03),
        open: 112.71,
        high: 114.56,
        low: 112.28,
        close: 114.06,
        volume: 100000),
    StockData(
        date: DateTime(2016, 10, 10),
        open: 115.02,
        high: 118.69,
        low: 114.72,
        close: 117.63,
        volume: 100000),
    StockData(
        date: DateTime(2017, 10, 17),
        open: 117.33,
        high: 118.21,
        low: 113.8,
        close: 116.6,
        volume: 100000),
    StockData(
        date: DateTime(2017, 10, 24),
        open: 117.1,
        high: 118.36,
        low: 113.31,
        close: 113.72,
        volume: 100000),
    StockData(
        date: DateTime(2017, 10, 31),
        open: 113.65,
        high: 114.23,
        low: 108.11,
        close: 108.84,
        volume: 100000),
    StockData(
        date: DateTime(2017, 11, 07),
        open: 110.08,
        high: 111.72,
        low: 105.83,
        close: 108.43,
        volume: 100000),
    StockData(
        date: DateTime(2017, 11, 14),
        open: 107.71,
        high: 110.54,
        low: 104.08,
        close: 110.06,
        volume: 100000),
    StockData(
        date: DateTime(2017, 01, 11),
        open: 98.97,
        high: 101.19,
        low: 95.36,
        close: 97.13,
        volume: 100000),
    StockData(
        date: DateTime(2017, 01, 18),
        open: 98.41,
        high: 101.46,
        low: 93.42,
        close: 101.42,
        volume: 100000),
    StockData(
        date: DateTime(2017, 01, 25),
        open: 101.52,
        high: 101.53,
        low: 92.39,
        close: 97.34,
        volume: 100000),
    StockData(
        date: DateTime(2017, 02),
        open: 96.47,
        high: 97.33,
        low: 93.69,
        close: 94.02,
        volume: 100000),
    StockData(
        date: DateTime(2017, 02, 08),
        open: 93.13,
        high: 96.35,
        low: 92.59,
        close: 93.99,
        volume: 100000),
    StockData(
        date: DateTime(2017, 02, 15),
        open: 91.02,
        high: 94.89,
        low: 90.61,
        close: 92.04,
        volume: 100000),
    StockData(
        date: DateTime(2017, 02, 22),
        open: 98.0237,
        high: 98.0237,
        low: 98.0237,
        close: 98.0237,
        volume: 100000),
    StockData(
        date: DateTime(2017, 02, 29),
        open: 99.86,
        high: 106.75,
        low: 99.65,
        close: 106.01,
        volume: 100000),
    StockData(
        date: DateTime(2017, 03, 07),
        open: 102.39,
        high: 102.83,
        low: 100.15,
        close: 102.26,
        volume: 100000),
    StockData(
        date: DateTime(2017, 03, 14),
        open: 101.91,
        high: 106.5,
        low: 101.78,
        close: 105.92,
        volume: 200000),
    StockData(
      date: DateTime(2017, 03, 21),
      open: 105.93,
      high: 107.65,
      low: 104.89,
      close: 105.67,
      volume: 130000,
    ),
    StockData(
        date: DateTime(2017, 03, 28),
        open: 106,
        high: 110.42,
        low: 104.88,
        close: 109.99,
        volume: 170000),
    StockData(
        date: DateTime(2017, 04, 04),
        open: 110.42,
        high: 112.19,
        low: 108.121,
        close: 108.66,
        volume: 100900),
    StockData(
        date: DateTime(2017, 04, 11),
        open: 108.97,
        high: 112.39,
        low: 108.66,
        close: 109.85,
        volume: 300000),
    StockData(
        date: DateTime(2017, 04, 18),
        open: 108.89,
        high: 108.95,
        low: 104.62,
        close: 105.68,
        volume: 100000),
    StockData(
        date: DateTime(2017, 04, 25),
        open: 105,
        high: 105.65,
        low: 92.51,
        close: 93.74,
        volume: 100000),
    StockData(
        date: DateTime(2017, 05, 02),
        open: 93.965,
        high: 95.9,
        low: 91.85,
        close: 92.72,
        volume: 100000),
    StockData(
        date: DateTime(2017, 05, 09),
        open: 93,
        high: 93.77,
        low: 89.47,
        close: 90.52,
        volume: 100000),
    StockData(
        date: DateTime(2017, 05, 16),
        open: 92.39,
        high: 95.43,
        low: 91.65,
        close: 95.22,
        volume: 100000),
    StockData(
        date: DateTime(2017, 05, 23),
        open: 95.87,
        high: 100.73,
        low: 95.67,
        close: 100.35,
        volume: 100000),
    StockData(
        date: DateTime(2017, 05, 30),
        open: 99.6,
        high: 100.4,
        low: 96.63,
        close: 97.92,
        volume: 100000),
    StockData(
        date: DateTime(2017, 06, 06),
        open: 97.99,
        high: 101.89,
        low: 97.55,
        close: 98.83,
        volume: 400000),
    StockData(
        date: DateTime(2017, 06, 13),
        open: 98.69,
        high: 99.12,
        low: 95.3,
        close: 95.33,
        volume: 700000),
    StockData(
        date: DateTime(2017, 06, 20),
        open: 96,
        high: 96.89,
        low: 92.65,
        close: 93.4,
        volume: 100000),
    StockData(
        date: DateTime(2017, 06, 27),
        open: 93,
        high: 96.465,
        low: 91.5,
        close: 95.89,
        volume: 100000),
    StockData(
        date: DateTime(2017, 07, 04),
        open: 95.39,
        high: 96.89,
        low: 94.37,
        close: 96.68,
        volume: 100000),
    StockData(
        date: DateTime(2017, 07, 11),
        open: 96.75,
        high: 99.3,
        low: 96.73,
        close: 98.78,
        volume: 100000),
    StockData(
        date: DateTime(2017, 07, 18),
        open: 98.7,
        high: 101,
        low: 98.31,
        close: 98.66,
        volume: 100000),
    StockData(
        date: DateTime(2017, 07, 25),
        open: 98.25,
        high: 104.55,
        low: 96.42,
        close: 104.21,
        volume: 100000),
    StockData(
        date: DateTime(2017, 08),
        open: 104.41,
        high: 107.65,
        low: 104,
        close: 107.48,
        volume: 100000),
    StockData(
        date: DateTime(2017, 08, 08),
        open: 107.52,
        high: 108.94,
        low: 107.16,
        close: 108.18,
        volume: 100000),
    StockData(
        date: DateTime(2017, 08, 15),
        open: 108.14,
        high: 110.23,
        low: 108.08,
        close: 109.36,
        volume: 100000),
    StockData(
        date: DateTime(2017, 08, 22),
        open: 108.86,
        high: 109.32,
        low: 106.31,
        close: 106.94,
        volume: 100000),
    StockData(
        date: DateTime(2017, 08, 29),
        open: 106.62,
        high: 108,
        low: 105.5,
        close: 107.73,
        volume: 100000),
    StockData(
        date: DateTime(2017, 09, 05),
        open: 107.9,
        high: 108.76,
        low: 103.13,
        close: 103.13,
        volume: 100000),
    StockData(
        date: DateTime(2017, 09, 12),
        open: 102.65,
        high: 116.13,
        low: 102.53,
        close: 114.92,
        volume: 100000),
    StockData(
        date: DateTime(2017, 09, 19),
        open: 115.19,
        high: 116.18,
        low: 111.55,
        close: 112.71,
        volume: 100000),
    StockData(
        date: DateTime(2017, 09, 26),
        open: 111.64,
        high: 114.64,
        low: 111.55,
        close: 113.05,
        volume: 100000),
    StockData(
        date: DateTime(2017, 10, 03),
        open: 112.71,
        high: 114.56,
        low: 112.28,
        close: 114.06,
        volume: 100000),
    StockData(
        date: DateTime(2017, 10, 10),
        open: 115.02,
        high: 118.69,
        low: 114.72,
        close: 117.63,
        volume: 100000),
    StockData(
        date: DateTime(2017, 10, 17),
        open: 117.33,
        high: 118.21,
        low: 113.8,
        close: 116.6,
        volume: 100000),
    StockData(
        date: DateTime(2017, 10, 24),
        open: 117.1,
        high: 118.36,
        low: 113.31,
        close: 113.72,
        volume: 100000),
    StockData(
        date: DateTime(2017, 10, 31),
        open: 113.65,
        high: 114.23,
        low: 108.11,
        close: 108.84,
        volume: 100000),
    StockData(
        date: DateTime(2017, 11, 07),
        open: 110.08,
        high: 111.72,
        low: 105.83,
        close: 108.43,
        volume: 100000),
    StockData(
        date: DateTime(2017, 11, 14),
        open: 107.71,
        high: 110.54,
        low: 104.08,
        close: 110.06,
        volume: 100000),
    StockData(
        date: DateTime(2016, 11, 21),
        open: 115.42,
        high: 115.42,
        low: 115.42,
        close: 115.42,
        volume: 100000),
    StockData(
        date: DateTime(2016, 11, 28),
        open: 111.43,
        high: 112.465,
        low: 108.85,
        close: 109.9,
        volume: 100000),
    StockData(
        date: DateTime(2016, 12, 05),
        open: 110,
        high: 114.7,
        low: 108.25,
        close: 113.95,
        volume: 100000),
    StockData(
        date: DateTime(2016, 12, 12),
        open: 113.29,
        high: 116.73,
        low: 112.49,
        close: 115.97,
        volume: 100000),
    StockData(
        date: DateTime(2016, 12, 19),
        open: 115.8,
        high: 117.5,
        low: 115.59,
        close: 116.52,
        volume: 200000),
    StockData(
        date: DateTime(2016, 12, 26),
        open: 116.52,
        high: 118.0166,
        low: 115.43,
        close: 115.82,
        volume: 300000),

    // StockData(DateTime(2024, 1, 1), 150.20, 195.60, 148.80, 153.40, 1500000),
    // StockData(DateTime(2024, 1, 2), 153.40, 195.20, 152.10, 156.80, 1800000),
    // StockData(DateTime(2024, 1, 3), 156.80, 158.90, 124.30, 200.20, 2100000),
    // StockData(DateTime(2024, 1, 4), 155.20, 160.00, 154.80, 159.60, 1900000),
    // StockData(DateTime(2024, 1, 5), 159.60, 162.40, 158.20, 161.80, 2300000),
    // StockData(DateTime(2024, 1, 8), 161.80, 163.90, 160.50, 162.70, 1700000),
    // StockData(DateTime(2024, 1, 9), 162.70, 165.20, 161.30, 164.90, 2000000),
    // StockData(DateTime(2024, 1, 10), 164.90, 166.80, 163.40, 165.60, 2200000),
    // StockData(DateTime(2024, 1, 11), 165.60, 168.30, 164.20, 167.90, 2400000),
    // StockData(DateTime(2024, 1, 12), 167.90, 195.50, 166.40, 168.80, 1900000),
    // StockData(DateTime(2024, 1, 15), 168.80, 171.20, 167.60, 170.40, 2100000),
    // StockData(DateTime(2024, 1, 16), 170.40, 172.90, 169.30, 171.80, 2300000),
    // StockData(DateTime(2024, 1, 17), 171.80, 200.60, 170.20, 172.50, 2000000),
    // StockData(DateTime(2024, 1, 18), 172.50, 175.10, 171.40, 174.30, 2500000),
    // StockData(DateTime(2024, 1, 19), 174.30, 176.80, 173.20, 175.90, 2200000),
  ];
}
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.dark(),
//       home: const StockChartScreen(),
//     );
//   }
// }

// class StockChartScreen extends StatefulWidget {
//   const StockChartScreen({super.key});

//   @override
//   _StockChartScreenState createState() => _StockChartScreenState();
// }

// class _StockChartScreenState extends State<StockChartScreen> {
//   late List<StockData> stockData;

//   @override
//   void initState() {
//     super.initState();
//     stockData = generateRandomStockData();
//   }

//   List<StockData> generateRandomStockData() {
//     List<StockData> data = [];
//     double lastClose = 100;

//     for (int i = 0; i < 300; i++) {
//       double open = lastClose;
//       double close = open + Random().nextDouble() * 10;
//       double high = max(open, close) + Random().nextDouble() * 5;
//       double low = min(open, close) - Random().nextDouble() * 5;
//       int volume = Random().nextInt(1000000) + 500000;

//       data.add(StockData(i, open, high, low, close, volume));
//       lastClose = close;
//     }

//     return data;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Stock Chart"),
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Expanded(
//               fledate: 2,
//               child: SfCartesianChart(
//                 zoomPanBehavior: ZoomPanBehavior(
//                   enablePinching: true,
//                   enablePanning: true,
//                   enableDoubleTapZooming: true,
//                   enableMouseWheelZooming: true,
//                   enableSelectionZooming: true,
//                 ),
//                 plotAreaBorderWidth: 0,
//                 primaryXAxis: NumericAxis(
//                   interval: 5,
//                   majorGridLines: const MajorGridLines(width: 0),
//                 ),
//                 primaryYAxis: NumericAxis(
//                   majorGridLines: const MajorGridLines(
//                     width: 0.5,
//                     dashArray: [5, 5],
//                   ),
//                 ),
//                 series: <CartesianSeries>[
//                   CandleSeries<StockData, int>(
//                     dataSource: stockData,
//                     xValueMapper: (StockData data, _) => data.day,
//                     lowValueMapper: (StockData data, _) => data.low,
//                     highValueMapper: (StockData data, _) => data.high,
//                     openValueMapper: (StockData data, _) => data.open,
//                     closeValueMapper: (StockData data, _) => data.close,
//                     enableTooltip: true,
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: SfCartesianChart(
//                 zoomPanBehavior: ZoomPanBehavior(
//                   enablePinching: true,
//                   enablePanning: true,
//                   enableDoubleTapZooming: true,
//                   enableMouseWheelZooming: true,
//                   enableSelectionZooming: true,
//                 ),
//                 plotAreaBorderWidth: 0,
//                 primaryXAxis: NumericAxis(
//                   interval: 5,
//                   majorGridLines: const MajorGridLines(width: 0),
//                 ),
//                 primaryYAxis: NumericAxis(
//                   majorGridLines: const MajorGridLines(
//                     width: 0.5,
//                     dashArray: [5, 5],
//                   ),
//                 ),
//                 series: <CartesianSeries>[
//                   ColumnSeries<StockData, int>(
//                     dataSource: stockData,
//                     xValueMapper: (StockData data, _) => data.day,
//                     yValueMapper: (StockData data, _) => data.volume,
//                     color: Colors.blue.withOpacity(0.7),
//                     spacing: 0.7,
//                     enableTooltip: true,
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class StockData {
//   final int day;
//   final double open;
//   final double high;
//   final double low;
//   final double close;
//   final int volume;

//   StockData(this.day, this.open, this.high, this.low, this.close, this.volume);
// }
