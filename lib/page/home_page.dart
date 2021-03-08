import 'package:fill_gallon_flutter/widget/gallon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:yeslist_fill_gallon/yeslist_fill_gallon.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  List<Bottle> _bottles = <Bottle>[];
  Gallon gallon = Gallon(1);
  String valueText = '';

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

  _createDialog(BuildContext context) async {
    TextEditingController controller = TextEditingController();

    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Bottle filled volume: '),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: controller,
              keyboardType: TextInputType.number,
            ),
            actions: <Widget>[
              MaterialButton(
                color: Colors.green,
                elevation: 5.0,
                child: Text('add'),
                onPressed: () {
                  setState(() {
                    if (double.tryParse(valueText) != null) {
                      _bottles.add(Bottle(double.parse(valueText)));
                      Navigator.of(context).pop(controller.text.toString());
                      _counter = _bottles.length;
                      valueText = '';
                    }
                  });
                },
              ),
              MaterialButton(
                color: Colors.red,
                elevation: 5.0,
                child: Text('cancel'),
                onPressed: () {
                  Navigator.of(context).pop(controller.text.toString());
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          mainAxisAlignment: MainAxisAlignment.start,
          // horizontal).
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List<Widget>.generate(_bottles.length, (index) {
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: <Widget>[
                          Stack(
                            children: [
                              Container(
                                child: SvgPicture.asset(
                                  'assets/bottle.svg',
                                  height: MediaQuery.of(context).size.height *
                                      15 /
                                      100,
                                  placeholderBuilder: (BuildContext context) =>
                                      Container(
                                          child: Text(_bottles[index].label)),
                                ),
                              ),
                              Positioned(
                                bottom: 0.0,
                                child: Container(
                                    height:
                                        ((((MediaQuery.of(context).size.height *
                                                        15 /
                                                        100) -
                                                    30) *
                                                _bottles[index].volume) /
                                            _bottles[index].capacity),
                                    width: 100,
                                    color: Colors.blue,
                                    child: Container()),
                              ),
                            ],
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  _bottles[index].label,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(0xFF000000), fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: GallonWidget(
                gallon: gallon,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Total of bottles:',
              style: TextStyle(
                  color: Color(0xFF0556b2),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '$_counter',
              //style: Theme.of(context).textTheme.headline4,
              style: TextStyle(color: Color(0xFF077ccc), fontSize: 36),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.orange,
            onPressed: () => _createDialog(context),
            tooltip: 'Increment',
            child: Icon(Icons.play_arrow),
          ),
          SizedBox(
            width: 15,
          ),
          FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () {
              setState(() {
                _bottles = <Bottle>[];
                _counter = 0;
              });
            },
            tooltip: 'Increment',
            child: Icon(Icons.delete),
          ),
          SizedBox(
            width: 15,
          ),
          FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () => _createDialog(context),
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
