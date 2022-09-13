import 'package:test_webspark/domain/models/cell.dart';
import 'package:test_webspark/domain/models/field.dart';

class Task {
  final List<Field> _fields = [];
  late final String _id;
  late final Cell _start;
  late final Cell _end;

  List<Field> get fields => _fields;

  Cell get end => _end;

  Cell get start => _start;

  String get id => _id;

  Task.fromJson(dynamic obj) {
    _id = obj['id'];
    for (String row in obj['field']) {
      _fields.add(Field(row));
    }
    _start = Cell(obj['start']);
    _end = Cell(obj['end']);
  }

  Task.test() {
    _fields.add(Field('X.'));
    _fields.add(Field('..'));
    _start = Cell({'x': 1, 'y': 0});
    _end = Cell({'x': 0, 'y': 1});
  }
}
