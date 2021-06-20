import 'package:flutter/material.dart';
import 'package:rive_nav/navs.dart';

import 'refresh_body.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rive2 Nav',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: navs.length,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          centerTitle: true,
          title: TabBar(
            tabs: navs.map((NavModle nav) => Tab(text: nav.title)).toList(),
            isScrollable: true,
          ),
        ),
        body: TabBarView(
          children: navs.map((NavModle nav) => RefreshBody(nav: nav)).toList(),
        ),
      ),
    );
  }
}
