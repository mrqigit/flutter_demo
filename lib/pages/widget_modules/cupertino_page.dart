import 'package:flutter/material.dart';

class CupertinoPage extends StatefulWidget {
  const CupertinoPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CupertinoPageState();
  }
}

class _CupertinoPageState extends State<CupertinoPage> {
  List dataSource = [];

  dynamic currMode;

  @override
  void initState() {
    super.initState();

    dataSource = [
      {'code': null, 'mark': '全部'},
      {'code': '1', 'mark': '男'},
      {'code': '2', 'mark': '女'},
      {'code': '3', 'mark': '未知'},
    ];

    currMode = dataSource[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cupertino')),
      body: Column(
        children:
            dataSource
                .map(
                  (item) => StateItem(
                    value: item,
                    groupValue: currMode,
                    onChanged: (value) {
                      setState(() {
                        currMode = value!;
                      });
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            content: Text(
                              '12123',
                              style: TextStyle(
                                color: Color(0xff86909C),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        );
                    },
                    builder: (value) {
                      final item = value! as Map<String, dynamic>;
                      return Row(
                        children: [
                          Text(item['mark'] ?? ''),
                          const SizedBox(width: 10),
                          if (currMode == value) const Icon(Icons.check),
                        ],
                      );
                    },
                  ),
                )
                .toList(),
      ),
    );
  }
}

class StateItem<T> extends StatelessWidget {
  const StateItem({
    super.key,
    required this.builder,
    this.value,
    this.groupValue,
    this.onChanged,
  });

  final T? value;
  final T? groupValue;
  final Widget Function(T? value) builder;
  final void Function(T? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onChanged == null) {
          return;
        }
        if (value == groupValue) {
          return;
        }
        onChanged?.call(value);
      },
      child: builder(value),
    );
  }
}
