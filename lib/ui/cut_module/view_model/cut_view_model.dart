import 'dart:ui' as ui;

import 'package:demo/data/repositories/cut/cut_respository.dart';
import 'package:demo/utils/command.dart';
import 'package:demo/utils/file_util.dart';
import 'package:demo/utils/image_util.dart';
import 'package:demo/utils/qiniu_util.dart';
import 'package:demo/utils/result.dart';
import 'package:demo/utils/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:qiniu_flutter_sdk/qiniu_flutter_sdk.dart';

class CutViewModel extends ChangeNotifier {
  CutViewModel() {
    getOriginalImage = CommandAction(_getOriginalImage);
    getSplitImage = CommandAction(_getSplitImage);
    uploadImage = CommandAction(_uploadImage);
  }

  late ui.Image _originalImage;
  bool _isImageLoaded = false;
  List<ui.Image> splitImages = [];
  double progress = 0;

  late CommandAction getOriginalImage;
  late CommandAction getSplitImage;
  late CommandAction uploadImage;

  Future<Result> _getOriginalImage() async {
    final respository = await CutRespository().getCutData();
    if (respository is Succ) {
      _originalImage = (respository as Succ).value;
      _isImageLoaded = true;
      ToastUtil.show('图片加载成功');
      notifyListeners();
    }
    return respository;
  }

  Future<Result> _getSplitImage() async {
    if (!_isImageLoaded) {
      ToastUtil.show('图片未加载');
      return Result.fail(Exception('Image is not loaded'));
    }
    final respository = await CutRespository().cutImage(
      image: _originalImage,
      rows: 25,
      columns: 25,
    );
    if (respository is Succ) {
      splitImages = (respository as Succ).value;
      notifyListeners();
    }
    return respository;
  }

  Future<Result> _uploadImage() async {
    final file = await ImageUtil.getFilePath(splitImages.first);
    if (file == null) {
      return Result.fail(Exception('File is null'));
    }

    await QiniuUtil.uploadFile(
      file: file,
      addProgressListener: (percent) {
        progress = progress;
        notifyListeners();
      },
      
    );
    ToastUtil.show('上传成功');
    return Result.succ('');
  }
}
