import 'package:flutter/material.dart';
import 'package:test_webspark/domain/core/solution.dart';
import 'package:test_webspark/screens/preview_screen.dart';

class ResultListScreen extends StatelessWidget {
  const ResultListScreen({Key? key, required this.solutions}) : super(key: key);

  final List<Solution> solutions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result list screen"),
      ),
      body: ListView.builder(
        itemCount: solutions.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => PreviewScreen(
                    way: solutions[index].finalWay.toString(),
                    matrix: solutions[index].cells,
                  ),
                ),
              );
            },
            shape: const Border(
              bottom: BorderSide(width: 0.1),
            ),
            title: Text(
              solutions[index].finalWay.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}
