import 'package:flutter/material.dart';

class OrientationBuilders extends StatelessWidget {
  final String flutter =
      '''A state is information that can be read when the widget is built and might change or modified over a lifetime of the app. If you want to change your widget, you need to update the state object, which can be done by using the setState() function available for Stateful widgets. The setState() function allows us to set the properties of the state object that triggers a redraw of the UI.

The state management is one of the most popular and necessary processes in the lifecycle of an application. According to official documentation, Flutter is declarative. It means Flutter builds its UI by reflecting the current state of your app. The following figure explains it more clearly where you can build a UI from the application state.''';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orientation Builder'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black,
          child: OrientationBuilder(
              builder: (context, orientation) =>
                  orientation == Orientation.portrait
                      ? buildprotrait()
                      : buildlandscape())),
    );
  }

  Widget buildText() {
    return Container(
      child: Column(
        children: [
          Image.network(
              "https://cdn.dribbble.com/users/1622791/screenshots/11174104/flutter_intro.png"),
          Text(
            flutter,
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.white, fontSize: 16),
          )
        ],
      ),
    );
  }

  Widget buildlandscape() {
    return Container(
      child: Row(
        children: [
          Image.network(
              "https://cdn.dribbble.com/users/1622791/screenshots/11174104/flutter_intro.png"),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                flutter,
                textAlign: TextAlign.justify,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildprotrait() {
    return Container(
      child: Column(
        children: [buildText()],
      ),
    );
  }
}
