import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoPage extends StatefulWidget {
  const CupertinoPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CupertinoPageState();
  }
}

class _CupertinoPageState extends State<CupertinoPage> {
  CupertinoStyle value = CupertinoStyle.light;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cupertino')),
      body: Column(
        children: [
          CupertinoRadio(
            value: value,
            groupValue: CupertinoStyle.dark,
            onChanged: (value) {
              setState(() {
                this.value = value!;
              });
            },
          ),
          CupertinoRadio(
            value: value,
            groupValue: CupertinoStyle.light,
            onChanged: (value) {
              setState(() {
                this.value = value!;
              });
            },
          ),
        ],
      ),
    );
  }
}

enum CupertinoStyle { light, dark }
