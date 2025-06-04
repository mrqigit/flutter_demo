import 'package:flutter/material.dart';

class ShiftPage extends StatelessWidget {
  const ShiftPage({super.key});

  List get dataSource => [
    {'title': 'Shift Left', 'action': shiftLeftAction},
    {'title': 'Shift Right', 'action': shiftRightAction},
    {'title': 'Unsigned Shift Right', 'action': unsignedShiftRightAction},
    {'title': 'AND', 'action': andAction},
    {'title': 'OR', 'action': orAction},
    {'title': 'XOR', 'action': xorAction},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: dataSource.length,
        itemBuilder: (context, index) {
          final item = dataSource[index];
          return InkWell(
            onTap: item['action'] as void Function(),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 0.5),
              height: 44,
              color: Colors.white,
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                item['title'] as String,
                style: TextStyle(
                  color: Color(0xff86909C),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void shiftLeftAction() {
    print(-1023 >> 0);
    print(1023 >> 1);
    print(1023 >> 2);
    print(1023 >> 3);
    print(1023 >> 4);
    print(1023 >> 5);
    print(1023 >> 6);
    print(1023 >> 7);
    print(-1023 >> 8);
    print(-1023 >> 9);
  }

  void shiftRightAction() {
    print(1 << 0);
    print(1 << 1);
    print(1 << 2);
    print(1 << 3);
    print(1 << 4);
    print(1 << 5);
    print(1 << 6);
    print(1 << 7);
    print(1 << 8);
    print(1 << 9);
  }

  void unsignedShiftRightAction() {
    print(-1023 >>> 0);
    print(1023 >>> 1);
    print(1023 >>> 2);
    print(1023 >>> 3);
    print(1023 >>> 4);
    print(1023 >>> 5);
    print(1023 >>> 6);
    print(1023 >>> 7);
    print(-1023 >>> 8);
    print(-1023 >>> 9);
  }

  void andAction() {
    print(1 & 1);
    print(1 & 0);
    print(0 & 1);
    print(0 & 0);
  }

  void orAction() {
    print(1 | 1);
    print(1 | 0);
    print(0 | 1);
    print(0 | 0);
  }

  void xorAction() {
    print(10 ^ 1);
    print(10 ^ 2);
    print(10 ^ 3);
    print(10 ^ 4);
  }
}
