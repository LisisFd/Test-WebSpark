import 'dart:math';

import 'package:test_webspark/domain/core/node.dart';
import 'package:test_webspark/domain/models/task.dart';
import 'package:test_webspark/domain/models/way.dart';

class Algorithm {
  /// All nodes in matrix
  final List<Node> _nodes = [];

  /// All possible ways to [_endNode]
  final List<List<String>> _ways = [];

  /// Iteration start node
  late final Node _startNode;

  /// Iteration end node
  late final Node _endNode;

  /// Doesn`t used [Cell]
  final List<Map<String, int>> blockedCell = [];

  /// Shortest way between [_startNode] and [_endNode]
  final Way _finalWay = Way();

  Way get finalWay => _finalWay;

  Algorithm(Task task) {
    _createAllNodes(task);
    _finalWay.add({
      'x': int.parse(_startNode.point.split('.')[0]),
      'y': int.parse(_startNode.point.split('.')[1])
    });

    _findWay(_startNode, _nodes);

    _ways.sort((a, b) => a.length.compareTo(b.length));
    for (var stepSting in _ways.first) {
      Map<String, int> step = {
        'x': int.parse(stepSting.split('.')[0]),
        'y': int.parse(stepSting.split('.')[1])
      };
      _finalWay.add(step);
    }
  }

  ///Defines [_startNode], [_endNode] and [_nodes]
  void _createAllNodes(Task task) {
    for (int i = 0; i < task.fields.length; i++) {
      for (int y = 0; y < task.fields[i].row.length; y += 1) {
        if (task.fields[i].row[y]) {
          if ('$y.$i' == task.start.toString()) {
            _startNode = Node('$y.$i');
            continue;
          }
          '$y.$i' == task.end.toString() ? _endNode = Node('$y.$i') : null;
          _nodes.add(Node('$y.$i'));
        } else {
          blockedCell.add({"x": y, "y": i});
        }
      }
    }
  }

  ///Recursive function finds all possible [_ways] from [_startNode] to [_endNode]
  bool _findWay(Node startNode, List<Node> nodes, [List<String>? way]) {
    way ??= [];

    if (startNode.point == _endNode.point) {
      _ways.add(way.toList());
      return true;
    }

    List<Node> neighbor = _getNeighbor(startNode, nodes);

    if (neighbor.isEmpty) {
      return false;
    }

    for (Node node in neighbor) {
      List<Node> tempNodes = nodes.toList();
      tempNodes.remove(node);
      way.add(node.point);
      _findWay(node, tempNodes, way);
      way.remove(node.point);
    }

    return true;
  }

  /// Determines if [Node] are neighbors
  bool _isNeighbor(int firstX, int firstY, int secondX, int secondY) {
    double res = (sqrt(pow(secondX - firstX, 2) + pow(secondY - firstY, 2)));
    if (res < 2) {
      return true;
    }
    return false;
  }

  /// Specifies all possible [_isNeighbor] for one [Node]
  List<Node> _getNeighbor(Node startNode, List<Node> allNodes) {
    List<Node> neighbor = [];
    int startX = int.parse(startNode.point.split('.')[0]);
    int startY = int.parse(startNode.point.split('.')[1]);
    for (Node node in allNodes) {
      int nodeX = int.parse(node.point.split('.')[0]);
      int nodeY = int.parse(node.point.split('.')[1]);
      if (_isNeighbor(startX, startY, nodeX, nodeY)) {
        neighbor.add(node);
      }
    }
    return neighbor;
  }
}
