import 'dart:convert';

import 'package:test_webspark/api/api.dart';
import 'package:test_webspark/domain/core/solution.dart';
import 'package:test_webspark/domain/models/task.dart';

class Data {
  late final Api api;

  Data({required this.api});

  Future<List<Task>> getTasks() async {
    List<dynamic> data = jsonDecode(await api.get())['data'];
    List<Task> tasks = data.map((item) => Task.fromJson(item)).toList();
    return tasks;
  }

  Future<void> postSolutions(List<Solution> solutions) async {
    List<Map<String, dynamic>> body = [];
    for (Solution solution in solutions) {
      body.add(solution.toJson());
    }
    Map<String, dynamic> data = jsonDecode(await api.post(json.encode(body)));
    if (data["error"] == true) {
      throw Exception(data["data"]["message"]);
    }
  }
}
