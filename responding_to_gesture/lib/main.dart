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
      home: ManagePeople(),
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
            IconButton(
                onPressed: () => print('You click IconButton'),
                icon: Icon(Icons.thumb_down)),
            RaisedButton(
                child: Text("Go"),
                onPressed: () => print('You swiped the raised button'),
                elevation: 5.0),
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

class ManagePeople extends StatelessWidget {
  List<Person> fetchPeople() {
    List<Person> listPerson = <Person>[];

    listPerson.add(Person(firstName: "Jim", lastName: "Halpert"));
    listPerson.add(Person(firstName: "Kelly", lastName: "Kapoor"));
    listPerson.add(Person(firstName: "Creed", lastName: "Bratton"));
    listPerson.add(Person(firstName: "Dwight", lastName: "Schrute"));
    listPerson.add(Person(firstName: "Andy", lastName: "Bernard"));
    listPerson.add(Person(firstName: "Pam", lastName: "Beasley"));
    listPerson.add(Person(firstName: "Robert", lastName: "California"));
    listPerson.add(Person(firstName: "David", lastName: "Wallace"));
    listPerson.add(Person(firstName: "Ryan", lastName: "Howard"));

    return listPerson;
  }

  @override
  Widget build(BuildContext context) {
    var _peopleObjects = fetchPeople();
    return ListView(
      children: _peopleObjects
          .map((person) => GestureDetector(
                child: person,
                onLongPress: () {
                  print("Deleted ${person.firstName}");
                },
              ))
          .toList(),
    );
  }
}

class Person extends StatelessWidget {
  final String firstName;
  final String lastName;

  Person({required this.firstName, required this.lastName}) {}

  Widget build(BuildContext context) {
    return Container(child: Text('$firstName $lastName'));
  }
}
