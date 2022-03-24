import 'package:flutter/material.dart';

class InitPage extends StatelessWidget {
  InitPage({Key? key}) : super(key: key);

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        TextField(
          controller: controller,
        ),
        ElevatedButton(
            onPressed: () {
              if (controller.text == "qwe123") {
                print("ImportData");
              }
            },
            child: const Text("IMPORT"))
      ]),
    );
  }
}
