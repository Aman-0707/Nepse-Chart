// Scaffold(
//           // backgroundColor: Colors.black, // Black background for the Scaffold

//           appBar: AppBar(
//             title: _isSearching
//                 ? TextField(
//                     style: const TextStyle(color: Colors.white),
//                     controller: _searchController,
//                     onChanged: _filterSearch,
//                     autofocus: true,
//                     decoration: const InputDecoration(
//                       hintText: "Search Stock",
//                       hintStyle: TextStyle(color: Colors.white),
//                       border: InputBorder.none,
//                     ),
//                   )
//                 : Text(selectedStockName),
//             backgroundColor: primaryColor,
//             iconTheme: const IconThemeData(color: Colors.white),
//             foregroundColor: Colors.white,
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back), // Custom back button
//               onPressed: () {
//                 Navigator.pop(context); // Pops the current screen
//               },
//             ),
//             actions: [
//               IconButton(
//                 icon: Icon(_isSearching ? Icons.close : Icons.search),
//                 onPressed: _toggleSearch,
//               ),
//             ],
//           ),
//           body: Stack(
//             children: [
//               // Gesture Detector to capture taps outside the search overlay
//               GestureDetector(
//                 onTap: () {
//                   if (_isSearching) {
//                     setState(() {
//                       _isSearching = false;
//                     });
//                   }
//                 },
//                 behavior: HitTestBehavior.opaque, // Detect taps on empty space
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                         padding: const EdgeInsets.symmetric(vertical: 6),
//                         color:
//                             primaryColor, // Set container background to green
//                         // width: 500,
//                         // Add some padding
//                         child: SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Row(
//                             children: [
//                               SizedBox(width: 10),

//                               // Broker Button
//                               SizedBox(
//                                 width: 205, // Ensures button fits well
//                                 child: Column(
//                                   children: [
//                                     ElevatedButton(
//                                       onPressed: () {
//                                         showBrokerDialog(context);
//                                       },
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor:
//                                             Color.fromARGB(255, 6, 90, 159),
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(20),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 0,
//                                             vertical: 0), // Adjust padding
//                                       ),
//                                       child: Column(
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             mainAxisSize: MainAxisSize
//                                                 .min, // Prevents Row from expanding
//                                             children: [
//                                               SizedBox(width: 8),
//                                               const Icon(Icons.person,
//                                                   color: Colors.white),
//                                               SizedBox(width: 8),
//                                               // Space between icon and text
//                                               Expanded(
//                                                 // Allows text to take available space
//                                                 child: Text(
//                                                   selectedBrokerName,
//                                                   style: const TextStyle(
//                                                       color: Colors.white),
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                   maxLines: 2,
//                                                 ),
//                                               ),
//                                               IconButton(
//                                                 onPressed: () {
//                                                   setState(() {
//                                                     selectedBrokerName =
//                                                         'Search Broker';
//                                                   });
//                                                 },
//                                                 icon: const Icon(
//                                                   Icons.close,
//                                                   size: 20,
//                                                   color: Colors
//                                                       .white, // Ensure it matches button text color
//                                                 ),
//                                                 padding: EdgeInsets
//                                                     .zero, // Removes extra padding around icon
//                                                 constraints:
//                                                     BoxConstraints(), // Avoids flex issues
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               // Seller Broker Button
//                               SizedBox(
//                                 width: 215,
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     showSellerBrokerDialog(context);
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.purple,
//                                     padding: EdgeInsets
//                                         .zero, // Remove extra button padding
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(20),
//                                     ),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 0,
//                                         vertical: 0), // Less left/right padding
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize
//                                           .min, // Prevents unnecessary expansion
//                                       children: [
//                                         SizedBox(
//                                           width: 6,
//                                         ),
//                                         const Text(
//                                           'SELLER:  ', // Custom text icon
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         SizedBox(
//                                             width:
//                                                 4), // Reduce space between "SELL" and broker name
//                                         Expanded(
//                                           // Allows text to take available space and avoid overflow
//                                           child: Text(
//                                             selectedSellerBrokerName,
//                                             style: const TextStyle(
//                                                 color: Colors.white),
//                                             overflow: TextOverflow.ellipsis,
//                                             maxLines: 2,
//                                           ),
//                                         ),
//                                         IconButton(
//                                           onPressed: () {
//                                             setState(() {
//                                               selectedSellerBrokerName =
//                                                   'Seller Broker';
//                                             });
//                                           },
//                                           icon: const Icon(
//                                             Icons.close,
//                                             size:
//                                                 18, // Slightly smaller to reduce padding effect
//                                             color: Colors.white,
//                                           ),
//                                           padding: EdgeInsets
//                                               .zero, // Removes extra padding around the icon
//                                           constraints:
//                                               BoxConstraints(), // Fixes layout issues
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               // Buyer Broker Button
//                               SizedBox(
//                                 width: 205,
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     showBuyerBrokerDialog(context);
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor:
//                                         const Color.fromARGB(255, 248, 62, 6),
//                                     padding: EdgeInsets
//                                         .zero, // Remove default button padding
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(20),
//                                     ),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 0,
//                                         vertical: 0), // Less left/right padding
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize
//                                           .min, // Prevents unnecessary expansion
//                                       children: [
//                                         SizedBox(width: 6),
//                                         const Text(
//                                           'BUYER: ',
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontWeight: FontWeight
//                                                   .bold), // Custom text icon
//                                         ),
//                                         SizedBox(
//                                             width:
//                                                 4), // Reduce space between "BUY" and broker name
//                                         Expanded(
//                                           // Allows text to take available space and avoid overflow
//                                           child: Text(
//                                             selectedbuyerBrokerName,
//                                             style: const TextStyle(
//                                                 color: Colors.white),
//                                             overflow: TextOverflow.ellipsis,
//                                             maxLines: 2,
//                                           ),
//                                         ),
//                                         IconButton(
//                                           onPressed: () {
//                                             setState(() {
//                                               selectedbuyerBrokerName =
//                                                   'Buyer Broker';
//                                             });
//                                           },
//                                           icon: const Icon(
//                                             Icons.close,
//                                             size:
//                                                 18, // Slightly smaller to reduce padding effect
//                                             color: Colors.white,
//                                           ),
//                                           padding: EdgeInsets
//                                               .zero, // Removes extra padding around the icon
//                                           constraints:
//                                               BoxConstraints(), // Fixes layout issues
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )),
//                     // Container(
//                     //   padding: const EdgeInsets.symmetric(vertical: 6),
//                     //   color: primaryColor,
//                     //   child: Row(
//                     //     mainAxisAlignment: MainAxisAlignment.center,
//                     //     children: [

