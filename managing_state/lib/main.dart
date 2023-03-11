import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// The stateful widget
class ColorMixer extends StatefulWidget {
  ColorMixer({Key? key}) : super(key: key);
  _ColorMixerState createState() => _ColorMixerState();
}

// The state object
class _ColorMixerState extends State<ColorMixer> {
  // These three variables are the 'state' of the widget
  int _red = 0;
  int _blue = 0;
  int _green = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          // This widget uses the variables (aka state)
          ColorCircle(
            color: Color.fromRGBO(_red, _green, _blue, 1),
            radius: 200,
          ),
          // These three pass the _setColor function down so that the
          // state *here* can be changed at lower levels. This is
          // called "lifting state up".
          ColorValueChanger(property: "Red", value: _red, onChanged: _setColor),
          ColorValueChanger(
              property: "Green", value: _green, onChanged: _setColor),
          ColorValueChanger(
              property: "Blue", value: _blue, onChanged: _setColor),
        ],
      ),
    );
  }

  void _setColor(String property, int value) {
    setState(() {
      _red = (property == "Red") ? value : _red;
      _green = (property == "Green") ? value : _green;
      _blue = (property == "Blue") ? value : _blue;
    });
  }
}

class ColorCircle extends StatefulWidget {
  const ColorCircle({Key? key, required this.color, required this.radius})
      : super(key: key);

  _ColorCircleState createState() => _ColorCircleState();
}

class _ColorCircleState extends State<ColorMixer> {
  double padValue = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Container as a Circle"),
          ),
          body: Container(
            margin: EdgeInsets.all(100.0),
            decoration: BoxDecoration(widget.color, shape: BoxShape.circle),
          )),
    );
  }
}

// The stateful widget
class ColorValueChanger extends StatefulWidget {
  ColorValueChanger(
      {Key? key,
      required this.property,
      required this.property,
      required this.property})
      : super(key: key);

  final String property;
  _ColorValueChangerState createState() => _ColorValueChangerState();
}

class _ColorValueChangerState extends State<ColorMixer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(property),
          Slider(
            min: 0,
            max: 255,
            value: _value.toDouble,
            label: property,
            onChanged: _onChanged,
          ),
        ],
      ),
    );
  }

  _onChanged(double value) {
    setState(() => _value = value.round());
    onChanged(property, value.round()); // Lifting state up
  }
}
