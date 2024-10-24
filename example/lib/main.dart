import 'package:flutter/material.dart';
import 'package:gravity_sensor/gravity_sensor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('gravity_sensor example app'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
            stream: GravitySensor().gravityEvents,
            builder: (_, snapshot) {
              if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));

              final GravityEvent? data = snapshot.data;
              if (data == null) return const Center(child: Text('No data'));

              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Column(
                        children: <Widget>[
                          Text('x:'),
                          Text('y:'),
                          Text('z:'),
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Text(data.x.toStringAsFixed(5)),
                        Text(data.y.toStringAsFixed(5)),
                        Text(data.z.toStringAsFixed(5)),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
