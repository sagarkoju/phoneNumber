import 'package:flutter/material.dart';

class Lay extends StatefulWidget {
  @override
  _LayState createState() => _LayState();
}

class _LayState extends State<Lay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LayOut Builder'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: LayoutBuilder(builder: (context, constraint) {
            if (constraint.maxWidth <= 600) {
              return home();
            } else {
              return home1();
            }
          }),
        ),
      ),
    );
  }

  Widget home() {
    return buildpadding();
  }

  Padding buildpadding() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          children: List.generate(100, (index) => buildCard(index))),
    );
  }

  Card buildCard(int index) {
    return Card(
      child: Container(
        alignment: Alignment.center,
        color: Colors.green,
        child: Text('$index', textScaleFactor: 2),
      ),
    );
  }

  Widget home1() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          children: List.generate(100, (index) => buildCard(index))),
    );
  }
}
