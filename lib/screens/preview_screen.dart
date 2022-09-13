import 'package:flutter/material.dart';
import 'package:test_webspark/domain/models/cell.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({Key? key, required this.matrix, required this.way})
      : super(key: key);

  final List<List<Cell>> matrix;
  final String way;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preview Screen"),
      ),
      body: Column(
        children: [
          Column(
            children: _getListRow(context, matrix),
          ),
          Text(
            way,
            style: const TextStyle(fontSize: 17),
          ),
        ],
      ),
    );
  }

  List<Row> _getListRow(BuildContext context, List<List<Cell>> matrix) {
    List<Row> res = [];
    for (int i = 0; i < matrix.length; i++) {
      res.add(_getRow(context, matrix[i]));
    }
    return res;
  }

  Row _getRow(BuildContext context, List<Cell> matrixRow) {
    double sizeCell = MediaQuery.of(context).size.width / matrix.length;
    List<Container> children = [];
    for (int i = 0; i < matrixRow.length; i++) {
      children.add(Container(
        width: sizeCell,
        height: sizeCell,
        decoration: BoxDecoration(
            color: matrixRow[i].color,
            border: Border.all(color: Colors.black, width: 1.0)),
        child: Center(
            child: Text(
          matrixRow[i].toString(),
          style: TextStyle(color: matrixRow[i].cordsColor),
        )),
      ));
    }
    return Row(
      children: children,
    );
  }
}
