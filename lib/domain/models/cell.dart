import 'package:flutter/material.dart';

abstract class AbstractCell {
  int get x;

  int get y;

  Color get color;

  Color get cordsColor;
}

class Cell extends AbstractCell {
  int _x = 0;
  int _y = 0;
  final Color _color = Colors.white;
  final Color _cordsColor = Colors.black;

  Cell(dynamic obj) {
    _x = obj['x'];
    _y = obj['y'];
  }

  @override
  int get x => _x;

  @override
  int get y => _y;

  @override
  String toString() {
    return '$_x.$_y';
  }

  @override
  Color get color => _color;

  @override
  Color get cordsColor => _cordsColor;
}

class BlockedCell extends Cell {
  final Color _blockedColor = Colors.black;

  final Color _cordsBlockedColor = Colors.white;

  BlockedCell(super.obj);

  @override
  Color get color => _blockedColor;

  @override
  Color get cordsColor => _cordsBlockedColor;
}

class StartCell extends Cell {
  final Color _startColor = const Color.fromRGBO(100, 255, 218, 1);

  StartCell(super.obj);

  @override
  Color get color => _startColor;
}

class EndCell extends Cell {
  final Color _endColor = const Color.fromRGBO(0, 150, 136, 1);

  EndCell(super.obj);

  @override
  Color get color => _endColor;
}

class WayCell extends Cell {
  final Color _wayColor = const Color.fromRGBO(76, 175, 80, 1);

  WayCell(super.obj);

  @override
  Color get color => _wayColor;
}
