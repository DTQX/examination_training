import './route_path.dart';
import 'test_paper/do/do_test_paper.dart';
import 'package:flutter/material.dart';

import 'test_paper/select/select_paper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: RoutePath.SELECT_TEST,
      routes: {
        RoutePath.SELECT_TEST: (context) => SelectTestPaper(),
        RoutePath.DO_TEST: (context) => DoTestPaper(),
      },
    );
  }
}
