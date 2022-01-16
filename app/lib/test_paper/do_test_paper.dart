import 'package:flutter/material.dart';
import '../route_path.dart';

class DoTestPaper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('00:00'),
            Text('1/22'),
            Checkbox(value: false, onChanged: (bool) => {})
          ],
        )),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Image(image: AssetImage('images/p1.png')),
            ],
          ),
        ),
        bottomSheet: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () =>
                  {Navigator.pushNamed(context, RoutePath.DO_TEST)},
              child: Text('收藏'),
            ),
            ElevatedButton(
              onPressed: () =>
                  {Navigator.pushNamed(context, RoutePath.DO_TEST)},
              child: Text('提交'),
            ),
            OutlinedButton(
              child: Text("上一题"),
              onPressed: () {},
            ),
            OutlinedButton(
              child: Text("下一题"),
              onPressed: () {},
            )
          ],
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
