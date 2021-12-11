// loading_screen.dart
// This loading screen is shown at the start of
// the app for just a few seconds

// imports
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:retrospective_reminder/screens/tasks_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:retrospective_reminder/utility/data_manager.dart';
import 'package:google_fonts/google_fonts.dart';

// Displays a progress indicator whilst loading the data
// then navigates to the next screen,
// passing it the data
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool dataLoaded = false;
  DataManager dm = DataManager();

  @override
  void initState() {
    super.initState();
    start();
  }

  void start() async {
    Timer(Duration(seconds: 5), () {
      getStoredData();
    });
  }

  void getStoredData() async {
    var f = await dm.init();
    setState(() {
      dataLoaded = true;
    });

    await Future.delayed(const Duration(milliseconds: 200), () {});

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TasksScreen(dataManager: dm);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent.shade700,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 40,
          left: 20,
          right: 20,
          bottom: 30,
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Retrospective',
                textAlign: TextAlign.center,
                style: GoogleFonts.merriweather(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Improvement Ideas',
                textAlign: TextAlign.center,
                style: GoogleFonts.merriweatherSans(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 40,
              ),
              dataLoaded
                  ? Column(
                      children: [
                        Text(
                          'Loaded',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.merriweatherSans(
                              fontSize: 35,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return TasksScreen(dataManager: dm);
                            }));
                          },
                          icon: Icon(Icons.forward, size: 18),
                          label: Text("View List"),
                        )
                      ],
                    )
                  : SpinKitWave(
                      color: Colors.white,
                      size: 100.0,
                    ),
              SizedBox(
                height: 40,
              ),
              Text(
                dataLoaded ? '' : 'Loading...',
                textAlign: TextAlign.center,
                style: GoogleFonts.merriweatherSans(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
