import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:polyrhythm_web/main.dart';

class BufferScreen extends StatelessWidget {
  const BufferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainCanvas()));
            },
            child: const Text(
              "Press to go to correct screen",
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}
