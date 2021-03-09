import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import 'package:yeslist_fill_gallon/yeslist_fill_gallon.dart';

part 'home_controller.g.dart';

class HomeController = _HomeController with _$HomeController;

abstract class _HomeController with Store {
  @observable
  ObservableList<Gallon> gallons = ObservableList<Gallon>();
  @observable
  ObservableList<Bottle> bottles = ObservableList<Bottle>();

  @observable
  bool updateGallon = false;

  @observable
  double capacity = 0.0;
  @observable
  double volume = 0.0;

  @observable
  bool isBottle = false;

  @observable
  int counter = 0;

  @observable
  AutovalidateMode validadeMode = AutovalidateMode.disabled;

  @action
  void initGallon() {
    gallons.clear();
    gallons.add(Gallon(15));
  }

  @action
  void saveForm() {
    if (isBottle) {
      bottles.add(Bottle(capacity));
      counter = bottles.length;
      if (gallons.isNotEmpty) gallons.last.fillSource = bottles;
    } else {
      gallons.clear();
      gallons.add(Gallon(capacity, fillSource: bottles)
        ..filled = volume
        ..isEmpty = (volume == 0)
        ..isFullFilled = (volume == capacity));
      print(gallons[0].toJson());
    }
    formReset();
  }

  @action
  void formReset() {
    capacity = 0.0;
    volume = 0.0;
  }
}