//                     //     ],
//                     //   ),
//                     // ),
//                     Expanded(
//                       flex: 4,
//                       child: SizedBox(
//                         width: MediaQuery.of(context).size.width * 0.9,
//                         height: MediaQuery.of(context).size.height * 0.9,
//                         child: SfCartesianChart(
//                           backgroundColor: Colors.black,
//                           plotAreaBorderWidth: 0,
//                           title: ChartTitle(text: selectedStockNameChart),
//                           trackballBehavior: _trackballBehavior,
//                           crosshairBehavior: CrosshairBehavior(
//                             lineDashArray: [5, 5],
//                             enable: true,
//                             activationMode: ActivationMode.singleTap,
//                             shouldAlwaysShow: true,
//                             lineColor: Colors.white,
//                             lineWidth: 1,
//                           ),
//                           primaryXAxis: DateTimeCategoryAxis(
//                             intervalType: DateTimeIntervalType.days,
//                           ),
//                           primaryYAxis: NumericAxis(
//                             interval: 100,
//                             opposedPosition: true,
//                           ),
//                           zoomPanBehavior: _zoomPanBehavior,
//                           series: <CandleSeries<StockData, DateTime>>[
//                             CandleSeries<StockData, DateTime>(
//                               enableSolidCandles: true,
//                               dataSource: stockData,
//                               xValueMapper: (StockData data, _) => data.date,
//                               lowValueMapper: (StockData data, _) => data.low,
//                               highValueMapper: (StockData data, _) => data.high,
//                               openValueMapper: (StockData data, _) => data.open,
//                               closeValueMapper: (StockData data, _) =>
//                                   data.close,
//                               borderWidth: 2,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: SfCartesianChart(
//                         borderWidth: 2,
//                         primaryXAxis: DateTimeCategoryAxis(),
//                         primaryYAxis: NumericAxis(),
//                         trackballBehavior: _trackballBehavior,
//                         zoomPanBehavior: _zoomPanBehavior,
//                         series: <ColumnSeries<StockData, DateTime>>[
//                           ColumnSeries<StockData, DateTime>(
//                             borderWidth: 2,
//                             dataSource: stockData,
//                             xValueMapper: (StockData data, _) => data.date,
//                             yValueMapper: (StockData data, _) => data.volume,
//                             pointColorMapper: (StockData data, _) =>
//                                 VolumeColor(data.open, data.close),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // Search results overlay inside Positioned
//               if (_isSearching)
//                 Positioned(
//                   top: 10,
//                   left: 35,
//                   right: 35,
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: Colors.grey[50],
//                         borderRadius: BorderRadius.circular(20)),
//                     height: 500,
//                     child: ListView.builder(
//                       itemCount: filteredItems.length,
//                       itemBuilder: (context, index) {
//                         final stock = filteredItems[index];
//                         return GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               selectedStockName =
//                                   "Broker Chart - " + (stock['name'])!;
//                               selectedStockNameChart = (stock['name'])!;
//                               _isSearching = false;
//                               fetchStockData();
//                             });
//                           },
//                           child: ListTile(
//                             leading: SizedBox(
//                               width: 40,
//                               height: 40,
//                               child: (stock["images"] != null &&
//                                       stock["images"]!.isNotEmpty)
//                                   ? Image.network(
//                                       stock["images"]!,
//                                       fit: BoxFit.cover,
//                                       errorBuilder:
//                                           (context, error, stackTrace) {
//                                         return const Icon(Icons.business);
//                                       },
//                                     )
//                                   : const Icon(Icons.house),
//                             ),
//                             title: Text(
//                               (stock["name"] ?? "Unknown Name") +
//                                   " - " +
//                                   (stock["description"] ??
//                                       "No description available"),
//                               style: const TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.normal,
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ));
 