import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'Add_location.dart';
import 'Setting.dart';

class Weatherhome extends StatefulWidget {
  final String city;
  final PageController controller;
  final int length;
  final String description;
  final double? temperature;
  final Future<void> Function() function;

  const Weatherhome({
    super.key,
    required this.city,
    required this.controller,
    required this.length,
    required this.description,
    this.temperature,
    required this.function,
  });

  @override
  State<Weatherhome> createState() => _WeatherhomeState();
}

class _WeatherhomeState extends State<Weatherhome> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(8, 10, 0, 0),
                child: Text(
                  widget.city,
                  style: TextStyle(fontSize: 50),
                ),
              ),
              IconButton(
                onPressed: () async => await widget.function(),
                icon: Icon(Icons.refresh),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddLocation()),
                  );
                },
                icon: Icon(Icons.add_location_alt_sharp),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Setting()),
                  );
                },
                icon: Icon(Icons.settings),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 20,
                      child: SmoothPageIndicator(
                        controller: widget.controller,
                        count: widget.length,
                        effect: WormEffect(
                          activeDotColor: Colors.white,
                          dotColor: Colors.white54,
                          dotHeight: 10,
                          dotWidth: 10,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                      child: Column(
                        children: [
                          Text(
                            "${widget.temperature ?? 'N/A'}°C",
                            style: TextStyle(fontSize: 80),
                          ),
                          Text(
                            widget.description,
                            style: TextStyle(fontSize: 50),
                          ),
                          SizedBox(height: 50),
                          Container(
                            height: height / 4,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.blue,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Center(child: Text("Today")),
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: height / 6,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.blue,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Center(child: Text("Tomorrow")),
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: height / 3,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.blue,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(children: [Text("26"), Text("Sunny")]),
                                Row(children: [Text("27"), Text("Rainy")]),
                                Row(children: [Text("28"), Text("Cloudy")]),
                                Row(children: [Text("29"), Text("Clear")]),
                                Row(children: [Text("30"), Text("Rainy")]),
                                Row(children: [Text("31"), Text("Clear")]),
                                Row(children: [Text("01"), Text("Cloudy")]),
                              ],
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
        ],
      ),
    );
  }
}
