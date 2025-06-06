import 'package:demo/domain/models/drag_model.dart';
import 'package:flutter/material.dart';

import '../view_model/drag_view_model.dart';

class DragPage extends StatelessWidget {
  DragPage({super.key});
  DragViewModel viewModel = DragViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) {
          return RefreshIndicator(
            onRefresh: viewModel.callRefresh.run,
            child: Column(
              children: [
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 4,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 20,
                    ),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children:
                        viewModel.dataSource.map(_buildDragTarget).toList(),
                  ),
                ),
                SizedBox(height: 30),
                InkWell(
                  onTap: viewModel.randomIndex.run,
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

                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                        viewModel.activitySource.map(_buildDragable).toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDragable(DragModel item) {
    return Draggable(
      data: item,
      feedback: Container(
        width: 100,
        height: 100,
        color: Colors.grey,
        alignment: Alignment.center,
        child: Text(
          item.title,
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
        color: Colors.blue,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              item.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '标号${item.id}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDragTarget(DragModel item) {
    return DragTarget(
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: double.infinity,
          height: 100,
          color: Colors.yellow,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.title,
                style: TextStyle(
                  color: Color(0xff86909C),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '挂载${item.mount}个',
                style: TextStyle(
                  color: Color(0xff86909C),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '标号${item.id}',
                style: TextStyle(
                  color: Color(0xff86909C),
                  fontSize: 8,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        );
      },
      onAcceptWithDetails: (detail)=> viewModel.onAcceptWithDetails.run({'item': detail.data, 'target': item}),
    );
  }
}
