import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_webspark/controllers/process_screen_controller.dart';
import 'package:test_webspark/screens/result_list_screen.dart';

class ProcessScreen extends StatelessWidget {
  final ProcessScreenController processController;

  const ProcessScreen({Key? key, required this.processController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Process screen'),
      ),
      body: GetBuilder<ProcessScreenController>(
          init: processController,
          builder: (controller) {
            return Center(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Obx(() {
                  return Column(children: [
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Visibility(
                            visible: controller.processScreenState.value !=
                                ProcessScreenState.loading,
                            child: const Text(
                              'All calculations has finished, you can send your results to server',
                              style: TextStyle(fontSize: 17),
                              textAlign: TextAlign.center,
                            )),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(controller.percentString,
                                style: const TextStyle(fontSize: 20))),
                        SizedBox(
                          width: 90,
                          height: 90,
                          child: CircularProgressIndicator(
                            value: controller.percentDouble,
                            backgroundColor: Colors.cyanAccent,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Visibility(
                      visible: controller.processScreenState.value !=
                          ProcessScreenState.loading,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: controller.processScreenState.value ==
                                    ProcessScreenState.posting
                                ? null
                                : () {
                                    controller
                                        .checkSolution()
                                        .then((value) => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        ResultListScreen(
                                                  solutions:
                                                      controller.solutions,
                                                ),
                                              ),
                                            ))
                                        .onError((error, stackTrace) =>
                                            _showErrorDialog(context, error));
                                  },
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                width: 1.0,
                                color: Color.fromRGBO(72, 146, 223, 1),
                              ),
                              primary: const Color.fromRGBO(63, 196, 255, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Send results to server',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]);
                }),
              ),
            );
          }),
    );
  }

  _showErrorDialog(context, error) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(error.toString()),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
