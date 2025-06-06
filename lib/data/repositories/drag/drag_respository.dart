import 'dart:math';

import 'package:demo/domain/models/drag_model.dart';
import 'package:demo/utils/result.dart';

class DragRepository {
  /// 获取页面数据
  Future<Result<List<DragModel>>> getDragDataSource() async {
    final random = Random();
    return Result.succ(
      List.generate(
        16,
        (index) =>
            DragModel(id: '$index', title: '标题${index + random.nextInt(16)}'),
      ),
    );
  }

  /// 刷新待匹配项
  Future<Result<List<DragModel>>> refreshDragDataSource() async {
    final random = Random();
    return Result.succ(
      List.generate(
        4,
        (index) =>
            DragModel(id: '$index', title: '标题${index + random.nextInt(16)}'),
      ),
    );
  }
}
