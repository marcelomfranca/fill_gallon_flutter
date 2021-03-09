import 'package:fill_gallon_flutter/page/home_controller.dart';
import 'package:fill_gallon_flutter/widget/recipient_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:yeslist_fill_gallon/yeslist_fill_gallon.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController _homeController = HomeController();
  final _formKey = GlobalKey<FormState>();

  _createDialog(BuildContext context, String recipient) async {
    TextEditingController controllerCapacityInput = TextEditingController();
    TextEditingController controllerFilledVolumeInput = TextEditingController()
      ..text = '0';
    var title = '';
    var autofill = false;

    if (recipient.toLowerCase() == 'bottle') {
      title = 'Create a bottle: ';
      autofill = true;
      _homeController.isBottle = true;
    } else if (recipient.toLowerCase() == 'gallon') {
      title = 'Create a gallon: ';
      autofill = false;
      _homeController.isBottle = false;
    }

    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Form(
              key: _formKey,
              autovalidateMode: _homeController.validadeMode,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Capacity:'),
                    controller: controllerCapacityInput,
                    keyboardType: TextInputType.number,
                    validator: _validadeCapacity,
                    onSaved: (value) {
                      _homeController.capacity = double.parse(value);
                    },
                  ),
                  Visibility(
                    visible: !autofill,
                    child: TextFormField(
                      enabled: !autofill,
                      decoration:
                          const InputDecoration(labelText: 'Filled volume:'),
                      controller: controllerFilledVolumeInput,
                      keyboardType: TextInputType.number,
                      validator: _validadeVolume,
                      onSaved: (value) {
                        _homeController.volume = double.parse(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                color: Colors.green,
                elevation: 5.0,
                child: Text('add'),
                onPressed: _sendForm,
              ),
              MaterialButton(
                color: Colors.red,
                elevation: 5.0,
                child: Text('cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  String _validadeCapacity(String value) {
    var v = double.tryParse(value);

    if (v == null) {
      return '>>> insert a number <<<';
    } else if (v == 1 - 1) {
      return '>>> empty is not a valid capacity <<<';
    } else if (v < 1 - 1) {
      return '>>> insert a positive number <<<';
    }
    return null;
  }

  String _validadeVolume(String value) {
    if (value.isEmpty) return '';

    var v = double.tryParse(value);

    if (v == null) {
      return '>>> insert a positive number <<<';
    }
    return null;
  }

  _sendForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _homeController.saveForm();
      Navigator.of(context).pop();
    } else {
      _homeController.validadeMode = AutovalidateMode.always;
    }
  }

  _run(Gallon gallon) {
    if (gallon != null) {
      if (gallon.isFullFilled) return;

      //if (gallon.fillOptions.isNotEmpty) {
      gallon
        ..startFillAnalysis()
        ..whereIsOptimal();

      if (gallon.optimalFillOptions.isEmpty) {
        return;
      }

      gallon.fill(gallon.optimalFillOptions[0]);

      _homeController.gallons.clear();
      _homeController.gallons.add(gallon);
      _homeController.bottles = gallon.fillSource;
    }
    //}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: (MediaQuery.of(context).size.height * 15) / 100,
                decoration: BoxDecoration(
                    //border: Border.all(),
                    ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    child: Observer(builder: (_) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List<Widget>.generate(
                            _homeController.bottles.length, (index) {
                          return RecipientWidget(
                              objectType: RecipientType.bottle,
                              object: _homeController.bottles[index]);
                        }),
                      );
                    }),
                  ),
                ),
              ),
              Observer(builder: (_) {
                return GestureDetector(
                  onTap: () {
                    _createDialog(context, RecipientType.gallon);
                  },
                  child: RecipientWidget(
                    height:
                        (((MediaQuery.of(context).size.width * 33) / 100) * 2) -
                            66,
                    width: MediaQuery.of(context).size.width * 33 / 100,
                    padding: EdgeInsets.all(20),
                    objectType: RecipientType.gallon,
                    object: (_homeController.gallons.isEmpty)
                        ? Gallon(0)
                        : _homeController.gallons.last,
                  ),
                );
              }),
              Text(
                'Total of bottles:',
                style: TextStyle(
                    color: Color(0xFF0556b2),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Observer(builder: (_) {
                return Text(
                  '${_homeController.counter}',
                  //style: Theme.of(context).textTheme.headline4,
                  style: TextStyle(color: Color(0xFF077ccc), fontSize: 36),
                );
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.orange,
            onPressed: () => _run((_homeController.gallons.isEmpty)
                ? null
                : _homeController.gallons.last),
            tooltip: 'Increment',
            child: Icon(Icons.play_arrow),
          ),
          SizedBox(
            width: 15,
          ),
          FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () {
              _homeController.gallons.clear();
              _homeController.bottles.clear();
              _homeController.counter = 0;
            },
            tooltip: 'Increment',
            child: Icon(Icons.delete),
          ),
          SizedBox(
            width: 15,
          ),
          FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () => _createDialog(context, 'bottle'),
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
