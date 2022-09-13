class Way {
  final List<Map<String, int>> _way = [];

  @override
  String toString() {
    String finalString = '';

    for (var step in _way) {
      finalString += '(${step['x']},${step['y']})';
      finalString += _way.last == step ? '' : "->";
    }
    return finalString;
  }

  List<Map<String, int>> get toList => _way;

  void add(Map<String, int> obj) => _way.add(obj);
}
