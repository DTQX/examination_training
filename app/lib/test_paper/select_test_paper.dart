import 'package:flutter/material.dart';
import '../route_path.dart';

List<Container> getYear() {
  return ['2020', '2019', '2018']
      .map((e) => Container(
            child: Text(e),
            margin: EdgeInsets.fromLTRB(14,14,14,0),
          ))
      .toList();
}

List<Container> getSubject() {
  return ['数学', '理综']
      .map((e) => Container(
            child: Text(e),
            margin: EdgeInsets.all(14),
          ))
      .toList();
}

class SelectTestPaper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('选择试卷'),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(children: getYear()),
              Row(children: getSubject()),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: ()=>{
                      Navigator.pushNamed(context, RoutePath.DO_TEST)
                    },
                    child: Text('试卷1'),
                  ),
                  ElevatedButton(
                    child: Text('试卷2'),
                    onPressed: ()=>{
                      Navigator.pushNamed(context, RoutePath.DO_TEST)
                    },
                  )
                ],
              )
            ],
          ),
        ));
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new DecoratedBox(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage('images/p1.png'),
          // ...
        ),
        // ...
      ),
    );
  }
}
