import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_webspark/controllers/home_screen_controller.dart';
import 'package:test_webspark/controllers/process_screen_controller.dart';
import 'package:test_webspark/screens/process_screen.dart';

class HomeScreen extends StatelessWidget {
  final HomeScreenController _homeScreenController = HomeScreenController();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home screen'),
        ),
        body: GetBuilder<HomeScreenController>(
            init: _homeScreenController,
            builder: (controller) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Set valid API base URL in order to continue',
                      style: TextStyle(fontSize: 15),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.swap_horiz,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: TextField(
                              controller: controller.textController,
                              onChanged: (url) {
                                controller.url.value = url.replaceAll(' ', '');
                              },
                              decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2.0, color: Colors.grey))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.checkUrl().then((value) {
                              value
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ProcessScreen(
                                                processController:
                                                    ProcessScreenController(
                                          url: controller.url.value,
                                        )),
                                      ),
                                    )
                                  : _showErrorDialog(context);
                            });
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
                            'Start counting process',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }));
  }

  Future<void> _showErrorDialog(context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('URI is not valid'),
          content: const Text('Please enter another Uri'),
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
