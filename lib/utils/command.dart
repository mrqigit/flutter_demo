import 'package:demo/utils/result.dart';
import 'package:flutter/material.dart';

typedef CommandCallback<T> = Future<Result<T>> Function();
typedef CommandBuilder<T, Argument> = Future<Result<T>> Function(Argument);

abstract class Command<T> extends ChangeNotifier {
  Command();

  /// 进行操作拦截
  bool _running = false;
  bool get running => _running;

  /// 处理结果
  Result<T>? _result;
  Result? get result => _result;
  bool get fail => _result is Fail;
  bool get success => _result is Succ;

  /// 清除最后一次执行结果
  void clearResult() {
    _result = null;
    notifyListeners();
  }

  Future<void> _run(CommandCallback<T> action) async {
    if (_running) return;
    _running = true;
    _result = null;

    notifyListeners();

    try {
      _result = await action();
    } catch (e) {
      _result = Result.fail(Exception(e));
    } finally {
      _running = false;
      notifyListeners();
    }
  }
}

class CommandAction<T> extends Command<T> {
  CommandAction(this._action);

  final CommandCallback<T> _action;

  Future<void> run() async {
    await _run(_action);
  }
}

class CommandArgument<T, Argument> extends Command<T> {
  CommandArgument(this._action);

  final CommandBuilder<T, Argument> _action;

  Future<void> run(Argument argument) async {
    await _run(() => _action(argument));
  }
}
