import 'dart:math';

import 'package:flutter/material.dart';

class DragPage extends StatefulWidget {
  const DragPage({super.key});

  @override
  State<DragPage> createState() => _DragPageState();
}

class _DragPageState extends State<DragPage> {
  List<Map<String, dynamic>> dataSource = [];

  List<int> indexList = [];

  @override
  void initState() {
    super.initState();

    dataSource = List.generate(
      16,
      (int index) => {'value': index * index, 'isFilled': false},
      growable: false,
    );

    _randomIndex();
  }

  void _randomIndex() {
    indexList.clear();
    final Random random = Random();

    for (int i = 0; i < 4; i++) {
      // 生成0到100之间的随机整数（包含0和100）
      int randomNumber = random.nextInt(16);
      indexList.add(randomNumber * randomNumber);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: dataSource.map(_buildDragTarget).toList(),
            ),
          ),

          SizedBox(height: 30),
          InkWell(
            onTap: _randomIndex,
            child: Text(
              '刷新',
              style: TextStyle(
                color: Color(0xff86909C),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 30),

          Row(children: indexList.map(_buildDragable).toList()),
        ],
      ),
    );
  }

  Widget _buildDragable(dynamic item) {
    return Draggable(
      data: item,
      feedback: Container(
        width: 100,
        height: 100,
        color: Colors.grey,
        alignment: Alignment.center,
        child: Text(
          item.toString(),
          style: TextStyle(
            color: Color(0xff86909C),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      child: Container(
        width: 100,
        height: 100,
        color: Colors.red,
        alignment: Alignment.center,
        child: Text(
          item.toString(),
          style: TextStyle(
            color: Color(0xff86909C),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildDragTarget(dynamic item) {
    return DragTarget(
      builder: (context, candidateData, rejectedData) {
        final isFilled = item?['isFilled'] ?? false;
        return Container(
          width: double.infinity,
          height: 100,
          color: isFilled ? Colors.blue : Colors.yellow,
          alignment: Alignment.center,
          child: Text(
            '${item?['value']}',
            style: TextStyle(
              color: Color(0xff86909C),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        );
      },
      onAcceptWithDetails: (details) {
        if (item?['value'] == details.data) {
          final index = dataSource.indexOf(item);
          item?['isFilled'] = true;
          item?['value'] = item?['value'] + item?['value'];
          dataSource[index] = item;
          setState(() {});
        }
      },
    );
  }
}
