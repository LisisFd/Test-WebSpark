import 'package:flutter/foundation.dart';
import 'package:test_webspark/domain/core/algorithm.dart';
import 'package:test_webspark/domain/models/cell.dart';
import 'package:test_webspark/domain/models/task.dart';
import 'package:test_webspark/domain/models/way.dart';

class Solution {
  late final Algorithm _algorithm;

  /// Solution before algorithm
  late final Way _finalWay;

  late final int _sizeMatrix;

  final List<List<Cell>> _cells = [];

  ///Id a [task]
  late final String taskId;

  List<List<Cell>> get cells => _cells;

  Way get finalWay => _finalWay;

  /// Creating an instance of the [Solution] class
  ///
  /// that solves the [task] and stores the solution as [finalWay]
  Solution(Task task) {
    taskId = task.id;
    _sizeMatrix = task.fields.length;
    _algorithm = Algorithm(task);
    _finalWay = _algorithm.finalWay;
    _createCells();
  }

  Map<String, dynamic> toJson() => {
        "id": taskId,
        "result": {"steps": _finalWay.toList, "path": _finalWay.toString()}
      };

  void _createCells() {
    for (int i = 0; i < _sizeMatrix; i++) {
      List<Cell> tempList = [];
      for (int y = 0; y < _sizeMatrix; y++) {
        Map<String, int> modelMap = {"x": y, "y": i};
        String model = '($y,$i)';
        if (mapEquals(modelMap, _finalWay.toList.first)) {
          tempList.add(StartCell({"x": y, "y": i}));
        } else if (mapEquals(modelMap, _finalWay.toList.last)) {
          tempList.add(EndCell({"x": y, "y": i}));
        } else if (_finalWay.toString().contains(model)) {
          tempList.add(WayCell(modelMap));
        } else if (_algorithm.blockedCell
            .firstWhere((element) => mapEquals(modelMap, element),
                orElse: () => {})
            .isNotEmpty) {
          tempList.add(BlockedCell(modelMap));
        } else {
          tempList.add(Cell(modelMap));
        }
      }
      _cells.add(tempList);
    }
  }
}
