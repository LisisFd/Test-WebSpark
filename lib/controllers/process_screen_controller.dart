import 'package:get/get.dart';
import 'package:test_webspark/api/api.dart';
import 'package:test_webspark/domain/core/solution.dart';

import 'package:test_webspark/domain/models/task.dart';
import 'package:test_webspark/domain/repository/data.dart';

/// Ui drawing states
///
/// [loading] - used during [Data] retrieval
/// [posting] - used when sending [Data]
/// [done] - used after [loading] or [posting]
enum ProcessScreenState { loading, posting, done }

/// Used for storage
class ProcessScreenController extends GetxController {
  /// Repository for [Api]
  late final Data _data;

  /// Calculation progress bar
  final RxDouble _percent = RxDouble(0.0);

  /// [_tasks] [Solution] storage
  final List<Solution> _solutions = [];

  /// Screen state storage for rendering ui
  Rx<ProcessScreenState> processScreenState = Rx(ProcessScreenState.loading);

  /// [Task] storage from [_data]
  late final List<Task> _tasks;

  /// [_percent] string indicator
  String get percentString => '${_percent.value.toString()}%';

  /// [_percent] double indicator
  double get percentDouble => _percent.value / 100;

  List<Solution> get solutions => _solutions;

  ProcessScreenController({required String url}) {
    _data = Data(api: Api(url));
    _percent.value += 10.0;
    _getTask().then((value) {
      _solutionTask();
      processScreenState.value = ProcessScreenState.done;
    });
  }

  ///Send post request with [_solutions] data
  Future<void> checkSolution() async {
    processScreenState.value = ProcessScreenState.posting;
    await _data
        .postSolutions(_solutions)
        .whenComplete(() => processScreenState.value = ProcessScreenState.done);
  }

  /// Solution delivered [_tasks]
  void _solutionTask() {
    _percent.value += 20.0;
    for (Task task in _tasks) {
      _solutions.add(Solution(task));
      _percent.value += 70.0 / _tasks.length;
    }
  }

  /// Request for [_tasks]
  Future<void> _getTask() async {
    _tasks = await _data.getTasks();
  }
}
