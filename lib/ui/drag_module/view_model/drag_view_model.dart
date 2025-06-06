import 'package:demo/data/repositories/drag/drag_respository.dart';
import 'package:demo/domain/models/drag_model.dart';
import 'package:demo/utils/command.dart';
import 'package:demo/utils/result.dart';
import 'package:flutter/material.dart';

class DragViewModel extends ChangeNotifier {
  DragViewModel() {
    onAcceptWithDetails = CommandArgument(_onAcceptWithDetails);
    randomIndex = CommandAction(_randomIndex);
    callRefresh = CommandAction(_callRefresh);
    dataSource = [];
    activitySource = [];

    callRefresh.run();
    randomIndex.run();
  }

  final DragRepository repository = DragRepository();

  late CommandArgument<void, Map> onAcceptWithDetails;
  late CommandAction<void> randomIndex;
  late CommandAction<void> callRefresh;
  late List<DragModel> dataSource;
  late List<DragModel> activitySource;

  Future<Result<void>> _onAcceptWithDetails(Map details) async {
    final data = details['item'];
    final target = details['target'];
    if (data is! DragModel) {
      return Result.fail(Exception('data error'));
    }
    if (target is! DragModel) {
      return Result.fail(Exception('target error'));
    }
    if ((data == target) == false) {
      return Result.fail(Exception('data != target'));
    }
    final index = dataSource.indexWhere((item) => item.id == target.id);
    if (index > dataSource.length - 1) {
      return Result.fail(Exception('index error'));
    }
    dataSource[index].mount += 1;
    notifyListeners();
    return Result.succ(null);
  }

  Future<Result<void>> _randomIndex() async {
    activitySource.clear();
    final result = await repository.refreshDragDataSource();
    if (result is Succ) {
      activitySource = (result as Succ).value;
    }
    return Result.succ(null);
  }

  Future<Result<void>> _callRefresh() async {
    final result = await repository.getDragDataSource();
    if (result is Succ) {
      dataSource = (result as Succ).value;
    }
    notifyListeners();
    return Result.succ(null);
  }
}
