import 'package:demo/routing/routes_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List<ListModel> dataSource =
      RoutesPages.pages.entries
          .toList()
          .map((page) => ListModel(title: page.key, router: page.key))
          .toList();

  Future<void> onRefresh() async {
    dataSource =
        RoutesPages.pages.entries
            .toList()
            .map((page) => ListModel(title: page.key, router: page.key))
            .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView.builder(
          itemCount: dataSource.length,
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              onTap:
                  () => Navigator.of(context).pushNamed(
                    dataSource[index].router,
                    arguments: dataSource[index].arguments,
                  ),
              child: ListTile(
                title: Text(
                  dataSource[index].title,
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
      ),
    );
  }

  /// 游戏页面
}

class ListModel {
  final String title;
  final String router;
  final dynamic arguments;

  ListModel({required this.title, required this.router, this.arguments});
}
