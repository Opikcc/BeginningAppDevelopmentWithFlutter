import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      // home: MyHomePage(title: "Hello"),
      home: ProperForm(title: "Hello"),
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
  String _searchTerm = '';
  TextEditingController _controller =
      TextEditingController(text: "Initial value here");
  TextEditingController _emailController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  void Function(bool)? onPressed;
  bool isInstructionView = false;
  void Function(String)? _searchType;
  String searchVal = '';
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  void _incrementCounter() {
    setState(() {
      _counter++;
      print("_searchTerm : $_searchTerm");
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
            Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text('Nama'),
                    TextField(
                      controller: _controller,
                      onChanged: (String val) => _searchTerm = val,
                    ),
                  ],
                )),
            const Text('Click'),
            const Text('Here'),
            const Icon(
              Icons.ads_click,
              color: Colors.red,
              size: 20,
            ),
            // Image.asset('assets/images/Gambar 1.jpg', fit: BoxFit.contain),
            // Image.network(
            //     'https://upload.wikimedia.org/wikipedia/en/9/9d/Logo_Al-Nassr.png',
            //     fit: BoxFit.contain),
            const Text('Search terms'),
            TextField(
              controller: _controller,
              onChanged: (String val) => _searchTerm = val,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'you@email.com',
                icon: Icon(Icons.contact_mail),
              ),
            ),
            TextField(
              controller: _numberController,
              decoration: InputDecoration(
                labelText: 'Salary',
                icon: Icon(Icons.money),
              ),
              inputFormatters: [
                FilteringTextInputFormatter(RegExp('[0-9 -]'), allow: true),
                LengthLimitingTextInputFormatter(16)
              ],
            ),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Switch(
                value: isInstructionView,
                onChanged: (onPressed) => setState(() {
                      isInstructionView = onPressed;
                    })),
            Radio<String>(
              groupValue: searchVal,
              value: "Search Anywhere",
              onChanged: (_searchType) => searchVal = _searchType as String,
            ),
            const Text('Search Anywhere'),
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

class FancyHelloWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("A fancier app"),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Text("Hello World!!!"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.thumb_up),
          onPressed: () => {},
        ),
      ),
    );
  }
}

enum SearchType { web, image, news, shopping }

// This is a stateful widget. Don't worry about how it or
// the setState() calls work until
// Chapter 9. For now, just focus on the Form itself.
class ProperForm extends StatefulWidget {
  const ProperForm({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ProperFormState createState() => _ProperFormState();
}

class _ProperFormState extends State<ProperForm> {
  // A Map (aka. hash) to hold the data from the Form.
  final Map<String, dynamic> _searchForm = <String, dynamic>{
    'searchTerm': '',
    'searchType': SearchType.web,
    'safeSearchOn': true,
  };

  // The Flutter key to point to the Form
  final GlobalKey<FormState> _key = GlobalKey();

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
            Form(
              key: _key,
              // Make autovalidate true to validate on every keystroke. In
              // this case we only want to validate on submit.
              // autovalidate: true,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    initialValue: _searchForm['searchTerm'],
                    decoration: InputDecoration(
                      labelText: 'Search terms',
                    ),
                    // On every keystroke, you can do something.
                    onChanged: (String val) {
                      setState(() => _searchForm['searchTerm'] = val);
                    },
                    // When the user submits, you could do something
                    // for this field
                    onSaved: (val) {
                      print("val : $val");
                    },
                    // Called when we "validate()". The val is the String
                    // in the text box.
                    // Note that it returns a String; null if validation passes
                    // and an error message if it fails for some reason.
                    validator: (val) {
                      String value = val ?? val.toString();
                      if (value.isEmpty) {
                        return 'We need something to search for';
                      }
                      return null;
                    },
                  ),

                  FormField<SearchType>(
                    builder: (FormFieldState<SearchType> state) {
                      return DropdownButton<SearchType>(
                        value: _searchForm['searchType'],
                        items: const <DropdownMenuItem<SearchType>>[
                          DropdownMenuItem<SearchType>(
                            child: Text('Web'),
                            value: SearchType.web,
                          ),
                          DropdownMenuItem<SearchType>(
                            child: Text('Image'),
                            value: SearchType.image,
                          ),
                          DropdownMenuItem<SearchType>(
                            child: Text('News'),
                            value: SearchType.news,
                          ),
                          DropdownMenuItem<SearchType>(
                            child: Text('Shopping'),
                            value: SearchType.shopping,
                          ),
                        ],
                        onChanged: (val) {
                          setState(() => _searchForm['searchTyoe'] = val);
                        },
                      );
                    },
                    onSaved: (initialValue) {},
                  ),
                  // Wrapping the Checkbox in a FormField so we can have an
                  // onSaved and a validator
                  FormField<bool>(
                    // initialValue: false, // Ignored for Checkboxes
                    builder: (FormFieldState<bool> state) {
                      return Row(
                        children: <Widget>[
                          Checkbox(
                            value: _searchForm['safeSearchOn'],
                            // Every time it changes, you can do something.
                            onChanged: (val) {
                              setState(() => _searchForm['safeSearchOn'] = val);
                            },
                          ),
                          const Text('Safe Search on'),
                        ],
                      );
                    },
                    // When the user saves, this is run
                    onSaved: (initialValue) {},
                    // No need for validation because it is a checkbox. But
                    // if you wanted it, put a validator function here.
                  ),

                  // This is the 'Submit' button
                  RaisedButton(
                    child: const Text('Submit'),
                    onPressed: () {
                      // If every field passed validation, let them through.
                      // Remember, this calls the validator on all fields in
                      // the form.
                      final form = _key.currentState;
                      if (form != null && form.validate()) {
                        // Similarly this calls onSaved() for all fields
                        form.save();
                        // You'd save the data to a database or whatever here
                        print('Successfully saved the state.');
                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
