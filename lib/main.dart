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
  List<DateTime>? t;
  List<double>? o;
  List<double>? h;
  List<double>? l;
  List<double>? c;
  List<int>? v;

  Stock({this.s, this.t, this.o, this.h, this.l, this.c, this.v});

  Stock.fromJson(Map<String, dynamic> json) {
    s = json['s'];
    // t = json['t'].cast<DateTime>();
    // t = (json['t'] as List<dynamic>)
    //     .map((value) => DateTime.parse(value))
    //     .toList();
    t = (json['t'] as List<dynamic>)
        .map((timestamp) =>
            DateTime.fromMillisecondsSinceEpoch(timestamp * 1000))
        .toList();
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
  String jsonString =
      '''{"s":"ok","t":[1669906800,1670166000,1670252400,1670338800,1670425200,1670770800,1670857200,1670943600,1671030000,1671116400,1671375600,1671462000,1671548400,1671634800,1671721200,1672066800,1672153200,1672239600,1672326000,1672671600,1672758000,1672844400,1672930800,1673190000,1673276400,1674054000,1675177200,1675263600,1675350000,1675609200,1675695600,1675782000,1675868400,1675954800,1676214000,1676386800,1676473200,1676559600,1676905200,1677078000,1677164400,1677423600,1677510000,1677769200,1678201200,1678633200,1678719600,1678806000,1678892400,1678978800,1679238000,1679324400,1679497200,1679583600,1679842800,1679929200,1680015600,1680102000,1680188400,1680447600,1680534000,1680620400,1680706800,1680793200,1681052400,1681138800,1681225200,1681311600,1681398000,1681657200,1681743600,1681830000,1681916400,1682002800,1682262000,1682348400,1682434800,1682521200,1682607600,1682866800,1683039600,1683126000,1683212400,1683471600,1683558000,1683644400,1683730800,1683817200,1684076400,1684162800,1684249200,1684422000,1684681200,1684767600,1684854000,1684940400,1685286000,1685458800,1685545200,1685631600,1685890800,1685977200,1686063600,1686150000,1686236400,1686495600,1686582000,1686668400,1686754800,1686841200,1687100400,1687186800,1687273200,1687359600,1687446000,1687705200,1687791600,1687878000,1687964400,1688310000,1688396400,1688482800,1688569200,1688655600,1688914800,1689001200,1689087600,1689174000,1689260400,1689519600,1689606000,1689692400,1689778800,1689865200,1690124400,1690210800,1690297200,1690383600,1690470000,1690729200,1690902000,1690988400,1691074800,1691334000,1691420400,1691506800,1691593200,1691679600,1691938800,1692025200,1692111600,1692198000,1692284400,1692543600,1692716400,1692802800,1692889200,1693148400,1693234800,1693321200,1693407600,1693753200,1693839600,1693926000,1694098800,1694358000,1694444400,1694530800,1694617200,1694962800,1695049200,1695135600,1695308400,1695567600,1695654000,1695740400,1695826800,1696172400,1696258800,1696345200,1696431600,1696518000,1696777200,1696863600,1696950000,1697036400,1697122800,1697468400,1697554800,1697641200,1697727600,1698591600,1698678000,1698764400,1698937200,1699196400,1699282800,1699369200,1699455600,1699542000,1700492400,1700578800,1700751600,1701010800,1701097200,1701183600,1701270000,1701356400,1701615600,1701702000,1701788400,1701874800,1701961200,1702220400,1702306800,1702393200,1702479600,1702566000,1702825200,1702911600,1702998000,1703084400,1703170800,1703430000,1703689200,1703775600,1733065200,1733151600,1733238000,1733324400,1733410800,1733670000,1733756400,1733842800,1733929200,1734015600,1734361200,1734447600,1734534000,1734620400,1734879600,1734966000,1735052400,1735225200,1735484400,1735657200,1735743600,1735830000,1736089200,1736175600,1736262000,1736348400,1736434800,1736694000,1736780400,1736953200,1737298800,1737385200,1737471600,1737558000,1737644400,1737903600,1737990000,1738076400,1738508400,1738594800,1738681200,1738767600],"o":[1156.4,1162.0,1152.1,1150.0,1150.0,1130.5,1140.0,1130.0,1134.0,1140.0,1125.1,1118.0,1123.0,1117.1,1110.7,1111.0,1146.0,1142.0,1155.0,1223.8,1260.0,1304.5,1375.0,1330.0,1321.0,1285.2,1136.0,1149.0,1140.0,1125.1,1132.5,1143.0,1180.0,1160.0,1150.0,1158.0,1131.0,1130.0,1110.0,1111.1,1076.1,968.5,1040.0,820.0,765.0,755.0,751.0,754.1,750.1,739.2,735.2,735.0,740.0,714.0,692.0,670.0,676.4,689.9,737.0,713.0,700.7,738.0,797.0,790.2,784.0,805.0,797.0,845.0,819.0,828.9,806.9,805.0,824.0,803.7,773.4,801.1,795.0,781.0,795.0,760.0,785.0,771.0,785.0,739.5,753.6,763.8,765.0,740.0,755.0,718.0,717.0,740.0,757.9,759.1,803.6,838.9,846.1,799.0,798.7,815.6,817.0,806.0,815.0,817.0,820.1,830.0,837.9,840.0,901.5,898.0,883.0,915.0,900.1,877.1,900.0,912.0,930.0,964.0,955.0,928.0,880.0,885.1,920.0,925.0,918.1,918.0,919.0,957.0,970.0,1020.0,1053.0,1050.0,1068.0,1025.0,1084.6,1041.4,1037.0,1028.0,991.0,988.1,962.0,941.0,976.7,936.9,937.1,924.1,926.0,938.0,934.0,900.0,930.0,878.1,908.0,850.7,859.1,860.0,856.9,866.0,844.0,840.0,845.0,827.0,830.0,830.0,849.0,794.0,816.0,845.0,860.0,833.0,820.3,859.7,891.0,895.0,880.0,899.9,884.8,870.0,901.0,883.0,910.0,878.3,880.1,875.1,904.0,868.4,855.0,850.1,874.9,842.1,840.3,842.1,833.0,827.0,818.1,804.1,801.0,805.0,821.2,815.0,865.5,823.5,805.0,803.6,802.1,779.0,775.1,775.0,755.2,752.0,750.0,758.2,790.0,822.6,804.0,800.0,812.0,815.0,820.0,879.9,880.0,888.0,866.0,858.0,835.2,828.2,1316.0,1321.1,1296.1,1306.0,1301.0,1261.0,1275.0,1260.1,1278.0,1260.0,1240.0,1196.5,1188.0,1165.0,1154.0,1163.0,1180.0,1175.0,1179.8,1156.2,1161.0,1160.0,1148.3,1175.0,1175.1,1225.0,1207.1,1190.0,1190.0,1151.5,1152.1,1180.0,1170.0,1199.0,1211.0,1220.0,1219.0,1183.3,1247.3,1359.1,1321.0,1320.1],"h":[1198.0,1178.0,1175.0,1155.0,1150.0,1140.0,1140.0,1150.0,1140.0,1160.0,1136.0,1140.0,1140.4,1130.0,1120.0,1155.0,1170.0,1160.0,1160.9,1272.0,1284.9,1350.0,1392.0,1364.0,1333.0,1359.0,1172.0,1158.0,1147.0,1159.9,1154.1,1172.6,1195.0,1169.0,1164.0,1158.0,1150.0,1151.9,1129.9,1125.0,1076.1,1000.6,1041.4,854.0,793.9,790.7,761.5,775.2,765.0,749.9,760.0,754.0,753.8,725.0,712.0,696.0,709.0,727.1,737.0,727.2,719.0,764.9,815.0,839.0,856.0,839.0,808.9,861.0,863.5,834.7,840.0,815.0,838.0,840.0,818.9,815.0,800.0,801.0,800.0,804.0,800.0,780.0,785.0,800.7,775.0,770.0,765.0,760.0,760.0,733.9,729.8,751.0,772.5,771.0,833.0,860.0,877.2,830.0,819.0,820.0,845.7,838.0,815.0,836.4,833.0,839.9,869.9,869.0,927.9,910.0,908.9,939.0,990.0,910.0,906.0,913.9,938.0,1020.0,1001.0,941.1,928.0,904.9,935.6,925.0,932.9,934.9,1002.0,1081.0,1027.0,1061.0,1059.0,1075.9,1089.0,1106.7,1105.0,1089.0,1110.7,1048.0,1020.0,988.1,976.0,968.0,997.0,1025.0,963.6,982.8,958.5,959.6,950.0,947.9,930.0,924.0,930.2,929.0,874.9,869.0,874.0,866.0,850.0,860.0,861.7,865.8,853.7,845.0,849.0,864.9,875.0,886.2,878.2,885.2,899.9,874.8,894.5,902.7,906.6,917.0,914.9,948.0,966.9,959.9,954.0,929.8,900.0,910.0,922.8,900.0,899.4,862.1,905.5,874.9,915.3,860.0,862.3,896.0,825.0,850.6,844.0,847.7,870.0,852.6,915.0,896.7,835.0,836.4,814.0,836.4,800.0,787.0,780.0,765.0,780.0,858.0,840.9,822.6,835.0,816.0,827.5,827.4,843.0,889.4,889.9,902.0,876.0,864.0,893.8,905.0,1329.0,1335.0,1340.0,1340.0,1324.9,1295.0,1284.2,1283.0,1280.0,1331.0,1241.0,1216.0,1220.0,1180.0,1165.0,1164.5,1185.0,1197.0,1210.0,1199.9,1183.0,1194.9,1164.9,1198.0,1193.3,1245.0,1230.0,1208.0,1192.0,1174.0,1180.0,1194.0,1185.0,1248.4,1230.0,1230.0,1230.0,1251.0,1318.9,1399.3,1363.0,1348.0],"l":[1156.4,1150.0,1151.6,1140.0,1137.0,1118.0,1128.0,1110.0,1126.0,1125.0,1118.0,1112.0,1099.0,1117.1,1108.4,1105.0,1137.0,1120.0,1140.0,1185.0,1247.0,1230.0,1306.0,1290.0,1305.0,1241.0,1136.0,1138.0,1125.0,1125.0,1132.1,1143.0,1150.0,1150.1,1124.0,1124.0,1111.0,1124.0,1110.0,1097.0,988.2,900.0,1000.0,799.7,750.0,750.0,748.5,748.0,747.0,735.0,733.1,727.1,728.0,710.5,691.0,665.1,676.0,689.9,701.0,708.0,687.0,691.0,734.6,761.0,768.4,792.9,765.0,790.1,810.0,794.0,784.0,784.0,780.0,792.5,773.4,782.0,791.7,780.0,775.0,760.0,773.3,769.3,755.0,720.3,718.0,750.0,734.8,725.0,721.0,702.8,701.0,705.0,725.9,720.0,754.6,805.1,814.0,786.4,770.0,789.0,809.0,803.6,790.0,796.0,789.3,808.0,819.2,810.1,850.1,875.0,868.0,888.0,900.0,865.0,875.0,880.0,892.0,930.0,940.0,901.6,876.0,862.4,901.0,870.0,901.0,899.7,902.0,942.0,961.4,965.0,954.9,1006.0,1020.0,985.0,1048.6,1020.3,1030.0,989.5,955.0,940.0,940.9,932.2,931.0,882.0,907.1,914.0,907.5,919.3,890.0,882.0,870.0,877.0,860.0,842.8,830.0,852.0,841.0,827.0,825.0,833.3,835.1,822.3,810.2,808.5,804.1,794.0,809.0,835.0,830.0,825.2,817.1,835.0,843.0,850.1,863.0,873.0,866.0,839.0,853.2,856.0,866.1,875.0,850.0,841.2,849.7,851.2,845.1,840.0,837.9,823.2,835.0,823.0,812.2,820.1,809.0,786.0,765.4,779.1,774.0,783.0,782.0,823.5,777.0,774.1,795.0,767.1,775.0,773.0,753.0,748.0,748.1,737.0,788.0,775.2,774.2,796.0,797.0,793.0,785.0,807.6,864.4,869.9,845.0,840.9,828.0,824.0,1295.0,1313.0,1295.0,1281.0,1285.0,1256.0,1250.0,1242.1,1228.0,1255.0,1235.0,1190.0,1165.4,1147.0,1150.0,1145.1,1163.0,1160.0,1165.0,1151.5,1153.0,1155.0,1131.9,1153.1,1170.0,1199.0,1206.1,1186.0,1166.0,1151.5,1152.1,1156.4,1165.0,1185.0,1188.1,1205.0,1200.0,1177.0,1222.9,1308.3,1306.0,1293.7],"c":[1156.4,1152.0,1152.1,1140.6,1150.0,1135.0,1130.0,1150.0,1140.0,1140.0,1121.1,1118.0,1122.0,1130.0,1109.1,1110.0,1158.0,1142.0,1158.0,1220.0,1260.0,1350.0,1340.0,1320.0,1313.0,1247.0,1140.0,1155.0,1125.0,1147.0,1143.4,1172.6,1150.0,1160.2,1147.0,1126.4,1129.9,1124.0,1118.2,1098.0,988.2,948.0,1003.5,854.0,770.0,758.0,759.0,760.0,755.0,735.0,741.0,735.0,740.0,712.1,697.1,672.0,696.0,691.0,737.0,719.1,710.0,738.4,790.0,810.0,775.0,795.0,808.9,846.9,810.0,829.8,813.2,795.0,824.9,803.9,814.7,807.8,795.0,790.0,798.8,788.2,774.0,780.0,770.0,739.6,757.9,751.0,750.0,738.0,725.5,718.0,727.0,716.6,760.9,759.9,769.9,838.9,841.9,800.0,787.0,790.2,816.0,806.0,815.0,817.0,820.7,830.9,853.0,864.9,897.0,881.1,883.2,923.0,912.0,895.0,900.0,910.0,892.0,996.9,953.2,915.0,920.0,886.0,922.0,902.0,932.0,899.7,906.1,1020.0,1010.0,1061.0,1039.8,1048.0,1049.9,1106.7,1080.0,1049.7,1050.9,1037.0,972.0,985.0,962.0,947.1,970.0,987.0,934.9,940.9,910.1,939.0,940.0,938.4,909.0,912.0,907.0,848.1,868.5,857.0,856.9,841.0,835.0,844.9,835.1,837.0,830.0,845.0,821.0,811.1,868.9,848.1,878.2,849.9,820.2,852.0,891.0,888.9,874.9,897.0,880.0,948.0,901.1,884.2,910.0,893.8,879.1,904.8,902.7,886.0,850.0,850.0,872.1,840.0,856.8,858.8,840.1,827.1,818.1,805.1,799.0,804.0,791.2,815.0,815.4,823.5,805.1,789.5,797.0,780.1,789.0,774.0,753.2,752.0,780.0,758.1,840.9,806.5,805.0,816.0,812.9,805.0,819.0,865.6,880.0,888.0,869.1,857.0,853.8,859.8,1315.0,1321.0,1310.0,1308.0,1291.0,1266.0,1274.0,1249.5,1265.0,1305.0,1235.0,1195.0,1165.4,1166.0,1155.0,1163.0,1177.0,1174.0,1179.8,1157.1,1161.0,1160.0,1164.9,1175.0,1185.0,1224.0,1230.0,1186.0,1175.0,1166.0,1180.0,1157.4,1183.0,1211.0,1219.0,1219.0,1200.0,1199.0,1318.9,1340.0,1363.0,1320.0],"v":[1602,602,875,1714,190,651,1238,557,863,463,1004,1062,610,518,1956,3510,2580,1939,2351,3543,3781,9228,6246,4753,3478,3638,2558,1572,1379,923,1029,2788,2298,939,1255,1791,1992,1763,1391,3344,9097,4462,12735,7983,6061,5738,1583,3139,1566,947,1118,1371,3238,2796,3753,4855,5859,3108,2473,9886,4185,5792,4739,5891,6065,3110,895,4772,6761,1208,3157,816,3566,4498,3071,922,646,1184,701,1257,160,554,2398,2062,1458,799,65,2088,1970,2161,3773,2286,2618,2265,14806,5606,7095,4428,2367,5469,1645,1672,1227,3345,2042,3557,3946,20078,10168,2133,6948,12517,8382,2823,5106,7815,6487,11542,7746,5174,3321,6124,14872,3135,4604,2399,4814,6089,5366,6715,10661,6085,4727,4035,2959,5044,2336,4353,6929,3725,924,660,2459,2131,4135,743,230,1442,1714,4213,4886,1863,4652,4931,1683,2111,1873,1709,571,906,919,1624,1773,356,607,2122,1507,589,3630,984,1306,2398,5106,2507,768,2963,1529,2621,2515,1295,3315,1852,1851,3192,1571,1298,2103,1490,1012,3649,3961,1089,1112,2368,2616,3172,3520,2959,2976,2541,7412,4133,3628,2143,1250,2016,1010,1971,2263,1604,1712,1687,2665,40,7099,4481,4109,5604,3850,19721,5664,5466,8885,3566,1679,3298,3363,4891,5237,1945,1357,3646,1962,1038,3216,1766,1724,6856,4195,5858,1928,2158,1489,1263,5225,1571,652,1422,2445,3402,5032,4987,1653,1128,1192,2293,975,2728,1596,4086,3594,3712,4035,5622,27220,16076,4704,5988]}''';

  List<StockData> stockData = [];
  late TrackballBehavior _trackballBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
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
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enablePanning: true,
      enableDoubleTapZooming: true,
      // Sync charts on zoom/pan
      zoomMode: ZoomMode.xy,
    );
  }

  List<StockData> getStockData() {
    Random random = Random();
    List<StockData> stockDataList = [];
    for (int i = 0; i < 200; i++) {
      // for (int i = 0; i < stock.o!.length; i++) {
      // Random date, for example from 2016-01-01 to 2016-12-31
      DateTime randomDate =
          DateTime(2016, 1, 1).add(Duration(days: random.nextInt(30)));

      // print(randomDate);

      // Use stock data from the JSON
      double open = stock.o![i];
      double high = stock.h![i]; // Ensure it's a double
      double low = stock.l![i];
      double close = stock.c![i];
      int volume = stock.v![i];
      DateTime date = stock.t![i];
      print(date); // Volume from JSON

      // Create StockData instance and add it to the list
      StockData stockData = StockData(
        date: date,
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
      // appBar: AppBar(title: const Text("Stock Chart")),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              title: ChartTitle(text: 'Stock'),
              trackballBehavior: _trackballBehavior,
              primaryXAxis: DateTimeAxis(
                // minimum: DateTime(2022, 11, 01),
                maximum: DateTime(2026, 04, 6),
                // intervalType: DateTimeIntervalType.months,
              ),
              primaryYAxis: NumericAxis(
                // minimum: 300,
                // maximum: 1500,
                interval: 100,
                opposedPosition: true,
              ),
              zoomPanBehavior: _zoomPanBehavior,
              series: <CandleSeries<StockData, DateTime>>[
                CandleSeries<StockData, DateTime>(
                  enableSolidCandles: true,
                  dataSource: stockData,
                  xValueMapper: (StockData data, _) => data.date,
                  lowValueMapper: (StockData data, _) => data.low,
                  highValueMapper: (StockData data, _) => data.high,
                  openValueMapper: (StockData data, _) => data.open,
                  closeValueMapper: (StockData data, _) => data.close,
                  borderWidth: 1,
                )
              ],
            ),
          ),
          Expanded(
            child: SfCartesianChart(
              primaryXAxis: DateTimeAxis(
                  // minimum: DateTime(2022, 01, 01),
                  // maximum: DateTime(2025, 2, 31),
                  // intervalType: DateTimeIntervalType.years,
                  ),
              primaryYAxis: NumericAxis(minimum: 0, maximum: 20000),
              zoomPanBehavior: _zoomPanBehavior,
              series: <ColumnSeries<StockData, DateTime>>[
                ColumnSeries<StockData, DateTime>(
                  dataSource: stockData,
                  xValueMapper: (StockData data, _) => data.date,
                  yValueMapper: (StockData data, _) => data.volume,
                  pointColorMapper: (StockData data, _) =>
                      VolumeColor(data.open, data.close),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Color? VolumeColor(double open, double close) {
  if (open > close) {
    return Colors.green; // Color for decreasing volume
  } else {
    return Colors.red; // Color for increasing volume
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
