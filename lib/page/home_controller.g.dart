// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeController, Store {
  final _$gallonsAtom = Atom(name: '_HomeController.gallons');

  @override
  ObservableList<Gallon> get gallons {
    _$gallonsAtom.reportRead();
    return super.gallons;
  }

  @override
  set gallons(ObservableList<Gallon> value) {
    _$gallonsAtom.reportWrite(value, super.gallons, () {
      super.gallons = value;
    });
  }

  final _$bottlesAtom = Atom(name: '_HomeController.bottles');

  @override
  ObservableList<Bottle> get bottles {
    _$bottlesAtom.reportRead();
    return super.bottles;
  }

  @override
  set bottles(ObservableList<Bottle> value) {
    _$bottlesAtom.reportWrite(value, super.bottles, () {
      super.bottles = value;
    });
  }

  final _$updateGallonAtom = Atom(name: '_HomeController.updateGallon');

  @override
  bool get updateGallon {
    _$updateGallonAtom.reportRead();
    return super.updateGallon;
  }

  @override
  set updateGallon(bool value) {
    _$updateGallonAtom.reportWrite(value, super.updateGallon, () {
      super.updateGallon = value;
    });
  }

  final _$capacityAtom = Atom(name: '_HomeController.capacity');

  @override
  double get capacity {
    _$capacityAtom.reportRead();
    return super.capacity;
  }

  @override
  set capacity(double value) {
    _$capacityAtom.reportWrite(value, super.capacity, () {
      super.capacity = value;
    });
  }

  final _$volumeAtom = Atom(name: '_HomeController.volume');

  @override
  double get volume {
    _$volumeAtom.reportRead();
    return super.volume;
  }

  @override
  set volume(double value) {
    _$volumeAtom.reportWrite(value, super.volume, () {
      super.volume = value;
    });
  }

  final _$isBottleAtom = Atom(name: '_HomeController.isBottle');

  @override
  bool get isBottle {
    _$isBottleAtom.reportRead();
    return super.isBottle;
  }

  @override
  set isBottle(bool value) {
    _$isBottleAtom.reportWrite(value, super.isBottle, () {
      super.isBottle = value;
    });
  }

  final _$counterAtom = Atom(name: '_HomeController.counter');

  @override
  int get counter {
    _$counterAtom.reportRead();
    return super.counter;
  }

  @override
  set counter(int value) {
    _$counterAtom.reportWrite(value, super.counter, () {
      super.counter = value;
    });
  }

  final _$validadeModeAtom = Atom(name: '_HomeController.validadeMode');

  @override
  AutovalidateMode get validadeMode {
    _$validadeModeAtom.reportRead();
    return super.validadeMode;
  }

  @override
  set validadeMode(AutovalidateMode value) {
    _$validadeModeAtom.reportWrite(value, super.validadeMode, () {
      super.validadeMode = value;
    });
  }

  final _$_HomeControllerActionController =
      ActionController(name: '_HomeController');

  @override
  void initGallon() {
    final _$actionInfo = _$_HomeControllerActionController.startAction(
        name: '_HomeController.initGallon');
    try {
      return super.initGallon();
    } finally {
      _$_HomeControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void saveForm() {
    final _$actionInfo = _$_HomeControllerActionController.startAction(
        name: '_HomeController.saveForm');
    try {
      return super.saveForm();
    } finally {
      _$_HomeControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
gallons: ${gallons},
bottles: ${bottles},
updateGallon: ${updateGallon},
capacity: ${capacity},
volume: ${volume},
isBottle: ${isBottle},
counter: ${counter},
validadeMode: ${validadeMode}
    ''';
  }
}
